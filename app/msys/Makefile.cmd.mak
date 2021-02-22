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
# git
git_push:
	@cd $(GPROJECT_PATH) && git pull && git add --all && git commit -m "Initial Commit" && git push -u origin master
git_clone:
	@cd $(GPROJECT_ROOT) && git clone $(GGIT_URL) $(GGIT_NAME) 
#================================================    
# pacman
pacman_version:
	pacman --version
pacman_search:
	pacman -Ss $(GPACMAN_PACKAGE_SEARCH) | grep -ie "i686"
pacman_install:
	pacman -S $(GPACMAN_PACKAGE_INSTALL)
#================================================    
# pkgconfig
pkgconfig_version:
	pkg-config --version
pkgconfig_list:
	pkg-config --list-all
pkgconfig_search:
	pkg-config --list-all | grep -ie $(GPKGCONFIG_PACKAGE_SEARCH)
pkgconfig_libs:
	pkg-config --libs $(GPKGCONFIG_PACKAGE_LIBS)
pkgconfig_flags:
	pkg-config --cflags $(GPKGCONFIG_PACKAGE_CFLAGS)
#================================================    
