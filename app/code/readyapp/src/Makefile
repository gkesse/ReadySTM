#================================================    
BINARY		= $(GPROJECT_BIN)
SRCFILES	= main.c rtos/heap_4.c rtos/list.c rtos/port.c rtos/queue.c rtos/tasks.c rtos/opencm3.c
LDSCRIPT	= stm32f103c8t6.ld
#================================================    
SRCFILES +=\
    $(wildcard $(GPROJECT_SRC)/manager/*.c) \
#================================================    
TGT_CFLAGS +=\
    -I$(GPROJECT_SRC)/include \
#================================================    
include $(GSTM_PATH)/Makefile.incl
include $(GSTM_RTOS)/Makefile.rtos
#================================================    
