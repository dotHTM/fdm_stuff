# FDM stuff

Various objects and board game accessories.

OpenSCAD files and STLs.

Modules directory contains reusable OpenSCAD code.

ALL FILES PROVIDED AS IS AND WITH NO WARRANTY. MIT/BSD LICENSE UNLESS OTHERWISE NOTED.

# Projects

Projects and experiments for printing:

- [filament mixing](Projects/filament mixing (wip))
 
Games:

- [Arcs Storage](Projects/Arcs Storage)
- [Card holders](Projects/Card holders)

Toys & Education:

- [stim handle](Projects/stim handle)
- [pointers](Projects/pointers)
- [shattered dagger](Projects/shattered dagger)
- [whistles](Projects/whistles)
- [shells](Projects/shells) (untested)

Organization:

- [arkfeild flashlight accessories](Projects/arkfeild)
- [Can Holders](Projects/Can Holders)

Clothing and "Jewelry":

- [Strap holders](Projects/Clothing)
- [low_poly_rings](Projects/low_poly_rings)

Decoration:

- [pottery](Projects/pottery)
- [Slotted stain glass tree](Projects/Slotted stain glass tree)

Recycling parts:

- [Grip Strength](Projects/Grip Strength)


# OpenSCAD Modules

## `math_tricks.scad`

<dt>`practically_zero` : scalar</dt>
<dd>For times you want a 2d element to technically exist within R^3.</dd>

<dt>`pz(value: scalar, negative: bool ) -> scalar`</dt>
<dd>If value is zero, replace with `practically_zero` (optionally as a negative).</dd>

<dt>`epsilon`</dt>
<dd>A very small number for offsetting surfaces, often to avoid z-fighting or to help union or splitting parts with minimal side-effects. Control the scale of this value with `$epsilon_scale`.</dd>

<dt>`pass_positive( value )`</dt>
<dd>returns a positive value or zero</dd>

<dt>`pass_positive_max( value, maximum )`</dt>
<dd>returns a positive value up to a maximum or zero</dd>

<dt>`pass_between( value, low, high )`</dt>
<dd>returns the value or the nearest limit or the low limit</dd>


<dt>`sqrt2`, `sqrt3`</dt>
<dd>Unit "box" diagonal length constants.</dd>

<dt>quick vectors: `xv`, `yv`, `zv`, `xyv`, `yzv`, `zxv`, `dv`, </dt>
<dd>
  When you don't want to write out the full `vect3` notation to do a single axis translate, scale, or rotate. One in each axis and pair, and one in the R^3 "diagonal" (not normalized).
</dd>

<dt>quick vector functions: `iv()`, `jv()`, `kv()`, `ijv()`, `jkv()`, `kiv()`, `ijkv()`</dt>
<dd>Same as above, but feed a scalar to get an `vect3`</dd>

## `t_slots.scad`

<dt>`t_slot_slice( positive, part_window, interface_angle, t_round, t_width, t_thick, t_neck, t_neck_thick, t_height)`</dt>
<dd>Volume that creates a t-slot near the origin. Positive and negative versions of the same feature for matching features.</dd>

## `handles.scad`

<dt>`grip_wand( height ,  detail_height ,  disc_height, center_offset, lw )`</dt>
<dd>Handle for a pointer.</dd>

<dt>`handle_sword()`</dt>
<dd>Handle for a pointer, also looks like a sword.</dd>

<dt>`x_axis_polygon_revolve( points )`</dt>
<dd>Lathe a list of points along the x-axis.</dd>


## `icons.scad`

<dt>`icon_hand(center_height, outline_height)`</dt>
<dd>An old hand pointer.</dd>

<dt>`icon_arrow(pointing = false, center_height, outline_height)`</dt>
<dd>An old arrow pointer.</dd>

<dt>`svg_extrude(height, file_path, center_plane = false)`</dt>
<dd>Open an SVG and extrude in a single line.</dd>


