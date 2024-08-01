# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container at /app
COPY target/myjavaapp-1.0-SNAPSHOT.jar /app/myjavaapp.jar

# Run the JAR file
ENTRYPOINT ["java", "-jar", "myjavaapp.jar"]
