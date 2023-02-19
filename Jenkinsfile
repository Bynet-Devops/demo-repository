
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
   stage('Build project') {
    steps {
      sh '''mvn install'''
    }
  }
   stage('SonarQube analysis') {
     environment {
       SCANNER_HOME = tool 'Sonar-scanner'
     }
     steps {
     withSonarQubeEnv(installationName:'sq-server') {
     withCredentials([string(credentialsId: 'new-sq-pass', variable: 'SONARQUBE_TOKEN')]) {
          sh '''$SCANNER_HOME/bin/sonar-scanner \
            -Dsonar.projectKey=sq-inner \
            -Dsonar.projectName=sq-inner \
            -Dsonar.sources=./ \
            -Dsonar.login=$new-sq-pass \
           '''
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

