#!/usr/bin env bash

#Update the Package
sudo apt update -y
sudo apt upgrade -y

#Install Jenkins
url -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt update -y
sudo apt install -y jenkins

# Enable and start
sudo systemctl enable jenkins
sudo systemctl start jenkins


#Install Docker 
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
sudo systemctl start docker

# allow ubuntu user to run docker without sudo
sudo usermod -aG docker ubuntu
newgrp docker


#Create a Folder for SonarQube 
mkdir ~/sonarqube_data
sudo apt-get install tree
sudo apt-get nginx 

echo "Hello Puneeth Nginx Server is running" | tee var/
