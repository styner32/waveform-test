class WT.WaveformController
  sizeOfSegment: 1024
  constructor: (@$container, @waveformData) ->
    @template="<div class='frame'><div class='waveform'></div></div>"
    @$frame=$(@template)
    @$waveform=@$frame.find('.waveform')

  render: ->
    @$container.append(@$frame)
    @$waveform.css("width", "#{@waveformData.length}px")
    numberOfSegment = parseInt(@waveformData.length/@sizeOfSegment)

    for i in [0..numberOfSegment]
      startIndex = i*@sizeOfSegment
      lastIndex = @waveformData.length - 1
      endIndex = (i+1)*@sizeOfSegment
      endIndex = if lastIndex < endIndex then lastIndex else endIndex

      segment = []
      for waveformDataIndex in [startIndex...endIndex]
        segment.push(@waveformData[waveformDataIndex])

      waveform = new Waveform({
        container: @$waveform[0]
        innerColor: "blue"
        outerColor: "gray"
        data: segment
        width: segment.length
        height: 100
      });
