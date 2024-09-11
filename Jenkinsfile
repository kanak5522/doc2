pipeline {
    agent any
    environment {
        AWS_CREDENTIALS_ID = 'kanakaws' // ID for your AWS credentials in Jenkins
        ECR_REPO_NAME = 'kanakchandel-kanakimage' // Name of your ECR repository
        AWS_REGION = 'eu-west-1' // Region where your ECR repository is located
        DOCKER_TAG = 'latest'
        ECR_URI = "846654926420.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${ECR_REPO_NAME}:${DOCKER_TAG}")
                }
            }
        }
        stage('Login to ECR') {
            steps {
                script {
                    // Login to AWS ECR
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                        sh 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URI}'
                    }
                }
            }
        }
        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Tag the Docker image for ECR
                    sh "docker tag ${ECR_REPO_NAME}:${DOCKER_TAG} ${ECR_URI}:${DOCKER_TAG}"
                    // Push the Docker image to ECR
                    sh "docker push ${ECR_URI}:${DOCKER_TAG}"
                }
            }
        }
    }
}
