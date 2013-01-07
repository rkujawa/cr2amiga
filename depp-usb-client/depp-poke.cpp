#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <dpcdecl.h>
#include <dmgr.h>
#include <depp.h>

bool
poke(int reg, int val) 
{
	HIF deviceHandle;
	int status;
	char deviceName[32] = "Cr2s2";
	
	status = DmgrOpen(&deviceHandle, deviceName);
	if (!status) {
		printf("Problem opening device, code %d\n", DmgrGetLastError());
		return false;
	}

	status = DeppEnable(deviceHandle);
	if (!status) {
		printf("Problem enabling port 0, code %d\n", DmgrGetLastError());
		return false;
	}
	
	DeppPutReg(deviceHandle, reg, val, fFalse);

	status = DeppDisable(deviceHandle);
	if (!status) {
		printf("Problem disabling DEPP, code %d\n", DmgrGetLastError());
		return false;
	}
	DmgrClose(deviceHandle);
}

int
main(int argc, char *argv[]) 
{
	int reg, val;

	if (argc != 3) {
		printf("usage: %s register value\n", argv[0]);
		exit(1);
	}	

	reg = atoi(argv[1]);
	val = atoi(argv[2]);
	
	if (poke(reg, val) != true)
		exit(2);

	return 0;	
}

