#!/usr/bin/env bash
# サーバーからログなどを取ってくる
source variables.sh

mkdir -p ./log

for server in ${ISUCON_SERVERS[@]};
do
    echo "--- fetching log from $server ---"
    rsync -az -e "ssh -i $ISUCON_SSH_KEY" --rsync-path='sudo rsync' $ISUCON_SSH_USER@$server:/var/log/isucon/ ./log/
done

./script/make-report.sh
