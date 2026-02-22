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
                    env.appVersion = packageJSON.version
                    echo "App Version: ${env.appVersion}"
                }
            }
        }

        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    withAWS(credentials: 'aws-auth', region: "${region}") {
                        sh """
                        aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${acc_id}.dkr.ecr.${region}.amazonaws.com
                        docker build -t ${project}/catalogue:${appVersion} .
                        docker tag ${project}/catalogue:${appVersion} ${acc_id}.dkr.ecr.${region}.amazonaws.com/${project}/catalogue:${appVersion}
                        docker push ${acc_id}.dkr.ecr.${region}.amazonaws.com/${project}/catalogue:${appVersion}
                        """
                    }
                }
            }
        }

    }
}