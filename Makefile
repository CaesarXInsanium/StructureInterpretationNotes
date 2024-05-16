PANDOC=/usr/bin/pandoc
TARGET_DIR=docs
TARGET=SICPNotes
AUTHOR=Caesar X Insanium
FLAGS= --pdf-engine=xelatex \
			 --toc \
			 --variable documentclass=report \
			 --variable title="$(TARGET)" \
			 --variable author="$(AUTHOR)" \
			 --variable margin-left=1in \
			 --variable margin-right=1in \
			 --variable margin-top=1in \
			 --variable margin-bottom=1in \

#--variable classoption=landscape,twocolumn 

SOURCES= Notes/Procedures.md \
				 Notes/DataAbstractions.md \
# Chapter 3\
				 Notes/ModularityObjectsStateIntro.md \
				 Notes/AssignmentAndLocalState.md \
				 Notes/EnvironmentModelEvaluation.md \
				 Notes/ModelingMutableData.md \
				 Notes/Concurrency.md \
				 Notes/Streams.md \
# Chapter 4\
				 Notes/MetalinguisticAbstraction.md \
				 Notes/MetacircularEvaluator.md \
				 Notes/LazyEvaluation.md \
				 Notes/NondeterministicComputing.md \
				 Notes/LogicProgramming.md \
# Chapter 5\
				 Notes/RegisterMachines.md \
				 Notes/DesigningRegister.md \
				 Notes/RegisterSimulator.md \
				 Notes/AllocationGarbageCollection.md \
				 Notes/ControlEvaluator.md \
				 Notes/Compilation.md



# allow force rebuild

.PHONY: $(TARGET_DIR) \
	   $(TARGET_DIR)/$(TARGET).pdf \
	   $(TARGET_DIR)/$(TARGET).epub

$(TARGET_DIR)/$(TARGET).pdf: $(SOURCES)
	$(PANDOC) $(FLAGS) $? -o $@

$(TARGET_DIR)/$(TARGET).epub: $(SOURCES)
	$(PANDOC) $(FLAGS) $? -o $@

epub: $(TARGET_DIR)/$(TARGET).epub

$(TARGET_DIR):
	mkdir $@

clean:
	rm -rf $(TARGET_DIR)

# useful flags
# shift to right
# --shift-heading-level-by=-1
#  --defaults
#  we can also have a file called defaults.yaml
#  next time we move to a full defaults.yaml file instead of Makefile
