topo readlammpsdata system.data

set res 1

# This is a normal way to write a Tcl while loop.

while {$res < 2049} {
    set sel [atomselect 0 "resid $res"]
    set z [expr { (rand()-0.5)/2 }]
    $sel moveby [list 0 0 $z]
    set res [expr {$res + 1}]
}

topo writelammpsdata system_r.data

