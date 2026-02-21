pipeline {
    agent { label 'agent-1' }
    environment { 
      appVersion=''
    }
    stages {
        
        stage('reading packagejson'){
            def packageJSON = readJSON file: 'package.json'
            appVersion = packageJSON.version

            echo "${appVersion}"
          
        }

        stage('build-image') {
            steps {
                script{
                    sh """
                    
                    """
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}