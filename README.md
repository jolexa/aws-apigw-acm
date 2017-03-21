# aws-apigw-acm
Reference Implementation of API GW using a custom domain

This is a quick implementation that was motivated because I wanted to figure it out. See also [SAM #106](https://github.com/awslabs/serverless-application-model/issues/106)

## What?
This repo represents three cloudformation stacks and two boto3 helpers.

One stack sets up the API GW and Lambda Hello World function (in `us-west-1`).  
One stack sets up the ACM cert, only available in `us-east-1` at this time.  
One stack sets up the Route53 CNAME and changes the API GW Base Path Mapping

## How?
If you want to test this yourself, change a few variables in `Makefile` and run `make deploy`

## Result

API GW responds on two domains, including my custom domain
```
curl https://j8zi1n66fc.execute-api.us-west-1.amazonaws.com/prod/
hello world
$ curl https://aws-api-gw-acm.jolexa.us/
hello world
```
```
$ host aws-api-gw-acm.jolexa.us
aws-api-gw-acm.jolexa.us is an alias for d1eko9ysqon0po.cloudfront.net.
d1eko9ysqon0po.cloudfront.net has address 52.85.202.123
d1eko9ysqon0po.cloudfront.net has address 52.85.202.112
d1eko9ysqon0po.cloudfront.net has address 52.85.202.113
d1eko9ysqon0po.cloudfront.net has address 52.85.202.142
d1eko9ysqon0po.cloudfront.net has address 52.85.202.127
d1eko9ysqon0po.cloudfront.net has address 52.85.202.19
d1eko9ysqon0po.cloudfront.net has address 52.85.202.37
d1eko9ysqon0po.cloudfront.net has address 52.85.202.36
d1eko9ysqon0po.cloudfront.net has IPv6 address 2600:9000:2009:ba00:9:3fd8:d700:93a1
d1eko9ysqon0po.cloudfront.net has IPv6 address 2600:9000:2009:6000:9:3fd8:d700:93a1
d1eko9ysqon0po.cloudfront.net has IPv6 address 2600:9000:2009:2200:9:3fd8:d700:93a1
d1eko9ysqon0po.cloudfront.net has IPv6 address 2600:9000:2009:c00:9:3fd8:d700:93a1
d1eko9ysqon0po.cloudfront.net has IPv6 address 2600:9000:2009:fa00:9:3fd8:d700:93a1
d1eko9ysqon0po.cloudfront.net has IPv6 address 2600:9000:2009:8200:9:3fd8:d700:93a1
d1eko9ysqon0po.cloudfront.net has IPv6 address 2600:9000:2009:a200:9:3fd8:d700:93a1
d1eko9ysqon0po.cloudfront.net has IPv6 address 2600:9000:2009:7400:9:3fd8:d700:93a1
```

## Questions?
I'm sure there are questions. I'll respond on GH issues as time allows.

Thanks for looking and providing feedback
