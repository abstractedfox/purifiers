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

#Ensure that modifying dependencies, like 'root.scad', enforces every file that uses it be rebuilt

$(OBJ_DIR):
	mkdir -pv $@
	mkdir -pv $@/60mm

ifneq "$$openscad" ""
#echo "Setting openscad environment variable to $$openscad"
OPENSCAD:=$$openscad
endif				

%.stl: %.scad
	$(OPENSCAD) $< -o $@

#Files that render into an actual STL. This rule exists so we can make them all dependent on root.scad
#$(OBJ_DIR)/60mm/$(60mm_stl): $(60mm_dir)/root.scad | $(OBJ_DIR)
#@echo "time to make $@"
#	$(OPENSCAD) $(60mm_dir)/$@ -o $(OBJ_DIR)/60mm/$(patsubst %.scad,%.stl,$@)
#	@echo "ok we did that"

$(60mm_stl):

60mm: $(60mm_stl) #$(60mm_src) 
	@echo "time to make 60mm"
	#$(60mm_src)
	@echo "ok donee"
