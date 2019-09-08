#!/usr/bin/env bash
# サーバーのプログラムをフルバックアップする ./backup/<server ip>/ 以下に保存
source variables.sh

for server in ${ISUCON_SERVERS[@]};
do
    echo "---- start full backup $server -----"
    mkdir -p ./backup/$server
    (cat <<EOF
mkdir -p /tmp/backup
tar czf /tmp/backup/home.tar.gz /home/isucon/
sudo tar czf /tmp/backup/etc.tar.gz /etc/
# mysqldump -uisucari -pisucari isucari  > /tmp/backup/mysqldump.sql
EOF
    ) | ssh $ISUCON_SSH_USER@$server -i $ISUCON_SSH_KEY bash
    rsync -az -e "ssh -i ${ISUCON_SSH_KEY}" --rsync-path='sudo rsync' $ISUCON_SSH_USER@$server:/tmp/backup/ ./backup/$server/
    ssh $ISUCON_SSH_USER@$server -i $ISUCON_SSH_KEY 'rm -r /tmp/backup'
done
