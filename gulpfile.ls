require!{
  'webpack-dev-server'
  'webpack': {HotModuleReplacementPlugin, ProvidePlugin, {CommonsChunkPlugin}:optimize}: webpack
  'browser-sync'
  'gulp'
}

const [task, src, dest] = ['task', 'src', 'dest'].map -> gulp~[&0]

task 'webpack-dev-server', ->
  config = {
    entry:
      app: [
        'webpack-dev-server/client?http://localhost:9090',
        'webpack/hot/only-dev-server'
        './src/entry.ls'
      ]
      vendor: [
        'react', 'react-dom', 'remark', 'remark-react', 'react-redux', 'redux', './node_modules/markdown-styles/layouts/github/assets/css/github-markdown.css'
      ]
    output:
      path: "#{__dirname}/build"
      filename: "[name].js"
      publicPath: '/assets'
    module:
      loaders:
        * test: /\.ls$/, loaders: ['react-hot', 'livescript', 'cjsx']
        * test: /\.json$/, loaders: ['json']
        * test: /\.css$/, loaders: ['style', 'css']
        * test: /\.md$/, loaders: ['raw']
        * test: /\.(jpe?g|png|gif|svg)$/, loaders: ['file']
        ...
    resolve: ['.', '', '.ls', '.js']
    plugins:
      * new CommonsChunkPlugin name: 'vendor', filename: 'vendor.js'
      * new HotModuleReplacementPlugin!
      * new ProvidePlugin do
          'React': 'react'
          'unalias': 'react-unalias'
          'L': "#{__dirname}/src/util/logger.ls"
      ...
    +watch
    devtool: 'sourcemap'
  }
  compiler = webpack(config)
  config = {
    contentBase: './build/'
    hot: true
    publicPath: '/assets'
    stats: true
    -quiet
    -noInfo
    -historyApiFallback
  }
  new webpackDevServer(compiler, config)
  .listen(9090, 'localhost', ->)

task 'browser-sync', ->
  config = {
    -ui
    -open
    server:
      baseDir: "./build/"
    port: 5001
  }
  browser-sync(config)
