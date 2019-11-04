#!/bin/sh

aws configservice put-organization-config-rule --organization-config-rule-name pge-S3-tags \
 --organization-managed-rule-metadata 'Description="Checks for required tags.", RuleIdentifier="REQUIRED_TAGS",InputParameters="{\"tag1Key\":\"Name\",\"tag2Key\":\"AppID\",\"tag3Key\":\"Notify\",\"tag4Key\":\"Environment\",\"tag5Key\":\"Role\"}", ResourceTypesScope="AWS::S3::Bucket"' \
 --profile=tah

# aws configservice delete-organization-config-rule --profile tah --organization-config-rule-name=pge_S3_tags

aws configservice describe-organization-config-rules --profile tah
