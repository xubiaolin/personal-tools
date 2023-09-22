#!/bin/bash
INSTALL="shadowsocks-all.sh"
OBFS_PORT=27017

apt update 
apt install jq expect -y


curl -fsSL "https://raw.githubusercontent.com/xubiaolin/shadowsocks_install/master/shadowsocks-all.sh" -o $INSTALL
chmod +x $INSTALL

#先卸载
uninstall_exp=$(cat <<'EOF'
spawn ./shadowsocks-all.sh uninstall
expect "Please enter a number \[1-4\]:"
send "1\r"

expect "Are you sure uninstall Shadowsocks-Python? \[y\/n\]\r\n(default: n):"
send "y\r"

EOF
)
expect -c "$uninstall_exp"

#安装ssr
EXP=$(cat <<'EOF'
# 设置超时时间
set timeout 60

# 设置密码长度
set password_length 12

# 定义用于密码的字符集
set chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

# 初始化密码变量
set password ""

# 循环，每次从字符集中随机选择一个字符，直到达到所需长度
for {set i 0} {$i < $password_length} {incr i} {
    set index [expr {int(rand() * [string length $chars])}]
    set password "$password[string index $chars $index]"
}

spawn ./shadowsocks-all.sh

expect "Please enter a number (Default Shadowsocks-Python):"
send "\r"


# 等待密码提示出现，并发送生成的随机密码
expect "Please enter password for Shadowsocks-Python\r\n(Default password: teddysun.com):"
send "$password\r"

expect "(Default port:"
send "\r"

expect "Which cipher you'd select(Default: aes-256-gcm):"
send "\r"

expect "Press any key to start...or Press Ctrl+C to cancel"
send "\r"

EOF
)

expect -c "$EXP"


#安装obfs
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake
git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
make install

#启动obfs
ps -ef |grep obfs-server |grep -v grep | awk '{print $2}' |xargs kill
obfs-server -v -f /var/run/obfs-server.pid -s 0.0.0.0 -p $OBFS_PORT --obfs http -r 127.0.0.1:$(cat /etc/shadowsocks-python/config.json |jq -r .server_port)

#设置自启动
crontab -l | grep -v 'obfs-server' | crontab -
echo "$(crontab -l; echo @reboot obfs-server -v -f /var/run/obfs-server.pid -s 0.0.0.0 -p $OBFS_PORT --obfs http -r 127.0.0.1:$(cat /etc/shadowsocks-python/config.json |jq -r .server_port))" | crontab -

echo "ss://$(echo -n "$(cat /etc/shadowsocks-python/config.json |jq -r .method):$(cat /etc/shadowsocks-python/config.json |jq -r .password)"  |base64)@$(curl -fsSL http://ipinfo.io/ip):$OBFS_PORT/?plugin=obfs-local;obfs=http;obfs-host=www.bing.com#自建-$(curl -fsSL http://ipinfo.io/ip)-obfs"
