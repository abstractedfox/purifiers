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

#If we passed an openscad executable using an environment variable, use it
ifneq "$$openscad" ""
OPENSCAD:=$$openscad
endif				

zip:
	if [[ $$(git diff-index HEAD) == "" ]]; then \
		$(MAKE) clean \
		zip -r release-$$(git rev-parse --short HEAD) out \
	else \
		echo "There are uncommitted changes, please commit your work before preparing a release"; \
	fi

#we explicitly set root.scad as a prerequisite so the entire project will be rebuilt if it gets modified
out/60mm/%.stl : 60mm/%.scad 60mm/root.scad 
	$(OPENSCAD) $< -D "resolution = resolutionProd" -o $@

$(OBJ_DIR)/60mm:
	mkdir -pv $(OBJ_DIR)/60mm

$(OBJ_DIR): $(OBJ_DIR)/60mm
	mkdir -pv $@

$(OBJ_DIR)/60mm/instructions.txt: 60mm/instructions.txt
	cp -f $< $@ 

$(OBJ_DIR)/60mm/src.tar.gz: $(60mm_dir)/*.scad
	tar -czf $@ $<

60mm: $(OBJ_DIR) $(60mm_stl) $(60mm_src) $(OBJ_DIR)/60mm/instructions.txt $(OBJ_DIR)/60mm/src.tar.gz

all:
	$(MAKE) 60mm

clean:
	rm -rf out
	$(MAKE) 60mm
