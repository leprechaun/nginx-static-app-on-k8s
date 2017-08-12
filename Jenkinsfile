pipeline {

  agent any

  stages {
    stage("Apply OC Build-Time things") {
      steps {
        sh "oc apply -f oc-manifests/build-time/"
      }
    }

    stage('Sanity Checks') {
      steps {
        parallel (
          "Commit message format": {
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
        script {
          def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
          def shortCommit = gitCommit.take(8)
          openshiftBuild(
            bldCfg: 'nginx-image',
            showBuildLogs: 'true',
            commit: shortCommit
          )

          openshiftTag(
            sourceStream: 'nginx',
            sourceTag: 'latest',
            destinationStream: 'nginx',
            destinationTag: shortCommit
          )
        }
      }
    }

    stage("Apply OC Run-Time things") {
      steps {
        sh "oc apply -f oc-manifests/run-time/"
      }
    }

    stage("Deploy: Testing ENV") {
      steps {
        script {
          def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
          def shortCommit = gitCommit.take(8)
          openshiftDeploy(
            depCfg: 'nginx'
          )
        }
      }
    }

    stage("Verify: Testing ENV") {
      steps {
        parallel(
          "curl1": {
            sh "curl -v http://nginx/"
          },
          "curl2": {
            sh "curl -v http://nginx/"
          }
        )
      }
    }
  }
}
