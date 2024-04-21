PANDOC=/usr/bin/pandoc
TARGET_DIR=docs
TARGET=SICPNotes
AUTHOR=Caesar X Insanium
FLAGS= --pdf-engine=xelatex \
			 --toc \
			 --variable documentclass=report \
			 --variable title="$(TARGET)" \
			 --variable author="$(AUTHOR)" \

SOURCES= Notes/Procedures.md \
				 Notes/DataAbstractions.md \


# allow force rebuild
.PHONY: all

all: $(TARGET_DIR) \
	  	$(TARGET_DIR)/$(TARGET).pdf

$(TARGET_DIR)/$(TARGET).pdf: $(SOURCES)
	$(PANDOC) $(FLAGS) $? -o $@

$(TARGET_DIR):
	mkdir $@

pdf: $(TARGET_DIR)/$(TARGET).pdf

clean:
	rm -rf $(TARGET_DIR)
