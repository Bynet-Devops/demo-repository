#!/bin/bash

# Download the SonarQube Scanner CLI tool
curl -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip --output sonar-scanner-cli.zip
unzip sonar-scanner-cli.zip

# Analyze a sample project
./sonar-scanner-4.6.2.2472-linux/bin/sonar-scanner \
  -Dsonar.projectKey=test-run \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=squ_ac4f4cdbd5d10a379d29208cc4f5bf6597f294d1
