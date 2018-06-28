#!/usr/bin/env ruby

require './lib/casemaker'

c = CaseMaker.new do
  name "Wemos D1"
  height 10
  width 35
  depth 26
  thickness 2
end

c.to_stl "wemos-d1.stl"
