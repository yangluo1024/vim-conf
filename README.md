## Description 
   perfect support Go and Rust, and used some perfect Plugin (universal-ctags, YouCompleteMe, airline, fzf and so on.),   
   MacVim app is better than Iterm2   
   enjoy it! 

## Install
```sh
    $ git clone https://github.com/jacksoom/vim-conf.git
    $ defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms), speeding your keyboard
    $ defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
    $ ln -s vim-conf/init.vim $HOME/.vimrc
    $ ln -s vim-conf/ $HOME/.vim
    $ vim ~/.vimrc 删除不能添加的Plugin:
      Plugin 'w0rp/ale'
      Plugin 'luochen1990/rainbow'
      Plugin 'liuchengxu/space-vim-dark'
      Plugin 'git://git.wincent.com/command-t.git'
      Plugin 'jremmen/vim-ripgrep'
      Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
      Plugin 'jodosha/vim-godebug'
      Plugin 'neoclide/coc.nvim', {'branch': 'release'}
      保存退出
    $ 安装vundle和YouCompleteMe
      1 git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle  
      2 git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe  
      3 cd ~/.vim/bundle/YouCompleteMe  
      4 git submodule update --init --recursive
    $ 打开vim, 命令模式输入：VundleInstall安装插件
    $ vim  # install some vundle package ,  :VundleInstall
    $ cd ~/.vim/bundle/YouCompleteMe  # install ycm, 
    $ python3 install.py --go-completer # go support, guide: ycm-core.github.io/YouCompleteMe
    $ python3 install.py --rust-completer # rust rupport
    $ # install ctags (https://github.com/universal-ctags/ctags).
    $ # you should modify the binary file URL of my personal relative paths in the .vimrc

```
## Env
   vim 8.0+


## Preview
![preview](preview.png)
