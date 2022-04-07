#! /bin/bash
apt-get update
apt-get install -y apache2
systemstl start apache2
systemstl enable apache2
echo "<h1> Hello Apace!!!<h1>" | sudo tee /var/www/html/index.html