#!/usr/bin/env bash
# ログファイルを処理してレポートを作成
source variables.sh

# kataribe report

for f in `find ./log -name access.log | grep nginx`;
do
    if [ ! -e ${f}_summary_data.log ]; then
        echo "processing $f"
        cat $f | kataribe > ${f}_summary_data.log
    fi
done

# wsgi line profiler report

for logname in wsgi_lineprof.log;
do
    for f in `find ./log -name $logname`;
    do
        if [ ! -e ${f}_line_data.log ]; then
            echo "processing $f"
            python3 script/wlreporter.py -f $f
        fi
    done
done
