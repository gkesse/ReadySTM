GSRC = $(GPROJECT_SRC)
GBIN = bin
GBUILD = build
GTARGET = $(GBIN)/rdc 

GINCS = \
    -I$(GSRC)/include \
    `pkg-config --cflags gtk+-3.0` \
    `pkg-config --cflags sqlite3` \
    
GLIBS = \
    `pkg-config --libs gtk+-3.0` \
    `pkg-config --libs sqlite3` \

GOBJS = \
    $(patsubst $(GSRC)/%.c, $(GBUILD)/%.o, $(wildcard $(GSRC)/*.c)) \
    $(patsubst $(GSRC)/manager/%.c, $(GBUILD)/%.o, $(wildcard $(GSRC)/manager/*.c)) \

GCFLAGS = \
    -std=gnu18 \
    -W -Wall \
    -Wno-unused-parameter \
    -Wno-deprecated-declarations \

#================================================    
all: c_clean_exe c_compile c_run
all2: c_clean_exe qmake qmake_compile
#================================================    
# c    
c_compile: $(GOBJS)
	@if ! [ -d $(GBIN) ] ; then mkdir -p $(GBIN) ; fi
	gcc -o $(GTARGET) $(GOBJS) $(GLIBS) 
$(GBUILD)/%.o: $(GSRC)/%.c
	@if ! [ -d $(GBUILD) ] ; then mkdir -p $(GBUILD) ; fi
	gcc $(GCFLAGS) -c $< -o $@ $(GINCS)
$(GBUILD)/%.o: $(GSRC)/manager/%.c
	@if ! [ -d $(GBUILD) ] ; then mkdir -p $(GBUILD) ; fi
	gcc $(GCFLAGS) -c $< -o $@ $(GINCS)
c_run:
	@echo
	$(GTARGET) $(argv)
	@echo
c_clean_exe:
	@if ! [ -d $(GBIN) ] ; then mkdir -p $(GBIN) ; fi
	rm -f $(GBIN)/*
c_clean:
	@if ! [ -d $(GBIN) ] ; then mkdir -p $(GBIN) ; fi
	@if ! [ -d $(GBUILD) ] ; then mkdir -p $(GBUILD) ; fi
	rm -f $(GBUILD)/* $(GBIN)/*
#================================================    
# package
pkg_install:
	pacman -S unzip --noconfirm --needed
	pacman -S cmake --noconfirm --needed
	pacman -S mingw-w64-i686-libusb --noconfirm --needed
	pacman -S mingw-w64-i686-stlink --noconfirm --needed
#================================================    
# stm32
stm_download:
	@if ! [ -d $(GSTM_ROOT) ] ; then mkdir -p $(GSTM_ROOT) ; fi
	cd $(GSTM_ROOT) && git clone $(GSTM_URL)
stm_build:
	cd $(GSTM_PATH) && make
#================================================    
# libopencm3
ocm_download:
	cd $(GSTM_PATH) && git clone $(GOCM_URL)
#================================================    
# freertos
frtos_download:
	cd $(GSTM_PATH)/rtos && git clone $(GFRTOS_URL)
#================================================    
# arm
arm_download:
	@if ! [ -d $(GARM_ROOT) ] ; then mkdir -p $(GARM_ROOT) ; fi
	cd $(GARM_ROOT) && wget $(GARM_URL)
	cd $(GARM_ROOT) && unzip *.zip
	cd $(GARM_ROOT) && rm -f *.zip
arm_test:
	arm-none-eabi-gcc --version
	type gcc && echo
	type arm-none-eabi-gcc && echo
#================================================    
# stlink
stl_device:
	st-info --probe
stl_erase:
	st-flash erase
#================================================    
# miniblink
mbk_all: mbk_clean mbk_compile mbk_flash

mbk_compile:
	cd $(GMBK_SRC) && make && echo
mbk_flash:
	cd $(GMBK_SRC) && make flash && echo
mbk_clean:
	cd $(GMBK_SRC) && make clobber && echo
#================================================    
# git
git_status:
	@cd $(GPROJECT_PATH) && git status
git_push:
	@cd $(GPROJECT_PATH) && git pull && git add --all && git commit -m "Initial Commit" && git push -u origin main
git_clone:
	@cd $(GPROJECT_ROOT) && git clone $(GGIT_URL) $(GGIT_NAME) 
#================================================    
