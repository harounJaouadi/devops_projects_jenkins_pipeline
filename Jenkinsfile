pipeline{
    agent any
    stages{
        stage("getting code") {
            steps {
                git url: 'https://github.com/harounJaouadi/spring-boot-hello-world', branch: 'master',
                credentialsId: 'github-credentials' //jenkins-github-creds
                sh "ls -ltr"
            }
        }

       //stage("Setting up infra") 
         stage("creation de image"){
            steps {                
                script {
                    echo "======== executing ========"
                        sh "mvn clean package"
            
                        sh "docker build -t hello-world ."
                       }            
                        }
                    } 
        stage("push to docker hub") {
            steps {    
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]){
                    echo "======== executing ========"
                    sh "pwd"
                    sh "ls"
                    echo "push to hub"
                    sh "docker tag hello-world harounjaouadi/hello-world:latest"
                    sh "docker push harounjaouadi/hello-world:latest"      
                        }
                    }              
                }
                }      
                
            post{
                success{
                    echo "======== Setting up infra executed successfully ========"
                }
                failure{
                    echo "======== Setting up infra execution failed ========"
                }
            }
             
        }        
   /* 
    post{
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }*/




//     pipeline {
//     agent any

//     stages {
//         stage('Pull from GitHub') {
//             steps {
//                 git url: 'https://github.com/Mouhib-hero/First-pipeline', branch: 'main',
//                 credentialsId: 'GitHubCredentials' //jenkins-github-creds
//                 sh "ls -ltr"
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 // Build Docker image
//                 sh 'docker build -t starprophecy/simplewebapp .'
//             }
//         }

//         stage('Push to DockerHub') {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'DockerHubCredentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
//                     sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
//                     sh 'docker push starprophecy/simplewebapp'
//                 }
//             }
//         }
//     }
// }