#!/bin/bash
cd
for n in bashrc bash_profile inputrc kermrc gitconfig gitignore tmux.conf
do
	ln -sfv -T .rc/$n .$n
done
cd - >&/dev/null
