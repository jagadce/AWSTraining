#! /bin/bash
apt-get update
apt-get install -y apache2
systemstl start apache2
systemstl enable apache2
echo "<h1> Deployed machine via Terraform<h1>" | sudo tee /var/www/html/index.html