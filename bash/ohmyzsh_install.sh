apt install zsh -y

sh -c "$(curl -fsSL https://ghproxy.markxu.online/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://ghproxy.markxu.online/https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://ghproxy.markxu.online/https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="clean"/g' ~/.zshrc
echo "bindkey '^ ' autosuggest-accept" >> $HOME/.zshrc

echo "修改插件为：git zsh-syntax-highlighting  zsh-autosuggestions"
