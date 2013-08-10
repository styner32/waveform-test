describe "Main", ->
  waveformController = null
  $container = null
  waveformData = [0.5, 0.1, 0.3, 0.4, 1]

  beforeEach ->
    $('#jasmine_content').html("<div class='container'></div>")
    $container = $('.container')
    waveformController = new WT.WaveformController($container, waveformData)

  describe 'render', ->
    it 'appends waveform div', ->
      waveformController.render()
      expect($container.find('.waveform').length).toBe(1)

