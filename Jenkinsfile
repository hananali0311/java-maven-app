pipeline {
    agent any

    tools {
        maven 'maven-3.9' // This should match the name of your Maven installation in Jenkins
    }

    environment {
        DOCKER_CREDENTIALS_ID = 'dock-hub-credentials' // Replace with the ID of your Docker Hub credentials in Jenkins
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
                    // Build the Docker image
                    docker.build('hananali0311/javarepo')
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image('hananali0311/javarepo').push('latest')
                    }
                }
            }
        }
    }
}
