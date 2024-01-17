# Stage 1: Build JAR
FROM maven:3.8.4-openjdk-11 AS build
COPY mvnw .
COPY pom.xml .
COPY src src
WORKDIR /workspace/app
RUN ./mvnw install -DskipTests

# Stage 2: Create a minimal image with JRE and the built JAR
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /workspace/app/target/*.jar springCICD.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "springCICD.jar"]