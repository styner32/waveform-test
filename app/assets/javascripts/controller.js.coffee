class window.Controller
  constructor: ->

  init: ->
    player = videojs('player')
    $('#submit-video-path').on 'click', ->
      $videoPath = $('#video-path')
      player.on('canplay', ->
        console.log('haha')
        player.play()
      )
      player.src($videoPath.val())

