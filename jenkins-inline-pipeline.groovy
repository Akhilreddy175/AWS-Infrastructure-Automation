pipeline {
    agent any
    environment {
        AWS_REGION            = 'us-east-1'
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        TF_VAR_db_password    = credentials('db-password-dev')
        TF_ENV                = 'C:\\Users\\akhil\\DevOps Project\\environments\\dev'
        TF_BIN                = 'C:\\Users\\akhil\\AppData\\Local\\Microsoft\\WinGet\\Packages\\Hashicorp.Terraform_Microsoft.Winget.Source_8wekyb3d8bbwe\\terraform.exe'
        AWS_BIN               = 'C:\\Program Files\\Amazon\\AWSCLIV2\\aws.exe'
    }
    options {
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }
    stages {
        stage('Verify Tools') {
            steps {
                script {
                    bat '"%TF_BIN%" version'
                    bat '"%AWS_BIN%" --version'
                    bat '"%AWS_BIN%" sts get-caller-identity'
                    echo "All tools verified and AWS credentials are working."
                }
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    bat """
                        cd /d "%TF_ENV%"
                        "%TF_BIN%" init -no-color -input=false
                    """
                }
            }
        }
        stage('Terraform Validate') {
            steps {
                script {
                    bat """
                        cd /d "%TF_ENV%"
                        "%TF_BIN%" validate -no-color
                    """
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    bat """
                        cd /d "%TF_ENV%"
                        "%TF_BIN%" plan -no-color -input=false -out=tfplan
                    """
                }
            }
            post {
                always {
                    bat """
                        cd /d "%TF_ENV%"
                        "%TF_BIN%" show -no-color tfplan > tfplan.txt 2>&1
                    """
                    archiveArtifacts artifacts: 'C:\\Users\\akhil\\DevOps Project\\environments\\dev\\tfplan.txt',
                                     allowEmptyArchive: true
                }
            }
        }
        stage('Approval Gate') {
            steps {
                input message: '''Review the Terraform Plan in the archived artifacts.
The plan shows what will change in your AWS infrastructure.
Click Proceed to run terraform apply, or Abort to cancel.''',
                      ok: 'Proceed with Apply'
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    bat """
                        cd /d "%TF_ENV%"
                        "%TF_BIN%" apply -no-color -input=false tfplan
                    """
                }
            }
        }
    }
    post {
        success { echo 'Pipeline completed successfully!' }
        failure { echo 'Pipeline FAILED — check the stage logs above.' }
        always  { echo "Build #${env.BUILD_NUMBER} finished with: ${currentBuild.currentResult}" }
    }
}
