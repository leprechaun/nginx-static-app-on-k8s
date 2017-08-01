stage('Test') {
    parallel linux: {
        node('master') {
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
