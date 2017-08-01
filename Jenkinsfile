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
        echo "one thing"
      },

      "another thing": {
        echo 'hello world'
      },

      "nested": {
        stage("nested one"){
          echo "nested 1"
        }
        stage("nested two"){
          echo "nested 2"
        }

      }
    )
  }

  stage("Done") {
    echo "done"
  }
}
