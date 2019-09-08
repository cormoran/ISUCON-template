#!/usr/bin/env bash
source variables.sh

./script/slack.sh "$USER executed deploy.sh."

for server in ${ISUCON_SERVERS[@]};
do
    echo "---- start deploy $server -----"
    # etc
    rsync -avz -e "ssh -i $ISUCON_SSH_KEY" --rsync-path='sudo rsync' ./etc/ $ISUCON_SSH_USER@$server:/etc/
    # app
    rsync -avz -e "ssh -i $ISUCON_SSH_KEY" ./home/ $ISUCON_SSH_USER@$server:~/ # --exclude=''
done

./script/log-rotate.sh deploy-by-$USER
