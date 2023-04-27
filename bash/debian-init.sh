set -ex

apt update

# docker
curl 'https://get.docker.com' | sh

# docker-compose
apt install docker-compose -y

# oh-my-zsh
sh -c "$(curl -fsSL https://ghproxy.markxu.online/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
