//================================================
#include "GProcess.h"
#include "GMiniBlink.h"
//================================================
static void GProcess_Mini_Blink();
//================================================
void GProcess_Run(eGProcess key) {
    if(key == Mini_Blink) {GProcess_Mini_Blink(); return;}
}
//================================================
void GProcess_Mini_Blink() {
	GMiniBlink_Init();
	xTaskCreate(GMiniBlink_Update, "LED", 100, NULL, configMAX_PRIORITIES-1, NULL);
}
//================================================
