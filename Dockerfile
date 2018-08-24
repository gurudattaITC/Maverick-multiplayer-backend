FROM openjdk:8-jre-alpine
WORKDIR /app

FROM maven:3.5-jdk-8-alpine
WORKDIR /app

COPY application.properties /app
COPY target/maverick-v6-0.0.1-SNAPSHOT.jar /app

EXPOSE 8080

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/maverick-v6-0.0.1-SNAPSHOT.jar"]
