.PHONY: all clean install add-cap-files

BUILD = $(shell pwd)/build

$(BUILD)/src/Makefile:
	mkdir -p $(BUILD)
	cp -r src $(BUILD)
	cp -r include $(BUILD)

$(BUILD)/src/libboot.a: $(BUILD)/src/Makefile
	$(MAKE) -C $(BUILD)/src libboot.a

all: $(BUILD)/src/libboot.a

add-comp-matrix:
	./choose_compartment_strategy.sh

install: all
	./install.sh

uninstall:   
	rm -rf $(BUILD)
clean: 
	rm -rf $(BUILD)