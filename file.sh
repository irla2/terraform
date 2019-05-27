#!/bin/bash
sudo apt update 
sudo apt install apache2 -y
sudo service apache2 start
echo "<html><h1>hello!!!!!!!!!!^^</h2><html>" >/var/www/html/index.html