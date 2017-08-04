pipeline {
  agent any

  stages {
    stage('Sanity Checks') {
      steps {
        parallel (
          "Commit message format": {
            echo 'done'
          },
          "Dunno": {
            echo 'done'
          }
        )
      }
    }

    stage('Tests') {
      steps {
        parallel (
          "Unit Tests": {
            echo 'done'
          },
          "Function Tests": {
            echo 'done'
          },
          "Urine Tests": {
            sh "cat Jenkinsfile"
          }
        )
      }
    }

    stage("Build Images") {
      steps {
        parallel(
          "leprechaun-jenkins-blue-test": {
            openshiftBuild(buildConfig: 'leprechaun-jenkins-blue-test', showBuildLogs: 'true')
          }
        )
      }
    }
  }
}
