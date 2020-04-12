export AWS_DEFAULT_REGION=us-east-1
export AWS_SECRET_ACCESS_KEY=key
export AWS_ACCESS_KEY_ID=random

awslocal s3 mb s3://lambdas
awslocal s3 cp dynamo/getMediaRandom.zip s3://lambdas
awslocal cloudformation create-stack --stack-name mediaApi --template-body file://api.yaml
node dynamo/seed.js
