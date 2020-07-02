#!/bin/sh
REGION="ap-south-1"
S3_BUCKET_NAME="terraform-formac-state-file"
DYNAMODB_TABLE_NAME="terraform-formac-state-lock"

# Create Keys folder Locally.
if [ -d "keys" ]; then
  echo "+ keys Directory already exists" ;
  echo 
else
  mkdir -p keys;
  echo "+ keys directory is created"
  echo
fi


# Generate SSH Keyfiles for all servers.
keylist=( "acsLaunchKey" "centosLaunchKey" "ubuntuLaunchKey" "windowsLaunchKey" )


for i in "${keylist[@]}"
do
  if [ ! -f keys/$i ]; then
    ssh-keygen -t rsa -m PEM -f keys/$i -q -N ""
    echo "+ $i is Created."
    echo
  else
    echo "+ $i is already exists."
    echo
  fi 
done

# Create S3 Bucket to store the state file.
aws s3 mb \
    s3://$S3_BUCKET_NAME \
    --region $REGION

if [ $? -eq 0 ]; then
   echo "+ Bucket: $S3_BUCKET_NAME Created in $REGION region."
   echo
fi

# Create DynamoDB Table to store the terraform state lock.
aws dynamodb create-table \
    --table-name $DYNAMODB_TABLE_NAME \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region $REGION

if [ $? -eq 0 ]; then
   echo "+ DynamoDB Table: $DYNAMODB_TABLE_NAME Created in $REGION region."
   echo
fi





