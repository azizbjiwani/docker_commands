docker -v
sudo service docker start
sudo docker ps
sudo service docker stop

sudo docker container run ubuntu:16.04 /bin/echo 'Hello world'
sudo docker container run -t -i ubuntu:16.04 /bin/bash
exit

sudo docker container run -d ubuntu:16.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
sudo docker logs 91b500693e46
sudo docker logs vigorous_chandrasekhar
sudo docker container stop 91b500693e46

sudo docker container run --name my-nginx-1 -P -d nginx
curl http://localhost:32768

#We can stop the container and remove:
sudo docker ps
sudo docker container stop 24a40c4b2b33
sudo docker container rm 24a40c4b2b33

#If we want to map the container's port 80 to a specific port of the host, we can use -p with host_port:docker_port
sudo docker container run --name my-nginx-1 -p8088:80 -d nginx
sudo docker exec -it 084d31dca0e9 /bin/bash

#Keep the Content and Configuration on the Docker Host
sudo docker container run --name my-nginx-2 -v /tmp/nginx/html:/usr/share/nginx/html:ro -p8088:80 -d nginx

#Copying files from the Docker host
sudo docker image build -t my-nginx-image-1 .

#Now we can create a container using the image by running the command (run command creates new container.. container will remain untill it is explicitly deleted)
docker container run --name my-nginx-3 -P -d my-nginx-image-1
docker container run --name my-nginx-3 -p8088:80 -d my-nginx-image-1

#docker search searches registry for image
sudo docker search ubuntu

#Download images - docker pull
sudo docker pull ubuntu

#Listing images on docker host (localhost) - docker images
sudo docker images

#List containers on docker host
sudo docker ps -a

#Running container - docker run
docker run -it ubuntu:latest /bin/bash
root@859d4a27d4c8:/# whoami
root@859d4a27d4c8:/# cat /etc/*release
root@859d4a27d4c8:/# top

#Getting out of a container without stopping it
"Ctrl + P + Q" will do the trick:
k@laptop:~$ pa aux | grep top
k@laptop:~$ docker ps
k@laptop:~$ docker attach 859d4a27d4c8

#Start, Stop, attach
sudo docker attach 98731ad42ddd
sudo docker ps
sudo docker run -it my-nginx-image-2 /bin/bash
sudo docker exec -it 98731ad42ddd /bin/bash
sudo docker start hungry_keldysh
sudo docker stop hungry_keldysh

#Check what processes are running inside a container
sudo docker top hungry_keldysh

#What's in our system related to the Docker containers?
sudo ls -lrht /var/lib/docker/containers

#Container host info:
sudo vi /var/lib/docker/containers/2e3ac07b52c1aa617f37b6e29c8360101b7e9fc4932716d1f0465615355f584f/hosts
172.17.0.2      2e3ac07b52c1

#Container port info:
sudo vi /var/lib/docker/containers/2e3ac07b52c1aa617f37b6e29c8360101b7e9fc4932716d1f0465615355f584f/hostconfig.json
PortBindings":{"80/tcp":[{"HostIp":"","HostPort":"8088"}]}
where 80 is port of nginx running inside container
8088 is port of docker host
http://dockerHost:8088  -- to access over web

#
sudo vi /var/lib/docker/containers/2e3ac07b52c1aa617f37b6e29c8360101b7e9fc4932716d1f0465615355f584f/config.v2.json
ExposedPorts":{"80/tcp":{}}NGINX_VERSION=1.17.0; {"maintainer":"NGINX Docker Maintainers; "MountPoints":{"/myVolume-1":{"Source":"","Destination":"/myVolume-1","RW":true

#docker image info is kept in 
sudo docker images
sudo /var/lib/docker/image/overlay2/repositories.json

#Docker search from registry
sudo docker search ubuntu
sudo docker search --filter=stars=100 

#Docker pull
sudo docker pull ubuntu
sudo docker images

#Docker run
sudo docker pull centos:latest
sudo docker images
sudo docker run -it centos:latest /bin/bash

#Docker ps - list containers
ps -a

#Docker restart
sudo docker restart 094c1d83c36f

#Docker attach
sudo docker attach 094c1d83c36f

#Docker remove containers
sudo docker rm ab89c860baa0 9b6a7ff8ad66 dd4a85e14bb3

#Remove all images and containers
To delete all containers:
sudo docker rm $(docker ps -a -q)
To delete all images:
sudo docker rmi $(docker images -q)

#Saving container- docker commit
sudo docker commit 2e3ac07b52c1 my-nginx-image-2

#
sudo docker inspect nginx
sudo docker images --no-trunc=true

#docker network interfaces
sudo docker network ls
sudo docker system prune
WARNING! This will remove:
        - all stopped containers
        - all networks not used by at least one container
        - all dangling images
        - all build cache
Are you sure you want to continue? [y/N] y
Deleted Containers:

sudo docker network inspect bridge
ip a
//docker0: >> inet 172.17.0.1/16  
    
#Creating a custom (user defined) docker bridge network and attaching a container to the network  
docker network create -d bridge my-bridge-network  
docker run -d -p 8088:80 --name nginx-server1 nginx:alpine  
docker inspect nginx-server1  
docker run -d -p 8788:80 --network="my-bridge-network" --name nginx-server2 nginx:alpine  
docker inspect nginx-server2  
docker exec -it nginx-server2 sh  
ping nginx-server1  
#ping: bad address 'nginx-server1'  
# The 2nd server not talking to the 1st server since they are in different networks    
#Remove - docker network rm    
docker network rm 43539acb896e  




































