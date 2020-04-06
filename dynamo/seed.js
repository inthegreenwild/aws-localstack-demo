var AWS = require("aws-sdk");
var fs = require('fs');
var path = require('path');
var hostName = 'http://' + process.env.LOCALSTACK_HOSTNAME + ':4569'

AWS.config.update({
    endpoint: 'http://localhost:4569',
    region: 'us-east-1',
    accessKeyId: 'secret',
    secretAccessKey: 'alsosecret'
})

var dynamodb = new AWS.DynamoDB.DocumentClient();


var allMovies = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'seed.json'), 'utf8'));
allMovies.forEach(function (movie) {
    var params = {
        TableName: "MovieDB",
        Item: {
            releaseYear: movie.release_year,
            title: movie.title,
            description: movie.description,
            type: movie.type,
            duration: movie.duration
        }
    };

    dynamodb.put(params, function (err, data) {
        if (err) {
            console.error("Unable to add movie", movie.title, ". Error JSON:", JSON.stringify(err, null, 2));
        } else {
            console.log("PutItem succeeded:", movie.title);
        }
    });
});