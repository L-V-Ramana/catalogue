pipeline {
    agent { label 'agent-1' }
    environment { 
      appVersion=''
      acc_id='867920734831'
      region='us-east-1'
      project='roboshop'
    }
    stages {
        
        stage('reading packagejson'){
            steps{
                 script{
                        def packageJSON = readJSON file: 'package.json'
                        appVersion = packagexJSON.version
                        echo "${appVersion}"
                }
            }
        }

        stage('instaling dependencies'){
            steps{
                script{
                   sh """
                        npm install
                   """
                }
            }
        }
        stage(){{
            steps{
                scripts{
                    withAWS(credentials: 'aws-auth', region: 'us-east-1') {
                    sh """
                    
                        'aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin 8679207${acc_id}34831.dkr.ecr.${region}.amazonaws.com'
                        docker build -t ${project}/catalogue . 
                        docker tag ${project}/catalogue:${appVersion} ${acc_id}.dkr.ecr.${region}.amazonaws.com/${project}/catalogue:${appVersionp}
                        docker push ${acc_id}.dkr.ecr.us-east-1.amazonaws.com/${project}/catalogue:${appVersion}
                    """
                }
            }
        }

    }
}