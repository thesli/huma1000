require!{
  'react-redux': {connect}
  '../store/YTElementStore.ls': {actions}
}


styles =
  base: (props, state) ->
    opacity:  | state.ready => 1
              | _ => 0
    transition: 'opacity 2s'
    verticalAlign: 'middle'

export YTElement = class extends React.Component
  @dp = videoId: 'kBdfcR-8hEY'
  @ds = {
    currTime: null
    duration: null
    -ready
  }
  timeTracker: ->
    @props.dispatch actions.YT_UPDATE_TRACK_TIME(@player.getCurrentTime!)

  init: ->
    YT = window.YT
    {{ENDED, PLAYING, PAUSED, BUFFERING, CUED}:PlayerState} = YT
    options = {
      videoId: @props.videoId
      playerVars: {controls: 1}
      events:
        onReady: ~>
          ns = {
            ready: true
            # duration: @player.getDuration!
          }
          style = {
            display: 'block'
            margin: '0 auto'
            height: 500
            padding: '15px'
            background: 'white'
            opacity: 1
            box-shadow: "0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23)"
          }
          @player.getIframe!style <<< style
          @setState (<<< ns), ~>
            @forceUpdate!

        onStateChange: ({data}) ~>
          switch data
          | PAUSED,ENDED =>
            clearInterval @interval
            @interval = null
          | BUFFERING => @timeTracker!
          | PLAYING =>
            @~timeTracker!
            @interval ?= setInterval @~timeTracker, 1000
    }
    @player = new window.YT.Player @refs['yt-frame'], options

  componentWillReceiveProps: (props) ->
    console.log props
    @player.seekTo(props.targetTime)
  lc: {
    cwu: (props) ->

    cwrp: ->
      console.log 'will receive props'

    cdm: ->
      if not window.YT?loaded
        @checkExist = setInterval ~>
          if window.YT?loaded
            @init!
            clearInterval @checkExist
        , 300
      else then @init!

    cwum: ->
      clearInterval @interval

  }
  r: ->
    <div style={styles.base(@props, @state)} ref='yt-frame'></div>
|> unalias >> connect(({targetTime, date}) -> {targetTime, date})
