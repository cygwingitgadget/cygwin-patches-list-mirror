Return-Path: <cygwin-patches-return-3671-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26144 invoked by alias); 6 Mar 2003 22:58:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26132 invoked from network); 6 Mar 2003 22:58:32 -0000
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: RE: PATCH: Implements /proc/cpuinfo and /proc/partitions
Date: Thu, 06 Mar 2003 22:58:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHMEFADGAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0015_01C2E433.E8B66DD0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20030302154006.GH1193@cygbert.vinschen.de>
Importance: Normal
X-SW-Source: 2003-q1/txt/msg00320.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0015_01C2E433.E8B66DD0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 2736

> On Sun, Mar 02, 2003 at 12:50:51PM -0000, Chris January wrote:
> > 2003-03-01  Christopher January  <chris@atomice.net>
> > 
> > 	* autoload.cc (GetSystemTimes): Define new autoload function. 
> > 	* fhandler_proc.cc (proc_listing): Add cpuinfo and 
> partitions entries.
> > 	(fhandler_proc::fill_filebuf): Add PROC_CPUINFO and 
> PROC_PARTITIONS cases.
> > 	(format_proc_uptime): Use GetSystemTimes if available.
> > 	(read_value): New macro.
> > 	(print): New macro.
> > 	(cpuid): New function.
> > 	(can_set_flag): New function.
> > 	(format_proc_cpuinfo): New function.
> > 	(format_proc_partitions): New function.
> > 	* w32api/include/winbase.h (FindFirstVolume): Add declaration.
> > 	(FindNextVolume): Add declaration.
> > 	(FindVolumeClose): Add declaration.
> > 	(GetSystemTimes): Add declaration.
> > 	* w32api/include/winnt.h: Add define for 
> PF_XMMI64_INSTRUCTIONS_AVAILABLE.
> 
> I tried this patch and it works nicely but the patch creates a couple of
> warnings at compile time:
> 
> fhandler_proc.cc: In function `off_t format_proc_cpuinfo(char*, 
> unsigned int)':
> fhandler_proc.cc:683: warning: unused variable `unsigned int 
> extended_family'
> fhandler_proc.cc:684: warning: unused variable `unsigned int 
> extended_model'
> fhandler_proc.cc:672: warning: unused variable `unsigned int cpuid_sig'
> fhandler_proc.cc:672: warning: unused variable `unsigned int extra_info'
> fhandler_proc.cc:672: warning: unused variable `unsigned int features'
> fhandler_proc.cc:625: warning: unused variable `int cpu'
> fhandler_proc.cc:625: warning: unused variable `int r1'
> fhandler_proc.cc:625: warning: unused variable `int r2'
> fhandler_proc.cc: In function `off_t 
> format_proc_partitions(char*, unsigned int)':
> fhandler_proc.cc:906: warning: comparison between signed and 
> unsigned integer expressions
> 
> Would you mind to send a new patch w/o these warnings?

Attached. w32api patch is now seperated.

2003-03-06  Christopher January  <chris@atomice.net>

	* autoload.cc (GetSystemTimes): Define new autoload function. 
	* fhandler_proc.cc (proc_listing): Add cpuinfo and partitions entries.
	(fhandler_proc::fill_filebuf): Add PROC_CPUINFO and PROC_PARTITIONS cases.
	(format_proc_uptime): Use GetSystemTimes if available.
	(read_value): New macro.
	(print): New macro.
	(cpuid): New function.
	(can_set_flag): New function.
	(format_proc_cpuinfo): New function.
	(format_proc_partitions): New function.

2003-03-06  Christopher January  <chris@atomice.net>

	* include/winbase.h (FindFirstVolume): Add declaration.
	(FindNextVolume): Add declaration.
	(FindVolumeClose): Add declaration.
	(GetSystemTimes): Add declaration.
	* include/winnt.h: Add define for PF_XMMI64_INSTRUCTIONS_AVAILABLE.

Chris

------=_NextPart_000_0015_01C2E433.E8B66DD0
Content-Type: text/plain;
	name="cpuinfo_partitions.ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpuinfo_partitions.ChangeLog.txt"
Content-length: 503

2003-03-01  Christopher January  <chris@atomice.net>

	* autoload.cc (GetSystemTimes): Define new autoload function. 
	* fhandler_proc.cc (proc_listing): Add cpuinfo and partitions entries.
	(fhandler_proc::fill_filebuf): Add PROC_CPUINFO and PROC_PARTITIONS cases.
	(format_proc_uptime): Use GetSystemTimes if available.
	(read_value): New macro.
	(print): New macro.
	(cpuid): New function.
	(can_set_flag): New function.
	(format_proc_cpuinfo): New function.
	(format_proc_partitions): New function.

------=_NextPart_000_0015_01C2E433.E8B66DD0
Content-Type: application/octet-stream;
	name="cpuinfo_partitions.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cpuinfo_partitions.patch"
Content-length: 23811

