FROM eclipse-temurin:17-jdk
WORKDIR /wcr
# Descargar el archivo wcr.jar desde Google Drive
RUN wget -O wcr.jar "https://drive.google.com/uc?id=12q_Ymeg9zr8jmKXmamHbnScCtBSjGgsn&export=download"

# Copiamos tanto el .jar como la base de datos
COPY db db
COPY sql.sql sql.sql
COPY public public

# Comando para iniciar tu app
CMD ["java", "-jar", "wcr.jar"]
