
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
    withSonarQubeEnv(credentialsId: 'sonar-username', installationName: 'sq-server') {
         sh '''$SCANNER_HOME/bin/sonar-scanner \
         -Dsonar.projectKey=sq-inner \
         -Dsonar.projectName=sq-inner \
         -Dsonar.sources=src/ \
         -Dsonar.java.binaries=target/classes/ \
         -Dsonar.exclusions=src/test/java/****/*.java \
         -Dsonar.java.libraries=/var/lib/jenkins/.m2/**/*.jar \
         -Dsonar.projectVersion=${BUILD_NUMBER}-${GIT_COMMIT_SHORT}'''
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
