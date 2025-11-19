# --- Build stage ---
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copiar todo el proyecto
COPY . .

# Hacer ejecutable el wrapper de Maven
RUN chmod +x mvnw

# Compilar la app sin tests
RUN ./mvnw package -DskipTests

# --- Runtime stage ---
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copiar el jar construido
COPY --from=build /app/target/*.jar app.jar

# Ejecutar el microservicio
CMD ["java", "-jar", "app.jar"]
