pipeline {
  agent any

  environment {
    APP_ENV = "staging"
    TEST_RESULTS = "results/results.xml"
  }

  options {
    timeout(time: 20, unit: 'MINUTES')
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }

  stages {
    stage('Checkout') {
      steps {
	    echo "📥 שלב ראשון - מורידים את הקוד מה־Git"
        checkout scm
      }
    }

    stage('Build') {
      steps {
        echo "🏗️ בונים את האפליקציה..."
        sh 'make build'
        stash includes: 'build/**', name: 'built-app'
      }
    }
    stage('Install dependencies') {
      steps {
        bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pip install pytest'
      }
    }

    stage('Run tests') {
      steps {
        bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pytest --junitxml=results.xml'
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
