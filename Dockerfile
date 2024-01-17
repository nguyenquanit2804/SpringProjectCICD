# Stage 1: Build JAR
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /workspace/app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY ./src ./src
RUN ./mvnw clean install

# Stage 2: Create a minimal image with JRE and the built JAR
FROM maven:3.8.4-openjdk-11
WORKDIR /opt/app
COPY --from=build /opt/app/target/*.jar /opt/app/*.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/opt/app/springCICD.jar"]