pipeline {
  agent any
  environment {
    AWS_REGION      = 'us-east-1'
    TF_ENV_DIR      = 'environments/dev'
    TF_VAR_db_password = credentials('db-password-dev')
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    timeout(time: 1, unit: 'HOURS')
    timestamps()
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
        sh 'echo "Branch: ${BRANCH_NAME}, Commit: ${GIT_COMMIT[0..7]}"'
      }
    }
    stage('Terraform Init') {
      steps {
        dir("${TF_ENV_DIR}") {
          sh '''
            terraform init \
              -input=false \
              -no-color
          '''
        }
      }
    }
