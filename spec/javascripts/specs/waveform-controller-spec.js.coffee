describe "Main", ->
  waveformController = null
  $container = null
  waveformData = [0.5, 0.1, 0.3, 0.4, 1]

  beforeEach ->
    $('#jasmine_content').html("<div class='container'></div>")
    $container = $('.container')

  afterEach ->
    $('#jasmine_content').html('')

  describe 'render', ->
    it 'appends waveform div', ->
      waveformController = new WT.WaveformController($container, waveformData)
      waveformController.render()
      expect($container.find('.waveform').length).toBe(1)

    it 'renders waveform in canvas', ->
      waveformController = new WT.WaveformController($container, waveformData)
      waveformController.render()
      expect($container.find('.waveform canvas').length).toBe(1)

    it 'sets length to length of waveform data', ->
      waveformController = new WT.WaveformController($container, waveformData)
      waveformController.render()
      expect($container.find('.waveform').css('width')).toBe("5px")

    context 'data size is bigger than 1024', ->
      beforeEach ->
        waveformData = (0.1 for num in [1..3000])
        waveformController = new WT.WaveformController($container, waveformData)

      it 'sets length to length of waveform data', ->
        waveformController.render()
        expect($container.find('.waveform').css('width')).toBe("3000px")

      it 'splites waveform not to exceed maximum length for each canvas', ->
        waveformController.render()
        expect($container.find('.waveform canvas').length).toBe(3)

