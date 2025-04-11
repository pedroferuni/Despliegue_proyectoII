ROM eclipse-temurin:17-jdk

# Establecer el directorio de trabajo
WORKDIR /wcr

# Descargar el archivo wcr.jar desde Google Drive
RUN wget -O wcr.jar "https://drive.google.com/uc?id=12q_Ymeg9zr8jmKXmamHbnScCtBSjGgsn&export=download"

# Copiar la base de datos y otros archivos necesarios
COPY data.db data.db
COPY sql.sql sql.sql
COPY public public

# Comando para iniciar tu aplicación
CMD ["java", "-jar", "wcr.jar"]
