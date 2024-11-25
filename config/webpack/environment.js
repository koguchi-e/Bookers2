const { environment } = require('@rails/webpacker');

// Nodeの設定を追加
environment.config.merge({
  node: false
});

module.exports = environment;
