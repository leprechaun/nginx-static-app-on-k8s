pipeline {

  agent any

  stages {
    stage('Sanity Checks') {
      steps {
        parallel (
          "Commit message format": {
            //gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
            //gitCommit = sh "git rev-parse HEAD"
            sh "git rev-parse HEAD"
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
            script {
              def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
              echo gitCommit
              openshiftBuild(
                bldCfg: 'image-leprechaun-jenkins-blue-test',
                showBuildLogs: 'true',
                commit: gitCommit
              )

              openshiftTag(
                sourceStream: 'leprechaun-jenkins-blue-test',
                sourceTag: 'latest',
                destinationStream: 'leprechaun-jenkins-blue-test',
                destinationTag: gitCommit
              )
            }
          }
        )
      }
    }
  }
}
