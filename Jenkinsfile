pipeline {
    agent { label 'agent-1' }
    environment { 
      appVersion=''
    }
    stages {
        
        stage('reading packagejson'){
            def packageJSON = readJSON file: 'package.json'
            def packageJSONVersion = packageJSON.version
            appVersion=packageJSONVersion

            echo packageJSONVersion
            sh 'VERSION=${packageJSONVersion}_${BUILD_NUMBER}_${BRANCH_NAME} npm run build'
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