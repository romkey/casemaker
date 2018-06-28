# CaseMaker

CaseMaker is a Ruby DSL for describing cases to be rendered as STL
files for 3D printers.

Most cases are simple and have common features:

- a case
- a lid
- standoffs for screws
- vents
- knockouts/cutouts for USB ports, LEDs, switches and other things

CaseMaker allows you to write a simple description of the dimensions
of the case and its features:

```
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
```

This will generate STL for a simple case for a Wemos D1 board, along
with a lid.

[[https://github.com/romkey/casemaker/blob/mastercura-screengrab.png|alt=case]]

## Installation

Ensure that you have a usable Ruby environment on your computer.

Use `example.rb` as a basis for your case definitions. To generate its
STL file, you'd run `ruby example.rb`. It leaves its output in "wemos-d1.stl".

## Roadmap

- improve the Ruby DSL to avoid unnecessary cruft
- add standoffs
- add vents
- add knockouts/cutouts
- add text
- maybe parse a Casefile
- publish as a gem

## Long term goals

- libraries of parts' dimensions
- ability to load a part from a library and automatically form a case
around it

## License

MIT: https://romkey.mit-license.org/
