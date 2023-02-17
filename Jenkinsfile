node {
  stage('SCM') {
    checkout scm
  }
  stage('SonarQube Analysis') {
    def mvn = tool 'Default Maven';
    withSonarQubeEnv() {
      sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=sq-inner"
      sh 'sonar-scanner -Dsonar.projectKey=sq-inner -Dsonar.sources=. -Dsonar.host.url=http://localhost:9000 -Dsonar.login=squ_ac4f4cdbd5d10a379d29208cc4f5bf6597f294d1'
    }
  
  }
}
