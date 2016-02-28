require!{
  '../component/YTElement.ls': {YTElement}
  '../component/ScrollView.ls': {ScrollView}
  '../store/YTElementStore.ls': {reducer}
  'radium'
  'redux': {createStore}
  'react-redux': {Provider, connect}
}

styles =
  wrapper:
    base:
      display: 'flex'
      flexDirection: 'column'
      width: '100%'
      height: '100%'
  row:
    base:
      flex: 1

secToStr = (s) ->
  p = -> if &0.toString!.length is 1 then "0#{&0}" else &0.toString!
  [(s / 60), (s % 60)].map(-> parseInt(&0) |>  p).join(':')

export App = class extends React.Component
  r: ->
    <div style={styles.wrapper.base}>
      <YTElement></YTElement>
      {secToStr @props.videoTime}
      <ScrollView></ScrollView>
    </div>
|> unalias >> connect(({videoTime})-> {videoTime})

export Page = App
