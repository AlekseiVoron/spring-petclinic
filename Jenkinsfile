#!groovy
pipeline {
    agent none
    stages {
        stage('Maven Install') {
            agent {
                docker {
                    image 'maven:3.6.0'
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
            agent any
            steps {
                ${container_id} = sh "docker run --name petclinic -d --publish 8080:8080 --network petclinic-run alekseivoron/spring-petclinic:latest"
                sh 'docker exec ${container_id} curl "http://localhost:8080/"'
            }
        }
    }
}
