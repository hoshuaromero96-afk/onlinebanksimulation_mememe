# Stage 1: Build the Java application using Maven
FROM maven:3.9.12-eclipse-temurin-25 AS build
WORKDIR /app
COPY demo/demo/pom.xml pom.xml
COPY demo/demo/src src
RUN mvn -B package

# Stage 2: Run the built JAR package inside a lightweight container
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
