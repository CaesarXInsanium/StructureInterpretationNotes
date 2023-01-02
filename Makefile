PANDOC=pandoc

PANDOC_OPTIONS= -V 'mainfont:/home/cxi/.fonts/Iosevka\ Nerd\ Font\ Complete.ttf'
         

PANDOC_HTML_OPTIONS=--to html5
PANDOC_PDF_OPTIONS=
PANDOC_DOCX_OPTIONS=
PANDOC_RTF_OPTIONS=
PANDOC_ODT_OPTIONS=
PANDOC_EPUB_OPTIONS=--to epub3

# One Page per book Chapter
NOTES_DIR=src
PANDOC_BUILD_DIR=pandoc
TARGET=StructureAndInterpretationNotes

CHAP02 := \
		  src/02intro.md \
		  src/02data_abstractions.md \
		  src/02hierarchy_closure.md \
		  src/02abstract_representation.md \
		  src/02generic_operations.md \

ALL_NOTES := \
	src/SUMMARY.md \
	src/01procedures.md \
	$(CHAP02)

.PHONY: all clean

all: pdf
	

$(PANDOC_BUILD_DIR):
	mkdir $(PANDOC_BUILD_DIR)

PDF_TARGET=$(PANDOC_BUILD_DIR)/$(TARGET).pdf
pdf: $(PDF_TARGET)
$(PDF_TARGET): $(PANDOC_BUILD_DIR)
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $(PDF_TARGET) $(ALL_NOTES) 

HTML_TARGET=$(PANDOC_BUILD_DIR)/$(TARGET).html
html: $(HTML_TARGET)
$(HTML_TARGET): $(PANDOC_BUILD_DIR)
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $(HTML_TARGET) $(ALL_NOTES) 

clean:
	rm -rf $(PANDOC_BUILD_DIR)



# Pattern-matching Rules

%.html : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<

%.pdf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<
	
%.docx : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $<

%.rtf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_RTF_OPTIONS) -o $@ $<

%.odt : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_ODT_OPTIONS) -o $@ $<

%.epub : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_EPUB_OPTIONS) -o $@ $<

