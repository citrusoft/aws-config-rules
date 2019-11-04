#!/bin/bash
set -o xtrace
AWS_PROFILE=thunt
export TAGSET='TagSet=[{Key="Name",Value="Popcorn"},{Key="AppID",Value="APP-111"},{Key="Order",Value="980791"},{Key="Org",Value="LnM"},{Key="Owner",Value="b1vc"},{Key="ProjectName",Value="OHGW"},{Key="Notify",Value="tahv@pge.com"},{Key="Environment",Value="TEST"},{Key="Role",Value="Repository"},{Key="createdBy",Value="tahv"},{Key="createDate",Value="2019-11-01"}]'

aws s3api put-bucket-tagging --bucket codepipeline-us-east-2-671040486051 --tagging $TAGSET --profile $AWS_PROFILE
aws s3api put-bucket-tagging --bucket config-bucket-123133550781 --tagging $TAGSET --profile $AWS_PROFILE
aws s3api put-bucket-tagging --bucket config-rule-code-bucket-123133550781-us-east-2 --tagging $TAGSET --profile $AWS_PROFILE
# aws s3api get-bucket-tagging --bucket tahunt-bucket --profile tahunt
# aws s3api delete-bucket-tagging --bucket tahunt-bucket
