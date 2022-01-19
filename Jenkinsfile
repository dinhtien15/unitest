pipeline {
  agent any
  stages {
    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "website-demo"
    // registryHost = "192.168.19.5:5000/"
    imageName = "${env.registry_host1}/${appName}:${tag}"
    env.BUILDIMG=imageName
    stage('Build') {
        sh "docker build -t ${imageName} ."
        }
      }
    }

    stage('Test') {
      steps {
        sh 'python3 test_app.py'
        input(id: "Deploy Gate", message: "Deploy ${params.project_name}?", ok: 'Deploy')
      }
    }
    stage('Push'){
        sh "docker push ${imageName}"
    }

    stage('Deploy')
    {
      steps {
        sh "sed -i s/xxx/$tag/g k8s/deployment.yaml"
	      sh "kubectl ${env.token_kube} apply -f k8s/deployment.yaml"
      }
    }

  }

  post {
        always {
            echo 'The pipeline completed'
            junit allowEmptyResults: true, testResults:'**/test_reports/*.xml'
        }
        success {
            
            sh "sudo nohup python3 app.py > log.txt 2>&1 &"
            echo "Flask Application Up and running!!"
        }
        failure {
            echo 'Build stage failed'
            error('Stopping early…')
        }
      }
}
