###### Require ######
g = require('gulp')

slim = require('gulp-slim')
sass = require('gulp-sass')
coffee = require('gulp-coffee')
del = require('del')
runSequence = require('run-sequence')

###### Valiable ######
src = './app/'
dest = './app_build/'

npm_dir = "./node_modules/"
bower_dir = "./bower_components/"

html_dest = dest + 'views/'
css_dest = dest + 'styles/'
js_dest = dest + 'scripts/'
font_dest = dest + 'fonts/'

html_src = html_dest + '**/*.slim'
css_src = css_dest + '**/*.sass'
js_src = js_dest + '**/*.coffee'
font_src = bower_dir + 'bootstrap-sass-official/assets/fonts/'

###### Task ######
g.task 'clean', (cb) ->
  del [dest + '**'], cb

g.task 'html', ->
  g.src(dest + 'index.slim')
    .pipe(slim(pretty: true))
    .pipe(g.dest(dest))
  g.src(html_src)
    .pipe(slim(pretty: true))
    .pipe(g.dest(html_dest))

g.task 'css', ->
  g.src(css_src)
    .pipe(sass())
    .pipe(g.dest(css_dest))

g.task 'js', ->
  g.src(js_src)
    .pipe(coffee())
    .pipe(g.dest(js_dest))

g.task 'font', ->
  g.src(font_src + "**/*")
    .pipe(g.dest(font_dest))

g.task 'copy_all', ->
  g.src(src + "**/*")
    .pipe(g.dest(dest))

g.task 'remove_src', (cb) ->
  del [dest + '**/*.slim', dest + '**/*.sass', dest + '**/*.coffee'], cb

g.task 'build', ->
  runSequence('clean', 'copy_all', ['html', 'css', 'js', 'font'], 'remove_src')

###### Watch ######
