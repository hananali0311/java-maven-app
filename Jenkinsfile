pipeline {
    agent any

    tools {
        maven 'maven-3.9' // Match the name of your Maven installation in Jenkins
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from Dockerfile
                    docker.build('hananali0311/javarepo:latest')
                }
            }
        }
    }
}
