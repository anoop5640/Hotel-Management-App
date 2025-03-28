FROM maven:3.8.6-openjdk-17

WORKDIR /app

# Copy just the POM first (for better layer caching)
COPY pom.xml .
# Download dependencies (creates cached layer)
RUN mvn dependency:go-offline

# Copy source
COPY src ./src

# Run with DevTools support
CMD ["mvn", "spring-boot:run"]