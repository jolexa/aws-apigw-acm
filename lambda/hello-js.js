exports.handler = function(event, context, callback) {
    callback(null, {
        "statusCode": 200,
        "body": "hello world, from node. Region: " + process.env.AWS_DEFAULT_REGION + "\n"
    });
}
