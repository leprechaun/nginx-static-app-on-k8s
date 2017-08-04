pipeline {

  agent any

  stages {
    stage('Sanity Checks') {
      steps {
        parallel (
          "Commit message format": {
            //gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
            //gitCommit = sh "git rev-parse HEAD"
            gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
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
