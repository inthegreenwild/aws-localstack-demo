awslocal s3 mb s3://lambdas
awslocal s3 cp getMediaRandom.zip s3://lambdas
awslocal cloudformation create-stack --stack-name mediaApi --template-body file://api.yaml
awslocal cloudformation create-stack --stack-name dynamoMovieDB --template-body file://MovieTable.yaml
node seed.js

# restApiId=$(awslocal apigateway create-rest-api --region us-east-1 --name 'Demo' --query id)
# echo $restApiId

# echo \
# '
# {
#     "restApiId": '"$restApiId"'
# }
# ' > paramFile.json


# parentId=$(awslocal apigateway get-resources --region us-east-1 --cli-input-json file://paramFile.json --query items[0].id)

# echo $parentId

# echo \
# '
# {
#     "restApiId": '"$restApiId"',
#     "parentId": '"$parentId"',
#     "pathPart": "{media}"
# }
# ' > paramFile.json 

# cat paramFile.json 
# echo $parentId 

# resourceId=$(awslocal apigateway create-resource --region us-east-1 --cli-input-json file://paramFile.json --query id)

# echo $resourceId
# echo \
# '
# {
#     "restApiId": '"$restApiId"',
#     "resourceId": '"$resourceId"',
#     "httpMethod": "GET",
#     "authorizationType": "NONE",
#     "requestParameters": {
#         "method.request.querystring.type": true
#     }
# }
# ' > paramFile.json

# awslocal apigateway put-method --region us-east-1 --cli-input-json file://paramFile.json 


# lambdaArn=$(awslocal lambda get-function --function-name getMediaRandom --query Configuration.FunctionArn | tr -d '"')
# lambdaUri="\"arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${lambdaArn}/invocations\""

# echo \
# '
# {
#     "restApiId": '"$restApiId"',
#     "resourceId": '"$resourceId"',
#     "httpMethod": "GET",
#     "type": "AWS_PROXY",
#     "integrationHttpMethod": "POST",
#     "uri": '"$lambdaUri"',
#     "passthroughBehavior": "WHEN_NO_MATCH",
#     "timeoutInMillis": 10000
# }
# ' > paramFile.json 

# awslocal apigateway put-integration \
#  --region us-east-1 \
#  --cli-input-json file://paramFile.json 


# echo \
# '
# {
#     "restApiId": '"$restApiId"',
#     "stageName": "test"
# }
# ' > paramFile.json 

# awslocal apigateway create-deployment \
#  --region us-east-1 \
#  --cli-input-json file://paramFile.json 

#  rm paramFile.json