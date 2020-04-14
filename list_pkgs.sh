DATE=$(date "+%Y.%m.%d-%H.%M")
MY_PATH=~saul/.pkg_history

OFF=$MY_PATH/pacman/pkglist_off-$DATE.txt
AUR=$MY_PATH/aur/pkglist_aur-$DATE.txt

pacman -Qqen > $OFF
pacman -Qqem > $AUR

# remove older than 30 days
echo "Removing the following old log files..."
find $MY_PATH -type f -name 'pkglist*' -mtime +30
find $MY_PATH -type f -name 'pkglist*' -mtime +30 -exec rm {} \;
