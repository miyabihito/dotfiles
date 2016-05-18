#!/bin/bash

set -e


# ドットファイルのインストール
echo 'Begin installing dotfiles.'

[ -z "$DOT_PROTOCOL" ] && DOT_PROTOCOL='https'
case "$DOT_PROTOCOL" in
	"https"	) DOT_URI="${DOT_PROTOCOL}://github.com/miyabihito/dotfiles.git" ;;
	"ssh"	) DOT_URI="git@github.com:miyabihito/dotfiles.git" ;;
	*	) echo "Unexpected value \"$DOT_PROTOCOL\" for \$DOT_PROTOCOL" >&2
		  exit 1 ;;
esac

[ -z "$DOT_DIR" ] && DOT_DIR=~/dotfiles

git clone "$DOT_URI" "$DOT_DIR"

DOT_FILE_LIST=(".bash_profile" ".bashrc" ".gitconfig" ".tmux.conf" ".vimrc")
for DOT_FILE in ${DOT_FILE_LIST[@]}
do
	ln -is "$DOT_DIR"/"$DOT_FILE"  ~/
done

echo 'Done.'


# bash completion,prompt for git のダウンロード
echo 'Begin installing bash completion,prompt for git.'

if [ ! -f ~/.git-completion.bash ]; then
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash --silent --output ~/.git-completion.bash
fi
if [ ! -f ~/.git-prompt.sh ]; then
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh --silent --output ~/.git-prompt.sh
fi

echo 'Done.'


# Vim Pluginのインストール
echo 'Begin installing Vim plugins.'

## Plugin Manager(NeoBundle)のインストール
BUNDLE_DIR=~/.vim/bundle
NEOBUNDLE_DIR="$BUNDLE_DIR/neobundle.vim"

if [ -e "$NEOBUNDLE_DIR" ]; then
	echo "NeoBundle already installed! Installation skipped."
else
	mkdir -p "$BUNDLE_DIR"
	git clone https://github.com/Shougo/neobundle.vim "$NEOBUNDLE_DIR"
fi

## Pluginのインストール
sh "$NEOBUNDLE_DIR"/bin/neoinstall

echo 'Done.'
