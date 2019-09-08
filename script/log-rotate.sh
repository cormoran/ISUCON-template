#!/usr/bin/env bash
#  ログをバックアップして初期化後、プログラムを再起動
#  使い方: ./script/log-rotate.sh <ログの名前>
#  <time stamp>-<ログの名前> ディレクトリ以下にログが保存されます
# 他の人は ./script/fetch.sh で取得しよう
source variables.sh

TIME_STAMP=$(date "+%Y-%m-%d--%H-%M-%S")-$1

mkdir -p ./log

for server in ${ISUCON_SERVERS[@]};
do
    echo "---- start log rotate $server ($TIME_STAMP) -----"
    (cat <<EOF
sudo systemctl daemon-reload
# nginx
sudo mkdir -p /var/log/isucon/$TIME_STAMP/nginx
sudo mkdir -p /var/isucon-logs/$TIME_STAMP/nginx
for f in access.log error.log; do
    sudo mv /var/log/nginx/\$f /var/log/isucon/$TIME_STAMP/nginx/
done

# mysql
sudo mkdir -p /var/log/isucon/$TIME_STAMP/mysql
for f in error.log slow.log; do
    sudo mv /var/log/mysql/\$f /var/log/isucon/$TIME_STAMP/mysql/
done

# python
sudo mkdir -p /var/log/isucon/$TIME_STAMP/python
for f in wsgi_lineprof.log; do
    sudo mv /var/log/python/\$f /var/log/isucon/$TIME_STAMP/python/
done

# --- 各サービスの再起動 ---
for s in nginx mysql TODO.python.service;
do
    sudo systemctl restart \$s
done

EOF
    ) | ssh $ISUCON_SSH_USER@$server -i $ISUCON_SSH_KEY bash
done

