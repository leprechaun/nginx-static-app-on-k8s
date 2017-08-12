pipeline {

  agent none

  stages {
    stage("Apply OC Build-Time things") {
      agent any
      steps {
        sh "oc apply -f oc-manifests/build-time/"
      }
    }

    stage('Sanity Checks') {
      agent any
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
      agent any
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

    stage("Inlcude ANother Jenkinsfile") {
      agent any
      steps {
        jobDsl targets: 'TestJenkinsfile'
      }
    }

    stage("Build Images") {
      agent any
      steps {
        script {
          def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
          def shortCommit = gitCommit.take(8)
          openshiftBuild(
            bldCfg: 'nginx-static-app-image',
            showBuildLogs: 'true',
            commit: shortCommit,
            env : [
              [ name : 'GIT_COMMIT', value : shortCommit ]
            ]
          )

          openshiftTag(
            sourceStream: 'nginx-static-app',
            sourceTag: 'latest',
            destinationStream: 'nginx-static-app',
            destinationTag: shortCommit
          )
        }
      }
    }

    stage("Confirm Deployment") {
      agent none
      steps {
        milestone 1
        input message: "Continue?"
        milestone 2
      }
    }


    stage("Apply OC Run-Time things") {
      agent any
      steps {
        sh "oc apply -f oc-manifests/run-time/"
      }
    }

    stage("Deploy: Testing ENV") {
      agent any
      steps {
        script {
          def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
          def shortCommit = gitCommit.take(8)
          openshiftDeploy(
            depCfg: 'nginx-static-app'
          )
        }
      }
    }

    stage("Verify: Testing ENV") {
      agent any
      steps {
        parallel(
          "curl1": {
            sh "curl -v http://nginx-static-app/"
          },
          "curl2": {
            sh "curl -v http://nginx-static-app/"
          }
        )
      }
    }
  }
}
