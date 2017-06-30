#!/usr/bin/env python

import os

def handler(event, context):
    return { "statusCode": 200, "body": "hello world, from python. Region: " +
            os.environ['AWS_DEFAULT_REGION'] + "\n" }
