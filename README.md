# FDM stuff

Various objects and board game accessories.

OpenSCAD files and STLs.

Modules directory contains reusable OpenSCAD code.

# Projects

## Arcs Component Holders

![Component Holders](previews/arcs_compents.png)

Player component organizers for quick to-the-table setup & play! Holds all player components from the base game and campaign expansion!

Fits in the campaign box with the save state bin and dividers to maintain functionality of the original vacuum-formed trays.

Additional drawer box to help hide the shame of all the bagged campaign fate tokens.

![Generic storage box](previews/arcs_tokens_box.png)

Designed in OnShape:

- [component holder](https://cad.onshape.com/documents/f8baa16c513774a1b4c4d1ff/w/156d0fb384fcc7c2bd21cdf2/e/2bc8450ed0d50105c287a671)
- [drawer box](https://cad.onshape.com/documents/24cb144bc6b0252d1dc903cc/w/38af809ec307699281591f3d/e/049a71283b5f04f74c4f6156)

## Shard of Nargasil

![prop shattered dagger](previews/shard_dagger.png)

A prop dagger (as big as would fit on my Prusa MK4), themed lightly on the "Shards of Narsil" from "The Lord of the Rings" film prop. Name is a mix between the LotR sword and my wife taking about the "nargles" interfering with me.

When importing into the slicer, you can make a textured grip by using the "Add Modify > Load" in PrusaSlicer, and add the fuzzy-skin setting and enable. Import the `modify` part as normal to get the dimensions in case the slicer imports the modify-`modify` object too small (is this a bug) and then visually align it as you can in the Y-axis ( X and Z should likely be both be zero when in Object Coordinates). I angled the group at 35º to fit on my 250 x 210 mm bed.

Print the dagger before you print a full scabbard. A `test` intersection of the scabbard has been provided to try out various scale factors. The scabbard has zero tolerance built in, so if you print it on a different plane than the dagger, round over errors will occur and make fitting the dagger in the scabbard impossible or one-way. I think 102% was okay for my print, but I ended up going with 104% for my final print.

Interesting geometric detail, you can glue two of these together along the "shatter" and make something that looks like a sword-equivalent of a drawknife or spokeshave.

[Designed in OnShape](https://cad.onshape.com/documents/8fd88022c6663004678fa262/w/4fc7def6cca343c748adaecc/e/43a368d694a9a7e5d57b0bc9)

## Card Holders

Import SVG into your slicer of choice, confirm scale by setting the Y height of the object (70.4 mm as of this writing) with a matching X scale, and adjust the Z "extrusion" to be as long as you'd like and/or can print on your machine.

Standard US playing cards are just under 64 mm, so three wide plus a little wiggle for comfort should be able to fan several per row.

I like the version "with token bin" to be printed one card wide, so that several can be printed in a multi-color filament to get my four player shades in one print job. Good for an auction system like the court in Arcs.

## Low Poly Rings

I'm an old Sonic the Hedgehog fan, and I happened to be reading "The Hobbit", so I wanted to have a prop that I could hold or wear that makes me think of either.

**Finger ring:**
![ring](previews/lpr_ring.png)

**Bracelet:**
![bracelet](previews/lpr_bracelet.png)

## Pointers

I was watching Dice Tower on YouTube, someone had a finger pointer to help with the rules explanation.

Once piece, small arrow & x, maxs out Prusa i3 bed at a 40º angle.

![basic wand](previews/pointer.png)

The same, but split using a t-slot to be BIGGER!

![multi](previews/pointer_multi.png)

Mac OS inspired pixel pointers. I accidentally added a point that made a sword/dagger hand guard, and I couldn't bring myself to remove it.

**Arrow**
![os arrow](previews/pointer_os_arrow.png)

**Hand**
![os hand](previews/pointer_os_hand.png)

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


