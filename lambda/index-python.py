#!/usr/bin/env python

from __future__ import print_function
import logging
from datetime import datetime

print('Loading function ' + datetime.now().time().isoformat())
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    return { "statusCode": 200, "body": "hello world, from python\n" }
