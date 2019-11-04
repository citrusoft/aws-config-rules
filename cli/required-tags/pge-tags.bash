#!/bin/bash
set -o xtrace
AWS_PROFILE=tah
RULENAME=pge-s3-tags
TMPFILE=/tmp/pge-tags-rule.json
TEMPLATE=pge-tags-rule.json
PARAMNAME="/pge/s3/tags"
# export TAGS='{"tag1Key":"Name","tag2Key":"AppID","tag3Key":"Notify","tag4Key":"Environment","tag5Key":"Role"}'
# export TAGS='{\"tag1Key\":\"AppID\",\"tag2Key\":\"Order\",\"tag3Key\":\"Org\",\"tag4Key\":\"Owner\",\"tag5Key\":\"ProjectName\"}'
# aws ssm delete-parameters --name $TAGNAME --profile=tah
# aws ssm put-parameter --name "$PARAMNAME" --value ${TAGS} --type String --overwrite --profile=tah
#METADATA="Description=\"Checks for mandatory tags.\", RuleIdentifier=\"REQUIRED_TAGS\",InputParameters="
aws ssm describe-parameters --profile=tah
# aws ssm describe-parameters --filters "Key=Name,Values=${TAGNAME}"
export TAGS=`aws ssm get-parameters --names $PARAMNAME --profile=tah | jq '.Parameters[0].Value'`
TAGS="${TAGS%\"}"
TAGS="${TAGS#\"}"
# echo "$TAGS"
rm ${TMPFILE}
jq --arg t $TAGS '.OrganizationManagedRuleMetadata.InputParameters=$t' <$TEMPLATE | sed 's/\\\\\\/\\/g' | tr -d '\n' >${TMPFILE}

# aws configservice put-config-rule --config-rule file://${TMPFILE} --profile=$AWS_PROFILE
aws configservice put-organization-config-rule --organization-config-rule-name ${RULENAME} \
 --cli-input-json "'"`cat ${TMPFILE}`"'" \
 --profile=${AWS_PROFILE}
# aws configservice delete-config-rule --config-rule-name=

aws configservice describe-config-rules --profile=$AWS_PROFILE
