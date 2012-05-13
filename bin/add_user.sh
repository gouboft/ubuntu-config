#!/bin/bash

# Add new user in ubuntu and generite key ssh key in .ssh
# Usage: add_user.sh username
# username : $name
# home: /home/$name
# passwd: 123456

name=$1
sudo useradd $name -d /home/$name --create-home -s /bin/bash -p 123456 

#Fixme: add the new user into the gerrit2 guoup
#sudo sed -i 's/^gerrit2/*,$name/' /etc/group

#ssh-keygen

#scp ~/.ssh/id_sda.pub $name@server:/home/$name/.ssh


