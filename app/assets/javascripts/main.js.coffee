class WT.Main
  pixelPerSecond: 30
  sizeOfSegment: 1024

  constructor: ->
    @$player = videojs('player')
    @$waveformContainer = $(".frame")
    @waveforms = []

  init: ->
    $('#video-file').on 'change', (e) =>
      file = e.target.files[0]
      @$player.src(window.URL.createObjectURL(file))

    $('.waveform-file').on 'change', (e) =>
      file = e.target.files[0]
      reader = new FileReader()
      reader.onload = (e) =>
        waveformData = $.parseJSON(e.target.result)
        waveform = new WT.WaveformController(@$waveformContainer, waveformData)
        waveform.render()
        @waveforms.push(waveform)
        @$player.on 'timeupdate', (e) =>
          currentTimeInSecond = e.currentTarget.currentTime
          position = currentTimeInSecond * @pixelPerSecond
          waveform.$el.css "left", -position + "px"

      reader.readAsText(file)
