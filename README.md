# AWS_CF_Lambda_Simple_Java_Maven
A Simple AWS Lambda implementing java created using cloudformation, maven 

**Prerequisites:**
- have an aws account
- aws cli installed
- aws iam profile configured

**To run:**
- edit/pass parameters to build.sh file; required fields are:
  1. bucket=${1} #must be a bucket which exists in your intended deployment region
  2. profile=${2} #your user configured using 'aws configure --profile'
  3. region=${3} #intended deployment region
  4. libraryversion=${4} #ie 'lib1'
  5. jarversion=${5} #ie 'aws_cf_simplelambda-1.0-SNAPSHOT'
  6. stackname=${6} #ie 'SimpleJavaLambda'
- ./build.sh
