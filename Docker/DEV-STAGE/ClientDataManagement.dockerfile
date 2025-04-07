FROM maven:3.8.6-eclipse-temurin-17 AS dev-builder
WORKDIR /app
COPY pom.xml .
COPY fineract-provider fineract-provider
RUN mvn -f fineract-provider/pom.xml dependency:go-offline
COPY . .
CMD ["mvn", "spring-boot:run", "-Dspring-boot.run.jvmArguments=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"]
EXPOSE 8080 5005