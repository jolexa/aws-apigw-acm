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

## Questions?
I'm sure there are questions. I'll respond on GH issues as time allows.

Thanks for looking and providing feedback
