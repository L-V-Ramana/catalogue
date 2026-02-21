pipeline {
    agent { label 'agent-1' }
    environment { 
      appVersion=''
    }
    stages {
        
        stage('reading packagejson'){
            steps{
                 script{
                def packageJSON = readJSON file: 'package.json'
            appVersion = packageJSON.version

            echo "${appVersion}"
            }
            }
           
            
          
        }

    }
}