awslocal s3 mb s3://lambdas
awslocal s3 cp getMediaRandom.zip s3://lambdas
awslocal cloudformation create-stack --stack-name mediaApi --template-body file://api.yaml
node seed.js
