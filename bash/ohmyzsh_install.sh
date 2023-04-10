sh -c "$(curl -fsSL https://ghproxy.markxu.online/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://ghproxy.markxu.online/https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://ghproxy.markxu.online/https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "bindkey '^ ' autosuggest-accept" >> $HOME/.zshrc

echo "自行修改主题为clean"
echo "修改插件为：git zsh-syntax-highlighting  zsh-autosuggestions"
