#include <stdio.h>
#include <stdlib.h>

#include <dpcdecl.h>
#include <dmgr.h>
#include <depp.h>

#define NUMADDR 0x0

int main(int argc, char *argv[]) 
{
	HIF deviceHandle;
	int status;
	char deviceName[32] = "Cr2s2";
	
	status = DmgrOpen(&deviceHandle, deviceName);
	if (!status) {
		printf("Problem opening device, code %d\n", DmgrGetLastError());
		return(10);
	}

	status = DeppEnable(deviceHandle);
	if (!status) {
		printf("Problem enabling port 0, code %d\n", DmgrGetLastError());
		return(11);
	}
	
	DeppPutReg(deviceHandle, NUMADDR, atoi(argv[1]), fFalse);

	status = DeppDisable(deviceHandle);
	if (!status) {
		printf("Problem disabling DEPP, code %d\n", DmgrGetLastError());
		return(12);
	}
	DmgrClose(deviceHandle);

}
