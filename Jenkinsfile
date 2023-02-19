pipeline {
  agent { label 'linux'}
  stages {
    stage('SCM') {
      steps {
          checkout scm
    }
  }
    stage('Scan') {
      steps {
        bat 'dotnet sonarscanner begin /k:Hatteland-POC /d:sonar.host.url="http://localhost:9000" /d:sonar.login=admin /d:sonar.password=123456'     bat "dotnet build demo-repository --configuration Release"     bat  "dotnet sonarscanner end /d:sonar.login=admin /d:sonar.password=123456"
        withSonarQubeEnv(installationName: 'SQ-scanner') { 
          sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
          sh 'sonar-scanner -Dsonar.projectKey=sq-inner -Dsonar.sources=. -Dsonar.host.url=http://localhost:9000 -Dsonar.login=squ_ac4f4cdbd5d10a379d29208cc4f5bf6597f294d1'
       }
      }
    }
  }
}

