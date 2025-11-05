pipeline {
  agent any

  environment {
    PATH = "C:\\Program Files (x86)\\GnuWin32\\bin;${env.PATH}"
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
	stage('Check PATH') {
	  steps {
		bat 'echo %PATH%'
	  }
	}

    stage('Build') {
      steps {
        echo "🏗️ בונים את האפליקציה..."
        bat 'make -B build'
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
	    echo "🧪 מריצים בדיקות יחידה..."
        unstash 'built-app'
        bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pytest --junitxml=results.xml'
      }
      post {
        always {
		  echo "📊 מציגים תוצאות בדיקות..."
          junit 'results.xml'
          archiveArtifacts artifacts: 'results.xml'
        }
      }
    }
    stage('Deploy (Fake)') {
      when { branch 'main' }
      steps {
        echo "🚀 נפריס גרסה ניסיונית לסביבת ${APP_ENV}"
        sh 'make deploy'
      }
    }

  }
  post {
    success {
      echo "🎉 כל השלבים עברו בהצלחה!"
    }
    failure {
      echo "❌ יש בעיה באחד השלבים, נא לבדוק את הלוג!"
    }
    always {
      echo "🧹 מנקים את סביבת העבודה..."
    }
  }
}
