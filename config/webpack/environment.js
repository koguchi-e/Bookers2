const { environment } = require('@rails/webpacker');

// Nodeの設定を追加
environment.config.merge({
  node: false
});

module.exports = environment;

// Bootstrapの導入
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)
