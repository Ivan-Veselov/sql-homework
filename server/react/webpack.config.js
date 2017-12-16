var webpack = require('webpack');
var path = require('path');

module.exports = {
    entry: 'index.js',
    devtool: 'sourcemaps',

    output: {
        path: __dirname,
        filename: '../build/resources/main/public/bundle.js'
    },

    resolve: {
        modules: [__dirname, 'node_modules', 'src'],
        extensions: ['.js', '.jsx', '.css', '.json']
    },

    module: {
        rules: [
        {
            test: /\.jsx?$/,
            exclude: /node_modules/,
            loaders: ['babel-loader?presets[]=react,presets[]=es2015,presets[]=stage-0']
        }
        ]
    },
};