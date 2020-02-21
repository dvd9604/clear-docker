# CLEAR LAB Docker Files

This repository holds several docker files for the UTSA CLEAR Lab.
These docker files are intended for teaching/educational purposes only, and should not be deployed in production environments.



## Docker Installation and Configuration 
```shell
# run this install in the VM over ssh

# snap install docker and docker compose 
sudo snap install docker


# add user to docker group

sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot now 

# Wait for VM to come back up
# This takes around 10-15 seconds

```
