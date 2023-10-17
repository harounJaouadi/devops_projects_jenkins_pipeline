FROM openjdk:11
EXPOSE 8080
ADD target/hello-world-0.1.0.jar hello-world-0.1.0.jar
ENTRYPOINT ["java", "-jar", "hello-world-0.1.0.jar"]