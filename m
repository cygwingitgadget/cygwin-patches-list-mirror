Return-Path: <cygwin-patches-return-3815-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30489 invoked by alias); 15 Apr 2003 20:38:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30469 invoked from network); 15 Apr 2003 20:38:43 -0000
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: RE: hostid patch
Date: Tue, 15 Apr 2003 20:38:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHCEMLDIAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0048_01C30397.62DB4C70"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <00f301c3038d$0697a760$5c51893e@pomello>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q2/txt/msg00042.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0048_01C30397.62DB4C70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 347

> Chris January wrote:
> > *Not* tested on anything other than Windows XP.
> >
> > Adds gethostid function to Cygwin. Three patches: one for 
> Cygwin, one for
> > newlib and one for w32api.
> > If I've done anything wrong let me know and I'll try to fix it.
> 
> "diff -u" format patches are preferred.
Oops - silly me! New ones attached.

Chris

------=_NextPart_000_0048_01C30397.62DB4C70
Content-Type: application/octet-stream;
	name="cygwin_hostid.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin_hostid.patch"
Content-length: 9582

Index: winsup/cygwin/autoload.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v=0A=
retrieving revision 1.66=0A=
diff -u -p -r1.66 autoload.cc=0A=
--- winsup/cygwin/autoload.cc	27 Mar 2003 09:40:25 -0000	1.66=0A=
+++ winsup/cygwin/autoload.cc	15 Apr 2003 20:32:46 -0000=0A=
@@ -523,4 +523,7 @@ LoadDLLfuncEx (timeGetDevCaps, 8, winmm,=0A=
 LoadDLLfuncEx (timeGetTime, 0, winmm, 1)=0A=
 LoadDLLfuncEx (timeBeginPeriod, 4, winmm, 1)=0A=
 LoadDLLfuncEx (timeEndPeriod, 4, winmm, 1)=0A=
+=0A=
+LoadDLLfuncEx (UuidCreate, 4, rpcrt4, 1)=0A=
+LoadDLLfuncEx (UuidCreateSequential, 4, rpcrt4, 1)=0A=
 }=0A=
Index: winsup/cygwin/cygwin.din=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v=0A=
retrieving revision 1.85=0A=
diff -u -p -r1.85 cygwin.din=0A=
--- winsup/cygwin/cygwin.din	10 Apr 2003 08:22:41 -0000	1.85=0A=
+++ winsup/cygwin/cygwin.din	15 Apr 2003 20:32:47 -0000=0A=
@@ -565,6 +565,8 @@ getgrnam32=0A=
 getgroups=0A=
 _getgroups =3D getgroups=0A=
 getgroups32=0A=
+gethostid=0A=
+_gethostid =3D gethostid=0A=
 getitimer=0A=
 getlogin=0A=
 _getlogin =3D getlogin=0A=
Index: winsup/cygwin/fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.27=0A=
diff -u -p -r1.27 fhandler_proc.cc=0A=
--- winsup/cygwin/fhandler_proc.cc	1 Apr 2003 16:11:41 -0000	1.27=0A=
+++ winsup/cygwin/fhandler_proc.cc	15 Apr 2003 20:32:48 -0000=0A=
@@ -28,6 +28,7 @@ details. */=0A=
 #include <sys/param.h>=0A=
 #include "ntdll.h"=0A=
 #include <winioctl.h>=0A=
+#include "cpuid.h"=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
 #include <dirent.h>=0A=
@@ -549,37 +550,6 @@ format_proc_stat (char *destbuf, size_t=20=0A=
 	  strcpy (bufptr, x), \=0A=
 	  bufptr +=3D sizeof (x) - 1; \=0A=
 	} while (0)=0A=
