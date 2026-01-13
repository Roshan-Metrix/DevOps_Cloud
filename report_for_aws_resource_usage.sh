#!/bin/bash

#########################
# Author: Roshan
# Date: 13th-Jan
#
# Version: v1
#
# This script will report the AWS resource usage
#########################

set -x

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

# list S3 buckets
echo "Print list of s3 buckets"
aws s3 ls

# list EC2 Instances
echo "Print list of EC2 instances"
aws ec2 describe-instances

# list lambda
echo "Print list of lambda function"
aws lambda list-functions

# list IAM users
echo "Print list of IAM users"
aws iam list-users
