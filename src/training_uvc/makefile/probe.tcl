## Establishing the probes for VHDL Design ##
#-------------------------------------------#

database -open default -shm

probe -create training_uvc_tb_top -depth all -all -shm -database default

run

exit
