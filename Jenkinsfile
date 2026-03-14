pipeline {
    agent { label 'agent-1' }
    options{
        ansiColor('xterm')
    }
    environment { 
        acc_id = '867920734831'
        region = 'us-east-1'
        project = 'roboshop'
        appVersion = ''
    }
    parameters{
         booleanParam(name:'deployment', defaultValue: false, description: 'Toggle this value')
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

        stage('sonar scan'){

             environment {
                          scannerHome = tool 'sonar-7.2'
                        }
            steps{
                                       
               script{
                    withSonarQubeEnv(installationName: 'sonar-7.2') {
                    sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }   

        stage('waiting-scanner-results'){
            steps{
                timeout(time: 15, unit: 'MINUTES') { // Set a reasonable timeout
                waitForQualityGate abortPipeline: false
            }
         }
        }

          stage('Check Dependabot Alerts') {
                environment {
                    GITHUB_TOKEN = credentials('github-token')
                    REPO = REPO = "L-V-Ramana/catalogue"
                }
            steps {
                script {

                    def response = sh(
                        script: """
                        curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
                        https://api.github.com/repos/${REPO}/dependabot/alerts
                        """,
                        returnStdout: true
                    ).trim()

                    def highIssues = sh(
                        script: """
                        echo '$response' | jq '[.[] | select(.security_advisory.severity=="high" or .security_advisory.severity=="critical")] | length'
                        """,
                        returnStdout: true
                    ).trim()

                    if(highIssues.toInteger() > 0){
                        error "High or Critical Dependabot vulnerabilities found: ${highIssues}"
                    } else {
                        echo "No High/Critical vulnerabilities"
                    }
                }
            }
        }
 


        stage('Docker Build & Push') {
            steps {
                script {
                    withAWS(credentials: 'aws-auth', region: "${region}") {
                        sh """
                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 867920734831.dkr.ecr.us-east-1.amazonaws.com
                        docker build -t roboshop/catalogue:${appVersion} .
                        docker tag roboshop/catalogue:${appVersion} 867920734831.dkr.ecr.us-east-1.amazonaws.com/roboshop/catalogue:${appVersion}
                        docker push 867920734831.dkr.ecr.us-east-1.amazonaws.com/roboshop/catalogue:${appVersion}
                        """
                    }
                }
            }
        }

        stage('trigger cd'){
            when{
                expression { params.deployment}
            }
            steps{
                    echo "${appVersion}"
                     build job: 'catalogue-cd', 
                     parameters: [
                        string(name: 'appVersion', value: "${appVersion}"),
                        string(name: 'deploy', value: 'dev')
                   
                    ],
                     propagate: false, // even catalogue cd failes will not show ci as failed
                     wait: false // wont wait untill cd complete , if ci complete show as success
            }

        }

    }
}   

