g = require('gulp')

slim = require('gulp-slim')
sass = require('gulp-sass')
coffee = require('gulp-coffee')
del = require('del')
runSequence = require('run-sequence')

src = './app/'
dest = './app_build/'

html_dest = dest + 'views/'
css_dest = dest + 'styles/'
js_dest = dest + 'scripts/'

html_src = html_dest + '**/*.slim'
css_src = css_dest + '**/*.sass'
js_src = js_dest + '**/*.coffee'

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

g.task 'copy_all', ->
  g.src(src + "**/*")
    .pipe(g.dest(dest))

g.task 'remove_src', (cb) ->
  del [dest + '**/*.slim', dest + '**/*.sass', dest + '**/*.coffee'], cb

g.task 'build', ->
  runSequence('clean', 'copy_all', ['html', 'css', 'js'], 'remove_src')
