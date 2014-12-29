_ = require("lodash-node")
IIDX = require("../../../app/scripts/pendual/pendual.coffee")

console.log _
console.log IIDX

describe("test sample:", ->
  it("success case", ->
    expect(1 + 1).toEqual(2)
  )
  it("fail case", ->
    expect(1 + 1).toEqual(3)
  )
  xit("skip case", ->
    expect(1 + 1).toEqual(3)
  )
)


