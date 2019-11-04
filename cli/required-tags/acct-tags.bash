#!/bin/bash
set -o xtrace
export AWS_PROFILE=tahunt
# export TAGS='{"tag1Key":"createdBy","tag2Key":"createDate"}'
# export TAGS='{\"tag1Key\":\"createdBy\",\"tag2Key\":\"createDate\"}'
TAGNAME="/pge/lnm/test/s3/tags"
# aws ssm delete-parameters --name $TAGNAME
# aws ssm put-parameter --name "$TAGNAME" --value ${TAGS} --type String --overwrite
#METADATA="Description=\"Checks for mandatory tags.\", RuleIdentifier=\"REQUIRED_TAGS\",InputParameters="
aws ssm describe-parameters --filters "Key=Name,Values=${TAGNAME}"
export TAGS=`aws ssm get-parameters --names $TAGNAME | jq '.Parameters[0].Value'`
TAGS="${TAGS%\"}"
TAGS="${TAGS#\"}"
# echo "$TAGS"
rm /tmp/acct-tags-rule.json
jq --arg t $TAGS '.InputParameters=$t' <acct-tags-rule.json | sed 's/\\\\\\/\\/g' >/tmp/acct-tags-rule.json

aws configservice put-config-rule --config-rule file:///tmp/acct-tags-rule.json --profile=$AWS_PROFILE

# aws configservice delete-config-rule --config-rule-name=

aws configservice describe-config-rules --profile=$AWS_PROFILE
