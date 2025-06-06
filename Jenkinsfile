pipeline {
    agent any

    tools {
        sonarQubeScanner 'Default'
    }

    environment {
        SONAR_TOKEN = credentials('sonarqube-token') // Secret text credential ID
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/<your-username>/<robot-framework-project>.git'
            }
        }

        stage('SonarQube Scan') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'sonar-scanner -Dsonar.login=$SONAR_TOKEN'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
