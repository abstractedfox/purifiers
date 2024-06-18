#Pass a path to the openscad executable as argument 1 to run the makefile using that executable 

export openscad="$1"
make -j $2
