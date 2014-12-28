###### Require ######
g = require('gulp')

# gulp-load-plugins will automatically load plugins starting with "gulp-"
$ = require('gulp-load-plugins')()
# manually loaded plugins
$.del = require('del')
$.runSequence = require('run-sequence')

###### Variable ######
src  = 'app/'
dest = 'app_build/'

npm_dir   = "node_modules/"
bower_dir = "bower_components/"

slim_src  = src + '**/*.slim'
sass_src   = src + '**/*.sass'
coffee_src    = src + '**/*.coffee'
font_src  = bower_dir + 'bootstrap-sass-official/assets/fonts/bootstrap/*'

###### Function ######
compile_slim = (s)   -> g.src(s, {base: src}).pipe($.slim(pretty: true)).pipe(g.dest(dest))
compile_sass = (s)   -> g.src(s, {base: src}).pipe($.sass()).pipe(g.dest(dest))
compile_coffee = (s) -> g.src(s, {base: src}).pipe($.coffee()).pipe(g.dest(dest))

###### Task ######
g.task 'slim',       -> compile_slim(slim_src)
g.task 'sass',       -> compile_sass(sass_src)
g.task 'coffee',     -> compile_coffee(coffee_src)
g.task 'font',       -> g.src(font_src).pipe(g.dest(dest + 'fonts/bootstrap/'))
g.task 'copy',       -> g.src(src + '**/!(*.slim|*.sass|*.coffee)').pipe(g.dest(dest))
g.task 'clean', (cb) -> $.del(dest, cb)
g.task 'build',      -> $.runSequence('clean', 'copy', ['slim', 'sass', 'coffee', 'font'], 'webpack')

# do nothing so far
g.task "webpack", ->
  g.src(dest + 'scripts/main.js')
    .pipe($.webpack())
    .pipe(g.dest(dest + 'scripts/'))

###### Watch ######
g.task 'watch', ->
  $.watch(slim_src, (vinyl) -> compile_slim(vinyl.path))
  $.watch(sass_src, (vinyl) -> compile_sass(vinyl.path))
  $.watch(coffee_src, (vinyl) -> compile_coffee(vinyl.path))
