FROM maven:3.8.5-openjdk-11 as  builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

#stage 2
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar ./app.jar
ENTRYPOINT ["java","-jar","app.jar"]
