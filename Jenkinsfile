pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devopsx-2.0:${BUILD_NUMBER} .'
            }
        }

        stage('Verify Application') {
            steps {
                sh 'docker image inspect devopsx-2.0:${BUILD_NUMBER} > /dev/null'
                echo 'Docker image built successfully.'
            }
        }
    }

    post {
        always {
            echo 'DevOpsX 2.0 pipeline finished.'
        }
    }
}
