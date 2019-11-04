#!/bin/bash
set -o xtrace
AWS_PROFILE=tahunt

########## CLEANUP PLAIN OLE CONFIG RULES
aws configservice delete-config-rule --config-rule-name=acct-S3-tags --profile=tahunt
aws configservice delete-config-rule --config-rule-name=ou-S3-tags --profile=thunt

########## CLEANUP ORG CONFIG RULES
aws configservice delete-organization-config-rule --organization-config-rule-name=pge-s3-tags --profile=tah
