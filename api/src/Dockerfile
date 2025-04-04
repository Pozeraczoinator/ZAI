FROM openjdk:17
ARG JAR_FILE=api/build/libs/*.jar 
COPY .env ./
COPY keystore.p12 api/src/main/resources/keystore.p12
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
