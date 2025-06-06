pipeline {
    agent any

    environment {
        VENV_DIR = '.venv'
        SONAR_SCANNER_HOME = tool 'SonarQubeScanner'  // Jenkins global tool config
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/harshatalele/assignment_converse.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python -m venv ${VENV_DIR}
                    . ${VENV_DIR}/Scripts/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                sh '''
                    . ${VENV_DIR}/Scripts/activate
                    robot -d results tests/
                '''
            }
        }

        stage('Archive Robot Reports') {
            steps {
                archiveArtifacts artifacts: 'results/**/*.*', fingerprint: true
            }
        }

        stage('SonarQube Scan') {
            environment {
                SONAR_TOKEN = credentials('sonarworking') // Jenkins secret text credential
            }
            steps {
                withSonarQubeEnv('MySonarQubeServer') {
                    sh '''
                        . ${VENV_DIR}/Scripts/activate
                        ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=robot-sonar-demo \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=$SONAR_HOST_URL \
                        -Dsonar.login=$SONAR_TOKEN
                    '''
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
