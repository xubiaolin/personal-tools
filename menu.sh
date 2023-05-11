docker_install() {
    curl -sSL 'https://get.docker.com' | sh
}

docker_compose_install() {
    apt install docker-compose -y
}

oh_my_zsh_install() {
    sh -c "$(curl -fsSL https://ghproxy.markxu.online/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

ss_install() {
    curl -sSL 'https://raw.githubusercontent.com/xubiaolin/personal-tools/master/cross/ss-install.sh' -O && chmod +x ss-install.sh && ./ss-install.sh
}

bbr_install() {
    wget -O tcpx.sh "https://github.com/ylx2016/Linux-NetSpeed/raw/master/tcpx.sh" && chmod +x tcpx.sh && ./tcpx.sh
}

v2ray_install() {
    curl -sSL 'https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh' -o 'v2ray-install.sh' && chmod +x v2ray-install.sh && ./v2ray-install.sh
}

bench_install() {
    curl -sSL 'https://raw.githubusercontent.com/teddysun/across/master/bench.sh' -o 'bench.sh' && chmod +x bench.sh && ./bench.sh
}

update_timezone(){
    apt-get update
    apt-get install -y tzdata
    timedatectl set-timezone Asia/Shanghai
    systemctl restart systemd-timedated
    date
}

update_nodejs(){
    curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt update 
    sudo apt-get install -y nodejs
}

install_yarn(){
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn
}



menu() {
    echo "1. docker install"
    echo "2. docker-compose install"
    echo "3. oh-my-zsh install"
    echo "4. ss install"
    echo "5. bbr install"
    echo "6. v2ray install"
    echo "7. bench"
    echo "8. update timezone"
    echo "9. update nodejs"
    echo "10. install yarn"

    echo "0. exit"
    read -p "Please input your choice: " choice
    case $choice in
    1)
        docker_install
        ;;
    2)
        docker_compose_install
        ;;
    3)
        oh_my_zsh_install
        ;;
    4)
        ss_install
        ;;
    5)
        bbr_install
        ;;
    6)
        v2ray_install
        ;;
    7)
        bench_install
        ;;
    8)
        update_timezone
        ;;
    9)
        update_nodejs
        ;;
    10)
        install_yarn
        ;;
    0)
        exit 0
        ;;
    *)
        echo "Please input a number between 1 to 7"
        ;;
    esac
}

menu
