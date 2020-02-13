# Openstack CLI Docker

## Build docker image

```shell
# clone repo
git clone

# cd into openstack dir
cd ./openstack

# build image and tag it with your username
docker build . -t dvd9604/openstackcli
```

## Run in interactive mode

```shell
# source RC FILE to set ENV vars OS_PASSWORD
source <rcfile>

# pass ENV OS vars to container
docker run -it --env-file <(env | grep OS_) dvd9604/openstackcli
```

## Run in detached/adhoc mode

```shell
# source RC FILE to set ENV vars OS_PASSWORD
source <rcfile>

# run container in detached mode
docker run -id --rm --env-file <(env | grep OS_) --name openstack-client dvd9604/openstackcli

# call openstack cli commands
docker exec openstack-client openstack <command>
```
