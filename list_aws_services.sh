#!/bin/bash

# Specify your AWS region here
region="us-east-1"

# List of AWS services
services=("ec2" "s3" "lambda" "rds" "dynamodb" "cloudfront" "elasticbeanstalk" "elasticache" "ecs" "route53" "cloudwatch" "iam" "sns" "sqs" "kinesis" "apigateway" "codecommit" "codedeploy" "codepipeline" "cognito" "kms" "dms" "redshift" "datapipeline" "directconnect" "elastictranscoder" "emr" "glacier" "opsworks" "cloudformation" "cloudsearch" "cloudtrail" "config" "ecs" "efs" "eks" "guardduty" "lightsail" "mediastore" "mediastore-data" "organizations" "resourcegroupstaggingapi" "secretsmanager" "servicecatalog" "shield" "sms" "storagegateway" "swf" "transfer" "waf" "workspaces" "xray")

# Set AWS region
export AWS_DEFAULT_REGION="$region"

# Iterate over each service
for service in "${services[@]}"; do
    echo "Service Name: $service"
    case "$service" in
        "ec2")
            # Get number of running instances
            instance_count=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --output text | wc -l)
            echo "Number of Instances: $instance_count"
            echo "Instance ID | Instance Status"
            # Get instance IDs and status
            aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId, State.Name]' --output text | column -t
            ;;
        "s3")
            # Get number of S3 buckets
            bucket_count=$(aws s3api list-buckets --query 'Buckets[*].[Name]' --output text | wc -l)
            echo "Number of Buckets: $bucket_count"
            ;;
        "lambda")
            # Get number of Lambda functions
            function_count=$(aws lambda list-functions --query 'Functions[*].[FunctionName]' --output text | wc -l)
            echo "Number of Functions: $function_count"
            ;;
        # Add more cases for other services as needed
        *)
            echo "No specific information available"
            ;;
    esac
    echo "---------------------------------------------"
done
