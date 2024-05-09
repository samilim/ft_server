# server

### Consignes du projet
- Vous devrez, dans un seul container Docker, mettre en place un serveur web avec
Nginx. Le container devra tourner avec Debian Buster
- Votre serveur devra être capable de faire tourner plusieurs services en même temps.
Les services seront un Wordpress à installer par vous même, ainsi que Phpmyadmin
et MySQL. Vous devrez vous assurer que votre base de donnée SQL fonctionne
avec le wordpress et phpmyadmin.
- Votre serveur devra pouvoir, quand c’est possible, utiliser le protocole SSL.
- Vous devrez vous assurer que, selon l’url tapé, votre server redirige vers le bon
site.
- Vous devrez aussi vous assurer que votre serveur tourne avec un index automatique
qui doit pouvoir être désactivable.

____________________

## For my evaluator

- docker build -t containername .
- docker run -it -p 80:80 -p 443:443 containername
- Open your browser, then type the '127.0.0.1' or 'localhost' url to access your local server.
- Click on the padlock icon to check my ssl certificate.
- You can then check if the database is working with the phpmyadmin and wordress services. Use 'root' as username and no password for phpmyadmin.
- (I made 2 scripts in srcs folder if you want to activete/deactivate the autoindex)

After the evaluation, you can use 
sudo docker system prune -a --volumes 
To delete all docker containers & images

And dont forget to stop the services with :
service ngninx stop
service mysql stop

______________________________________________________________________

### Comprendre l'utilité du docker
https://www.journaldunet.fr/web-tech/dictionnaire-du-webmastering/1445240-conteneur-en-informatique-definition-precise-et-fonctionnement/

### Le Dockerfile
Sert à build le container. Il permet de construire une image docker étape par étape de façon automatisée. Un conteneur est ainsi créé.
Ici, docker-compose est interdit. 
Docker permet ainsi le transport et l'utilisation d'applications de manière fluide entre différents environnements.

### srcs
Contient tous les fichiers nécessaires au wordpress.
A savoir;
- un script (.sh) qui initialisera le container
- trois fichiers de configuration pour wordpress, phpmyadmin et ngninx


______________________________________________________________________


### La difference entre serveur statique et serveur dynamique
https://waytolearnx.com/2018/12/difference-entre-php-et-html.html
Les pages Web statiques sont celles dont le contenu ne peut pas changer que si un développeur modifie son code source. Tandis que les pages Web dynamiques peuvent afficher un contenu différent à partir du même code source.
https://business-antidote.com/difference-entre-site-statique-et-site-dynamique/
Le serveur statique ne contient que l'OS et le serveur http


____________
## notes

### Les ports 80 et 443
80 : port HTTP
443 : port pour trafic sécurisé


### Le protocole SSL

https://www.youtube.com/watch?v=_UpuZ0Y3k-c

Chiffre et sécurise les données échangée avec le serveur et identifie les machines pour s'assurer que les échanges se font bien entre les bons appareils.
La cryptographie est dite 'symétrique' car elle utilise une clé commune au serveur et au client.


### La commande brew
gestionnaire de paquets (à voir)
