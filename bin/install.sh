#!/bin/bash

set -e

# 渡された変数の展開
[ -z "$DOT_PROTOCOL" ] && DOT_PROTOCOL='https'

case "$DOT_PROTOCOL" in
	"https"	) DOT_URI="${DOT_PROTOCOL}://github.com/miyabihito/dotfiles.git" ;;
	"ssh"	) DOT_URI="git@github.com:miyabihito/dotfiles.git" ;;
	*	) echo "Unexpected value \"$DOT_PROTOCOL\" for \$DOT_PROTOCOL" >&2
		  exit 1 ;;
esac

[ -z "$DOT_DIR" ] && DOT_DIR=~/dotfiles


# GitHubからリポジトリをクローン
git clone "$DOT_URI" "$DOT_DIR"


# ドットファイルをホームディレクトリにシンボリックリンク
DOT_FILE_LIST=(".bash_profile" ".bashrc" ".gitconfig" ".tmux.conf" ".vimrc")
for DOT_FILE in ${DOT_FILE_LIST[@]}
do
	ln -is "$DOT_DIR"/"$DOT_FILE"  ~/
done
