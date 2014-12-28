var path = require("path");
var webpack = require("webpack");

var npmPath = path.join(__dirname, "node_modules")
var bowerPath = path.join(__dirname, "bower_components")

module.exports = {
    resolve: {
        root: ["app_build/scripts"],
        modulesDirectories: [npmPath, bowerPath]
    },
    plugins: [
        new webpack.ResolverPlugin(
            new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
        )
    ],
    output: {
      filename: 'main.build.js',
    },
}
