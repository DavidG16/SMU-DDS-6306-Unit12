const path = require("path");
const {CleanWebpackPlugin} = require('clean-webpack-plugin');


module.exports = {
  entry: {
    main: "./src/client/index.js",
  },
  module: {
    rules: [
        {
        test: '/\.js$/',
        exclude: /node_modules/,
        loader: 'babel-loader'
        },    
      {
        test: /\.html$/,
        use: ["html-loader"]
      },
      {
        test: /\.(svg|png|jpg|gif|jpe)$/,
        use: {
          loader: "file-loader",
          options: {
            name: "[name].[hash].[ext]",
            outputPath: "imgs"
          }}}]},
  plugins: [
     new CleanWebpackPlugin({
      dry: true,
      verbose: true,
      cleanStaleWebpackAssets: true,
      protectWebpackAssets: false
  }),
]
};