FROM maven:3.8.5-openjdk-11 AS maven_build
# Use the official Jenkins image as the base image
FROM jenkins/jenkins:latest

COPY pom.xml /tmp/
# Switch to the root user for installation
USER root

COPY src /tmp/src/
# Update the package manager and install required packages
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

WORKDIR /tmp/
# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN mvn package
# Add Docker CE repository
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

#pull base image
# Install Docker CE and tini
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io tini

FROM eclipse-temurin:11

#expose port 8080
EXPOSE 8080
# Optional: Install Docker Compose (uncomment the following lines if needed)
# USER root
# RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# RUN chmod +x /usr/local/bin/docker-compose
# USER jenkins

#default command
CMD java -jar /data/hello-world-0.1.0.jar
# Optionally, configure Docker permissions (you may need to adjust this depending on your use case)
# RUN usermod -a -G docker jenkins

#copy hello world to docker image from builder image
# Other configurations and plugins can be added here

COPY --from=maven_build /tmp/target/hello-world-0.1.0.jar /data/hello-world-0.1.0.jar
# Start Jenkins
ENTRYPOINT ["/bin/bash"]