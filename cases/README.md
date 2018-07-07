# Case specifications

**This is a proposal for syntax and features for Casemaker. Casemaker does not currently support this file format or these features.**

- cases consist of an optional `body` and `lid`
- inner dimensions: length (x), width (y), height (z) in mm
- wall thickness in mm
- name
- link to specs for specific boards

All dimensions are in mm.

To avoid ambiguity, ll parameters are named. Knockouts and vents specify offsets in the plane of their face, from the lower left hand corner of the feature.

The code is pure Ruby, so you can use Ruby expressions, conditionals, functions, etc, in it.

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
    knockout offset_x: x, offset_y: y, shape: :microusb
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

Each wall may be customized.
```
body do
  front do
    knockout offset_x: 2, offset_y: 2, height: 4, width: 4
    knockout offset_x: 20, offset_y: 20, radius: 5, shape: :circle
  end
end
```

A body will only be printed if specified.

### Knockouts

A wall may have knockouts. A knockout has the position of its lower left corner and has dimensions. Knockouts are currently always rectangular.

A knockout may reference a pre-defined size or shape like :microusb, :miniusb, :hdmi, :rj45, :circle

Circular knockouts also take a `radius:` parameter. Their x and y offsets are the coordinate of the lower left corner of their square bounding box.

Casemaker will throw an error if there is insufficient space for a knockout (for instance, the knockout is higher than the remaining case in its position).

### Vents

A wall may have vents. Vents have a number of incisions and the offset of the lower left hand side. By default vents are set into the largest remaining panel after knockouts are processed.

```
vent do
  offset_x 2
  offset_y 2
  width 2
  height 5
end

vents number: 5, width: 1, offset_x: 2, offset_y: 2, height: 4
```

All arguments are optional. Casemaker will make its best guess at how to arrange vents if options are not specified.

Vents will be evenly distributed across the remaining wall.

Casemaker will throw an error if there is insufficient space for the specified quantity or width of vents.

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
