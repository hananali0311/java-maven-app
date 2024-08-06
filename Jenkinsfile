pipeline {
    agent any

    tools {
        maven 'Maven' // This should match the name of your Maven installation in Jenkins
    }

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Your Docker Hub credentials ID
        SSH_CREDENTIALS_ID = 'ubuntu-app-server' // Your Jenkins SSH credentials ID for EC2
        EC2_USER = 'ubuntu' // Username for EC2
        EC2_HOST = '16.170.220.113' // Your EC2 instance IP address
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
        stage('Deploy to EC2') {
            steps {
                sshagent([SSH_CREDENTIALS_ID]) {
                    script {
                        // SSH into the EC2 instance and deploy the Docker container
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} 'docker stop dazzling_turing || true'"
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} 'docker rm dazzling_turing || true'"
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} 'docker pull hananali0311/javarepo:latest'"
                        sh "ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} 'docker run -d --name dazzling_turing hananali0311/javarepo:latest'"
                    }
                }
            }
        }
    }
}
