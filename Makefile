.PHONY: all clean install add-cap-files

BUILD = $(shell pwd)/build

$(BUILD)/src/Makefile:
	mkdir -p $(BUILD)
	cp -r src $(BUILD)
	cp -r include $(BUILD)

$(BUILD)/src/libboot.a: $(BUILD)/src/Makefile
	$(MAKE) -C $(BUILD)/src libboot.a

all: $(BUILD)/src/libboot.a

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