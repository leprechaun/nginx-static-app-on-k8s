pipeline {

  agent any

  stages {
    stage("Apply OC Build-Time things") {
      steps {
        echo "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
        sh "env"
        sh "oc apply -f oc-manifests/build-time/"
      }
    }

    stage("Build Images") {
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

    stage("Generate run-time manifests") {
      steps {
        echo "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
        script {
          def shortCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim().take(8)
          sh "sed -e \"s/#BUILD_NUMBER#/${env.BUILD_NUMBER}/g\" -e \"s/#GIT_COMMIT#/${shortCommit}/g\" -e \"s/#BUILD_DATE#/\$(date +%Y%m%d-%H%M)/g\" oc-manifests/run-time/objects-template.yml > template.yml && cat template.yml && oc apply -f template.yml"
        }
      }
    }

    stage("Trigger a build in Sandbox"){
      steps{
        script {
          def shortCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim().take(8)
          openshiftBuild(
            bldCfg: 'nginx-static-app-deploy-pipeline',
            showBuildLogs: 'true',
            commit: shortCommit,
            env : [
              [ name : 'DEPLOY_BUILD_NUMBER', value : "${env.BUILD_NUMBER}" ],
              [ name : 'DEPLOY_GIT_COMMIT', value : shortCommit ],
              [ name : 'DEPLOY_NAMESPACE', value : "sandbox" ]
            ]
          )
        }
      }
    }

    /*
    stage("Deploy: Testing ENV") {
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
    */
  }
}
