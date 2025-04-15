FROM eclipse-temurin:21-jdk
WORKDIR /wcr
# Descargar el archivo wcr.jar desde Google Drive
RUN curl -L "https://drive.google.com/uc?id=1_PwkTrdPMzUMJqv1rdDn61KoFbTX6iYy" -o wcr-0.9.jar

# Comando para iniciar tu app
CMD ["java", "-jar", "wcr-0.9.jar"]
