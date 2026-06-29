pipeline {

   agent any

   stages {

       stage('Git Checkout') {
           steps {
               git 'https://github.com/RutujaRajgure/aws-lex-chatbot.git'
           }
       }

       stage('Docker Build') {
           steps {
               sh 'docker build -t aws-lex-chatbot:v1 .'
           }
       }

       stage('Docker Push') {
           steps {
               sh '''
               docker tag aws-lex-chatbot:v1 rutujarajgure/aws-lex-chatbot:v1
               docker push rutujarajgure/aws-lex-chatbot:v1
               '''
           }
       }

       stage('Deploy EKS') {
           steps {
               sh 'kubectl apply -f deployment.yaml'
               sh 'kubectl apply -f service.yaml'
           }
       }
   }
}
