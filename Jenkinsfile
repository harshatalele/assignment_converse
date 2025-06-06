pipeline {
    agent any

    environment {
        VENV_DIR = '.venv'
        SONAR_SCANNER_HOME = tool 'converse_SAST'  // Jenkins global tool config
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/harshatalele/assignment_converse.git'
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat """
                    call ${VENV_DIR}\\Scripts\\activate.bat
                    robot -d results tests/
                """
            }
        }

        stage('Archive Robot Reports') {
            steps {
                archiveArtifacts artifacts: 'results\\**\\*.*', fingerprint: true
            }
        }

        stage('SonarQube Scan') {
            environment {
                SONAR_TOKEN = credentials('sonarworking') // Jenkins secret text credential
            }
            steps {
                withSonarQubeEnv('MySonarQubeServer') {
                    bat """
                        call ${VENV_DIR}\\Scripts\\activate.bat
                        ${SONAR_SCANNER_HOME}\\bin\\sonar-scanner.bat ^
                        -Dsonar.projectKey=robot-sonar-demo ^
                        -Dsonar.sources=. ^
                        -Dsonar.host.url=%SONAR_HOST_URL% ^
                        -Dsonar.login=%SONAR_TOKEN%
                    """
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
