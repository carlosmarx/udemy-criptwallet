const { environment } = require('@rails/webpacker')

const customConfig = require('./custom');

const webpack = require('webpack')

environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        notify: 'notify-js-legacy/notify'
    })
)

environment.config.merge(customConfig);

module.exports = environment
