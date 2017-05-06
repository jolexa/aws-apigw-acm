#!/usr/bin/env python

def handler(event, context):
    return { "statusCode": 200, "body": "hello world, from python\n" }
