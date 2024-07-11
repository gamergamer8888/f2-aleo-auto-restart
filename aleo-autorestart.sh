#!/bin/bash
# 适用官方脚本 aleo.sh
# token获取地址 https://www.f2pool.com/user/account#tab-api
API_TOKEN=
# 账户名
ACCOUNTNAME=
# 矿工名
WORKERNAME=
# api文档地址 https://www.f2pool.com/api_doc
# 查询矿工列表
URL=https://api.f2pool.com/v2/hash_rate/worker/list
# 启动脚本
CMD="./aleo.sh stratum+ssl://nlb-7b20ejgco2wxsf4av2.cn-chengdu.nlb.aliyuncs.com:4420 $ACCOUNTNAME.$WORKERNAME"
# 工作目录
WORKSPACE="$(cd $(dirname $0) && pwd)"
# 日志文件路径
LOG_PATH="$WORKSPACE/aleo-miner.log"

# echo $WORKSPACE
# 安装缺失模块
if ! which jq > /dev/null; then
    sudo apt install jq -y
fi
# 获取离线矿工名，写入workers数组
# 测试网 aleo-staging
# status: 0 在线 1 离线 2 失效
readarray -t workers < <(curl -X POST $URL --silent \
     -H 'Content-Type: application/json' \
     -H "F2P-API-SECRET: $API_TOKEN" \
     -d '{"mining_user_name":"'"$ACCOUNTNAME"'","currency": "aleo-staging"}' \
     | jq '[.workers|map(select(.status|.==1)).[].hash_rate_info.name]')
# 判断是否离线
if [[ "${workers[@]}"  =~ "$WORKERNAME" ]]; then
    echo "$WORKERNAME is offline，restart miner..." >> $LOG_PATH
    # 重新启动miner
    $CMD
fi