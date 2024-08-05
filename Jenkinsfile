pipeline {
    agent any

    tools {
        maven 'Maven' // This should match the name of your Maven installation in Jenkins
    }

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Your Docker Hub credentials ID
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
                    docker.build('hananali0311/javarepo:latest')
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image('hananali0311/javarepo:latest').push('latest')
                    }
                }
            }
        }
    }
}
