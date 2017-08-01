stage('Test') {
    parallel linux: {
        node('any') {
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
