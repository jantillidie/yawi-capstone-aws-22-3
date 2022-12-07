#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo systemctl enable docker
sudo docker pull benbusby/whoogle-search
sudo docker run -p 80:5000 -d --name whoogle-search benbusby/whoogle-search:latest
