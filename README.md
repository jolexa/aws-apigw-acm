# aws-apigw-acm
Reference Implementation of two API Gateways behind one custom domain, using
ACM.

This is a quick implementation that was motivated because I wanted to figure it
out. See also [SAM #106](https://github.com/awslabs/serverless-application-model/issues/106)

## What?
This repository represents two cloudformation stacks.

One stack is the core implementation and sets up the two API Gateways that proxy
to two Lambda Hello World functions (in `us-west-1`), for fun one is NodeJS and
one is Python. There is also a lambda for a custom cloudformation resource. At
this time, there is no CloudFormation resource available for a API Gateway
Custom Domain.  
One stack sets up the ACM cert, only available in `us-east-1` at this time.  

## How?
If you want to test this yourself, change a few variables in `Makefile` and run `make`

## Result

API GW responds its own domain and the custom domain
```
$ curl https://33xxlia8t7.execute-api.us-west-1.amazonaws.com/prod
hello world, from node
$ curl https://dfklmr369e.execute-api.us-west-1.amazonaws.com/prod
hello world, from python
$ curl https://aws-apigw-acm.jolexa.us/node
hello world, from node
$ curl https://aws-apigw-acm.jolexa.us/python
hello world, from python
```
```
% host aws-apigw-acm.jolexa.us
aws-apigw-acm.jolexa.us has address 52.222.214.211
aws-apigw-acm.jolexa.us has address 52.222.214.205
aws-apigw-acm.jolexa.us has address 52.222.214.253
aws-apigw-acm.jolexa.us has address 52.222.214.134
aws-apigw-acm.jolexa.us has address 52.222.214.34
aws-apigw-acm.jolexa.us has address 52.222.214.222
aws-apigw-acm.jolexa.us has address 52.222.214.196
aws-apigw-acm.jolexa.us has address 52.222.214.192
aws-apigw-acm.jolexa.us has IPv6 address 2600:9000:204d:8600:e:167d:41c0:21
aws-apigw-acm.jolexa.us has IPv6 address 2600:9000:204d:8c00:e:167d:41c0:21
aws-apigw-acm.jolexa.us has IPv6 address 2600:9000:204d:200:e:167d:41c0:21
aws-apigw-acm.jolexa.us has IPv6 address 2600:9000:204d:3c00:e:167d:41c0:21
aws-apigw-acm.jolexa.us has IPv6 address 2600:9000:204d:9200:e:167d:41c0:21
aws-apigw-acm.jolexa.us has IPv6 address 2600:9000:204d:c00:e:167d:41c0:21
aws-apigw-acm.jolexa.us has IPv6 address 2600:9000:204d:ee00:e:167d:41c0:21
aws-apigw-acm.jolexa.us has IPv6 address 2600:9000:204d:3e00:e:167d:41c0:21
```

## Questions?
I'm sure there are questions. I'll respond on GH issues as time allows.

Thanks for looking and providing feedback
