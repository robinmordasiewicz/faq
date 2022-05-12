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
          - name: imagemagick
            image: robinhoodis/imagemagick:latest
            imagePullPolicy: Always
            command:
            - cat
            tty: true
          - name: ffmpeg
            image: jrottenberg/ffmpeg:latest
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
          triggeredBy cause: 'UserIdCause'
        }
      }
      steps {
        container('imagemagick') {
          sh 'sh imagemagick.sh'
        }
        container('ffmpeg') {
          sh 'sh ffmpeg.sh'
        }
      }
    }
    stage('Commit New Assets') {
      when {
        beforeAgent true
        allOf {
          not {changeset "intro.png"}
          not {changeset "intro.mov"}
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
