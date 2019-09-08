#/usr/bin/env bash
curl -s -X POST --data-urlencode "payload={\"username\": \"$USER\", \"text\": \"$*\"}" $SLACK_WEBHOOK_URL > /dev/null
