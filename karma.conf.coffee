# Karma configuration
# Generated on Mon Dec 29 2014 16:39:56 GMT+0900 (JST)
module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: ""

    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ["jasmine"]

    # list of files / patterns to load in the browser
    files: ["test/pendual/unit/*.coffee"]

    # list of files to exclude
    exclude: []

    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors:
      '**/*.coffee' : ['coffee', 'webpack', 'sourcemap']

    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ["progress"]

    # web server port
    port: 9876

    # enable / disable colors in the output (reporters and logs)
    colors: true

    # level of logging
    # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ["Chrome"]

    plugins: [
      'karma-chrome-launcher'
      'karma-coffee-preprocessor'
      'karma-jasmine'
      'karma-sourcemap-loader'
      'karma-webpack'
    ]

    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false

