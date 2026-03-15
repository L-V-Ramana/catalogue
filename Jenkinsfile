// @ Library('jenkins-shared-library')_

// def configMap=[
//      greeting: "hello world"
// ]

// samplePipeline(configMap)

@Library ('jenkins-shared-library')_

    def configMap = [
        project : "roboshop",
        component: "catalogue"
    ]
if(!        (env.BRANCH_NAME.equalsIgnoreCase('main'))){
         nodejsEKSPipeline(configMap)
}
else{
    echo "already scanned in feature branch"
}
   



   