#!/bin/bash

aws dynamodb delete-table \
    --table-name terraform-formac-state-lock \
    --region ap-south-1

aws s3 rm \
    --recursive s3://terraform-formac-state-file \
    --region ap-south-1

aws s3 rb \
    s3://terraform-formac-state-file \
    --region ap-south-1
