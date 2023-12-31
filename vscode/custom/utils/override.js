const WorkboxWebpackPlugin = require('workbox-webpack-plugin');

module.exports = function override(config, env) {
  config.plugins = config.plugins.map(plugin => {
    if (plugin.constructor.name === 'GenerateSW') {
      return new WorkboxWebpackPlugin.InjectManifest({
        swSrc: './src/custom-service-worker.js',
        swDest: 'service-worker.js'
      });
    }
    return plugin;
  });
  return config;
};

workbox.routing.registerRoute(new RegExp('/path/to/cache/directory/'), workbox.strategies.NetworkFirst());
workbox.precaching.precacheAndRoute(self.__precacheManifest || []);
