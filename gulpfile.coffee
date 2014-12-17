g = require('gulp')

slim = require('gulp-slim')
sass = require('gulp-sass')
coffee = require('gulp-coffee')
del = require('del')
runSequence = require('run-sequence')

src = './app/'
dest = './app_build/'

html = [src + 'index.slim', src + 'views/**/*.slim']
css = src + 'layouts/**/*.sass'
js = src + 'scripts/**/*.coffee'

g.task 'clean', ->
  del [dest + '**']

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
  g.src(src + "*").pipe(g.dest(dest))

g.task 'remove_src', ->
  del [dest + '**/*.slim', dest + '**/*.sass', dest + '**/*.coffee']

g.task 'make', ->
  runSequence('clean', 'copyall', ['html', 'css', 'js'], 'removesrc')
