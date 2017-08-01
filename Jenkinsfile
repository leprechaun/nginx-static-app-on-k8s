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
          stage("nested one one"){
            echo "nested one one"
          }
          stage("nested one two"){
            echo "nested one two"
          }

        }
        stage("nested two"){
          stage("Nested two one"){
            echo "nested two one"
          }
        }

      }
    )

    stage("nested three"){
      stage("nested three one"){
        echo "nested one one"
      }
      stage("nested three two"){
        echo "nested one two"
      }

    }

  }

  stage("Done") {
    echo "done"
  }
}
