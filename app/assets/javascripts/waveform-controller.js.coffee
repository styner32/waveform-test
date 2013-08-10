class WT.WaveformController
  constructor: (@$container, @waveformData) ->

  render: ->
    @$container.append("<div class='waveform'></div>")
