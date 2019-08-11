pipeline {
  environment {
    registry = "johnsondnz/ansible"
    registryCredential = "dockerhub"
    CI = "true"
    version = ""
  }
  agent any 
  options {
      skipDefaultCheckout(true)
  }
  stages {
    stage("Checkout SCM") {
      steps {
        echo "==> Checking out the source control..."
        checkout scm
      }
    }
    stage("Versioning") {
      steps {
        script {
          version = readFile('VERSION')
        }
      }
    }
    stage("Check for docker daemon") {
      steps {
        echo "==> Checking for docker service..."
        sh "docker --version"
      }
    }
    stage("Build Image") {
      steps {
        echo "==> Building container with Ansible=${version}..."
        sh "docker build -t ${registry}:latest . --build-arg ANSIBLE_VERSION=${version}"
      }
    }
    stage("Test Image") {
      steps {
        echo "==> Testing the new image with ansible-playbook --version..."
        sh "docker run --rm ${registry}:${version}"
      }
    }
    stage("Publish images") {
      steps {
        echo "==> Publishing images to DockerHub..."
        script {
          docker.withRegistry( '', registryCredential ) {
            sh "docker push ${registry}:latest"
            sh "docker push ${registry}:${version}"
          }
        }
      }
    }
    stage("Remove image") {
      steps {
        echo "==> Removing images..."
        sh "docker rmi ${registry}:latest"
        sh "docker rmi ${registry}:${version}"
      }
    }
    stage("Clean system") {
      steps {
        echo "==> Cleaning system..."
        sh "docker system prune --volumes --force"
      }
    }
  }
}
