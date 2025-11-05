pipeline {
  agent any

  environment {
    PATH = "C:\\Program Files (x86)\\GnuWin32\\bin;${env.PATH}"
    //DEPLOY_USER = credentials('myFirstUser')
    //TEXT = credentials('aabbcc')
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
	    echo "Step One - Download the code from Git"
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
        echo "build the application"
        bat 'make -B build'
        stash includes: 'build/**', name: 'built-app'
      }
    }
    stage('Debug Branch') {
	  steps {
		echo "Current branch: ${env.BRANCH_NAME}"
		echo "GIT_BRANCH: ${env.GIT_BRANCH}"
	  }
	}

    stage('Install dependencies') {
      steps {
        bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pip install pytest'
      }
    }

    stage('Run tests') {
      steps {
	    echo "Running unit tests..."
        bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pytest --junitxml=results.xml'
      }
      post {
        always {
		  echo "Showing test results..."
          junit 'results.xml'
          archiveArtifacts artifacts: 'results.xml'
        }
      }
    }
    stage('Parallel Tests') {
	  parallel {
		  stage('Math Tests') {
			  steps {
				  bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pytest tests/test_hello --junitxml=results.xml'
			  }
		  }

		  stage('String Tests') {
			  steps {
				  bat '"C:\\Users\\USER\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pytest tests/test_hello2 --junitxml=results.xml'
			  }
	  	  }
	  }
	  post {
		always {
		  junit 'results/*.xml'
		}
	  }
	}

    stage('Deploy (Fake)') {
      when  { expression {env.GIT_BRANCH == 'origin/main' } }
      steps {
	    withCredentials([
		  usernamePassword(credentialsId: '213390479', usernameVariable: 'USER', passwordVariable: 'PASS'),
		  string(credentialsId: '123', variable: 'TEXT')
		]) {
		  bat '''
			echo  Deploying as %USER% %PASS%
			echo Using secret text: %TEXT%
			echo Password hidden: ********
		  '''
		}
        echo "deploy try version to ${APP_ENV}"
        bat 'make deploy'
	    unstash 'built-app'

      }
    }

  }

  post {
    success {
      echo "All steps passed successfully.!"
    }
    failure {
      echo "There is a problem with one of the steps, please check the log.!"
    }
    always {
      echo "Cleaning the work environment..."
    }
  }

}