require!{
  '../component/MarkdownEl.ls': {MarkdownEl}
  '../util/smoothscroll.ls': {SmoothScroll}
}

export ScrollView = class extends React.Component
  lc: {

    cdm: ->
      setTimeout ~>
        m = /title=(.+)/.exec location.search
        if m[1]?
          @refs['wrap'].querySelectorAll('h1')[1].scrollIntoView!
      , 1000

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
