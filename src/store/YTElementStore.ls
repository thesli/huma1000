require!{
  'redux-actions': {createAction, handleActions}
}

# export actions = {
#   YT_UPDATE_TRACK_TIME: 'YT_UPDATE_TRACK_TIME'
#   YT_UPDATE_PLAYER_TIME: 'YT_UPDATE_PLAYER_TIME'
# }
#
# export reducer = (state = {targetTime: 0,videoTime: 0}, {type,payload}) ->
#   ns = switch type
#   | actions.YT_UPDATE_TRACK_TIME => {videoTime: payload.videoTime}
#   | actions.YT_UPDATE_PLAYER_TIME => {targetTime: payload.targetTime}
#   | _  => {}
#   {...state, ...ns}

export actions = {
  YT_UPDATE_PLAYER_TIME: -> targetTime: &0
  YT_UPDATE_TRACK_TIME: -> videoTime: &0, date: new Date!
} |> (obj) ->
  reducer = (ag, [a,b]) -> ag <<< "#{a}": createAction(a,b)
  [[k,v] for k,v of obj].reduce(reducer, {})

# export reducer = handleActions do
#   YT_UPDATE_PLAYER_TIME: (state, {type, payload}) ->
#     state <<< payload
#
#   YT_UPDATE_TRACK_TIME: (state, {type, payload}) ->
#     ns = state <<< payload
#     ns
#
#   {targetTime: 0,videoTime: 0}

export reducer = (state = {targetTime: 0,videoTime: 0, date: new Date!}, {type,payload}) ->
  ns = switch type
  | "YT_UPDATE_TRACK_TIME" =>
    {videoTime: payload.videoTime}
  | "YT_UPDATE_PLAYER_TIME" =>
    {targetTime: payload.targetTime, date: new Date!}
  | _  => {}
  {...state, ...ns}
