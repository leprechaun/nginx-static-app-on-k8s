pipeline {
  def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()

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
          },

          "BuildConfigs": {
            sh "oc get bc"
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
            openshiftBuild(
              bldCfg: 'image-leprechaun-jenkins-blue-test',
              showBuildLogs: 'true'
            )
          }
        )
      }
    }
  }
}
