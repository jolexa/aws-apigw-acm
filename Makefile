STACKNAME_BASE="aws-apigw-acm-reference"
REGION="us-west-1"
URL="aws-apigw-acm.jolexa.us"
ZONE="jolexa.us."
BUCKET="aws-apigw-acm-reference"

all: deploy

prep:
	cd lambda && \
		zip -r9 zipfile.zip * && \
		aws s3 cp --acl public-read ./zipfile.zip s3://$(BUCKET)/zipfile_v3.zip && \
		rm -f zipfile.zip

deploy-apigw: prep
	aws cloudformation deploy \
		--template-file apigw-lambdas.yml \
		--stack-name $(STACKNAME_BASE) \
		--region $(REGION) \
		--parameter-overrides "DomainName=$(URL)" \
		"Bucket=$(BUCKET)" \
		--capabilities CAPABILITY_IAM || exit 0

deploy-acm: deploy-apigw
	# Only works in us-east-1
	aws cloudformation deploy \
		--template-file acm_certs.yml \
		--stack-name $(STACKNAME_BASE)-acm-certs \
		--region us-east-1 \
		--parameter-overrides "ACMUrl=$(URL)" \
		--capabilities CAPABILITY_IAM || exit 0

deploy-domainname: deploy-acm
	# This script is not idempotent, will exit 1 if ran twice
	scripts/create_domain_name.py \
		--cert-arn $(shell aws cloudformation --region us-east-1 describe-stacks --stack-name $(STACKNAME_BASE)-acm-certs --query Stacks[0].Outputs[0].OutputValue --output text) \
		--domain-name $(URL) --region $(REGION) || exit 0

deploy: deploy-domainname
	aws cloudformation deploy \
		--template-file post_domain.yml \
		--stack-name $(STACKNAME_BASE)-post \
		--region $(REGION) \
		--parameter-overrides "DomainName=$(URL)" "CloudFrontDistro=$(shell scripts/get_domain_name_distro.py --domain-name $(URL) --region $(REGION))" "ZoneName=$(ZONE)" \
		--capabilities CAPABILITY_IAM || exit 0
