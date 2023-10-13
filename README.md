# In Home:
* git clone https://github.com/slsh/dotfiles.git
* cd dotfiles
* chmod +x pre-install.sh
* chmod +x install.sh
* ./pre-install.sh
* ./install.sh

# In case of several git accounts at the same service -
To make use of the `swuser USER` command, do the following

1. Generate ssh keys and name the files after the users
2. Copy the content of "config" into ~/.ssh/config
3. Replace `user1` and `user2` in the config-file with your usernames 
