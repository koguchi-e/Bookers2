const { environment } = require('@rails/webpacker');

// Nodeの設定を追加
environment.config.merge({
  node: false
});

// Bootstrapの導入
const webpack = require('webpack');
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
);

// Sassの設定を追加
const sassLoader = environment.loaders.get('sass');
if (sassLoader) {
  sassLoader.use.find(item => item.loader === 'sass-loader').options = {
    additionalData: `@use 'sass:math';`
  };
}

module.exports = environment;
