#!groovy
node('master') {
  stage("Checkout") {
    checkout scm
  }

  stage("Sanity") {
    parallel(
      "one thing": {
        echo "hi"
      },

      "another thing": {
        echo 'hello world'
      }
    )
  }

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

  stage("Done") {
    echo "done"
  }
}
