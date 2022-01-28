#!groovy
pipeline {
    agent none
    stages {
        stage('Maven Install') {
            agent {
                docker {
                    image 'maven:3.6.3'
                }
            }
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build') {
            agent any
            steps {
                sh 'docker build -t alekseivoron/spring-petclinic:latest .'
            }
        }
    }
}
