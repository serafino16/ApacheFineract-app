FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=dev-builder /app/fineract-provider/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
EXPOSE 8080