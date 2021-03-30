.PHONY: all clean install add-cap-files libboot_no_compartments

BUILD = $(shell pwd)/build

$(BUILD)/src/Makefile:
	mkdir -p $(BUILD)
	cp -r src $(BUILD)
	cp -r include $(BUILD)

$(BUILD)/src/libboot.a: $(BUILD)/src/Makefile
	$(MAKE) -C $(BUILD)/src libboot.a

$(BUILD)/src/libboot_normal.a: $(BUILD)/src/Makefile
	$(MAKE) -C $(BUILD)/src libboot_normal.a

all: $(BUILD)/src/libboot.a

libboot_no_compartments: $(BUILD)/src/libboot_normal.a

add-cap-files:
	./choose_compartment_strategy.sh $(COMPARTMENT_STRATEGY_CHOICE)

install: all
	./install.sh

uninstall:   
	rm -rf $(BUILD)
clean: 
	rm -rf $(BUILD)
	rm -f src/*.cap
	rm -f src/startup_2.c
	rm cap_matrix.h