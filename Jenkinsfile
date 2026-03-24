pipeline {

    agent any

    stages {

        stage('Load Config') {

            steps {

                configFileProvider([
                    configFile(
                        fileId: 'flyway-local-config',
                        variable: 'fileConfig'
                    )
                ]) {

                    script {

                        properties = readProperties file: fileConfig

                        env.DB_URL = properties.'flyway_url'
                        env.DB_USER = properties.'flyway_user'
                        env.DB_PASSWORD = properties.'flyway_password'
                        env.DB_LOCATIONS = properties.'flyway_locations'

                    }

                }

            }

        }

        stage('Run Flyway') {

            steps {

                script {

                    bat """
                    flyway ^
                      -url=%DB_URL% ^
                      -user=%DB_USER% ^
                      -password=%DB_PASSWORD% ^
                      -locations=%DB_LOCATIONS% ^
                      migrate
                    """

                }

            }

        }

    }

}