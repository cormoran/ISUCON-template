#!/usr/bin/env bash
# 各種ツールをサーバーにインストールする
source variables.sh

for server in ${ISUCON_SERVERS[@]};
do
    (cat <<EOF
sudo apt install -y emacs vim git wget curl
# netdata
bash <(curl -Ss https://my-netdata.io/kickstart-static64.sh) # これじゃないと動かなかった
EOF
    ) | ssh $ISUCON_SSH_USER@$server -i $ISUCON_SSH_KEY bash
done
