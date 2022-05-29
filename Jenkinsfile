pipeline {
  options {
    disableConcurrentBuilds()
    skipDefaultCheckout(true)
  }
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: ubuntu
            image: robinhoodis/ubuntu:latest
            imagePullPolicy: Always
            command:
            - cat
            tty: true
          - name: diagrams
            image: robinhoodis/diagrams:latest
            imagePullPolicy: Always
            command:
            - cat
            tty: true
          - name: mermaid-cli
            image: robinhoodis/mermaid-cli:latest
            imagePullPolicy: Always
            command:
            - cat
            tty: true
          - name: marp
            image: robinhoodis/marp:latest
            imagePullPolicy: Always
            command:
            - cat
            tty: true
          - name: imagemagick
            image: robinhoodis/imagemagick:latest
            imagePullPolicy: Always
            command:
            - cat
            tty: true
          - name: melt
            image: robinhoodis/melt:latest
            imagePullPolicy: Always
            command:
            - cat
            tty: true
          - name: ffmpeg
            image: robinhoodis/ffmpeg:latest
            imagePullPolicy: Always
            command:
            - cat
            tty: true
        '''
    }
  }
  stages {
    stage('INIT') {
      steps {
        cleanWs()
        checkout scm
      }
    }
    stage('Images') {
      when {
        beforeAgent true
        anyOf {
          changeset "1920x1080-openslide.png"
          changeset "f5-logo-rgb.png"
          changeset "imagemagick.sh"
          triggeredBy cause: 'UserIdCause'
        }
      }
      steps {
        container('imagemagick') {
          sh 'sh imagemagick.sh'
        }
      }
    }
    stage('Python Diagrams') {
      when {
        beforeAgent true
        anyOf {
          changeset "ASPEN.png"
          changeset "diagrams.sh"
          changeset "intro-diagram.py"
          triggeredBy cause: 'UserIdCause'
        }
      }
      steps {
        container('diagrams') {
          sh 'sh diagrams.sh'
        }
      }
    }
    stage('Mermaid Diagrams') {
      when {
        beforeAgent true
        anyOf {
          changeset "mermaid-cli.sh"
          changeset "intro.mmd"
          triggeredBy cause: 'UserIdCause'
        }
      }
      steps {
        container('mermaid-cli') {
          sh 'sh mermaid-cli.sh'
        }
      }
    }
    stage('Videos') {
      when {
        beforeAgent true
        anyOf {
          changeset "melt.sh"
          changeset "intro.mlt"
          changeset "intro.png"
          changeset "diagram.png"
          triggeredBy cause: 'UserIdCause'
        }
      }
      steps {
        container('melt') {
          sh 'sh melt.sh'
        }
      }
    }
    stage('PPTX') {
      when {
        beforeAgent true
        anyOf {
          changeset "marp.sh"
          changeset "intro.png"
          changeset "diagram.png"
          changeset "intro.md"
          triggeredBy cause: 'UserIdCause'
       }
      }
      steps {
        container('marp') {
          sh 'sh marp.sh'
        }
      }
    }
    stage('Commit New Assets') {
      when {
        beforeAgent true
        expression {
          container('ubuntu') {
            sh(returnStatus: true, script: 'git diff-files --quiet') == 1
          }
        }
      }
      steps {
        sh 'git status'
        sh 'git config user.email "robin@mordasiewicz.com"'
        sh 'git config user.name "Robin Mordasiewicz"'
        sh 'git add . && git diff --staged --quiet || git commit -m "New Assets"'
        withCredentials([gitUsernamePassword(credentialsId: 'github-pat', gitToolName: 'git')]) {
          sh 'git push origin HEAD:main'
        }
        sh 'git status'
      }
    }
  }
  post {
    always {
      cleanWs(cleanWhenNotBuilt: false,
            deleteDirs: true,
            disableDeferredWipeout: true,
            notFailBuild: true,
            patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                       [pattern: '.propsfile', type: 'EXCLUDE']])
    }
  }
}