? cygwin/win9xioctl.cc=0A=
Index: autoload.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v=0A=
retrieving revision 1.63=0A=
diff -u -p -r1.63 autoload.cc=0A=
--- autoload.cc	21 Feb 2003 14:29:17 -0000	1.63=0A=
+++ autoload.cc	6 Mar 2003 22:54:05 -0000=0A=
@@ -501,6 +501,7 @@ LoadDLLfuncEx (CreateHardLinkA, 12, kern=0A=
 LoadDLLfuncEx (CreateToolhelp32Snapshot, 8, kernel32, 1)=0A=
 LoadDLLfuncEx2 (GetCompressedFileSizeA, 8, kernel32, 1, 0xffffffff)=0A=
 LoadDLLfuncEx (GetConsoleWindow, 0, kernel32, 1)=0A=
+LoadDLLfuncEx (GetSystemTimes, 12, kernel32, 1)=0A=
 LoadDLLfuncEx2 (IsDebuggerPresent, 0, kernel32, 1, 1)=0A=
 LoadDLLfuncEx (Process32First, 8, kernel32, 1)=0A=
 LoadDLLfuncEx (Process32Next, 8, kernel32, 1)=0A=
Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.20=0A=
diff -u -p -r1.20 fhandler_proc.cc=0A=
--- fhandler_proc.cc	10 Jan 2003 12:32:46 -0000	1.20=0A=
+++ fhandler_proc.cc	6 Mar 2003 22:54:06 -0000=0A=
@@ -8,6 +8,8 @@ This software is a copyrighted work lice=0A=
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
 details. */=0A=
=20=0A=
+#define _WIN32_WINNT 0x0501=0A=
+=0A=
 #include "winsup.h"=0A=
 #include <errno.h>=0A=
 #include <unistd.h>=0A=
@@ -25,6 +27,7 @@ details. */=0A=
 #include <sys/utsname.h>=0A=
 #include <sys/param.h>=0A=
 #include "ntdll.h"=0A=
+#include <winioctl.h>=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
 #include <dirent.h>=0A=
@@ -36,6 +39,8 @@ static const int PROC_REGISTRY =3D 4;=20=20=20=20=20=0A=
 static const int PROC_STAT     =3D 5;     // /proc/stat=0A=
 static const int PROC_VERSION  =3D 6;     // /proc/version=0A=
 static const int PROC_UPTIME   =3D 7;     // /proc/uptime=0A=
+static const int PROC_CPUINFO  =3D 8;     // /proc/cpuinfo=0A=
+static const int PROC_PARTITIONS =3D 9;   // /proc/partitions=0A=
=20=0A=
 /* names of objects in /proc */=0A=
 static const char *proc_listing[] =3D {=0A=
@@ -47,6 +52,8 @@ static const char *proc_listing[] =3D {=0A=
   "stat",=0A=
   "version",=0A=
   "uptime",=0A=
+  "cpuinfo",=0A=
+  "partitions",=0A=
   NULL=0A=
 };=0A=
=20=0A=
@@ -63,7 +70,9 @@ static const DWORD proc_fhandlers[PROC_L=0A=
   FH_REGISTRY,=0A=
   FH_PROC,=0A=
   FH_PROC,=0A=
-  FH_PROC=0A=
+  FH_PROC,=0A=
+  FH_PROC,=0A=
+  FH_PROC,=0A=
 };=0A=
=20=0A=
 /* name of the /proc filesystem */=0A=
@@ -73,6 +82,8 @@ const int proc_len =3D sizeof (proc) - 1;=0A=
 static off_t format_proc_meminfo (char *destbuf, size_t maxsize);=0A=
 static off_t format_proc_stat (char *destbuf, size_t maxsize);=0A=
 static off_t format_proc_uptime (char *destbuf, size_t maxsize);=0A=
+static off_t format_proc_cpuinfo (char *destbuf, size_t maxsize);=0A=
+static off_t format_proc_partitions (char *destbuf, size_t maxsize);=0A=
=20=0A=
 /* auxillary function that returns the fhandler associated with the given =
path=0A=
  * this is where it would be nice to have pattern matching in C - polymorp=
hism=0A=
@@ -363,6 +374,18 @@ fhandler_proc::fill_filebuf ()=0A=
 	filesize =3D format_proc_meminfo (filebuf, bufalloc);=0A=
 	break;=0A=
       }=0A=
+    case PROC_CPUINFO:=0A=
+      {=0A=
+        filebuf =3D (char *) realloc (filebuf, bufalloc =3D 16384);=0A=
+        filesize =3D format_proc_cpuinfo (filebuf, bufalloc);=0A=
+        break;=0A=
+      }=0A=
+    case PROC_PARTITIONS:=0A=
+      {=0A=
+        filebuf =3D (char *) realloc (filebuf, bufalloc =3D 4096);=0A=
+        filesize =3D format_proc_partitions (filebuf, bufalloc);=0A=
+        break;=0A=
+      }=0A=
     }=0A=
     return true;=0A=
 }=0A=
@@ -405,24 +428,29 @@ format_proc_uptime (char *destbuf, size_=0A=
   unsigned long long uptime =3D 0ULL, idle_time =3D 0ULL;=0A=
   SYSTEM_PROCESSOR_TIMES spt;=0A=
=20=0A=
-  NTSTATUS ret =3D NtQuerySystemInformation (SystemProcessorTimes, (PVOID)=
 &spt,=0A=
-					   sizeof spt, NULL);=0A=
-  if (!ret && GetLastError () =3D=3D ERROR_PROC_NOT_FOUND)=0A=
-    uptime =3D GetTickCount () / 10;=0A=
-  else if (ret !=3D STATUS_SUCCESS)=0A=
-    {=0A=
-      __seterrno_from_win_error (RtlNtStatusToDosError (ret));=0A=
-      debug_printf("NtQuerySystemInformation: ret =3D %d, "=0A=
-		   "Dos(ret) =3D %d",=0A=
-		   ret, RtlNtStatusToDosError (ret));=0A=
-      return 0;=0A=
-    }=0A=
-  else=0A=
+  if (!GetSystemTimes ((FILETIME *)&spt.IdleTime, (FILETIME *)&spt.KernelT=
ime, (FILETIME *)&spt.UserTime) &&=0A=
+      GetLastError () =3D=3D ERROR_PROC_NOT_FOUND)=0A=
     {=0A=
-      idle_time =3D spt.IdleTime.QuadPart / 100000ULL;=0A=
-      uptime =3D (spt.KernelTime.QuadPart +=0A=
-			spt.UserTime.QuadPart) / 100000ULL;=0A=
-    }=0A=
+      NTSTATUS ret =3D NtQuerySystemInformation (SystemProcessorTimes, (PV=
OID) &spt,=0A=
+                                               sizeof spt, NULL);=0A=
+      if (!ret && GetLastError () =3D=3D ERROR_PROC_NOT_FOUND)=0A=
+        {=0A=
+          uptime =3D GetTickCount () / 10;=0A=
+          goto out;=0A=
+        }=0A=
+      else if (ret !=3D STATUS_SUCCESS)=0A=
+        {=0A=
+          __seterrno_from_win_error (RtlNtStatusToDosError (ret));=0A=
+          debug_printf("NtQuerySystemInformation: ret =3D %d, "=0A=
+                       "Dos(ret) =3D %d",=0A=
+                       ret, RtlNtStatusToDosError (ret));=0A=
+          return 0;=0A=
+        }=0A=
+    }=0A=
+  idle_time =3D spt.IdleTime.QuadPart / 100000ULL;=0A=
+  uptime =3D (spt.KernelTime.QuadPart +=0A=
+            spt.UserTime.QuadPart) / 100000ULL;=0A=
+out:=0A=
=20=0A=
   return __small_sprintf (destbuf, "%U.%02u %U.%02u\n",=0A=
 			  uptime / 100, long (uptime % 100),=0A=
@@ -503,3 +531,401 @@ format_proc_stat (char *destbuf, size_t=20=0A=
 			  context_switches,=0A=
 			  boot_time);=0A=
 }=0A=
+=0A=
+#define read_value(x,y) \=0A=
+      dwCount =3D BUFSIZE; \=0A=
+      if ((dwError =3D RegQueryValueEx (hKey, x, NULL, &dwType, (BYTE *) s=
zBuffer, &dwCount)), \=0A=
+          (dwError !=3D ERROR_SUCCESS && dwError !=3D ERROR_MORE_DATA)) \=
=0A=
+        { \=0A=
+          __seterrno_from_win_error (dwError); \=0A=
+          debug_printf ("RegQueryValueEx failed retcode %d", dwError); \=
=0A=
+          return 0; \=0A=
+        } \=0A=
+      if (dwType !=3D y) \=0A=
+        { \=0A=
+          debug_printf ("Value %s had an unexpected type (expected %d, fou=
nd %d)", y, dwType); \=0A=
+          return 0; \=0A=
+        }=0A=
+=0A=
+#define print(x) \=0A=
+        { \=0A=
+          strcpy (bufptr, x), \=0A=
+          bufptr +=3D sizeof (x) - 1; \=0A=
+        }=0A=
+=0A=
+static inline=0A=
+void=0A=
+cpuid (unsigned *a, unsigned *b, unsigned *c, unsigned *d, unsigned in)=0A=
+{=0A=
+  asm ("cpuid"=0A=
+       : "=3Da" (*a),=0A=
+         "=3Db" (*b),=0A=
+         "=3Dc" (*c),=0A=
+         "=3Dd" (*d)=0A=
+       : "a" (in));=0A=
+}=0A=
+=0A=
+static inline=0A=
+bool=0A=
+can_set_flag (unsigned flag)=0A=
+{=0A=
+  unsigned r1, r2;=0A=
+  asm("pushfl\n"=0A=
+      "popl %0\n"=0A=
+      "movl %0, %1\n"=0A=
+      "xorl %2, %0\n"=0A=
+      "pushl %0\n"=0A=
+      "popfl\n"=0A=
+      "pushfl\n"=0A=
+      "popl %0\n"=0A=
+      "pushl %1\n"=0A=
+      "popfl\n"=0A=
+      : "=3D&r" (r1), "=3D&r" (r2)=0A=
+      : "ir" (flag)=0A=
+  );=0A=
+  return ((r1 ^ r2) & flag) !=3D 0;=0A=
+}=0A=
+=0A=
+static=0A=
+off_t=0A=
+format_proc_cpuinfo (char *destbuf, size_t maxsize)=0A=
+{=0A=
+  SYSTEM_INFO siSystemInfo;=0A=
+  HKEY hKey;=0A=
+  DWORD dwError, dwCount, dwType;=0A=
+  DWORD dwOldThreadAffinityMask;=0A=
+  int cpu_number;=0A=
+  const int BUFSIZE =3D 256;=0A=
+  CHAR szBuffer[BUFSIZE];=0A=
+  char *bufptr =3D destbuf;=0A=
+=0A=
+  GetSystemInfo (&siSystemInfo);=0A=
+=0A=
+  for (cpu_number =3D 0;;cpu_number++)=0A=
+    {=0A=
+      __small_sprintf (szBuffer, "HARDWARE\\DESCRIPTION\\System\\CentralPr=
ocessor\\%d", cpu_number);=0A=
+=0A=
+      if ((dwError =3D RegOpenKeyEx (HKEY_LOCAL_MACHINE, szBuffer, 0, KEY_=
QUERY_VALUE, &hKey)) !=3D ERROR_SUCCESS)=0A=
+        {=0A=
+          if (dwError =3D=3D ERROR_FILE_NOT_FOUND)=0A=
+            break;=0A=
+          __seterrno_from_win_error (dwError);=0A=
+          debug_printf ("RegOpenKeyEx failed retcode %d", dwError);=0A=
+          return 0;=0A=
+        }=0A=
+=0A=
+      dwOldThreadAffinityMask =3D SetThreadAffinityMask (GetCurrentThread =
(), 1 << cpu_number);=0A=
+      if (dwOldThreadAffinityMask =3D=3D 0)=0A=
+        debug_printf ("SetThreadAffinityMask failed %E");=0A=
+      // I'm not sure whether the thread changes processor immediately=0A=
+      // and I'm not sure whether this function will cause the thread to b=
e rescheduled=0A=
+      low_priority_sleep (0);=0A=
+=0A=
+      bool has_cpuid =3D false;=0A=
+=0A=
+      if (!can_set_flag (0x00040000))=0A=
+        debug_printf ("386 processor - no cpuid");=0A=
+      else=0A=
+        {=0A=
+          debug_printf ("486 processor");=0A=
+          if (can_set_flag (0x00200000))=0A=
+            {=0A=
+              debug_printf ("processor supports CPUID instruction");=0A=
+              has_cpuid =3D true;=0A=
+            }=0A=
+          else=0A=
+            debug_printf ("processor does not support CPUID instruction");=
=0A=
+        }=0A=
+=0A=
+      if (!has_cpuid)=0A=
+        {=0A=
+          bufptr +=3D __small_sprintf (bufptr, "processor       : %d\n", c=
pu_number);=0A=
+          read_value ("VendorIdentifier", REG_SZ)=0A=
+          bufptr +=3D __small_sprintf (bufptr, "vendor id       : %s\n", s=
zBuffer);=0A=
+          read_value ("Identifier", REG_SZ);=0A=
+          bufptr +=3D __small_sprintf (bufptr, "identifier      : %s\n", s=
zBuffer);=0A=
+          read_value ("~Mhz", REG_DWORD);=0A=
+          bufptr +=3D __small_sprintf (bufptr, "cpu MHz         : %u\n", *=
(DWORD *) szBuffer);=0A=
+=0A=
+          print ("flags           :");=0A=
+          if (IsProcessorFeaturePresent (PF_3DNOW_INSTRUCTIONS_AVAILABLE))=
=0A=
+            print (" 3dnow");=0A=
+          if (IsProcessorFeaturePresent (PF_COMPARE_EXCHANGE_DOUBLE))=0A=
+            print (" cx8");=0A=
+          if (!IsProcessorFeaturePresent (PF_FLOATING_POINT_EMULATED))=0A=
+            print (" fpu");=0A=
+          if (IsProcessorFeaturePresent (PF_MMX_INSTRUCTIONS_AVAILABLE))=
=0A=
+            print (" mmx");=0A=
+          if (IsProcessorFeaturePresent (PF_PAE_ENABLED))=0A=
+            print (" pae");=0A=
+          if (IsProcessorFeaturePresent (PF_RDTSC_INSTRUCTION_AVAILABLE))=
=0A=
+            print (" tsc");=0A=
+          if (IsProcessorFeaturePresent (PF_XMMI_INSTRUCTIONS_AVAILABLE))=
=0A=
+            print (" sse");=0A=
+          if (IsProcessorFeaturePresent (PF_XMMI64_INSTRUCTIONS_AVAILABLE)=
)=0A=
+            print (" sse2");=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          bufptr +=3D __small_sprintf (bufptr, "processor       : %d\n", c=
pu_number);=0A=
+          unsigned maxf, vendor_id[4], unused;=0A=
+          cpuid (&maxf, &vendor_id[0], &vendor_id[1], &vendor_id[2], 0);=
=0A=
+          maxf &=3D 0xffff;=0A=
+          vendor_id[3] =3D 0;=0A=
+          bufptr +=3D __small_sprintf (bufptr, "vendor id       : %s\n", (=
char *)vendor_id);=0A=
+          read_value ("~Mhz", REG_DWORD);=0A=
+          unsigned cpu_mhz =3D *(DWORD *)szBuffer;=0A=
+          if (maxf >=3D 1)=0A=
+            {=0A=
+              unsigned features2, features1, extra_info, cpuid_sig;=0A=
+              cpuid (&cpuid_sig, &extra_info, &features2, &features1, 1);=
=0A=
+              /* unsigned extended_family =3D (cpuid_sig & 0x0ff00000) >> =
20,=0A=
+                          extended_model  =3D (cpuid_sig & 0x000f0000) >> =
16; */=0A=
+              unsigned type            =3D (cpuid_sig & 0x00003000) >> 12,=
=0A=
+                       family          =3D (cpuid_sig & 0x00000f00) >> 8,=
=0A=
+                       model           =3D (cpuid_sig & 0x000000f0) >> 4,=
=0A=
+                       stepping        =3D cpuid_sig & 0x0000000f;=0A=
+              unsigned brand_id        =3D extra_info & 0x0000000f,=0A=
+                       cpu_count       =3D (extra_info & 0x00ff0000) >> 16=
,=0A=
+                       apic_id         =3D (extra_info & 0xff000000) >> 24=
;=0A=
+              const char *type_str;=0A=
+              switch (type)=0A=
+                {=0A=
+                case 0:=0A=
+                  type_str =3D "primary processor";=0A=
+                  break;=0A=
+                case 1:=0A=
+                  type_str =3D "overdrive processor";=0A=
+                  break;=0A=
+                case 2:=0A=
+                  type_str =3D "secondary processor";=0A=
+                  break;=0A=
+                case 3:=0A=
+                default:=0A=
+                  type_str =3D "reserved";=0A=
+                  break;=0A=
+                }=0A=
+              unsigned maxe =3D 0;=0A=
+              cpuid (&maxe, &unused, &unused, &unused, 0x80000000);=0A=
+              if (maxe >=3D 0x80000004)=0A=
+                {=0A=
+                  unsigned *model_name =3D (unsigned *) szBuffer;=0A=
+                  cpuid (&model_name[0], &model_name[1], &model_name[2], &=
model_name[3], 0x80000002);=0A=
+                  cpuid (&model_name[4], &model_name[5], &model_name[6], &=
model_name[7], 0x80000003);=0A=
+                  cpuid (&model_name[8], &model_name[9], &model_name[10], =
&model_name[11], 0x80000004);=0A=
+                  model_name[12] =3D 0;=0A=
+                }=0A=
+              else=0A=
+                {=0A=
+                  // could implement a lookup table here if someone needs =
it=0A=
+                  strcpy (szBuffer, "unknown");=0A=
+                }=0A=
+              bufptr +=3D __small_sprintf (bufptr, "type            : %s\n=
"=0A=
+                                                 "cpu family      : %d\n"=
=0A=
+                                                 "model           : %d\n"=
=0A=
+                                                 "model name      : %s\n"=
=0A=
+                                                 "stepping        : %d\n"=
=0A=
+                                                 "brand id        : %d\n"=
=0A=
+                                                 "cpu count       : %d\n"=
=0A=
+                                                 "apic id         : %d\n"=
=0A=
+                                                 "cpu MHz         : %d\n"=
=0A=
+                                                 "fpu             : %s\n",=
=0A=
+                                         type_str,=0A=
+                                         family,=0A=
+                                         model,=0A=
+                                         szBuffer,=0A=
+                                         stepping,=0A=
+                                         brand_id,=0A=
+                                         cpu_count,=0A=
+                                         apic_id,=0A=
+                                         cpu_mhz,=0A=
+                                         IsProcessorFeaturePresent (PF_FLO=
ATING_POINT_EMULATED) ? "no" : "yes");=0A=
+              print ("flags           :");=0A=
+              if (features1 & (1 << 0))=0A=
+                print (" fpu");=0A=
+              if (features1 & (1 << 1))=0A=
+                print (" vme");=0A=
+              if (features1 & (1 << 2))=0A=
+                print (" de");=0A=
+              if (features1 & (1 << 3))=0A=
+                print (" pse");=0A=
+              if (features1 & (1 << 4))=0A=
+                print (" tsc");=0A=
+              if (features1 & (1 << 5))=0A=
+                print (" msr");=0A=
+              if (features1 & (1 << 6))=0A=
+                print (" pae");=0A=
+              if (features1 & (1 << 7))=0A=
+                print (" mce");=0A=
+              if (features1 & (1 << 8))=0A=
+                print (" cx8");=0A=
+              if (features1 & (1 << 9))=0A=
+                print (" apic");=0A=
+              if (features1 & (1 << 11))=0A=
+                print (" sep");=0A=
+              if (features1 & (1 << 12))=0A=
+                print (" mtrr");=0A=
+              if (features1 & (1 << 13))=0A=
+                print (" pge");=0A=
+              if (features1 & (1 << 14))=0A=
+                print (" mca");=0A=
+              if (features1 & (1 << 15))=0A=
+                print (" cmov");=0A=
+              if (features1 & (1 << 16))=0A=
+                print (" pat");=0A=
+              if (features1 & (1 << 17))=0A=
+                print (" pse36");=0A=
+              if (features1 & (1 << 18))=0A=
+                print (" psn");=0A=
+              if (features1 & (1 << 19))=0A=
+                print (" clfl");=0A=
+              if (features1 & (1 << 21))=0A=
+                print (" dtes");=0A=
+              if (features1 & (1 << 22))=0A=
+                print (" acpi");=0A=
+              if (features1 & (1 << 23))=0A=
+                print (" mmx");=0A=
+              if (features1 & (1 << 24))=0A=
+                print (" fxsr");=0A=
+              if (features1 & (1 << 25))=0A=
+                print (" sse");=0A=
+              if (features1 & (1 << 26))=0A=
+                print (" sse2");=0A=
+              if (features1 & (1 << 27))=0A=
+                print (" ss");=0A=
+              if (features1 & (1 << 28))=0A=
+                print (" htt");=0A=
+              if (features1 & (1 << 29))=0A=
+                print (" tmi");=0A=
+              if (features1 & (1 << 30))=0A=
+                print (" ia-64");=0A=
+              if (features1 & (1 << 31))=0A=
+                print (" pbe");=0A=
+              if (features2 & (1 << 0))=0A=
+                print (" sse3");=0A=
+              if (features2 & (1 << 3))=0A=
+                print (" mon");=0A=
+              if (features2 & (1 << 4))=0A=
+                print (" dscpl");=0A=
+              if (features2 & (1 << 8))=0A=
+                print (" tm2");=0A=
+              if (features2 & (1 << 10))=0A=
+                print (" cid");=0A=
+            }=0A=
+          else=0A=
+            {=0A=
+              bufptr +=3D __small_sprintf (bufptr, "cpu MHz         : %d\n=
"=0A=
+                                                 "fpu             : %s\n",=
=0A=
+                                                 cpu_mhz,=0A=
+                                                 IsProcessorFeaturePresent=
 (PF_FLOATING_POINT_EMULATED) ? "no" : "yes");=0A=
+            }=0A=
+        }=0A=
+      if (dwOldThreadAffinityMask !=3D 0)=0A=
+        SetThreadAffinityMask (GetCurrentThread (), dwOldThreadAffinityMas=
k);=0A=
+=0A=
+      RegCloseKey (hKey);=0A=
+      bufptr +=3D __small_sprintf (bufptr, "\n");=0A=
+  }=0A=
+=0A=
+  return bufptr - destbuf;=0A=
+}=0A=
+=0A=
+#undef read_value=0A=
+#undef cpuid=0A=
+=0A=
+static=0A=
+off_t=0A=
+format_proc_partitions (char *destbuf, size_t maxsize)=0A=
+{=0A=
+  char *bufptr =3D destbuf;=0A=
+  print ("major minor  #blocks  name\n\n");=0A=
+=0A=
+  if (wincap.is_winnt ())=0A=
+    {=0A=
+      for (int drive_number=3D0;;drive_number++)=0A=
+        {=0A=
+          CHAR szDriveName[MAX_PATH];=0A=
+          __small_sprintf (szDriveName, "\\\\.\\PHYSICALDRIVE%d", drive_nu=
mber);=0A=
+          HANDLE hDevice;=0A=
+          hDevice =3D CreateFile (szDriveName,=0A=
+                                GENERIC_READ,=0A=
+                                FILE_SHARE_READ | FILE_SHARE_WRITE,=0A=
+                                NULL,=0A=
+                                OPEN_EXISTING,=0A=
+                                0,=0A=
+                                NULL);=0A=
+          if (hDevice =3D=3D INVALID_HANDLE_VALUE)=0A=
+            {=0A=
+              if (GetLastError () =3D=3D ERROR_PATH_NOT_FOUND)=0A=
+                  break;=0A=
+              __seterrno ();=0A=
+              debug_printf ("CreateFile %d %E", GetLastError ());=0A=
+              break;=0A=
+            }=0A=
+          else=0A=
+            {=0A=
+              DWORD dwBytesReturned, dwRetCode;=0A=
+              DISK_GEOMETRY dg;=0A=
+              int buf_size =3D 4096;=0A=
+              char buf[buf_size];=0A=
+              dwRetCode =3D DeviceIoControl (hDevice,=0A=
+                                           IOCTL_DISK_GET_DRIVE_GEOMETRY,=
=0A=
+                                           NULL,=0A=
+                                           0,=0A=
+                                           &dg,=0A=
+                                           sizeof (dg),=0A=
+                                           &dwBytesReturned,=0A=
+                                           NULL);=0A=
+              if (!dwRetCode)=0A=
+                debug_printf ("DeviceIoControl %E");=0A=
+              else=0A=
+                {=0A=
+                  bufptr +=3D __small_sprintf (bufptr, "%5d %5d %9U sd%c\n=
",=0A=
+                                             FH_FLOPPY,=0A=
+                                             drive_number * 16 + 32,=0A=
+                                             (long long)((dg.Cylinders.Qua=
dPart * dg.TracksPerCylinder *=0A=
+                                              dg.SectorsPerTrack * dg.Byte=
sPerSector) >> 6),=0A=
+                                             drive_number + 'a');=0A=
+                }=0A=
+              while (dwRetCode =3D DeviceIoControl (hDevice,=0A=
+                                                  IOCTL_DISK_GET_DRIVE_LAY=
OUT,=0A=
+                                                  NULL,=0A=
+                                                  0,=0A=
+                                                  (DRIVE_LAYOUT_INFORMATIO=
N *) buf,=0A=
+                                                  buf_size,=0A=
+                                                  &dwBytesReturned,=0A=
+                                                  NULL),=0A=
+                     !dwRetCode && GetLastError () =3D=3D ERROR_INSUFFICIE=
NT_BUFFER)=0A=
+              buf_size *=3D 2;=0A=
+              if (!dwRetCode)=0A=
+                debug_printf ("DeviceIoControl %E");=0A=
+              else=0A=
+                {=0A=
+                  DRIVE_LAYOUT_INFORMATION *dli =3D (DRIVE_LAYOUT_INFORMAT=
ION *) buf;=0A=
+                  for (unsigned partition =3D 0; partition < dli->Partitio=
nCount; partition++)=0A=
+                    {=0A=
+                      if (dli->PartitionEntry[partition].PartitionLength.Q=
uadPart =3D=3D 0)=0A=
+                        continue;=0A=
+                      bufptr +=3D __small_sprintf (bufptr, "%5d %5d %9U sd=
%c%d\n",=0A=
+                                                 FH_FLOPPY,=0A=
+                                                 drive_number * 16 + parti=
tion + 33,=0A=
+                                                 (long long)(dli->Partitio=
nEntry[partition].PartitionLength.QuadPart >> 6),=0A=
+                                                 drive_number + 'a',=0A=
+                                                 partition + 1);=0A=
+                    }=0A=
+                }=0A=
+=0A=
+              CloseHandle (hDevice);=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      // not worth the effort=0A=
+      // you need a 16 bit thunk DLL to access the partition table on Win9=
x=0A=
+      // and then you have to decode it yourself=0A=
+    }=0A=
+  return bufptr - destbuf;=0A=
+}=0A=
+=0A=
+#undef print=0A=

------=_NextPart_000_0015_01C2E433.E8B66DD0
Content-Type: text/plain;
	name="cpuinfo_partitions_w32api.ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpuinfo_partitions_w32api.ChangeLog.txt"
Content-length: 235

	* include/winbase.h (FindFirstVolume): Add declaration.
	(FindNextVolume): Add declaration.
	(FindVolumeClose): Add declaration.
	(GetSystemTimes): Add declaration.
	* include/winnt.h: Add define for PF_XMMI64_INSTRUCTIONS_AVAILABLE.

------=_NextPart_000_0015_01C2E433.E8B66DD0
Content-Type: application/octet-stream;
	name="cpuinfo_partitions_w32api.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cpuinfo_partitions_w32api.patch"
Content-length: 3989

Index: w32api/include/winbase.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/winbase.h,v=0A=
retrieving revision 1.37=0A=
diff -b -B -u -p -r1.37 winbase.h=0A=
--- w32api/include/winbase.h	23 Feb 2003 08:31:37 -0000	1.37=0A=
+++ w32api/include/winbase.h	2 Mar 2003 12:40:10 -0000=0A=
@@ -1117,9 +1117,18 @@ HANDLE WINAPI FindFirstFileW(LPCWSTR,LPW=0A=
 HANDLE WINAPI FindFirstFileExA(LPCSTR,FINDEX_INFO_LEVELS,PVOID,FINDEX_SEAR=
CH_OPS,PVOID,DWORD);=0A=
 HANDLE WINAPI FindFirstFileExW(LPCWSTR,FINDEX_INFO_LEVELS,PVOID,FINDEX_SEA=
RCH_OPS,PVOID,DWORD);=0A=
 BOOL WINAPI FindFirstFreeAce(PACL,PVOID*);=0A=
+#if (_WIN32_WINNT >=3D 0x0500)=0A=
+HANDLE WINAPI FindFirstVolumeA(LPCSTR,DWORD);=0A=
+HANDLE WINAPI FindFirstVolumeW(LPCWSTR,DWORD);=0A=
+#endif=0A=
 BOOL WINAPI FindNextChangeNotification(HANDLE);=0A=
 BOOL WINAPI FindNextFileA(HANDLE,LPWIN32_FIND_DATAA);=0A=
 BOOL WINAPI FindNextFileW(HANDLE,LPWIN32_FIND_DATAW);=0A=
+#if (_WIN32_WINNT >=3D 0x0500)=0A=
+BOOL WINAPI FindNextVolumeA(HANDLE,LPCSTR,DWORD);=0A=
+BOOL WINAPI FindNextVolumeW(HANDLE,LPWSTR,DWORD);=0A=
+BOOL WINAPI FindVolumeClose(HANDLE);=0A=
+#endif=0A=
 HRSRC WINAPI FindResourceA(HMODULE,LPCSTR,LPCSTR);=0A=
 HRSRC WINAPI FindResourceW(HINSTANCE,LPCWSTR,LPCWSTR);=0A=
 HRSRC WINAPI FindResourceExA(HINSTANCE,LPCSTR,LPCSTR,WORD);=0A=
@@ -1264,6 +1273,9 @@ UINT WINAPI GetSystemDirectoryW(LPWSTR,U=0A=
 VOID WINAPI GetSystemInfo(LPSYSTEM_INFO);=0A=
 BOOL WINAPI GetSystemPowerStatus(LPSYSTEM_POWER_STATUS);=0A=
 VOID WINAPI GetSystemTime(LPSYSTEMTIME);=0A=
+#if (_WIN32_WINNT >=3D 0x0501)=0A=
+BOOL WINAPI GetSystemTimes(LPFILETIME,LPFILETIME,LPFILETIME);=0A=
+#endif=0A=
 BOOL WINAPI GetSystemTimeAdjustment(PDWORD,PDWORD,PBOOL);=0A=
 void WINAPI GetSystemTimeAsFileTime(LPFILETIME);=0A=
 DWORD WINAPI GetTapeParameters(HANDLE,DWORD,PDWORD,PVOID);=0A=
@@ -1684,7 +1696,13 @@ typedef HW_PROFILE_INFOW HW_PROFILE_INFO=0A=
 #define FindFirstChangeNotification FindFirstChangeNotificationW=0A=
 #define FindFirstFile FindFirstFileW=0A=
 #define FindFirstFileEx FindFirstFileExW=0A=
+#if (_WIN32_WINNT >=3D 0x0500)=0A=
+#define FindFirstVolume FindFirstVolumeW=0A=
+#endif=0A=
 #define FindNextFile FindNextFileW=0A=
+#if (_WIN32_WINNT >=3D 0x0500)=0A=
+#define FindNextVolume FindNextVolumeW=0A=
+#endif=0A=
 #define FindResource FindResourceW=0A=
 #define FindResourceEx FindResourceExW=0A=
 #define FormatMessage FormatMessageW=0A=
@@ -1825,7 +1843,13 @@ typedef HW_PROFILE_INFOA HW_PROFILE_INFO=0A=
 #define FindFirstChangeNotification FindFirstChangeNotificationA=0A=
 #define FindFirstFile FindFirstFileA=0A=
 #define FindFirstFileEx FindFirstFileExA=0A=
+#if (_WIN32_WINNT >=3D 0x0500)=0A=
+#define FindFirstVolume FindFirstVolumeA=0A=
+#endif=0A=
 #define FindNextFile FindNextFileA=0A=
+#if (_WIN32_WINNT >=3D 0x0500)=0A=
+#define FindNextVolume FindNextVolumeA=0A=
+#endif=0A=
 #define FindResource FindResourceA=0A=
 #define FindResourceEx FindResourceExA=0A=
 #define FormatMessage FormatMessageA=0A=
Index: w32api/include/winnt.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/winnt.h,v=0A=
retrieving revision 1.58=0A=
diff -b -B -u -p -r1.58 winnt.h=0A=
--- w32api/include/winnt.h	5 Feb 2003 15:51:27 -0000	1.58=0A=
+++ w32api/include/winnt.h	2 Mar 2003 12:40:14 -0000=0A=
@@ -611,6 +611,7 @@ typedef DWORD FLONG;=0A=
 #define PF_3DNOW_INSTRUCTIONS_AVAILABLE 7=0A=
 #define PF_RDTSC_INSTRUCTION_AVAILABLE 8=0A=
 #define PF_PAE_ENABLED 9=0A=
+#define PF_XMMI64_INSTRUCTIONS_AVAILABLE 10=0A=
 #define PAGE_READONLY 2=0A=
 #define PAGE_READWRITE 4=0A=
 #define PAGE_WRITECOPY 8=0A=

------=_NextPart_000_0015_01C2E433.E8B66DD0--
