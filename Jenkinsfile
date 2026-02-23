pipeline {
    agent { label 'agent-1' }

    environment { 
        acc_id = '867920734831'
        region = 'us-east-1'
        project = 'roboshop'
        appVersion = ''
    }

    stages {

        stage('Read package.json') {
            steps {
                script {
                    def packageJSON = readJSON file: 'package.json'
                    appVersion = packageJSON.version
                    echo "App Version: ${appVersion}"
                }
            }
        }

        stage('Install dependencies') {
            steps {
                script{
                    sh """
                    npm install 
                    """ 
                }
                
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    withAWS(credentials: 'aws-auth', region: "${region}") {
                        sh """
                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 867920734831.dkr.ecr.us-east-1.amazonaws.com
                        docker build -t roboshop/catalogue:${appversion} .
                        docker tag roboshop/catalogue:${appVersion} 867920734831.dkr.ecr.us-east-1.amazonaws.com/roboshop/catalogue:${appVersion}
                        docker push 867920734831.dkr.ecr.us-east-1.amazonaws.com/roboshop/catalogue:${appVersion}
                        """
                    }
                }
            }
        }

    }
}   

