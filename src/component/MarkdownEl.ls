require!{
  'remark'
  'remark-react'
  'radium'
}

require!{
  'react-redux': {connect}
  '../store/YTElementStore.ls': {actions}
}

export TrackElement = class extends React.Component
  (props) ->
    [@st, @en] = (props.range / '-').map (el) ->
      [m, s] = (el / ':').map((x) -> parseInt(x))
      m * 60 + s
    super!
  r: ->
    {dispatch, range, videoTime} = @props
    text = @props.children?props.children
    b = @st <= videoTime <= @en
    t = dispatch.bind(null,actions.YT_UPDATE_PLAYER_TIME(@st))
    style =
      | b =>
        transition: 'all 2s'
        paddingTop: 5
        paddingBottom: 5
        color: 'white'
        background: '#4183c4'
      | _ =>
        transition: 'all 2s'
        color: '#4183c4'
        background: 'transparent'
    <a onClick={t} style={style}>{text}</a>
|> unalias >> connect(({videoTime}) -> {videoTime})

processor = remark!
  .use remark-react, do
    remarkReactComponents:
      h1: ({children}) ->
        <h1>{children}</h1>

      a: ({href, children}:props) ->
        text = props.children?props.children
        t = /(.+?):(.+?)-(.+?):(.+)/.exec(href)
        if t?
          <TrackElement range={href}>{children}</TrackElement>
        else
          <a href={href}>{children}</a>

export MarkdownEl = class extends React.Component
  r: ->
    result = try processor.process @props.children
    result
|> unalias

if module.hot?
  module.hot.addDisposeHandler ->
    console.clear!
    L 'application reloaded'
