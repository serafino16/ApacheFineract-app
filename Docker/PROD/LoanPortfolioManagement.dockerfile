FROM maven:3.8.6-eclipse-temurin-17 AS prod-builder
WORKDIR /app
COPY pom.xml .
COPY fineract-provider fineract-provider
RUN mvn -f fineract-provider/pom.xml dependency:go-offline
COPY . .
ARG BUILD_PROFILE=prod
RUN mvn -P${BUILD_PROFILE} clean package -DskipTests
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
RUN addgroup -S fineract && adduser -S fineract -G fineract
USER fineract
COPY --from=prod-builder /app/fineract-provider/target/*.jar app.jar
ENV JAVA_OPTS="-Xms512m -Xmx2g -XX:+UseG1GC"
EXPOSE 8080
CMD ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]