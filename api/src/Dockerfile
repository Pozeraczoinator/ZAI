FROM openjdk:17
ARG JAR_FILE=api/build/libs/*.jar 
COPY .env ./
COPY api/src/main/resources/keystore.p12 /app/keystore.p12
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
