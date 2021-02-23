//================================================
#include "GMiniBlink.h"
//================================================
void GMiniBlink_Init(void) {
	rcc_clock_setup_in_hse_8mhz_out_72mhz();
	rcc_periph_clock_enable(RCC_GPIOC);
	gpio_set_mode(GPIOC, GPIO_MODE_OUTPUT_2_MHZ, GPIO_CNF_OUTPUT_PUSHPULL,GPIO13);
}
//================================================
void GMiniBlink_Update(void *args) {
	int i;
	(void)args;

	for (;;) {
		gpio_toggle(GPIOC,GPIO13);
		for (i = 0; i < 300000; i++) {
			__asm__("nop");
        }
	}
}
//================================================
