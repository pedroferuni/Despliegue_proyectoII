FROM eclipse-temurin:17-jdk
WORKDIR /wcr
# Descargar el archivo wcr.jar desde Google Drive
RUN curl -L "https://drive.google.com/uc?export=download&id=12q_Ymeg9zr8jmKXmamHbnScCtBSjGgsn" -o wcr.jar

# Copiamos tanto el .jar como la base de datos
COPY db db
COPY sql.sql sql.sql
COPY public public

# Comando para iniciar tu app
CMD ["java", "-jar", "wcr.jar"]