-=0A=
-static inline void=0A=
-cpuid (unsigned *a, unsigned *b, unsigned *c, unsigned *d, unsigned in)=0A=
-{=0A=
-  asm ("cpuid"=0A=
-       : "=3Da" (*a),=0A=
-	 "=3Db" (*b),=0A=
-	 "=3Dc" (*c),=0A=
-	 "=3Dd" (*d)=0A=
-       : "a" (in));=0A=
-}=0A=
-=0A=
-static inline bool=0A=
-can_set_flag (unsigned flag)=0A=
-{=0A=
-  unsigned r1, r2;=0A=
-  asm("pushfl\n"=0A=
-      "popl %0\n"=0A=
-      "movl %0, %1\n"=0A=
-      "xorl %2, %0\n"=0A=
-      "pushl %0\n"=0A=
-      "popfl\n"=0A=
-      "pushfl\n"=0A=
-      "popl %0\n"=0A=
-      "pushl %1\n"=0A=
-      "popfl\n"=0A=
-      : "=3D&r" (r1), "=3D&r" (r2)=0A=
-      : "ir" (flag)=0A=
-  );=0A=
-  return ((r1 ^ r2) & flag) !=3D 0;=0A=
-}=0A=
=20=0A=
 static _off64_t=0A=
 format_proc_cpuinfo (char *destbuf, size_t maxsize)=0A=
Index: winsup/cygwin/syscalls.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v=0A=
retrieving revision 1.263=0A=
diff -u -p -r1.263 syscalls.cc=0A=
--- winsup/cygwin/syscalls.cc	1 Apr 2003 16:11:41 -0000	1.263=0A=
+++ winsup/cygwin/syscalls.cc	15 Apr 2003 20:32:54 -0000=0A=
@@ -36,6 +36,7 @@ details. */=0A=
 #include <winnls.h>=0A=
 #include <wininet.h>=0A=
 #include <lmcons.h> /* for UNLEN */=0A=
+#include <rpc.h>=0A=
=20=0A=
 #undef fstat=0A=
 #undef stat=0A=
@@ -55,6 +56,8 @@ details. */=0A=
 #define NEED_VFORK=0A=
 #include "perthread.h"=0A=
 #include "pwdgrp.h"=0A=
+#include "cpuid.h"=0A=
+#include "registry.h"=0A=
=20=0A=
 #undef _close=0A=
 #undef _lseek=0A=
@@ -2724,4 +2727,110 @@ pututline (struct utmp *ut)=0A=
       ReleaseMutex (mutex);=0A=
       CloseHandle (mutex);=0A=
     }=0A=
