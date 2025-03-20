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

# 创建并配置swap的函数
setup_swap() {
    # 默认参数
    local multiplier=${1:-2}    # swap大小倍数，默认2倍内存
    local swappiness=${2:-70}   # swap使用偏好，默认70
    local swapfile=${3:-"/swapfile"}  # swap文件路径，默认/swapfile

    # 以root权限运行检查
    if [ "$EUID" -ne 0 ]; then
        echo "请以root权限运行此脚本"
        return 1
    fi

    # 获取物理内存大小（单位：MB）
    local MEM_SIZE=$(free -m | awk '/^Mem:/{print $2}')
    local SWAP_SIZE=$((MEM_SIZE * multiplier))

    echo "检测到物理内存: ${MEM_SIZE}MB"
    echo "将创建 ${SWAP_SIZE}MB 的swap空间"

    # 检查目标路径是否有足够空间
    local available_space=$(df -m $(dirname "$swapfile") | awk 'NR==2 {print $4}')
    if [ "$available_space" -lt "$SWAP_SIZE" ]; then
        echo "错误：磁盘空间不足，需要 ${SWAP_SIZE}MB，可用 ${available_space}MB"
        return 1
    fi

    # 创建swap文件
    echo "正在创建swap文件: $swapfile..."
    fallocate -l ${SWAP_SIZE}M "$swapfile"

    # 设置正确的权限
    chmod 600 "$swapfile"

    # 设置swap区域
    echo "设置swap区域..."
    mkswap "$swapfile"

    # 启用swap
    echo "启用swap..."
    swapon "$swapfile"

    # 设置swappiness
    echo "设置swappiness为${swappiness}..."
    sysctl vm.swappiness="$swappiness"
    echo "vm.swappiness=${swappiness}" >> /etc/sysctl.conf

    # 添加到fstab
    if ! grep -q "$swapfile" /etc/fstab; then
        echo "$swapfile none swap sw 0 0" >> /etc/fstab
    fi

    # 显示结果
    echo "当前内存和swap状态："
    free -m

    echo "swap设置完成！"
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
    echo "11. enable swap"

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
    11)
       setup_swap 
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
