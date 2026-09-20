pipeline {
    agent any

    environment {
        REGISTRY = '192.168.49.2:5000'
        IMAGE_NAME = 'devopsx-2.0'
        IMAGE = "${REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER}"
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE} .'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push ${IMAGE}'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl set image deployment/devopsx-app \
                      devopsx-app=${IMAGE}
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    kubectl rollout status deployment/devopsx-app --timeout=120s
                    kubectl get deployment devopsx-app
                '''
            }
        }
    }

    post {
        always {
            echo 'DevOpsX 2.0 pipeline finished.'
        }
    }
}
