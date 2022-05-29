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
    stage('Create new Images') {
      when {
        beforeAgent true
        anyOf {
          changeset "imagemagick.sh"
          changeset "intro.png"
          triggeredBy cause: 'UserIdCause'
        }
      }
      steps {
        container('imagemagick') {
          sh 'sh imagemagick.sh'
        }
      }
    }
    stage('Create new Diagrams') {
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
    stage('Create new mp4') {
      when {
        beforeAgent true
        anyOf {
          changeset "melt.sh"
          changeset "intro.mlt"
          triggeredBy cause: 'UserIdCause'
        }
      }
      steps {
        container('melt') {
          sh 'sh melt.sh'
        }
      }
    }
    stage('Create New Assets') {
      when {
        beforeAgent true
        anyOf {
          changeset "1920x1080-openslide.png"
          changeset "f5-logo-rgb.png"
          changeset "ffmpeg.sh"
          changeset "marp.sh"
          changeset "mermaid-cli.sh"
          changeset "intro.md"
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
    stage('Commit New Assets') {
      when {
        beforeAgent true
        allOf {
          not {changeset "intro.png"}
          not {changeset "intro.mp4"}
          not {changeset "intro.pptx"}
          not {changeset "diagram.png"}
        }
      }
      steps {
        sh 'git config user.email "robin@mordasiewicz.com"'
        sh 'git config user.name "Robin Mordasiewicz"'
        sh 'git add . && git diff --staged --quiet || git commit -m "New Assets"'
        sh 'git status'
        withCredentials([gitUsernamePassword(credentialsId: 'github-pat', gitToolName: 'git')]) {
          sh 'git push origin HEAD:main'
        }
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
