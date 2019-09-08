#!/usr/bin/env bash
#  サーバーの各種情報を取得 ./log/<server ip>/server-info 以下に保存
source variables.sh

for server in ${ISUCON_SERVERS[@]};
do
    mkdir -p ./log/$server
    echo "---- start get server info $server -----"
    (cat <<EOF

mkdir -p /tmp/server-info
cat /proc/cpuinfo > /tmp/server-info/cpuinfo.txt
free -h > /tmp/server-info/free.txt
ps aux > /tmp/server-info/ps.aux.txt
systemctl > /tmp/server-info/systemctl.txt
EOF
    ) | ssh $ISUCON_SSH_USER@$server -i $ISUCON_SSH_KEY bash
    rsync -az -e "ssh -i $ISUCON_SSH_KEY" --rsync-path='sudo rsync' $ISUCON_SSH_USER@$server:/tmp/server-info/ ./log/$server/server-info/
done
