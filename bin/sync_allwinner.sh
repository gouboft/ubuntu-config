#!/bin/bash

for repo_path in $(repo list | awk -F " : " '{print $2}')
do
    if [ "${repo_path:0:2}" == "rk" ]
    then
        if [ "${repo_path:0:11}" == "rk/platform" ]
        then
            cd  $(echo $repo_path | sed "s/^rk\/platform\///g")
            path=$(echo $repo_path | sed "s/^rk\///g")
	    echo "1111111111111111"
	elif [ "${repo_path:0:11}" == "rk/hardware" ]
        then
	    cd $(echo $repo_path | sed "s/^rk\///g")
            path=$(echo $repo_path | sed "s/^rk/platform/g")
	    echo "22222222222222222"
	elif [ "${repo_path:0:9}" == "rk/device" ]
        then
            cd  $(echo $repo_path | sed "s/^rk\///g")
            path=$(echo $repo_path | sed "s/^rk\///g")
	    echo "33333333333333333333"
        else
            cd  $(echo $repo_path | sed "s/^rk\///g")
            path=$(echo $repo_path | sed "s/^rk/platform/g")
	    echo "444444444444444444"
	fi
	git remote rm jbs
        git remote add jbs ssh://venus/home/git/android/kitkat/$path
        git push jbs HEAD:kitkat-rk3026
	cd -
	continue
    else
        cd  $(echo $repo_path | sed "s/^platform\///g")
    fi
    echo $repo_path
    pwd
    #git remote add jbs ssh://venus/home/git/android/kitkat/$repo_path
    git push jbs HEAD:kitkat-rk3026
    cd - > /dev/null
    echo ""
done
