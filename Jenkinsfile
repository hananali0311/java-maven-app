pipeline {
    agent any

    tools {
        maven 'maven-3.9' // This should match the name of your Maven installation in Jenkins
    }

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // Replace with the ID of your Docker Hub credentials in Jenkins
        SUDO_PASSWORD_ID = 'sudo-password' // Replace with the ID of your sudo password credential in Jenkins
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
                    withCredentials([string(credentialsId: SUDO_PASSWORD_ID, variable: 'SUDO_PASSWORD')]) {
                        // Build the Docker image using sudo and -S option
                        sh 'echo $SUDO_PASSWORD | sudo -S docker build -t hananali0311/javarepo:latest .'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD'),
                                     string(credentialsId: SUDO_PASSWORD_ID, variable: 'SUDO_PASSWORD')]) {
                        // Login to Docker Hub using sudo and -S option
                        sh 'echo $SUDO_PASSWORD | sudo -S echo $DOCKERHUB_PASSWORD | sudo -S docker login -u $DOCKERHUB_USERNAME --password-stdin'
                        // Push the Docker image to Docker Hub using sudo and -S option
                        sh 'echo $SUDO_PASSWORD | sudo -S docker push hananali0311/javarepo:latest'
                    }
                }
            }
        }
    }
}
