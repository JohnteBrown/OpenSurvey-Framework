const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
  entry: "./src/index.js",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "assets/js"),
    clean: true
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: ["coffee-loader"]
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      },
      {
        test: /\.less$/,
        use: [MiniCssExtractPlugin.loader, "css-loader", "less-loader"]
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, "css-loader"]
      },
      {
        test: /\.html$/,
        type: "asset/source"
      }
    ]
  },
  resolve: {
    extensions: [".js", ".coffee"]
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: "../css/main.css"
    })
  ]
};
