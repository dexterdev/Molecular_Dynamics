mol addfile vesicle_15rad_apl_outer1.9_inner1.8.pdb
package require topotools
package require pbctools

set rad 15
set ra [expr $rad - 0.1]
set rb [expr $ra - 1.0]
set rbu [expr $rb + 0.2]
set lrad [expr $rad - 5.0]
set lrada [expr $lrad - 0.1]
set lradau [expr $lrad + 0.1]
set mu [expr $rad - 1.9]
set ml [expr $lrad + 1.9]
set lrb [expr $rb - 3.0]
set lrbu [expr $rbu - 3.0]

set boxx 35
set boxy 35
set boxz 35

set sel1 [atomselect 0 "sqrt(x^2+y^2+z^2)>$ra"]
$sel1 set type H

set sel2 [atomselect 0 "(sqrt(x^2+y^2+z^2)>$lrada) and (sqrt(x^2+y^2+z^2)<$lradau)"]
$sel2 set type H

set sel3 [atomselect 0 "(sqrt(x^2+y^2+z^2)>$rb) and (sqrt(x^2+y^2+z^2)<$rbu)"]
$sel3 set type T1

set sel4 [atomselect 0 "(sqrt(x^2+y^2+z^2)>$lrb) and (sqrt(x^2+y^2+z^2)<$lrbu)"]
$sel4 set type T1

set sel5 [atomselect 0 "(sqrt(x^2+y^2+z^2)>$ml) and (sqrt(x^2+y^2+z^2)<$mu)"]
$sel5 set type T2

set c [expr $rad - ($rad-$lrad)/2.0]
set sel6 [atomselect 0 "(sqrt(x^2+y^2+z^2)>$c)"]
$sel6 set segname U 

set sel7 [atomselect 0 "(sqrt(x^2+y^2+z^2)<$c)"]
$sel7 set segname L 

set blist {}
set natoms [molinfo top get numatoms]
for {set a 0; set b 1} {$b < $natoms} {set a [expr {$a + 3}]; set b [expr {$b + 3}]} {
  lappend blist [list $a $b H-T1]
}

set bblist {}
set natoms [molinfo top get numatoms]
for {set c 1; set d 2} {$d < $natoms} {set c [expr {$c + 3}]; set d [expr {$d + 3}]} {
  lappend bblist [list $c $d T1-T2]
}

set tlist [concat $blist $bblist]
topo setbondlist type $tlist

set anglelist {}
set natoms [molinfo top get numatoms]
for {set a 0; set b 1; set c 2} {$c < $natoms} {set a [expr {$a + 3}]; set b [expr {$b + 3}]; set c [expr {$c + 3}]} {
  lappend anglelist [list H-T1-T2 $a $b $c]
}
topo setanglelist $anglelist

set sel [atomselect 0 all]
$sel set mass 1

pbc set {boxx boxy boxz} -all -molid top
pbc box -center origin

topo writelammpsdata vesicle_15radius_topology_corrected.data
$sel writepsf vesicle_15radius_topology_corrected.psf
$sel writepdb vesicle_15radius_topology_corrected.pdb

