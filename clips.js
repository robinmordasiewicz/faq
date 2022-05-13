const concat = require('ffmpeg-concat')
concat({
  output: 'output.mov',
  videos: [
    'intro.mov',
    'clip1.mov',
    'intro.mov',
    'outro.mov'
  ],
  transitions: [
    {
      name: 'squareswire',
      duration: 1000
    },
    {
      name: 'cube',
      duration: 1000
    },
    {
      name: 'angular',
      duration: 1000
 }
  ]
})
