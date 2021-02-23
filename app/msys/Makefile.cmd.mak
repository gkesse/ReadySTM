#================================================    
# package
pkg_install:
	pacman -S unzip --noconfirm --needed
	pacman -S cmake --noconfirm --needed
	pacman -S hexcurse --noconfirm --needed
	pacman -S mingw-w64-i686-libusb --noconfirm --needed
	pacman -S mingw-w64-i686-stlink --noconfirm --needed
#================================================    
# stm32
stm_download:
	@if ! [ -d $(GSTM_ROOT) ] ; then mkdir -p $(GSTM_ROOT) ; fi
	cd $(GSTM_ROOT) && git clone $(GSTM_URL)
stm_build:
	cd $(GSTM_PATH) && make
stm_clean:
	cd $(GSTM_PATH) && make clobber
#================================================    
# libopencm3
ocm_download:
	cd $(GSTM_PATH) && git clone $(GOCM_URL)
#================================================    
# freertos
frtos_download:
	cd $(GSTM_RTOS) && wget $(GFRTOS_URL)
	cd $(GSTM_RTOS) && unzip *.zip
	cd $(GSTM_RTOS) && rm -f *.zip
#================================================    
# arm
arm_download:
	@if ! [ -d $(GARM_ROOT) ] ; then mkdir -p $(GARM_ROOT) ; fi
	cd $(GARM_ROOT) && wget $(GARM_URL)
	cd $(GARM_ROOT) && unzip *.zip
	cd $(GARM_ROOT) && rm -f *.zip
arm_test:
	arm-none-eabi-gcc --version
	type gcc
	type arm-none-eabi-gcc
#================================================    
# stlink
stl_device:
	st-info --probe
stl_read:
	st-flash read ./saved.img 0x8000000 0x1000
stl_write:
	st-flash write ./saved.img 0x8000000
stl_erase:
	st-flash erase
#================================================    
# hexcurse
hex_check:
	hexcurse ./saved.img
#================================================    
# miniblink
mbk_all: mbk_clean mbk_compile mbk_hex

mbk_compile:
	cd $(GMBK_SRC) && make
mbk_hex:
	cd $(GMBK_SRC) && objcopy -S -O ihex miniblink.elf miniblink.hex
mbk_check:
	cd $(GMBK_SRC) && hexcurse miniblink.elf
mbk_flash:
	cd $(GMBK_SRC) && make flash
mbk_clean:
	cd $(GMBK_SRC) && make clobber
#================================================    
# project
prj_create:
	cd $(GSTM_RTOS) && make -f $(GSTM_RTOS)/Project.mk PROJECT=$(GPROJECT_SRC)
#================================================    
# git
git_status:
	@cd $(GPROJECT_PATH) && git status
git_push:
	@cd $(GPROJECT_PATH) && git pull && git add --all && git commit -m "Initial Commit" && git push -u origin main
git_clone:
	@cd $(GPROJECT_ROOT) && git clone $(GGIT_URL) $(GGIT_NAME) 
#================================================    
