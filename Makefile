.PHONY: all clean install libboot

BUILD = $(shell pwd)/build

$(BUILD)/src/Makefile:
	mkdir -p $(BUILD)
	cp -r src $(BUILD)
	cp -r include $(BUILD)

# $(BUILD)/src/libboot_c.a: $(BUILD)/src/Makefile
libboot: $(BUILD)/src/Makefile
	$(MAKE) -C $(BUILD)/src libboot_c.a
	$(MAKE) -C $(BUILD)/src libboot_ocaml.a
	$(MAKE) -C $(BUILD)/src libboot_mirage.a

# $(BUILD)/src/libboot_ocaml.a: $(BUILD)/src/Makefile
# 	$(MAKE) -C $(BUILD)/src libboot_ocaml.a

# $(BUILD)/src/libboot_mirage.a: $(BUILD)/src/Makefile
# 	$(MAKE) -C $(BUILD)/src libboot_mirage.a

all: libboot # $(BUILD)/src/libboot_c.a $(BUILD)/src/libboot_ocaml.a $(BUILD)/src/libboot_mirage.a

install: all
	./install.sh

uninstall:   
	rm -rf $(BUILD)
clean: 
	rm -rf $(BUILD)