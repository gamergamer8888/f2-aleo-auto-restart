# f2-aleo-autorestart

#### 注意，本程序需要魔法，因为api地址在墙外，使用clash的tun模式即可
1. https://www.f2pool.com/user/account#tab-api 
    - 点击 Request a New Token
    - 进去后，勾上 hash_rate/worker/list权限，点击提交，复制保存 TOKEN
2. aleo-autorestart.sh 放入aleo.sh所在目录
3. 修改aleo-autorestart.sh
    - URL：默认不用改，除非api用转发
    - API_TOKEN：前面生成的TOKEN
    - ACCOUNTNAME：aleo.sh 使用的参数，账户名
    - WORKERNAME：aleo.sh 使用的参数，矿工名
4. 进入脚本所在目录， ```sudo chmod +x aleo-autorestart.sh ```，给执行权限
5. crontab -e 末尾追加 ```*/5 * * * * cd /root/f2-aleo && bash ./aleo-autorestart.sh```
    - 把 /root/f2-aleo 替换成自己的目录
    - 每5分钟检查一次，自行修改间隔
6. 查看日志：tail -f aleo-miner.log

