pipeline{
    agent any
    stages{
        stage("getting code") {
            steps {
                git url: 'https://github.com/harounJaouadi/devops_projects_jenkins_pipeline', branch: 'master',
                credentialsId: 'github-credentials' //jenkins-github-creds
                sh "ls -ltr"
            }
        }

       //stage("Setting up infra") 
         stage("creation de image"){
            steps {                
                script {
                    echo "======== executing ========"
                        sh "export PATH=$PATH:/opt/apache-maven-3.9.5/bin"
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
