pipeline {
  agent any
  stages {
      stage("test ansible connectivity") {
          steps {
              script {
                 sshagent(['jenkins-ansible-master-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.88.93 ansible --version'
                 }
              }
          }
      }
  }
    
} 
