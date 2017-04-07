# aws-apigw-acm
Reference Implementation of API GW using a custom domain

This is a quick implementation that was motivated because I wanted to figure it out. See also [SAM #106](https://github.com/awslabs/serverless-application-model/issues/106)

## What?
This repo represents three cloudformation stacks and two boto3 helpers.

One stack sets up the two API Gateways that proxy to two Lambda Hello World functions (in `us-west-1`).  
One stack sets up the ACM cert, only available in `us-east-1` at this time.  
One stack sets up the Route53 Alias and changes the API GW Base Path Mappings

## How?
If you want to test this yourself, change a few variables in `Makefile` and run `make deploy`

The reason that there are some boto3 helpers is because cloudformation does not support creating an API GW Domain Name.  
Reference: https://forums.aws.amazon.com/message.jspa?messageID=769627

## Result

API GW responds its own domain and the custom domain
```
$ curl https://6owdl3cmxj.execute-api.us-west-1.amazonaws.com/prod
hello world, from node
$ curl https://6q24sn35p0.execute-api.us-west-1.amazonaws.com/prod
hello world, from python
$ curl https://aws-apigw-acm.jolexa.us/node
hello world, from node
$ curl https://aws-apigw-acm.jolexa.us/python
hello world, from python
```
```
% host aws-apigw-acm.jolexa.us
aws-apigw-acm.jolexa.us has address 52.85.202.191
aws-apigw-acm.jolexa.us has address 52.85.202.241
aws-apigw-acm.jolexa.us has address 52.85.202.98
aws-apigw-acm.jolexa.us has address 52.85.202.178
aws-apigw-acm.jolexa.us has address 52.85.202.94
aws-apigw-acm.jolexa.us has address 52.85.202.186
aws-apigw-acm.jolexa.us has address 52.85.202.160
aws-apigw-acm.jolexa.us has address 52.85.202.13
```

## Questions?
I'm sure there are questions. I'll respond on GH issues as time allows.

Thanks for looking and providing feedback
