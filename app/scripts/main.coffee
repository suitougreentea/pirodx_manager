'use strict'
console.log 'main.coffee'

angular = require('angular')
_ = require('lodash-node')
window.$ = require('jquery') # for debug

IIDX = require('./pendual/pendual.js')

console.log angular
console.log _
console.log IIDX.test_add(1, 2)
console.log IIDX.status.test_mul(1, 2)
