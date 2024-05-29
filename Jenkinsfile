pipeline {
    agent any

    stages {
        stage('Checkout Codebase') {
            steps {
                cleanWs()
                git branch: 'main', url: 'https://github.com/KHOLUD-2030/Test-Repo.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mkdir lib'
                sh 'cd lib/ ; wget https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.7.0/junit-platform-console-standalone-1.7.0-all.jar'
                sh 'cd src ; javac -cp "../lib/junit-platform-console-standalone-1.7.0-all.jar" CarTest.java Car.java App.java'

                // Build Docker image for app.java
                sh 'docker build -t my-app .'
            }
        }

        stage('Test') {
            steps {
                sh 'cd src/ ; java -jar ../lib/junit-platform-console-standalone-1.7.0-all.jar -cp . --select-class CarTest --reports-dir="reports"'
                junit 'src/reports/*-jupiter.xml'
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    // Ensure Docker Compose is installed
                    sh 'docker compose version'

                    // Start containers defined in docker-compose.yaml
                    sh 'docker-compose up -d --no-color --wait'

                    // Get the name of the container
                    def containerName = sh(script: 'docker-compose ps -q echo-server', returnStdout: true).trim()

                    // Print logs of the container
                    sh "docker logs $containerName"

                    // Stop and remove containers after deployment
                    sh 'docker-compose down --remove-orphans -v'
                }
            }
        }
    }

    post {
        always {
            // Any cleanup or finalization steps here
            echo 'Post-build cleanup...'
        }
    }
}
