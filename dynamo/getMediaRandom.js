const AWS = require("aws-sdk");
const hostName = 'http://' + process.env.LOCALSTACK_HOSTNAME + ':4569'
AWS.config.update({
    region: "us-east-1",
    endpoint: hostName,
    accessKeyId: 'secret',
    secretAccessKey: 'alsosecret',
    maxRetries: 3
});
const docClient = new AWS.DynamoDB.DocumentClient();

let handler = async (event) => {
    const mediaType = event.queryStringParameters.type;
    const mediaMap = {
        'movie': 'Movie',
        'tv': 'TV Show'
    }
    const mediaMapped = mediaMap[mediaType];

    const scanParams = {
        TableName: 'MovieDB',
        FilterExpression: "#t = :t_val",
        ExpressionAttributeNames: { '#t': 'type' },
        ExpressionAttributeValues: { ':t_val': mediaMapped },
        ProjectionExpression: "releaseYear, title"
    };

    let data = null;

    try {
        data = await docClient.scan(scanParams).promise();
    } catch (e) {
        return {
            statusCode: 500,
            body: JSON.stringify({
                error: e
            }, null, 2)
        }
    }

    let len = data.Items.length;
    let ran = Math.floor(Math.random() * len);
    let item = data.Items[ran];

    const getParams = {
        TableName: 'MovieDB',
        Key: {
            releaseYear: item.releaseYear,
            title: item.title
        }
    }

    try {
        data = await docClient.get(getParams).promise();
    } catch (e) {
        return {
            statusCode: 500,
            body: JSON.stringify({
                error: e
            }, null, 2)
        }
    }


    return {
        statusCode: 200,
        body: JSON.stringify(data, null, 2)
    }
}

exports.handler = handler