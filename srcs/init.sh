#ANSI codes used to add colors on my printf / echos
RED='\033[0;31m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NONE='\033[0m'


# Creation of my server folder and setting permissions
mkdir /var/www/salimonserver
chown www-data -R /var/www/salimonserver/
chmod -R 755 /var/www
chmod -R 755 /var/www/*


# SSL protocol
echo -e "Waiting for the ${PURPLE}SSL ${NONE}protocol..."
mkdir /etc/nginx/ssl
chmod 750 /etc/nginx/ssl
openssl req -x509 -newkey rsa:4096 -nodes -out /etc/nginx/ssl/salimonserver.csr -days 365 -keyout /etc/nginx/ssl/salimonserver.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=salimon/CN=salimonserver"
#la commande du dessus génère une clé de chiffrement rsa de 4096 bits ainsi que le certificat ssl. Nodes, 'no des' skip le passphrase prompt. Keyout save la clé privée à l'emplacement qui suit la commande, out spécifie où le fichier du certicat sera srocké. ENfin, le switch subj permet de répondre au formulaire du csr automatiquement.
#x509 pour lire contenu certificat
chmod 500 /etc/nginx/ssl/salimonserver.csr


# NGINX configuration
echo -e "Waiting for ${PURPLE}Nginx ${NONE}server configuration..."
mv nginx.conf /etc/nginx/sites-available/salimonserver
ln -s /etc/nginx/sites-available/salimonserver /etc/nginx/sites-enabled/salimonserver
rm -rf /etc/nginx/sites-enabled/default


# MYSQL database
echo -e "Waiting for ${PURPLE}MySQL ${NONE}database creation..."
service mysql restart
echo "CREATE DATABASE mydatabase;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON mydatabase.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root
# above line gives privileges on all tables database to the user
echo "FLUSH PRIVILEGES;" | mysql -u root
# 'flush privilege' is needed so that the changes on privileges are taken into account before update
echo "update mysql.user set plugin='' where user='root';" | mysql -u root
# if we do not provide a password to root user durind the installation, it will use auth_socket plugin for authentification


# PHPMYADMIN configuration
echo -e "Waiting for ${PURPLE}phpmyadmin ${NONE}configuration..."
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
mv phpMyAdmin-5.0.1-english phpMyAdmin
mv phpMyAdmin /var/www/salimonserver
mv phpmyadmin-config.inc.php config.inc.php
mv config.inc.php /var/www/salimonserver/phpMyAdmin/config.inc.php


# WORDPRESS creation
echo -e "Waiting for the ${PURPLE}Wordpress ${NONE}creation..."
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz && rm -rf latest.tar.gz
mv wordpress /var/www/salimonserver
mv wp-config.php /var/www/salimonserver/wordpress


# Start of services
echo -e "Start of services..."
nginx -t
service nginx restart
service nginx status
service php7.3-fpm start

echo "Check if the salimonserver folder as been created :"
cd /var/www/salimonserver
pwd
echo "salimonserver contain :"
ls

echo "Here is my ssl certificate :"
cd /etc/nginx/ssl
ls -la

echo -e "${GREEN}You can now type '${NONE}127.0.0.1${GREEN}' or '${NONE}localhost${GREEN}' in your internet browser to check my server services :)"
sleep infinity & wait