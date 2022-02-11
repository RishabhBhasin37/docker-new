pipeline {
  agent any
    stages{
       stage("Build Docker Image"){
           steps{
             sh "docker build -t rishabhbhasin37/docker:${BUILD_ID} ."
          }
       }
       stage("Push Image to Repo"){
          steps{
            withCredentials([string(credentialsId: 'passwd', variable: 'pass')]) {
             sh "docker login -u rishabhbhasin37 -p ${pass}"
             sh "docker push rishabhbhasin37/docker:${BUILD_ID}"
            }  
           
          }
       }
       stage("K8s Deployment"){
          steps{
             sh "chmod +x myscript.sh"
             sh " sh myscript.sh ${BUILD_ID}" 
             sshagent(['ubuntu']) {
                 sh "scp -o StrictHostKeyChecking=no  newdep.yaml ubuntu@15.206.205.214:/home/ubuntu"
                 script{
                   try{
                      sh "ssh ubuntu@15.206.205.214 kubectl create -f newdep.yaml"
                   }
                   catch(error){
                        sh "ssh ubuntu@15.206.205.214 kubectl apply -f newdep.yaml"
                   }
                
                 }
             }           
            
          }
       }
 
    }  

}
