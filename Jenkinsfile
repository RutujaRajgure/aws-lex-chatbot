pipeline {
    agent any

    environment {
        IMAGE = "rutujarajgure/aws-lex-chatbot:v1"
        AWS_REGION = "ap-south-1"
        CLUSTER = "lex-cluster"
    }

    stages {

        stage('Git Pull') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/RutujaRajgure/aws-lex-chatbot.git',
                    credentialsId: 'github'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    docker push $IMAGE
                    '''
                }
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                sh '''
                cd terraform
                terraform init
                terraform apply -auto-approve
                '''
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                aws eks update-kubeconfig --region ap-south-1 --name $CLUSTER
                kubectl apply -f deployment.yaml
                kubectl apply -f service.yaml
                '''
            }
        }
    }
}
