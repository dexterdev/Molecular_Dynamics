source /home/devanandt/Documents/3KUC/TCL-scripts-fromVani/fitframes-ref-pdb.tcl
#======================
#Loading psf/dcd/pdb in text format (add below lines after 'source' in above script:

mol new /home/devanandt/Documents/RAS/1C1Y/DATA/1C1Y/FULL/SIM_1/RUN1/1c1y-full-WB-NEUTRALIZED.psf 
mol addfile /home/devanandt/Documents/RAS/1C1Y/DATA/1C1Y/FULL/SIM_1/RUN1/1C1Y_FULL_RUN1.dcd first 0 last 7000 step 1 waitfor all

mol new /home/devanandt/Documents/RAS/1C1Y/DATA/1C1Y/FULL/SIM_1/RUN1/1c1y-full-WB-NEUTRALIZED.pdb

set sel [atomselect 0 "segname U1 or segname U2"]
set nf1 [molinfo 0 get numframes]
set nf 7000
puts $nf
fitframesdcd 1 0 "segname U1 or segname U2"
puts "before animate"
animate write dcd test.dcd beg 0 end $nf waitfor all sel $sel 0
puts "after animate"
$sel writepsf test.psf
mol delete 0
mol delete 1
exit
