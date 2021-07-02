#!/bin/bash

set -x

BUCKET_NAME=$1
PATTERN_STRING=$2

#To check and install AWS cli 
CHECK_AWS_CLI=$(dpkg -l | grep "awscli")
if [ -z "$CHECK_AWS_CLI" ]
then
      echo "awscli is not installed, installing it now"
      sudo apt-get update
      sudo apt-get install awscli -y
      if [ $? -eq 0 ]; then
    	echo "awscli installation is successful"
      else
    	echo "failed to install awscli exiting"
	exit 1
      fi
fi

#To check if we have access to AWS S3

CHECK_AWS_S3_ACCESS=$(aws s3 ls)
if [ $? -eq 0 ]; then
  echo "AWS S3 access confirmed"
else
  echo "Please check the AWS S3 access"
  exit 1
fi

#To Download the S3 Bucket  
aws s3 sync s3://$BUCKET_NAME /tmp/$BUCKET_NAME
if [ $? -eq 0 ]; then
  echo "successfully downloaded the s3 bucket S{BUCKET_NAME}"
else
  echo "failed to download the bucket ${BUCKET_NAME}"
  exit 1
fi

#To check the Pattern string and Print
FILE_NAMES=$(grep -rl $PATTERN_STRING /tmp/$BUCKET_NAME)
if [ -z "$FILE_NAMES" ]
then
     echo "unable to find the string ${PATTERN_STRING}"
else
     echo "Found the string ${PATTERN_STRING} on below files"
     echo $FILE_NAMES
fi
