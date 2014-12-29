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

fixtures_dir = 'test/pendual/fixtures/'

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
    .pipe($.webpack(require('./webpack.config.coffee')))
    .pipe(g.dest(dest + 'scripts/'))

g.task 'convert_fixtures_convert_encoding', ->
  g.src(fixtures_dir + '**/*.html')
    .pipe($.shell('iconv -f sjis -t utf-8 <%= file.path %> > <%= file.path + "-utf8" %>', ignoreErrors: true))

g.task 'convert_fixtures_html2slim', ->
  g.src(fixtures_dir + '**/*.html-utf8')
    .pipe($.shell('html2slim <%= file.path %> <%= file.path.replace(/\.html-utf8/, ".slim") %>', ignoreErrors: true))

g.task 'convert_fixtures_slim2html', ->
  g.src(fixtures_dir + '**/*.slim')
    .pipe($.shell('slimrb -p <%= file.path %> <%= file.path.replace(/\.slim/, ".html-converted") %>', ignoreErrors: true))

g.task 'convert_fixtures_remove_head', ->
  g.src(fixtures_dir + '**/*.html-converted')
    .pipe($.shell('sed -e \'/<head>/,/<\\/head>/d\' <%= file.path %> > <%= file.path.replace(/\.html-converted/, ".html-removed") %>', ignoreErrors: true))

g.task 'convert_fixtures_overwrite_sources', ->
  g.src(fixtures_dir + '**/*.html-removed')
    .pipe($.rename(extname: '.html'))
    .pipe(g.dest(fixtures_dir))

g.task 'convert_fixtures_delete_temporary_files', (cb) ->
  $.del(fixtures_dir + '**/*.@(html-@(utf8|converted|removed)|slim)', cb)

g.task "convert_fixtures", (cb) ->
  $.runSequence('convert_fixtures_convert_encoding', 'convert_fixtures_html2slim', 'convert_fixtures_slim2html', 'convert_fixtures_remove_head', 'convert_fixtures_overwrite_sources', 'convert_fixtures_delete_temporary_files', cb)

###### Watch ######
g.task 'watch', ->
  $.watch(slim_src, (vinyl) -> compile_slim(vinyl.path))
  $.watch(sass_src, (vinyl) -> compile_sass(vinyl.path))
  $.watch(coffee_src, (vinyl) -> compile_coffee(vinyl.path))
