#!/bin/bash

function rm_exist_remote()
{
    exist_remote_name=$1 
    remote_names=`git remote show`
    for name in $remote_names
    do
	if [ "$name" == "$exist_remote_name" ]; then
	    git remote rm $exist_remote_name 
	    break
	fi
    done    
}

for repo_path in $(repo list | awk -F " : " '{print $2}')
do
    if [ "${repo_path:0:2}" == "rk" ]; then
	if [ "${repo_path:0:11}" == "rk/platform" ]; then
	    cd  $(echo $repo_path | sed "s/^rk\/platform\///g")
	    path=$(echo $repo_path | sed "s/^rk\///g")
	    echo "========================= rk/platform =========================="
	elif [ "${repo_path:0:11}" == "rk/hardware" ]; then
	    cd $(echo $repo_path | sed "s/^rk\///g")
	    path=$(echo $repo_path | sed "s/^rk/platform/g")
	    echo "========================= rk/hardware =========================="
	elif [ "${repo_path:0:9}" == "rk/device" ]; then
	    cd  $(echo $repo_path | sed "s/^rk\///g")
	    path=$(echo $repo_path | sed "s/^rk\///g")
	    echo "========================= rk/device =========================="
	elif [ "${repo_path:0:9}" == "rk/vendor" ]; then
	    cd  $(echo $repo_path | sed "s/^rk\///g")
	    path=$(echo $repo_path | sed "s/^rk/platform\/rk/g")
	    echo "========================= rk/vendor =========================="
	elif [ "${repo_path:0:9}" == "rk/RKDocs" ]; then
	    cd  $(echo $repo_path | sed "s/^rk\///g")
	    path=$(echo $repo_path | sed "s/^rk/platform\/rk/g")
	    echo "========================= rk/RKDocs =========================="
	elif [ "${repo_path:0:7}" == "rk/rkst" ]; then
	    cd  $(echo $repo_path | sed "s/^rk\///g")
	    path=$(echo $repo_path | sed "s/^rk/platform\/rk/g")
	    echo "========================= rk/rkst =========================="
	elif [ "${repo_path:0:10}" == "rk/RKTools" ]; then
	    cd  $(echo $repo_path | sed "s/^rk\///g")
	    path=$(echo $repo_path | sed "s/^rk/platform\/rk/g")
	    echo "========================= rk/RKTools =========================="
	elif [ "${repo_path:0:9}" == "rk/kernel" ]; then
	    cd  $(echo $repo_path | sed "s/^rk\///g")
	    path=$(echo $repo_path | sed "s/^rk/platform\/rk/g")
	    echo "========================= rk/kernel =========================="
	fi
	rm_exist_remote "jbs"
        pwd
	git remote add jbs ssh://venus/home/git/android/kitkat_rk/$path
        git push jbs HEAD:kitkat-rk3026
	cd -
	echo ""
    else
	cd  $(echo $repo_path | sed "s/^platform\///g")
	echo $repo_path
	rm_exist_remote "jbs"
        pwd
	git remote add jbs ssh://venus/home/git/android/kitkat_rk/$repo_path
	git push jbs HEAD:kitkat-rk3026
	cd - > /dev/null
	echo ""
    fi
done
