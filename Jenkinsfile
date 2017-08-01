node('master') {
    checkout scm
    stage('Test') {
        parallel(
            "one thing": {
                try {
                    echo 'make check'
                }
                finally {
                    echo 'done'
                }
            },

           "another thing": {
               echo 'hello world'
           }
        )
    }
}
