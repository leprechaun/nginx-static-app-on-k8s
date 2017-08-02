#!groovy
node('master') {
  stage("Checkout") {
    checkout scm
  }

  stage("Sanity") {
    parallel(
      "Commiter Identity": {
        echo "Email should match .*@ktaxa.com"
      },

      "Another step?": {
        echo 'hello world'
      }
    )
  }

  stage('Test') {
    parallel(
      "Unit Tests": {
        echo "Unit"
      },

      "Functional Tests": {
        echo 'Functional'
      },

      "Some Other Tests": {
        echo 'Other'
      }

    )
  }

  stage("Build Image") {
    echo "Trigger Image Build"
  }

  stage("Trigger Deploy to Sandbox") {
    echo "Trigger Deploy to Sandbox"
  }

  stage("Done") {
    echo "done"
  }
}
