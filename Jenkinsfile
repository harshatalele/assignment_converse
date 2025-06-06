pipeline {
    agent any

    environment {
        // Use Jenkins credentials ID for SonarQube token
        SONAR_TOKEN = credentials('sonarqube-token')
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout source code from GitHub
                git 'https://github.com/youruser/robot-project.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install Robot Framework and any dependencies
                sh 'pip3 install -r requirements.txt'
            }
        }

        stage('Run Robot Tests') {
            steps {
                // Run Robot Framework tests, output to results/
                sh 'robot --outputdir results tests/'
            }
        }

        stage('Archive Robot Reports') {
            steps {
                // Archive Robot Framework output and publish test results
                archiveArtifacts artifacts: 'results/**'
                junit 'results/output.xml' // Converts Robot results to Jenkins test report
            }
        }

        stage('SonarQube Scan') {
            steps {
                // Run SonarQube scanner with Jenkins Sonar environment
                withSonarQubeEnv('SonarQube') {
                    sh "sonar-scanner -Dsonar.login=$SONAR_TOKEN"
                }
            }
        }

        stage('Quality Gate') {
            steps {
                // Wait for SonarQube Quality Gate result; abort if failed
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }

    post {
        always {
            // Cleanup or notifications here if needed
            echo 'Pipeline finished.'
        }
    }
}
