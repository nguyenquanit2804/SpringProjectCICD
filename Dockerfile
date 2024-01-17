FROM adoptopenjdk/openjdk11:alpine-jre
ADD target/springCICD-2.7.2.jar springCICD.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar", "-Dtrust_all_cert=true", "-Duser.timezone=Asia/Ho_Chi_Minh", "-Doracle.jdbc.timezoneAsRegion=false","springCICD.jar"]
