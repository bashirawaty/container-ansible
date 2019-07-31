pipeline {
  environment {
    registry = "johnsondnz/ansible"
    registryCredential = "dockerhub"
    CI = "true"
    version = ""
    dockerImage = ""
  }
  agent any
  stages {
    stage("Versioning") {
      steps {
        script {
          version = readFile('VERSION')
        }
      }
    }
    stage("Building Image") {
      steps {
        script {
          sh "docker build -t $registry:latest --build-arg ANSIBLE_VERSION=$version -f Dockerfile ."
        }
      }
    }
    stage("Deploying Docker Image") {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            sh "docker push $registry:latest"
            sh "docker push $registry:$version"
          }
        }
      }
    }
    stage("Removing Images") {
      steps {
        sh "docker rmi $registry:latest"
      }
    }
  }
}

