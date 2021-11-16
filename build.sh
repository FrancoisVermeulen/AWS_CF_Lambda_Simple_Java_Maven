#!/bin/bash

#specify these
bucket=${1} #must be a bucket which exists in your intended deployment region
profile=${2} #your user configured using 'aws configure --profile'
region=${3} #intended deployment region
libraryversion=${4} #ie 'lib1'
jarversion=${5} #ie 'aws_cf_simplelambda-1.0-SNAPSHOT'
stackname=${6} #ie 'SimplevaLambda'

#to verify choices
echo bucket         : $bucket
echo profile        : $profile
echo region         : $region
echo libraryversion : $libraryversion #for changes to libraries to take effect this has to be changed from previous build
echo jarversion     : $jarversion #for source changes to take effect this has to be changed from previous build
echo stackname      : stackname #cloudformation stackname

#set library key
libkey=$libraryversion.zip

#package
mvn package

#export library to s3
mkdir -p java/lib #if it did not exist; has to be in java/lib directory
rm -rf java/lib #neccessary for consecutive builds
cp -r target/classes/lib java/lib #copy libs
zip -r -v java/lib/$libkey java/lib #zip
rm -r java/lib/*.jar #cleanup
aws s3 cp java/lib/$libkey s3://$bucket/$libkey --profile $profile --region $region #-> s3

#set code key
codekey=$jarversion.jar

aws s3 cp target/aws_cf_simplelambda-1.0-SNAPSHOT.jar s3://$bucket/$codekey --profile $profile --region $region #-> s3

#cloudformation
aws cloudformation package --template-file template.yaml --output-template-file template-output.yaml --s3-bucket $bucket

aws cloudformation deploy \
--template-file template-output.yaml \
--stack-name $stackname \
--parameter-overrides CODEBUCKET=$bucket CODEKEY=$codekey  LIBKEY=$libkey STACKNAME=$stackname \
--region $region \
--profile $profile \
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
