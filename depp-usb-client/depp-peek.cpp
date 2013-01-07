#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <dpcdecl.h>
#include <dmgr.h>
#include <depp.h>

uint8_t
peek(int reg) 
{
	HIF deviceHandle;
	int status;
	char deviceName[32] = "Cr2s2";
	uint8_t data;
	
	status = DmgrOpen(&deviceHandle, deviceName);
	if (!status) {
		printf("Problem opening device, code %d\n", DmgrGetLastError());
		return 0;
	}

	status = DeppEnable(deviceHandle);
	if (!status) {
		printf("Problem enabling port 0, code %d\n", DmgrGetLastError());
		return 0;
	}
	
	DeppGetReg(deviceHandle, reg, &data, fFalse);

	status = DeppDisable(deviceHandle);
	if (!status) {
		printf("Problem disabling DEPP, code %d\n", DmgrGetLastError());
		return 0;
	}
	DmgrClose(deviceHandle);

	return data;
}

int
main(int argc, char *argv[]) 
{
	int reg;

	if (argc != 2) {
		printf("usage: %s register\n", argv[0]);
		exit(1);
	}	

	reg = atoi(argv[1]);
	
	printf("%x\n", peek(reg));

	return 0;	
}

