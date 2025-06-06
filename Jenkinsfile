pipeline {
    agent any

    environment {
        PYTHON_HOME = tool 'PythonPath'
        SONAR_SCANNER_HOME = tool 'converse_SAST'
        VENV_DIR = '.venv'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/harshatalele/assignment_converse.git'
            }
        }

        stage('Set Up Python & Robot') {
            steps {
                withEnv(["PATH=${env.PYTHON_HOME};${env.PYTHON_HOME}\\Scripts;${env.PATH}"]) {
                    bat 'python --version'
                    bat 'robot --version'
                }
            }
        }

        stage('Run Robot Tests') {
            steps {
                withEnv(["PATH=${env.PYTHON_HOME};${env.PYTHON_HOME}\\Scripts;${env.PATH}"]) {
                    bat 'dir Automation\\SMSMagic\\robot_framework_automation\\tests\\'
                    bat 'robot Automation\\SMSMagic\\robot_framework_automation\\tests\\'
                }
            }
        }

        stage('Archive Robot Reports') {
            steps {
                archiveArtifacts artifacts: 'output.xml, report.html, log.html', fingerprint: true
            }
        }

        stage('SonarQube Scan') {
            environment {
                SONAR_TOKEN = credentials('sonarworking')
            }
            steps {
                withSonarQubeEnv('MySonarQubeServer') {
                    bat """
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
