# Use a specific version of Tomcat as base image
#FROM tomcat:8.0.20-jre8

# Expose port 8080 to access the application
#EXPOSE 8080

# Copy the WAR file from the target directory of your Maven project to the Tomcat webapps directory
#COPY target/maven-cloudaseem-app.war /usr/local/tomcat/webapps/




FROM maven:33.9.9-eclipse-temurin-11

WORKDIR /app

# Copy just the POM first (for better layer caching)
COPY pom.xml .
# Download dependencies (creates cached layer)
RUN mvn dependency:go-offline

# Copy source
COPY src ./src

# Run with DevTools support
CMD ["mvn", "spring-boot:run"]