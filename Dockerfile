# Set the base image to Ubuntu
FROM ubuntu

# Update the repository sources list
RUN apt-get update
RUN apt-get install -my wget gnupg
################## BEGIN INSTALLATION ######################
# Install MongoDB Following the Instructions at MongoDB Docs
# Ref: http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

# Add the package verification key
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

# Add MongoDB to the repository sources list
RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list

# Update the repository sources list once more
RUN apt-get update

# Install MongoDB package (.deb)
RUN apt-get install -y mongodb-org

# Create the default data directory
RUN mkdir -p /data/db

##################### INSTALLATION END #####################

# Expose the default port
EXPOSE 27017

# Default port to execute the entrypoint (MongoDB)
# CMD ["--port 27017"]
CMD ["--port 27017", "--smallfiles"]

# Set default container command
ENTRYPOINT usr/bin/mongod

FROM openjdk:8-jre-alpine
WORKDIR /app

FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY . /app
RUN mvn clean install 

COPY /app/target/maverick-v6-0.0.1-SNAPSHOT.jar /app 
CMD ["mvn spring-boot:run"]

