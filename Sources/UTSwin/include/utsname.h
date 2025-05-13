#include <stdio.h>
#include <WinSock2.h>
#include <windows.h>

// Maximum utsname member size
long unsigned int UNAME_MEMBER_SIZE = 50;

// utsname does not exist on Windows, so we define our own here
typedef struct {
  char sysname[50];
  char nodename[50];
  char release[50];
  char version[50];
  char machine[50];
} utsname;

// a Windows specific shim to get information in a Unix-like way
extern void win_uname(utsname* uts){
  // sysname
  strcpy_s(uts->sysname, 8, "Windows");

  // nodename
  WSADATA wsa;
  if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0) { puts("failed to start winsock\n"); }
  gethostname(uts->nodename, 256);
  WSACleanup();

  // version
  int i = 0;
  char c;
  FILE* f = _popen("ver", "r");
  while ((c = fgetc(f)) != EOF) {
    if (i < 50 && c != '\n') {
      uts->version[i] = c;
      i++; 
    }
  }
  fclose(f);

  // release fallback
  strcpy_s(uts->release, 50, uts->version);

  // release
  HKEY hkey;
  RegOpenKeyEx(HKEY_LOCAL_MACHINE, "Software\\Microsoft\\Windows NT\\CurrentVersion", 0, KEY_QUERY_VALUE, &hkey);
  RegQueryValueEx(hkey, "DisplayVersion", NULL, NULL, uts->release, &UNAME_MEMBER_SIZE);
  RegCloseKey(hkey);

  // machine
  SYSTEM_INFO sys;
  GetNativeSystemInfo(&sys);
  switch (sys.wProcessorArchitecture){
    case PROCESSOR_ARCHITECTURE_AMD64: strcpy_s(uts->machine, 10, "x86_64"); break;
    case PROCESSOR_ARCHITECTURE_ARM: strcpy_s(uts->machine, 10, "arm32"); break;
#ifdef PROCESSOR_ARCHITECTURE_ARM64
    case PROCESSOR_ARCHITECTURE_ARM64: strcpy_s(uts->machine, 10, "arm64"); break;
#endif
    case PROCESSOR_ARCHITECTURE_IA64: strcpy_s(uts->machine, 10, "IA-64"); break;
    case PROCESSOR_ARCHITECTURE_INTEL: strcpy_s(uts->machine, 10, "x86"); break;
    default: strcpy_s(uts->machine, 10, "UNKNOWN");

  }
}

// prints utsname members
extern void print_utsname(utsname* uts){
  printf("sysname: %s\n", uts->sysname);
  printf("nodename: %s\n", uts->nodename);
  printf("release: %s\n", uts->release);
  printf("version: %s\n", uts->version);
  printf("machine: %s\n", uts->machine);
}