+}=0A=
+=0A=
+extern "C"=0A=
+long gethostid(void)=0A=
+{=0A=
+  unsigned data[13] =3D {0x92895012,=0A=
+                       0x10293412,=0A=
+                       0x29602018,=0A=
+                       0x81928167,=0A=
+                       0x34601329,=0A=
+                       0x75630198,=0A=
+                       0x89860395,=0A=
+                       0x62897564,=0A=
+                       0x00194362,=0A=
+                       0x20548593,=0A=
+                       0x96839102,=0A=
+                       0x12219854,=0A=
+                       0x00290012};=0A=
+=0A=
+  bool has_cpuid =3D false;=0A=
+=0A=
+  if (!can_set_flag (0x00040000))=0A=
+    debug_printf ("386 processor - no cpuid");=0A=
+  else=0A=
+    {=0A=
+      debug_printf ("486 processor");=0A=
+      if (can_set_flag (0x00200000))=0A=
+        {=0A=
+          debug_printf ("processor supports CPUID instruction");=0A=
+          has_cpuid =3D true;=0A=
+        }=0A=
+      else=0A=
+        debug_printf ("processor does not support CPUID instruction");=0A=
+    }=0A=
+  if (has_cpuid)=0A=
+    {=0A=
+      unsigned maxf, unused[3];=0A=
+      cpuid (&maxf, &unused[0], &unused[1], &unused[2], 0);=0A=
+      maxf &=3D 0xffff;=0A=
+      if (maxf >=3D 1)=0A=
+        {=0A=
+          unsigned features;=0A=
+          cpuid (&data[0], &unused[0], &unused[1], &features, 1);=0A=
+          if (features & (1 << 18))=0A=
+            {=0A=
+              debug_printf ("processor has psn");=0A=
+              if (maxf >=3D 3)=0A=
+                {=0A=
+                  cpuid (&unused[0], &unused[1], &data[1], &data[2], 3);=
=0A=
+                  debug_printf ("Processor PSN: %04x-%04x-%04x-%04x-%04x-%=
04x",=0A=
+                                data[0] >> 16, data[0] & 0xffff, data[2] >=
> 16, data[2] & 0xffff, data[1] >> 16, data[1] & 0xffff);=0A=
+                }=0A=
+            }=0A=
+          else=0A=
+            debug_printf ("processor does not have psn");=0A=
+        }=0A=
+    }=0A=
+=0A=
+  UUID Uuid;=0A=
+  RPC_STATUS status =3D UuidCreateSequential (&Uuid);=0A=
+  if (GetLastError () =3D=3D ERROR_PROC_NOT_FOUND)=0A=
+    status =3D UuidCreate (&Uuid);=0A=
+  if (status =3D=3D RPC_S_OK)=0A=
+    {=0A=
+      data[4] =3D *(unsigned *)&Uuid.Data4[2];=0A=
+      data[5] =3D *(unsigned short *)&Uuid.Data4[6];=0A=
+      // Unfortunately Windows will sometimes pick a virtual Ethernet card=
=0A=
+      // e.g. VMWare Virtual Ethernet Adaptor=0A=
+      debug_printf ("MAC address of first Ethernet card: %02x:%02x:%02x:%0=
2x:%02x:%02x",=0A=
+                    Uuid.Data4[2], Uuid.Data4[3], Uuid.Data4[4],=0A=
+                    Uuid.Data4[5], Uuid.Data4[6], Uuid.Data4[7]);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      debug_printf ("no Ethernet card installed");=0A=
+    }=0A=
+=0A=
+  reg_key key (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE", "Microsoft", "Win=
dows", "CurrentVersion", NULL);=0A=
+  key.get_string ("ProductId", (char *)&data[6], 24, "00000-000-0000000-00=
000");=0A=
+  debug_printf ("Windows Product ID: %s", (char *)&data[6]);=0A=
+=0A=
+  GetDiskFreeSpaceEx ("C:\\", NULL, (PULARGE_INTEGER) &data[11], NULL);=0A=
+  if (GetLastError () =3D=3D ERROR_PROC_NOT_FOUND)=0A=
+    GetDiskFreeSpace ("C:\\", NULL, NULL, NULL, (DWORD *)&data[11]);=0A=
+=0A=
+  debug_printf ("hostid entropy: %08x %08x %08x %08x "=0A=
+                                "%08x %08x %08x %08x "=0A=
+                                "%08x %08x %08x %08x "=0A=
+                                "%08x",=0A=
+                                data[0], data[1],=0A=
+                                data[2], data[3],=0A=
+                                data[4], data[5],=0A=
+                                data[6], data[7],=0A=
+                                data[8], data[9],=0A=
+                                data[10], data[11],=0A=
+                                data[12]);=0A=
+=0A=
+  long hostid =3D 0x40291372;=0A=
+  // a random hashing algorithm=0A=
+  // dependancy on md5 is probably too costly=0A=
+  for (int i=3D0;i<13;i++)=0A=
+        hostid ^=3D ((data[i] << (i << 2)) | (data[i] >> (32 - (i << 2))))=
;=0A=
+=0A=
+  debug_printf ("hostid: %08x", hostid);=0A=
+=0A=
+  return hostid;=0A=
 }=0A=
Index: winsup/cygwin/include/cygwin/version.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v=0A=
retrieving revision 1.114=0A=
diff -u -p -r1.114 version.h=0A=
--- winsup/cygwin/include/cygwin/version.h	10 Apr 2003 08:22:42 -0000	1.114=
=0A=
+++ winsup/cygwin/include/cygwin/version.h	15 Apr 2003 20:32:57 -0000=0A=
@@ -199,12 +199,13 @@ details. */=0A=
        80: Export pthread_rwlock stuff=0A=
        81: CW_CHECK_NTSEC addition to external.cc=0A=
        82: Export wcscoll wcswidth wcwidth=0A=
+       83: Export gethostid=0A=
      */=0A=
=20=0A=
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull =
*/=0A=
=20=0A=
 #define CYGWIN_VERSION_API_MAJOR 0=0A=
-#define CYGWIN_VERSION_API_MINOR 82=0A=
+#define CYGWIN_VERSION_API_MINOR 83=0A=
=20=0A=
      /* There is also a compatibity version number associated with the=0A=
 	shared memory regions.  It is incremented when incompatible=0A=

------=_NextPart_000_0048_01C30397.62DB4C70
Content-Type: application/octet-stream;
	name="newlib_hostid.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="newlib_hostid.patch"
Content-length: 932

Index: newlib/libc/include/sys/unistd.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/newlib/libc/include/sys/unistd.h,v=0A=
retrieving revision 1.42=0A=
diff -u -p -r1.42 unistd.h=0A=
--- newlib/libc/include/sys/unistd.h	14 Mar 2003 18:39:05 -0000	1.42=0A=
+++ newlib/libc/include/sys/unistd.h	15 Apr 2003 20:32:27 -0000=0A=
@@ -60,6 +60,9 @@ uid_t   _EXFUN(geteuid, (void ));=0A=
 gid_t   _EXFUN(getgid, (void ));=0A=
 #endif=0A=
 int     _EXFUN(getgroups, (int __gidsetsize, gid_t __grouplist[] ));=0A=
+#if defined(__CYGWIN__)=0A=
+long    _EXFUN(gethostid, (void));=0A=
+#endif=0A=
 char    _EXFUN(*getlogin, (void ));=0A=
 #if defined(_POSIX_THREAD_SAFE_FUNCTIONS)=0A=
 int _EXFUN(getlogin_r, (char *name, size_t namesize) );=0A=
=20=

------=_NextPart_000_0048_01C30397.62DB4C70
Content-Type: application/octet-stream;
	name="w32api_hostid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="w32api_hostid.patch"
Content-length: 1244

Index: winsup/w32api/include/rpcdce.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/rpcdce.h,v
retrieving revision 1.5
diff -u -p -r1.5 rpcdce.h
--- winsup/w32api/include/rpcdce.h	9 Mar 2002 09:04:09 -0000	1.5
+++ winsup/w32api/include/rpcdce.h	15 Apr 2003 20:33:05 -0000
@@ -366,6 +366,7 @@ DECLSPEC_NORETURN void  RPC_ENTRY RpcRai
 RPC_STATUS RPC_ENTRY RpcTestCancel(void);
 RPC_STATUS RPC_ENTRY RpcCancelThread(void*);
 RPC_STATUS RPC_ENTRY UuidCreate(UUID*);
+RPC_STATUS RPC_ENTRY UuidCreateSequential(UUID*);
 signed int RPC_ENTRY UuidCompare(UUID*,UUID*, RPC_STATUS*);
 RPC_STATUS RPC_ENTRY UuidCreateNil(UUID*);
 int RPC_ENTRY UuidEqual(UUID*,UUID*, RPC_STATUS*);
Index: winsup/w32api/lib/rpcrt4.def
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/rpcrt4.def,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 rpcrt4.def
--- winsup/w32api/lib/rpcrt4.def	17 Feb 2000 19:38:32 -0000	1.1.1.1
+++ winsup/w32api/lib/rpcrt4.def	15 Apr 2003 20:33:17 -0000
@@ -344,6 +344,7 @@ TowerExplode@24
 UuidCompare@12
 UuidCreate@4
 UuidCreateNil@4
+UuidCreateSequential@4
 UuidEqual@12
 UuidFromStringA@8
 UuidFromStringW@8
 
------=_NextPart_000_0048_01C30397.62DB4C70
Content-Type: text/plain;
	name="cpuid.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpuid.h"
Content-length: 594

#ifndef CPUID_H
#define CPUID_H

inline void
cpuid (unsigned *a, unsigned *b, unsigned *c, unsigned *d, unsigned in)
{
  asm ("cpuid"
       : "=a" (*a),
         "=b" (*b),
         "=c" (*c),
         "=d" (*d)
       : "a" (in));
}

inline bool
can_set_flag (unsigned flag)
{
  unsigned r1, r2;
  asm("pushfl\n"
      "popl %0\n"
      "movl %0, %1\n"
      "xorl %2, %0\n"
      "pushl %0\n"
      "popfl\n"
      "pushfl\n"
      "popl %0\n"
      "pushl %1\n"
      "popfl\n"
      : "=&r" (r1), "=&r" (r2)
      : "ir" (flag)
  );
  return ((r1 ^ r2) & flag) != 0;
}

#endif // !CPUID_H

------=_NextPart_000_0048_01C30397.62DB4C70--
