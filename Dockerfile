# Stage 1: Build the application
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn -Dmaven.test.failure.ignore=true clean package

# Stage 2: Create a minimal JRE image and copy the JAR file
FROM adoptopenjdk:11-jre-hotspot
WORKDIR /app
COPY --from=build /app/target/*.jar /app/springProjectCICD.jar

# Expose port 8080
EXPOSE 8080

# Set the entry point to run the Spring Boot application with Maven
ENTRYPOINT ["java", "-jar", "/app/springProjectCICD.jar"]