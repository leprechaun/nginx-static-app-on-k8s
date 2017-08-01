node('master') {
    stage('Test') {
        parallel linux: {
            checkout scm
            try {
                echo 'make check'
            }
            finally {
                echo 'done'
            }
        }
    }
}
