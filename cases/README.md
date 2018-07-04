# Case specifications

**This is a proposal for syntax and features for Casemaker. Casemaker does not currently support this file format or these features.**

- cases consist of an optional `body` and `lid`
- inner dimensions: length (x), width (y), height (z)
- wall thickness
- name
- link to specs for specific boards

All dimensions are in mm.

For example:
```
name "Wemos D1"
spec "https://www.flickr.com/photos/143909899@N03/31400410271"

height 10
length 35
width 26
thickness 5

body do
  right do
    knockout x, y, z, :microusb
  end

  supports do
    height 1
  end
end

lid do
  # leave a 0.25mm gap between the inner lid and the case walls
  gap .25
end
```

## Body

A `body` has five walls:
- bottom
- front
- back
- left
- right

The body defaults to having all five walls. Each wall may be customized.

A body will only be printed if specified.

### Knockouts

A wall may have knockouts. A knockout has the position of its lower left corner and has dimensions. Knockouts are currently always rectangular.

A knockout may reference a pre-defined size like :microusb, :miniusb, :hdmi, :rj45

Casemaker will throw an error if there is insufficient space for a knockout (for instance, the knockout is higher than the remaining case in its position).

### Vents

A wall may have vents. Vents have a number of incisions and the offset of the lower left hand side. By default vents are set into the largest remaining panel after knockouts are processed.

```
vent do
  number x
  position x, y
end
```

Vents will be evenly distributed across the remaining wall.

Casemaker will throw an error if there is insufficient space for the specified quantity of vents.

### Supports

A body may have supports. By default, supports are four short posts, one built into each corner

### Mounts

A mount is a support with a screw hole in it.

If mounts are in consistent locations, they may be specified by giving an inset from the wall and a radius for the mount.

```
body do
  mounts do
    inset 3.5
    height 1
    radius 2
  end
end
```

If mounts are not in consistent locations they may be specified individually:

```
body do
  mount x1_offset, y2_offset, height, radius 
  mount x2_offset, y2_offset, height, radius 
end
```

### Attachments

A body may have external attachments. These jut out from the base and have a hole in them.

## Lid

The lid is the same dimensions of the body, with an interior, raised section which fits the inner dimensions of the body.

A lid will only be printed if specified.

### Lid features

A lid may have knockouts and vents, just as walls on a body.

### Gap

A lid may have a gap which allows for a space between the interior raised section and the inner walls of the body.

```
lid do
  gap 0.25
end
```
