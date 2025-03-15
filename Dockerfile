FROM maven:3.8.3-openjdk-17 AS stage_build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

#Can replace jdk by jre if want a lighter container
FROM openjdk:17.0.1-jdk-slim
COPY --from=stage_build /app/target/*.jar database-service.jar
ENTRYPOINT ["java", "-jar", "database-service.jar"]