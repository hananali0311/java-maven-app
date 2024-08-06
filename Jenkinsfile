pipeline {
    agent any

    tools {
        maven 'Maven' // This should match the name of your Maven installation in Jenkins
    }

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Your Docker Hub credentials ID
        SSH_CREDENTIALS_ID = 'ubuntu-app-server' // Your Jenkins SSH credentials ID for EC2
        EC2_USER = 'ubuntu' // Username for EC2
        EC2_HOST = '13.48.45.173' // Your EC2 instance IP address
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
                        sh '''
                        ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} << 'EOF'
                        # Stop and remove any existing container with the same name
                        docker stop dazzling_turing || true
                        docker rm dazzling_turing || true

                        # Pull the latest Docker image from Docker Hub
                        docker pull hananali0311/javarepo:latest

                        # Run the new Docker container
                        docker run -d --name dazzling_turing hananali0311/javarepo:latest
                        EOF
                        '''
                    }
                }
            }
        }
    }
}
