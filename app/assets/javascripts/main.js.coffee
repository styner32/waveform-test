class WT.Main
  pixelPerSecond: 30
  sizeOfSegment: 1024

  constructor: ->
    @$player = videojs('player')
    @$waveform = $('#waveform')
    @waveformElement = @$waveform[0]

  init: ->
    $('#video-file').on 'change', (e) =>
      file = e.target.files[0]
      @$player.src(window.URL.createObjectURL(file))

    $('#waveform-file').on 'change', (e) =>
      @$waveform.html('')
      file = e.target.files[0]
      reader = new FileReader()
      reader.onload = $.proxy @renderWaveform, @
      reader.readAsText(file)

  renderWaveform: (e) ->
    waveformData = $.parseJSON(e.target.result)
    @$waveform.css('width', "#{waveformData.length}px")

    for i in [0..parseInt(waveformData.length/@sizeOfSegment)]
      startIndex = i*@sizeOfSegment
      lastIndex = waveformData.length - 1
      endIndex = (i+1)*@sizeOfSegment
      endIndex = if lastIndex < endIndex then lastIndex else endIndex

      segment = []
      for waveformDataIndex in [startIndex...endIndex]
        segment.push(waveformData[waveformDataIndex])

      waveform = new Waveform({
        container: @waveformElement
        innerColor: 'blue'
        outerColor: 'gray'
        data: segment
        width: segment.length
        height: 100
      });

    @$player.on 'timeupdate', $.proxy @moveWaveform, @

  moveWaveform: (e) ->
    currentTimeInSecond = e.currentTarget.currentTime
    position = currentTimeInSecond * @pixelPerSecond
    @$waveform.css "left", -position + "px"
