pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install dependencies') {
      steps {
        bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pip install pytest'

      }
    }

    stage('Run tests') {
      steps {
        bat 'pytest --junitxml=results.xml'
      }
      post {
        always {
          junit 'results.xml'
          archiveArtifacts artifacts: 'results.xml'
        }
      }
    }
  }
}
