g = require('gulp')

del = require('del')

src = './app/'
dest = './app_build/'

g.task 'clean', ->
  del [dest + '**']
