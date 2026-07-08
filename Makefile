PANDOC=/usr/bin/pandoc
TARGET=SICPNotes
# TODO add method to add pandoc flags

# All pandoc configuration should remain in this file
CONFIG=defaults.yaml

default: $(TARGET).pdf

all: $(TARGET).pdf $(TARGET).epub $(TARGET).html

$(TARGET).epub:
	$(PANDOC) -d $(CONFIG) -o $(TARGET).epub

$(TARGET).html:
	$(PANDOC) -d $(CONFIG) -o $(TARGET).html

$(TARGET).pdf:
	$(PANDOC) -d $(CONFIG)

clean:
	rm -rf $(TARGET)*
