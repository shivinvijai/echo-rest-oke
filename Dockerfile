FROM maven:3.6.3-jdk-8 as BUILD

COPY src /usr/src/myapp/src
COPY pom.xml /usr/src/myapp

RUN mvn -f /usr/src/myapp/pom.xml package

#release container
FROM openjdk:8-jre-alpine

ARG BUILD

COPY --from=BUILD /usr/src/myapp/target/* /home/

EXPOSE 8080

CMD ["java", "-jar", "/home/rest.service-0.0.1-SNAPSHOT.jar"]
