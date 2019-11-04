#!/bin/bash
set -o xtrace
AWS_PROFILE=tahunt

# aws s3api get-bucket-tagging --bucket tahunt-bucket --profile tahunt
aws s3api delete-bucket-tagging --bucket tahunt-bucket --profile=$AWS_PROFILE
aws s3api delete-bucket-tagging --bucket config-bucket-567207295412 --profile=$AWS_PROFILE
aws s3api delete-bucket-tagging --bucket config-rule-code-bucket-567207295412-us-east-2 --profile=$AWS_PROFILE
