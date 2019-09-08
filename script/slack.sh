#/usr/bin/env bash
source variables.sh
curl -s -X POST --data-urlencode "payload={\"username\": \"$USER\", \"text\": \"$*\"}" $SLACK_WEBHOOK_URL > /dev/null
