require!{
  'redux': {createStore}
  'redux-actions': {createAction, handleActions}
  './YTElementStore.ls': {reducer}
}
# editorReducer = handleActions do

export store = createStore reducer
