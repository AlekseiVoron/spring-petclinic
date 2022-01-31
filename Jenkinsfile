#!groovy
pipeline {
    agent none
    stages {
        stage('Maven Install') {
            agent {
                docker {
                    image 'maven:3.6.0'
                    args '--network=petclinic-build'
                }
            }
            steps {
                sh 'mvn clean install -Dcheckstyle.skip'
            }
        }
        stage('Docker Build') {
            agent any
            steps {
                sh 'docker build --network petclinic-build -t alekseivoron/spring-petclinic:latest .'
            }
        }
        stage('Docker Push') {
            agent any
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', passwordVariable: 'dhPassword', usernameVariable: 'dhUser')]) {
                    sh "docker login -u ${env.dhUser} -p ${env.dhPassword}"
                    sh 'docker push alekseivoron/spring-petclinic:latest'
                }
            }
        }
        stage('Docker Run') {
            agent {
                docker {
                    image 'maven:3.6.0'
                    args '--network=petclinic-run'
                }
            }
            steps {
                sh "docker run --name petclinic --publish 8080:8080 --network petclinic-run alekseivoron/spring-petclinic:latest curl 'http://localhost:8080/'"
            }
        }
    }
}
