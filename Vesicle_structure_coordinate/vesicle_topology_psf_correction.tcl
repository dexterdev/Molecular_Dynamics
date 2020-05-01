mol addfile /home/devanandt/Documents/LAMMPS/PROJECTS/membrane_examples/farago2003/after_April21email_correction/smaller_vesicles/vesicle_resid_renumbered_rad10_apl1.8.pdb
package require topotools
package require pbctools

set sel1 [atomselect 0 "sqrt(x^2+y^2+z^2)>9.9"]
$sel1 set type H

set sel2 [atomselect 0 "(sqrt(x^2+y^2+z^2)>5.7) and (sqrt(x^2+y^2+z^2)<5.9)"]
$sel2 set type H

set sel3 [atomselect 0 "(sqrt(x^2+y^2+z^2)>8.9) and (sqrt(x^2+y^2+z^2)<9.1)"]
$sel3 set type T1

set sel4 [atomselect 0 "(sqrt(x^2+y^2+z^2)>6.7) and (sqrt(x^2+y^2+z^2)<6.9)"]
$sel4 set type T1

set sel5 [atomselect 0 "(sqrt(x^2+y^2+z^2)>7.7) and (sqrt(x^2+y^2+z^2)<8.1)"]
$sel5 set type T2

set sel6 [atomselect 0 "(sqrt(x^2+y^2+z^2)>7.9)"]
$sel6 set segname U 

set sel7 [atomselect 0 "(sqrt(x^2+y^2+z^2)<7.9)"]
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

pbc set {25 25 25} -all -molid top
pbc box -center origin

topo writelammpsdata vesicle_10radius_apl1.8_topology_corrected.data
$sel writepsf vesicle_10radius_apl_1.8_topology_corrected.psf


