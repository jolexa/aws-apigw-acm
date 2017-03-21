#!/usr/bin/env python

# NOTE: https://forums.aws.amazon.com/message.jspa?messageID=769627

import argparse
import boto3

parser = argparse.ArgumentParser(description='Find Output')
parser.add_argument("--cert-arn", dest="certarn", required=True)
parser.add_argument("--domain-name", dest="domainname", required=True)
parser.add_argument("--region", dest="region", required=True)
args = parser.parse_args()

client = boto3.client('apigateway', region_name=args.region)
response = client.create_domain_name(
    domainName=args.domainname,
    certificateArn=args.certarn
)

