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
    curl -sSL 'https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh' -O 'v2ray-install.sh' && chmod +x v2ray-install.sh && ./v2ray-install.sh
}

bench_install() {
    curl -sSL 'https://raw.githubusercontent.com/teddysun/across/master/bench.sh' -O 'bench.sh' && chmod +x bench.sh && ./bench.sh
}

menu() {
    echo "1. docker install"
    echo "2. docker-compose install"
    echo "3. oh-my-zsh install"
    echo "4. ss install"
    echo "5. bbr install"
    echo "6. v2ray install"
    echo "7. bench"
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
    0)
        exit 0
        ;;
    *)
        echo "Please input a number between 1 to 7"
        ;;
    esac
}

menu
