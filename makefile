#Produce a build of all .scad files

#By default we will assume openscad is on PATH
OPENSCAD:=openscad
OBJ_DIR:=out

60mm_dir:=./60mm
120mm_dir:=./120mm

60mm_src:=top.scad \
	flow-conditioner.scad \
	flow-conditioner-gap.scad \
	filter-housing.scad

60mm_stl:=$(patsubst %.scad, $(OBJ_DIR)/60mm/%.stl, $(60mm_src))

60mm_src:=$(patsubst %, $(60mm_dir)/%, $(60mm_src))

#Ensure that modifying dependencies, like 'root.scad', enforces every file that uses it be rebuilt

$(OBJ_DIR):
	mkdir -pv $@
	mkdir -pv $@/60mm

ifneq "$$openscad" ""
#echo "Setting openscad environment variable to $$openscad"
OPENSCAD:=$$openscad
endif				

%.stl : %.scad 
	@echo "hi we're in the implicit rule with the $%"
	$(OPENSCAD) $% -o $@


#$(60mm_stl): $(60mm_src)
#	$(OPENSCAD) $< -o $@

60mm: 60mm/top.scad out/60mm/top.stl
	@echo "ok does THIS work"

#60mm:  $(60mm_stl) $(60mm_src)
#	@echo "time to make 60mm"
#	@#echo $(60mm_src)
#	@#echo $(60mm_stl)
#	@echo "ok donee"
