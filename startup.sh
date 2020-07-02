#!/bin/sh


if [ -d "keys" ]; then
  echo "keys Directory already exists" ;
else
  mkdir -p keys;
  echo "keys directory is created"
fi


keylist=( "acsLaunchKey" "centosLaunchKey" "ubuntuLaunchKey" "windowsLaunchKey" )


for i in "${keylist[@]}"
do
  if [ ! -f keys/$i ]; then
    ssh-keygen -t rsa -m PEM -f keys/$i -q -N ""
    echo "$i is Created."
  else
    echo "$i is already exists."
  fi 
done


aws s3 mb \
    s3://terraform-formac-state-file \
    --region ap-south-1 

aws dynamodb create-table \
    --table-name terraform-formac-state-lock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 




