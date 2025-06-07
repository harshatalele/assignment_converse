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

        stage('Run Robot Tests') {
            steps {
                withEnv(["PATH=${env.PYTHON_HOME};${env.PYTHON_HOME}\\Scripts;${env.PATH}"]) {
                    bat 'robot tests/'
                }
            }
        }

        stage('Archive Robot Reports') {
            steps {
                archiveArtifacts artifacts: 'output.xml, report.html, log.html', fingerprint: true
            }
        }

        stage('OWASP Dependency-Check Scan') {
            steps {
                bat """
                E:\\Automation\\dependency-check\\bin\\dependency-check.bat ^
                --project "robot_framework_automation" ^
                --scan "%WORKSPACE%" ^
                --format "JSON" ^
                --out "%WORKSPACE%\\dependency-check-report"
                """
            }
        }

        stage('Archive Dependency-Check Reports') {
            steps {
                archiveArtifacts artifacts: 'dependency-check-report/**', fingerprint: true
            }
        }

        stage('Semgrep SAST Scan') {
            steps {
                withEnv(["PATH=${env.PYTHON_HOME};${env.PYTHON_HOME}\\Scripts;${env.PATH}"]) {
                    bat """
                        semgrep scan --config=robot_rules.yml --json > semgrep_report.json || exit 0
                        semgrep scan --config=robot_rules.yml --html=semgrep_report.html || exit 0
                    """
                }
            }
        }

        stage('Archive Semgrep Report') {
            steps {
                archiveArtifacts artifacts: 'semgrep_report.json', fingerprint: true
            }
        }

        // Uncomment below stages if you want to include SonarQube scan & quality gate
        // stage('SonarQube Scan') {
        //     environment {
        //         SONAR_TOKEN = credentials('sonarworking')
        //     }
        //     steps {
        //         withSonarQubeEnv('sonarqubeurl') {
        //             bat """
        //                 ${SONAR_SCANNER_HOME}\\bin\\sonar-scanner.bat ^
        //                 -Dsonar.projectKey=robot-sonar-demo ^
        //                 -Dsonar.sources=. ^
        //                 -Dsonar.host.url=%SONAR_HOST_URL% ^
        //                 -Dsonar.login=%SONAR_TOKEN%
        //             """
        //         }
        //     }
        // }

        // stage('Quality Gate') {
        //     steps {
        //         timeout(time: 10, unit: 'MINUTES') {
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }
    }

    post {
        always {
            dependencyCheckPublisher pattern: 'dependency-check-report/dependency-check-report.xml'
        }
    }
}
