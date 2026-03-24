pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('SQL Lint') {
            steps {
                script {
                    echo "Running SQLFluff lint..."

                    bat """
                    python -m sqlfluff lint sql
                    """
                }
            }
        }

        stage('Load Config') {
            steps {
                configFileProvider([
                    configFile(
                        fileId: '253fb770-d1a9-496c-89ec-b640bff344d7',
                        variable: 'fileConfig'
                    )
                ]) {
                    script {
                        def properties = readProperties file: env.fileConfig

                        env.DB_URL = properties.flyway_url
                        env.DB_USER = properties.flyway_user
                        env.DB_PASS = properties.flyway_password
                        env.DB_LOCATIONS = properties.flyway_locations
                    }
                }
            }
        }

        stage('Flyway Validate') {
            steps {
                script {
                    bat """
                    flyway ^
                      -url=%DB_URL% ^
                      -user=%DB_USER% ^
                      -password=%DB_PASS% ^
                      -locations=%DB_LOCATIONS% ^
                      validate
                    """
                }
            }
        }

        stage('Flyway Migrate') {
            steps {
                script {
                    bat """
                    flyway ^
                      -url=%DB_URL% ^
                      -user=%DB_USER% ^
                      -password=%DB_PASS% ^
                      -locations=%DB_LOCATIONS% ^
                      migrate
                    """
                }
            }
        }

    }

    post {

        success {
            echo "Pipeline executed successfully."
        }

        failure {
            echo "Pipeline failed. Check logs."
        }

    }
}