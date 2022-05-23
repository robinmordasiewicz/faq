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
          - name: mlt
            image: robinhoodis/mlt:latest
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
    stage('Create New Assets') {
      when {
        beforeAgent true
        anyOf {
          changeset "1920x1080-openslide.png"
          changeset "f5-logo-rgb.png"
          changeset "imagemagick.sh"
          changeset "ffmpeg.sh"
          changeset "mlt.sh"
          changeset "diagrams.sh"
          changeset "marp.sh"
          changeset "mermaid-cli.sh"
          changeset "diagram.png"
          changeset "intro.mlt"
          changeset "intro.md"
          changeset "intro.mmd"
          changeset "Jenkinsfile"
          changeset "intro-diagram.py"
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
