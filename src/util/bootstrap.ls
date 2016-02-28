require!{
  'react-dom': {render}
  '../container/Page.ls': {Page, App}
  'react-redux': {Provider}
  '../store/store.ls': {store}
}
$ = document~querySelector
addEventListener 'load', ->
  $page =
    <Provider store={store}>
      <App></App>
    </Provider>
  render $page, $('#react-container')
