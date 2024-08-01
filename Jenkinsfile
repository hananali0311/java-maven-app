pipeline {
    agent any

    tools {
        maven 'maven-3.9' // This should match the name of your Maven installation in Jenkins
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
    }
    stages {
        stage('Build image') {
            steps {
                echo "building the docker image..."
                withCredentials([usernamePassword(credentialsID: 'docker-hub-credentials' , passwordVariable: 'PASS' , usernameVariable: 'USER')]){
                    sh 'docker build -t hananali0311/javarepo'
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push hananali0311/javarepo '
                }
            }
        }
    }
}
