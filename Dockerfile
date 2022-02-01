FROM openjdk:8-jre-alpine
EXPOSE 8181
COPY /target/spring-petclinic-2.6.0-SNAPSHOT.jar /usr/bin/spring-petclinic.jar
ENTRYPOINT ["java","-jar","/usr/bin/spring-petclinic.jar","--server.port=8080"]
