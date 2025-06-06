pipeline {
    agent any

    environment {
        PYTHON_HOME = tool name: 'Python', type: 'hudson.plugins.shiningpanda.tools.PythonInstallation'
        SONAR_SCANNER_HOME = tool 'converse_SAST'  // Jenkins global tool config
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
                    bat 'pip install --upgrade pip'
                    bat 'pip install robotframework'
                    bat 'robot --version'
                }
            }
        }

        stage('Run Robot Tests') {
            steps {
                withEnv(["PATH=${env.PYTHON_HOME};${env.PYTHON_HOME}\\Scripts;${env.PATH}"]) {
                    bat 'robot -d results tests/'
                }
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
