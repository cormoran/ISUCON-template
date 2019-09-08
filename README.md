# ISUCON-template

## スクリプト

### 初動向け

- `script/full-backup.sh`: サーバー環境をバックアップ
- `script/get-server-info.sh`: サーバーの CPU, メモリ などの情報を取得
- `script/install-tools.sh`: 監視ツールや emacs などをインストール
  - 動かないと思うので中身を見て手動実行？

### デプロイ向け

- `script/deploy.sh`: プログラムをサーバーに送り込んで、`log-rotate.sh` 実行
  - `script/log-rotate.sh`: サービスのログをバックアップして消す & サービスを再起動

### 解析向け

- `script/fetch.sh`: サーバーからログを取得 & `make-report` 実行
  - `script/make-report.sh`: ./log 以下の生ログファイルから、kataribe など使って色々生成

### 問題に合わせて修正すべき部分

- [ ] `variables.sh` の環境変数
- [ ] full-backup の中身
- [ ] deploy の中身
- [ ] log-rotate の中身
- [ ] kataribe.toml の設定

## TODO

- makefile 書いて、スクリプト間の適当な依存をなくす
- wlreporter 適当に改造したけどバグってないか？