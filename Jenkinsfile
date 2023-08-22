pipeline {
  agent any

  options {
    buildDiscarder(logRotator(numToKeepStr: '2', daysToKeepStr: '7'))
  }

  stages {
      stage("source code checkout") {
          steps {
              git branch: 'main', url: 'https://github.com/NalawadeAnil14/E2E-jenkins-ansible-docker-kube.git'     
	    }
      }

      stage("test ansible connectivity") {
          steps {
              script {
                 sshagent(['jenkins-ansible-master-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.88.93 ansible --version'
                    sh 'scp /var/lib/jenkins/workspace/test-ansible/* ubuntu@172.31.88.93:/home/ubuntu' 
		}
              }
          }
      }

      stage("build docker image") {
          steps {
              script {
                 sshagent(['jenkins-ansible-master-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.88.93 cd /home/ubuntu'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.88.93 docker build -t e2e-demo-app .'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.88.93 docker tag e2e-demo-app anilnalawade/e2e-demo-app:v1'
                 }
              }
          }
      }
    
      stage("Push image on docker hub") {
          steps {
              script {
                 sshagent(['jenkins-ansible-master-key']) {
                     withCredentials([usernamePassword(credentialsId: 'dockerhubToken', passwordVariable: 'docker_password', usernameVariable: 'docker_username')]) {
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.88.93 docker login -u ${docker_username} -p ${docker_password}'
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.88.93 docker push anilnalawade/e2e-demo-app:v1'
                     }
                 }
              }
          }
      }
  }  
} 
