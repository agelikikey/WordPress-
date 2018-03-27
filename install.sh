#!/bin/bash -e

echo "================================================================="
echo "4Geeks Academy WordPress Installer!!"
echo "================================================================="

echo "Installing wordpress cli"

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

echo "Running MySQL"
mysql-ctl start

# if the user didn't say no, then go ahead an install
if [ "$run" == n ] ; then
exit
else

# add a simple yes/no confirmation before we proceed
echo "Run Install? (y/n)"
read -e run

# accept the name of our website
echo "Site Name: "
read -e sitename

# accept the name of our website
echo "Site Password: "
read -s sitepassword


# download the WordPress core files
wp core download

# create the wp-config file with our standard setup
wp core config --dbname="c9" --dbuser=$C9_USER --dbpass= --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'DISALLOW_FILE_EDIT', true );
PHP

# parse the current directory name
currentdirectory=${PWD##*/}

# create database, and install WordPress
wp core install --url="http://$C9_HOSTNAME/$currentdirectory" --title="$sitename" --admin_user="$C9_USER" --admin_password="$sitepassword" --admin_email=$C9_EMAIL

# discourage search engines
wp option update blog_public 0

# set pretty urls
wp rewrite structure '/%postname%/' --hard
wp rewrite flush --hard

# delete akismet and hello dolly
wp plugin delete akismet
wp plugin delete hello

clear

echo "================================================================="
echo "Installation is complete. Your WordPress username/password is listed below."
echo ""
echo "Username: $C9_USER (for wordpress and your database)" 
echo "Password: (whatever you specified earlier)"
echo ""
echo "To access your database: https://$C9_HOSTNAME/$currentdirectory/phpmyadmin"
echo ""
echo "================================================================="

fi