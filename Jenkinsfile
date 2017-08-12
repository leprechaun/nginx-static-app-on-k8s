pipeline {

  agent none

  stages {
    stage("Apply OC Build-Time things") {
      agent any
      steps {
        sh "oc apply -f oc-manifests/build-time/"
        echo "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
      }
    }

    stage('Sanity Checks') {
      agent any
      steps {
        parallel (
          "Commit message format": {
            checkout scm
            sh "git rev-parse HEAD"
          },
          "Dunno": {
            checkout scm
            echo 'done'
          },

          "BuildConfigs": {
            checkout scm
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
            checkout scm
            echo 'done'
          },
          "Function Tests": {
            checkout scm
            echo 'done'
          },
          "Urine Tests": {
            checkout scm
            sh "cat Jenkinsfile"
          }
        )
      }
    }

    stage("Build Images") {
      agent any
      steps {
        checkout scm
        build job: 'test-params', parameters: [string(name: 'environment', value: 'asdasd')]
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
        checkout scm
        sh "oc apply -f oc-manifests/run-time/"
      }
    }

    stage("Deploy: Testing ENV") {
      agent any
      steps {
        checkout scm
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
            checkout scm
            sh "curl -v http://nginx-static-app/"
          },
          "curl2": {
            checkout scm
            sh "curl -v http://nginx-static-app/"
          }
        )
      }
    }
  }
}
