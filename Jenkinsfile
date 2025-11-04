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
        sh 'pip install pytest'
      }
    }

    stage('Run tests') {
      steps {
        sh 'pytest --junitxml=results.xml'
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
