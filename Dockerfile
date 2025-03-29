# Use Maven with Java 17 (to match your Spring Boot version)
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy just the POM first (to leverage Docker layer caching)
COPY pom.xml .

# Download dependencies before copying the full source (better caching)
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the application (skip tests for faster build)
RUN mvn clean package -DskipTests

# Use a lightweight JDK image for running the app
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built JAR from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose the correct port (check application.properties)
EXPOSE 9090

# Run the application
CMD ["java", "-jar", "app.jar"]
