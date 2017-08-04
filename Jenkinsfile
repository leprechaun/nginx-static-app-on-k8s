pipeline {
    agent any

    stages {
        stage('Verifications') {
            parallel() {
              "test one": {
                echo "hello world"
              },

              "test two": {
                echo "hello world"
              }
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Build') {
            steps {
                echo 'Deploying....'
            }
        }

        stage('Trigger Sandbox Deploy') {
            steps {
                echo 'Deploying....'
            }
        }

    }
}
