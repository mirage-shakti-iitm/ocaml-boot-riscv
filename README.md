# Required packages

* [shakti-tee-tools](https://gitlab.com/sl33k/shakti-tee-tools) the SHAKTI-TEE toolchain 

# <a name="quickstart"></a>Quickstart

	$ mkdir build && cd build 
    $ cmake ..
    $ make

this generates an `libarch.a` file in `build/arch/` which is missing the `caml_startup(char**)` symbol.




