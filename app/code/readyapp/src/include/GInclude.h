//================================================
#ifndef _GInclude_
#define _GInclude_
//================================================
#include <string.h>
//================================================
#include "FreeRTOS.h"
#include "task.h"
//================================================
#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/cm3/nvic.h>
//================================================
#define mainECHO_TASK_PRIORITY ( tskIDLE_PRIORITY + 1 )
//================================================
#endif
//================================================
