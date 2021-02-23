//================================================
#include "GProcess.h"
//================================================
extern void vApplicationStackOverflowHook(xTaskHandle *pxTask,signed portCHAR *pcTaskName);
//================================================
void vApplicationStackOverflowHook(xTaskHandle *pxTask,signed portCHAR *pcTaskName) {
	(void)pxTask;
	(void)pcTaskName;
	while(1);
}
//================================================
int main(void) {
    GProcess_Run(Mini_Blink);
	vTaskStartScheduler();
	while(1);
	return 0;
}
//================================================
