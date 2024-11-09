pipeline {
    agent any
    environment {
        REGISTRY_URL = "${REGISTRY_URL}"
        PROJECT_NAME = "${PROJECT_NAME}"
        IMAGE_NAME = "${IMAGE_NAME}"
        TAG = "${BUILD_NUMBER}"
        OPENSHIFT_SERVER = "${OPENSHIFT_SERVER}"
        OPENSHIFT_TOKEN = credentials('openshift-token')
    }
    stages {
        stage('Build') {
            steps {
                script {
                    sh 'docker build -t ${IMAGE_NAME}:${TAG} .'
                }
            }
        }
        stage('Tag & Push') {
            steps {
                script {
                    sh 'docker tag ${IMAGE_NAME}:${TAG} ${REGISTRY_URL}/${PROJECT_NAME}/${IMAGE_NAME}:${TAG}'
                    sh 'docker push ${REGISTRY_URL}/${PROJECT_NAME}/${IMAGE_NAME}:${TAG}'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh "oc login ${OPENSHIFT_SERVER} --token=${OPENSHIFT_TOKEN}"
                    sh "oc tag ${PROJECT_NAME}/${IMAGE_NAME}:${TAG} ${PROJECT_NAME}/${IMAGE_NAME}:latest"
                    sh "oc rollout latest dc/${IMAGE_NAME}"
                }
            }
        }
    }
    post {
        always {
            script {
                sh 'docker rmi ${IMAGE_NAME}:${TAG}'
            }
        }
    }
}
