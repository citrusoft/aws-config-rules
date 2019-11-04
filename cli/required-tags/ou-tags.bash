#!/bin/bash
set -o xtrace
AWS_PROFILE=thunt
TMPFILE=/tmp/ou-tags-rule.json
TEMPLATE=ou-tags-rule.json
TAGNAME="/pge/lnm/s3/tags"
# export TAGS='{"tag1Key":"AppID","tag2Key":"Order","tag3Key":"Org","tag4Key":"Owner","tag5Key":"ProjectName"}'
# export TAGS='{\"tag1Key\":\"AppID\",\"tag2Key\":\"Order\",\"tag3Key\":\"Org\",\"tag4Key\":\"Owner\",\"tag5Key\":\"ProjectName\"}'
# aws ssm delete-parameters --name $TAGNAME --profile=tah
# aws ssm put-parameter --name "$TAGNAME" --value ${TAGS} --type String --overwrite --profile=tah
#METADATA="Description=\"Checks for mandatory tags.\", RuleIdentifier=\"REQUIRED_TAGS\",InputParameters="
aws ssm describe-parameters --profile=tah
# aws ssm describe-parameters --filters "Key=Name,Values=${TAGNAME}"
export TAGS=`aws ssm get-parameters --names $TAGNAME --profile=tah | jq '.Parameters[0].Value'`
TAGS="${TAGS%\"}"
TAGS="${TAGS#\"}"
# echo "$TAGS"
rm ${TMPFILE}
jq --arg t $TAGS '.InputParameters=$t' <$TEMPLATE | sed 's/\\\\\\/\\/g' >${TMPFILE}

aws configservice put-config-rule --config-rule file://${TMPFILE} --profile=$AWS_PROFILE

# aws configservice delete-config-rule --config-rule-name=

aws configservice describe-config-rules --profile=$AWS_PROFILE
