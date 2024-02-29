#!/bin/bash

cat bashrc.additions >> ~/.bashrc

cp ./.gitconfig ~

# powerline fonts for zsh theme
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd .. && rm -rf fonts

# oh-my-zsh & plugins
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
zsh -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
zsh -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
cp ./.zshrc ~


zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-nvm                               "
    echo "-----------------------------------------------------------"
    git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm
    echo "==========================================================="
    echo "             cloning asdf zsh plugin                       "
    echo "-----------------------------------------------------------"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    echo "==========================================================="
    echo "             cloning autojump                              "
    echo "-----------------------------------------------------------"
    git clone git://github.com/wting/autojump.git ~/autojump
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "             cloning zsh-syntax-highlighting               "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "==========================================================="
    echo "             cloning cd-reminder                           "
    echo "-----------------------------------------------------------"
    git clone https://github.com/bartboy011/cd-reminder ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/cd-reminder
    echo "==========================================================="
    echo "             cloning zsh-bd                                "
    echo "-----------------------------------------------------------"
    git clone https://github.com/Tarrasch/zsh-bd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/bd
    echo "==========================================================="
    echo "             cloning zsh-better-npm-completion             "
    echo "-----------------------------------------------------------"
    git clone https://github.com/lukechilds/zsh-better-npm-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-better-npm-completion
    echo "==========================================================="
    echo "             cloning zsh-auto-notify                       "
    echo "-----------------------------------------------------------"
    git clone https://github.com/MichaelAquilina/zsh-auto-notify.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/auto-notify
    echo "==========================================================="
    echo "             cloning zsh-dircolors-nord                    "
    echo "-----------------------------------------------------------"
    git clone --recursive https://github.com/coltondick/zsh-dircolors-nord.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-dircolors-nord
    echo "==========================================================="
    echo "             cloning caniuse                               "
    echo "-----------------------------------------------------------"
    git clone --recursive https://github.com/walesmd/caniuse.plugin.zsh.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/caniuse
    echo "==========================================================="
    echo "             cloning fzf-zsh-plugin                        "
    echo "-----------------------------------------------------------"
    git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin
    echo "==========================================================="
    echo "             cloning powerlevel10k                         "
    echo "-----------------------------------------------------------"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    cat .zshrc > $HOME/.zshrc
    echo "==========================================================="
    echo "             import powerlevel10k                          "
    echo "-----------------------------------------------------------"
    cat .p10k.zsh > $HOME/.p10k.zsh
}


zshrc

# make directly highlighting readable - needs to be after zshrc line
echo "" >> ~/.zshrc
echo "# remove ls and directory completion highlight color" >> ~/.zshrc
echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc

########################################################################################################################
#### set powerlevel10k/powerlevel10k as theme
#### in vscode settings for devcontainer (not for User or Workspace), 
#### Search for terminal.integrated.fontFamily value, and set it to "Roboto Mono for Powerline" (or any of those: https://github.com/powerline/fonts#font-families font families).
# save current zshrc
mv ~/.zshrc ~/.zshrc.bak

sudo sh -c "$(wget -O- https://raw.githubusercontent.com/deluan/zsh-in-docker/master/zsh-in-docker.sh)" -- \
    -t powerlevel10k/powerlevel10k

# remove newly created zshrc
rm -f ~/.zshrc
# restore saved zshrc
mv ~/.zshrc.bak ~/.zshrc
# update theme
sed -i '/^ZSH_THEME/c\ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc 
