path = require("path")
webpack = require("webpack")

npmPath = path.join(__dirname, "node_modules")
bowerPath = path.join(__dirname, "bower_components")

module.exports =
    module:
      loaders: [test: /\.coffee$/, loader: "coffee-loader"]
    resolve:
      modulesDirectories: [npmPath, bowerPath]
    plugins:
      [ new webpack.ResolverPlugin (
            new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
      ) ]
    output:
      filename: "main.build.js"
