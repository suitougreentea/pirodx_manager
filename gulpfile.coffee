g = require('gulp')

slim = require('gulp-slim')
sass = require('gulp-sass')
coffee = require('gulp-coffee')
del = require('del')
runSequence = require('run-sequence')

src = './app/'
dest = './app_build/'

html = [dest + 'index.slim', dest + 'views/**/*.slim']
css = dest + 'styles/**/*.sass'
js = dest + 'scripts/**/*.coffee'

g.task 'clean', (cb) ->
  del [dest + '**'], cb

g.task 'html', ->
  g.src(html)
    .pipe(slim(pretty: true))
    .pipe(g.dest(dest))

g.task 'css', ->
  g.src(css)
    .pipe(sass())
    .pipe(g.dest(dest))

g.task 'js', ->
  g.src(js)
    .pipe(coffee())
    .pipe(g.dest(dest))

g.task 'copy_all', ->
  g.src(src + "**/*")
    .pipe(g.dest(dest))

g.task 'remove_src', (cb) ->
  del [dest + '**/*.slim', dest + '**/*.sass', dest + '**/*.coffee'], cb

g.task 'build', ->
  runSequence('clean', 'copy_all', ['html', 'css', 'js'], 'remove_src')
