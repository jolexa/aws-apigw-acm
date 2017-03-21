REGION="us-west-1"
URL="aws-api-gw-acm.jolexa.us"

deploy:
	aws cloudformation deploy \
		--template-file template.yaml \
		--stack-name aws-api-gw-acm-reference \
		--region $(REGION) \
		--parameter-overrides "DomainName=$(URL)" \
		--capabilities CAPABILITY_IAM || exit 0
	aws cloudformation deploy \
		--template-file acm_certs.yml \
		--stack-name aws-api-gw-acm-reference-acm-certs \
		--region us-east-1 \
		--parameter-overrides "ACMUrl=$(URL)" \
		--capabilities CAPABILITY_IAM
