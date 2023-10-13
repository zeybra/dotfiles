alias swuser='f(){ ssh-add -D; ssh-add ~/.ssh/"$@"; unset -f f; }; f'
