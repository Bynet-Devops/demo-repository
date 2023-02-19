
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
     withSonarQubeEnv('sq-server') {
        withCredentials([string(credentialsId: 'sq-token', variable: 'SONARQUBE_TOKEN') {
        sh '''$SCANNER_HOME/bin/sonar-scanner \
          -Dsonar.projectKey=sq-inner \
          -Dsonar.projectName=sq-inner \
          -Dsonar.sources=./ \
          -Dsonar.login=sqa_1688f05d029be9e2f0ab98d4a6a8195073adbcf5'''
         
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

