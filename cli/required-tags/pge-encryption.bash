#!/bin/bash

aws configservice put-organization-config-rule \
--organization-config-rule-name pge_S3_encryption \
--organization-managed-rule-metadata 'Description="Checks whether encryption configured for S3 buckets.",RuleIdentifier="S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED",ResourceTypesScope="AWS::S3::Bucket"' \
--profile=tah
--generate-cli-skeleton

# aws configservice delete-organization-config-rule --profile tah --organization-config-rule-name=pge_mandatory_encryption

aws configservice describe-organization-config-rules --profile tah
