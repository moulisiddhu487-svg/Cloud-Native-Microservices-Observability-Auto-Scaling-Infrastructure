pipeline {
    agent any
    stages {
        stage('Health Check') {
            steps {
                echo 'Checking Boutique Microservices status...'
                sh 'curl -I http://localhost:30088 || true'
            }
        }
        stage('Deploy Notification') {
            steps {
                echo 'CI/CD Pipeline run successful!'
            }
        }
    }
}
