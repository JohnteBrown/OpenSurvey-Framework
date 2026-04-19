const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
  entry: "./src/index.js",

  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "assets/js"),
    clean: true,
    publicPath: "/assets/js/"
  },

  module: {
    rules: [
      // =========================
      // CoffeeScript
      // =========================
      {
        test: /\.coffee$/,
        include: path.resolve(__dirname, "src/coffee"),
        use: ["coffee-loader"]
      },

      // =========================
      // JS (your app + bootstrap)
      // =========================
      {
        test: /\.js$/,
        include: path.resolve(__dirname, "src"),
        exclude: /node_modules/,
        use: "babel-loader"
      },

      // =========================
      // CSS (FIXED: node_modules + normal CSS)
      // =========================
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          "css-loader"
        ]
      },

      // =========================
      // LESS (your custom styles)
      // =========================
      {
        test: /\.less$/,
        include: path.resolve(__dirname, "src/less"),
        use: [
          MiniCssExtractPlugin.loader,
          "css-loader",
          "less-loader"
        ]
      },

      // =========================
      // HTML templates
      // =========================
      {
        test: /\.html$/,
        include: path.resolve(__dirname, "src/templates"),
        type: "asset/source"
      },

      // =========================
      // Images
      // =========================
      {
        test: /\.(png|jpg|jpeg|gif|svg)$/,
        type: "asset/resource",
        generator: {
          filename: "../js/[name][ext]"
        }
      }
    ]
  },

  resolve: {
    extensions: [".js", ".coffee"],
    modules: [
      path.resolve(__dirname, "src/coffee"),
      path.resolve(__dirname, "src"),
      "node_modules"
    ]
  },

  plugins: [
    new MiniCssExtractPlugin({
      filename: "../css/main.css"
    })
  ]
};