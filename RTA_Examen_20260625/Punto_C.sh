#!/bin/bash

cd ~/UTN-FRA_SO_Examenes/202406/docker/
sudo docker build -t agustingustavodiazmazzotta/web1-mazzotta .
sudo docker run -d -p 8080:80 --name web1-mazzotta agustingustavodiazmazzotta/web1-mazzotta
sudo docker login
sudo docker push agustingustavodiazmazzotta/web1-mazzotta
