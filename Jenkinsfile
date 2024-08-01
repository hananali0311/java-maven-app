pipeline {
    agent any

    tools {
        maven 'maven-3.9' // This should match the name of your Maven installation in Jenkins
    }

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // Replace with the ID of your Docker Hub credentials in Jenkins
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
                    // Build the Docker image using sudo
                    sh 'sudo docker build -t hananali0311/javarepo:latest .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        // Login to Docker Hub
                        sh 'echo $DOCKERHUB_PASSWORD | sudo docker login -u $DOCKERHUB_USERNAME --password-stdin'
                        // Push the Docker image to Docker Hub using sudo
                        sh 'sudo docker push hananali0311/javarepo:latest'
                    }
                }
            }
        }
    }
}
