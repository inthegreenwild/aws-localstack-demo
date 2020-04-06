export AWS_DEFAULT_REGION=us-east-1
export AWS_SECRET_ACCESS_KEY=key
export AWS_ACCESS_KEY_ID=random

awslocal s3 mb s3://lambdas
awslocal s3 cp dynamo/getMediaRandom.zip s3://lambdas
awslocal cloudformation create-stack --stack-name mediaApi --template-body file://api.yaml
node dynamo/seed.js
# awslocal cloudformation describe-stacks --stack-name arn:aws:cloudformation:us-east-1:000000000000:stack/mediaApi/fe037482-74b5-4005-a152-5714ae661963
# curl -X GET 'http://localhost:4567/restapis/su8fpjokaa/test/_user_request_/media?type=movie'