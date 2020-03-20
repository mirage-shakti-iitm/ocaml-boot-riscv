.PHONY: all clean install

BUILD = $(shell pwd)/build

$(BUILD)/src/Makefile:
	mkdir -p $(BUILD)
	cp -r src $(BUILD)
	cp -r include $(BUILD)

$(BUILD)/src/libboot.a: $(BUILD)/src/Makefile
	$(MAKE) -C $(BUILD)/src libboot.a

all: $(BUILD)/src/libboot.a

install: all
	./install.sh

uninstall:   
	rm -r $(BUILD)
clean: 
	rm -r $(BUILD)