FROM eclipse-temurin:17-jdk
WORKDIR /wcr

# Copiamos tanto el .jar como la base de datos
COPY wcr.jar wcr.jar
COPY data.db data.db
COPY sql.sql sql.sql
COPY sql.sql sql.sql
COPY public public

# Comando para iniciar tu app
CMD ["java", "-jar", "wcr.jar"]