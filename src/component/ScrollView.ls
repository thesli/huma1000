require!{
  '../component/MarkdownEl.ls': {MarkdownEl}
}
export ScrollView = class extends React.Component
  lc: {
    cdm: ->

    cdu: ->
      # @refs['wrap'].scrollTop = 99999

  }
  r: ->
    {style} = @props
    onScroll = (e) ~>
      @refs['wrap'].scrollTop += if e.deltaY > 0 then 30 else -30

    <div ref='wrap'
        style={flex: 1, margin: '0 auto', width: '670', overflow: 'hidden'}
        className='markdown-body'
        onWheel={onScroll}>

      <MarkdownEl>
        {require('../md/HW1.md')}
      </MarkdownEl>
      <div style={height: 300}></div>
    </div>

|> unalias
