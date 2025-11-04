pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Check Python') {
        steps {
            bat 'python --version'
            bat 'pip --version'
        }
    }

    stage('Install dependencies') {
      steps {
        bat 'pip install pytest'
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
