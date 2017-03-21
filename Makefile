REGION="us-west-1"
URL="aws-api-gw-acm.jolexa.us"
ZONE="jolexa.us."

deploy-apigw:
	aws cloudformation deploy \
		--template-file template.yaml \
		--stack-name aws-api-gw-acm-reference \
		--region $(REGION) \
		--parameter-overrides "DomainName=$(URL)" \
		--capabilities CAPABILITY_IAM || exit 0

deploy-acm: deploy-apigw
	# Only works in us-east-1
	aws cloudformation deploy \
		--template-file acm_certs.yml \
		--stack-name aws-api-gw-acm-reference-acm-certs \
		--region us-east-1 \
		--parameter-overrides "ACMUrl=$(URL)" \
		--capabilities CAPABILITY_IAM || exit 0

deploy-domainname: deploy-acm
	# This script is not idempotent, will exit 1 if ran twice
	scripts/create_domain_name.py \
		--cert-arn $(shell aws cloudformation --region us-east-1 describe-stacks --stack-name aws-api-gw-acm-reference-acm-certs --query Stacks[0].Outputs[0].OutputValue --output text) \
		--domain-name $(URL) --region $(REGION) || exit 0

deploy: deploy-domainname
	aws cloudformation deploy \
		--template-file post_domain.yml \
		--stack-name aws-api-gw-acm-reference-post \
		--region $(REGION) \
		--parameter-overrides "DomainName=$(URL)" "CloudFrontDistro=$(shell scripts/get_domain_name_distro.py --domain-name $(URL) --region $(REGION))" "ZoneName=$(ZONE)" \
		--capabilities CAPABILITY_IAM || exit 0
