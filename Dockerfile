# Use Temurin JDK base image
FROM eclipse-temurin:17-jre

# Add application JAR file
COPY target/my-app-1.0-SNAPSHOT.jar /usr/app/

# Set working directory
WORKDIR /usr/app

# Command to run the application
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
