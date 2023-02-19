
pipeline {
agent any
environment {
   GIT_COMMIT_SHORT = sh(
     script: "printf \$(git rev-parse --short ${GIT_COMMIT})",
     returnStdout: true
    )
}
tools {
   maven 'Maven'
   jdk 'idk 1.8'
}
stages {
   stage('SonarQube analysis') {
     environment {
       SCANNER_HOME = tool 'Sonar-scanner'
     }
     steps {
     withSonarQubeEnv('SonarQube') {
     withCredentials([string(credentialsId: 'my-sonarqube-token', variable: 'SONARQUBE_TOKEN')]) {
       sh 'mvn clean install sonar:sonar -Dsonar.login=$SONARQUBE_TOKEN'
     }
        }
        }
       }

   stage('SQuality Gate') {
     steps {
       timeout(time: 1, unit: 'MINUTES') {
       waitForQualityGate abortPipeline: true
       }
  }
   }
}
}

