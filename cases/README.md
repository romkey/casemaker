# Case specifications

- cases consist of an optional `body` and `lid`
- inner dimensions: length (x), width (y), height (z)
- wall thickness

## Body

A `body` has five walls:
- bottom
- front
- back
- left
- right

A wall may have knockouts. A knockout has the position of its lower left corner and has dimensions. Knockouts are currently always rectangular.

A knockout may reference a defined size like :microusb, :miniusb, :hdmi, :rj45

A wall may have vents. Vents have a number of incisions and the offset of the lower left hand side. By default vents are set into the largest remaining panel after knockouts are processed.
```
vent do
  number x
  position x, y
end
```

A body may have supports. By default, supports are four short posts, one built into each corner
