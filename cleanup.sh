#!/bin/bash
REGION="ap-south-1"
S3_BUCKET_NAME="terraform-formac-state-file"
DYNAMODB_TABLE_NAME="terraform-formac-state-lock"

# Remove dynamodb table
aws dynamodb delete-table \
    --table-name $DYNAMODB_TABLE_NAME \
    --region $REGION

if [ $? -eq 0 ]; then
   echo "+ DynamoDB Table: $DYNAMODB_TABLE_NAME was deleted."
   echo
fi

# Empty S3 Bucket
aws s3 rm \
    --recursive s3://$S3_BUCKET_NAME \
    --region $REGION

# Remove S3 Bucket
aws s3 rb \
    s3://$S3_BUCKET_NAME \
    --region $REGION

if [ $? -eq 0 ]; then
   echo "+ Bucket: $S3_BUCKET_NAME was deleted."
   echo
fi

# Remove Available volumes
volumeids=`aws ec2 describe-volumes \
	   --filter "Name=status,Values=available" \
	   --query 'Volumes[*].{VolumeID:VolumeId}' \
	   --region $REGION \
	   --output text`

for i in $volumeids
do
   aws ec2 delete-volume --volume-id $i --region ap-south-1
   echo "+ VolumeID: $i is Deleted."
done

# Delete local keys folder
if [ -d "keys" ]; then
   rm -rf keys
fi

# Delete .terraform  folder
if [ -d ".terraform" ]; then
   rm -rf .terraform
fi
