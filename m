Return-Path: <cygwin-patches-return-2170-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6275 invoked by alias); 9 May 2002 23:28:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6241 invoked from network); 9 May 2002 23:28:49 -0000
X-WM-Posted-At: avacado.atomice.net; Fri, 10 May 02 00:31:39 +0100
Message-ID: <05cd01c1f7b1$aa451250$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: /proc improvements
Date: Thu, 09 May 2002 16:28:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_05CA_01C1F7BA.0BD264C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00154.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_05CA_01C1F7BA.0BD264C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2931

This is first of two patches adding a number of extra files to the /proc
virtual file system.
The main aim of this patch was to add compatibility with the procps tools,
which has been achieved. Specifically, both top and ps are working.
A lot of the process-specific information and some global information is
only available on Windows NT. This isn't because I'm mean, but simply
because I know no way of retrieving this information under Windows 95/98/me.
In fact the operating system doesn't bother recording most of the
information required.
Please test extensively. I've only tested it under Windows 2000 and Windows
98. In particular I need to know whether the patch works with NT 4.

Regards
Chris

2002-05-10  Christopher January <chris@atomice.net>

 * autoload.cc: Add dynamic load statements for 'ZwQueryInformationProcess'
 and 'ZwQueryVirtualMemory'.
 * fhandler.h: Change type of bufalloc and filesize members of
 fhandler_virtual from int to size_t.
 Change type of position member from __off32_t to __off64_t.
 Add new fileid member to fhandler_virtual class.
 Make seekdir take an __off64_t argument.
 Make lseek take an __off64_t argument.
 Add fill_filebuf method to fhandler_virtual.
 Add fill_filebuf method to fhandler_proc.
 Add fill_filebuf method to fhandler_registry.
 Add fill_filebuf method to fhandler_process.
 Add saved_pid and saved_p members to fhandler_process.
 * fhandler_proc.cc: Add 'loadavg', 'meminfo', and 'stat' files to
 proc_listing array.
 Add corresponding entries in proc_fhandlers array.
 (fhandler_proc::open): Use fill_filebuf to flesh out the file contents.
 (fhandler_proc::fill_filebuf): New method.
 (fhandler_proc::format_proc_meminfo): Ditto.
 (fhandler_proc::format_proc_stat): Ditto.
 (fhandler_proc::format_proc_uptime): Ditto.
 * fhandler_process.cc: Add 'stat' and 'statm' files to process_listing
 array.
 (fhandler_process::fstat): Find the _pinfo structure for the process
 named in the filename. Return ENOENT if the process is no longer around.
 Set the gid and uid fields of the stat structure.
 (fhandler_process::open): Store pid and pointer to _pinfo structure in
 saved_pid and saved_p respectively. Use fill_filebuf to flesh out file
 contents.
 (fhandler_proc::fill_filebuf): New method.
 (format_process_stat): New function.
 (format_process_status): Ditto.
 (format_process_statm): Ditto.
 (get_process_state): Ditto.
 (get_mem_values): Ditto.
 * fhandler_registry.cc (fhandler_registry::seekdir): Change argument type
 from __off32_t to __off64_t.
 (fhandler_registry::fill_filebuf): New method.
 * fhandler_virtual.cc (fhandler_virtual::seekdir): Change argument type
 from __off32_t to __off64_t.
 (fhandler_virtual::lseek): Ditto.
 (fhandler_virtual::fill_filebuf): New method.
 (fhandler_virtual::fhandler_virtual): Initialise fileid to -1.
 * wincap.cc: Set flag has_process_io_counters  appropriately.
 * wincap.h: Add flag has_process_io_counters.


------=_NextPart_000_05CA_01C1F7BA.0BD264C0
Content-Type: application/octet-stream;
	name="proc.patch.4"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.patch.4"
Content-length: 57759

Index: autoload.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v=0A=
retrieving revision 1.40=0A=
diff -u -3 -p -u -p -b -B -r1.40 autoload.cc=0A=
--- autoload.cc	7 Mar 2002 14:32:53 -0000	1.40=0A=
+++ autoload.cc	9 May 2002 23:14:37 -0000=0A=
@@ -381,6 +381,8 @@ LoadDLLfuncEx (NtUnmapViewOfSection, 8,=20=0A=
 LoadDLLfuncEx (RtlInitUnicodeString, 8, ntdll, 1)=0A=
 LoadDLLfuncEx (RtlNtStatusToDosError, 4, ntdll, 1)=0A=
 LoadDLLfuncEx (ZwQuerySystemInformation, 16, ntdll, 1)=0A=
+LoadDLLfuncEx (ZwQueryInformationProcess, 20, ntdll, 1)=0A=
+LoadDLLfuncEx (ZwQueryVirtualMemory, 24, ntdll, 1)=0A=
=20=0A=
 LoadDLLfuncEx (GetProcessMemoryInfo, 12, psapi, 1)=0A=
=20=0A=
Index: fhandler.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v=0A=
retrieving revision 1.113=0A=
diff -u -3 -p -u -p -b -B -r1.113 fhandler.h=0A=
--- fhandler.h	2 May 2002 04:13:45 -0000	1.113=0A=
+++ fhandler.h	9 May 2002 23:14:40 -0000=0A=
@@ -1043,8 +1043,9 @@ class fhandler_virtual : public fhandler=0A=
 {=0A=
  protected:=0A=
   char *filebuf;=0A=
-  int bufalloc, filesize;=0A=
-  __off32_t position;=0A=
+  size_t bufalloc, filesize;=0A=
+  __off64_t position;=0A=
+  int fileid; // unique within each class=0A=
  public:=0A=
=20=0A=
   fhandler_virtual (DWORD devtype);=0A=
@@ -1053,16 +1054,17 @@ class fhandler_virtual : public fhandler=0A=
   virtual int exists(const char *path);=0A=
   DIR *opendir (path_conv& pc);=0A=
   __off64_t telldir (DIR *);=0A=
-  void seekdir (DIR *, __off32_t);=0A=
+  void seekdir (DIR *, __off64_t);=0A=
   void rewinddir (DIR *);=0A=
   int closedir (DIR *);=0A=
   int write (const void *ptr, size_t len);=0A=
   int __stdcall read (void *ptr, size_t len) __attribute__ ((regparm (3)))=
;=0A=
-  __off64_t lseek (__off32_t, int);=0A=
+  __off64_t lseek (__off64_t, int);=0A=
   int dup (fhandler_base * child);=0A=
   int open (path_conv *, int flags, mode_t mode =3D 0);=0A=
   int close (void);=0A=
   int __stdcall fstat (struct stat *buf, path_conv *pc) __attribute__ ((re=
gparm (3)));=0A=
+  virtual void fill_filebuf ();=0A=
 };=0A=
=20=0A=
 class fhandler_proc: public fhandler_virtual=0A=
@@ -1076,6 +1078,7 @@ class fhandler_proc: public fhandler_vir=0A=
=20=0A=
   int open (path_conv *real_path, int flags, mode_t mode =3D 0);=0A=
   int __stdcall fstat (struct __stat64 *buf, path_conv *) __attribute__ ((=
regparm (3)));=0A=
+  void fill_filebuf ();=0A=
 };=0A=
=20=0A=
 class fhandler_registry: public fhandler_proc=0A=
@@ -1085,23 +1088,29 @@ class fhandler_registry: public fhandler=0A=
   int exists(const char *path);=0A=
   struct dirent *readdir (DIR *);=0A=
   __off64_t telldir (DIR *);=0A=
-  void seekdir (DIR *, __off32_t);=0A=
+  void seekdir (DIR *, __off64_t);=0A=
   void rewinddir (DIR *);=0A=
   int closedir (DIR *);=0A=
=20=0A=
   int open (path_conv *real_path, int flags, mode_t mode =3D 0);=0A=
   int __stdcall fstat (struct __stat64 *buf, path_conv *) __attribute__ ((=
regparm (3)));=0A=
   HKEY open_key(const char *name, REGSAM access =3D KEY_READ, bool isValue=
 =3D false);=0A=
+  void fill_filebuf ();=0A=
 };=0A=
=20=0A=
+struct _pinfo;=0A=
 class fhandler_process: public fhandler_proc=0A=
 {=0A=
+ private:=0A=
+  pid_t saved_pid;=0A=
+  _pinfo *saved_p;=0A=
  public:=0A=
   fhandler_process ();=0A=
   int exists(const char *path);=0A=
   struct dirent *readdir (DIR *);=0A=
   int open (path_conv *real_path, int flags, mode_t mode =3D 0);=0A=
   int __stdcall fstat (struct __stat64 *buf, path_conv *) __attribute__ ((=
regparm (3)));=0A=
+  void fill_filebuf ();=0A=
 };=0A=
=20=0A=
 typedef union=0A=
Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.3=0A=
diff -u -3 -p -u -p -b -B -r1.3 fhandler_proc.cc=0A=
--- fhandler_proc.cc	4 May 2002 03:24:35 -0000	1.3=0A=
+++ fhandler_proc.cc	9 May 2002 23:14:41 -0000=0A=
@@ -14,6 +14,7 @@ details. */=0A=
 #include <unistd.h>=0A=
 #include <stdlib.h>=0A=
 #include <sys/cygwin.h>=0A=
+#include <ntdef.h>=0A=
 #include "cygerrno.h"=0A=
 #include "security.h"=0A=
 #include "fhandler.h"=0A=
@@ -24,20 +25,27 @@ details. */=0A=
 #include "cygheap.h"=0A=
 #include <assert.h>=0A=
 #include <sys/utsname.h>=0A=
+#include "ntdll.h"=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
 #include <dirent.h>=0A=
=20=0A=
 /* offsets in proc_listing */=0A=
-static const int PROC_REGISTRY =3D 2;     // /proc/registry=0A=
-static const int PROC_VERSION  =3D 3;     // /proc/version=0A=
-static const int PROC_UPTIME   =3D 4;     // /proc/uptime=0A=
+static const int PROC_LOADAVG  =3D 2;     // /proc/loadavg=0A=
+static const int PROC_MEMINFO  =3D 3;     // /proc/meminfo=0A=
+static const int PROC_REGISTRY =3D 4;     // /proc/registry=0A=
+static const int PROC_STAT     =3D 5;     // /proc/stat=0A=
+static const int PROC_VERSION  =3D 6;     // /proc/version=0A=
+static const int PROC_UPTIME   =3D 7;     // /proc/uptime=0A=
=20=0A=
 /* names of objects in /proc */=0A=
 static const char *proc_listing[] =3D {=0A=
   ".",=0A=
   "..",=0A=
+  "loadavg",=0A=
+  "meminfo",=0A=
   "registry",=0A=
+  "stat",=0A=
   "version",=0A=
   "uptime",=0A=
   NULL=0A=
@@ -48,11 +56,14 @@ static const int PROC_LINK_COUNT =3D (size=0A=
 /* FH_PROC in the table below means the file/directory is handles by=0A=
  * fhandler_proc.=0A=
  */=0A=
-static const DWORD proc_fhandlers[] =3D {=0A=
+static const DWORD proc_fhandlers[PROC_LINK_COUNT] =3D {=0A=
+  FH_PROC,=0A=
+  FH_PROC,=0A=
   FH_PROC,=0A=
   FH_PROC,=0A=
   FH_REGISTRY,=0A=
   FH_PROC,=0A=
+  FH_PROC,=0A=
   FH_PROC=0A=
 };=0A=
=20=0A=
@@ -60,6 +71,10 @@ static const DWORD proc_fhandlers[] =3D {=0A=
 const char proc[] =3D "/proc";=0A=
 const int proc_len =3D sizeof (proc) - 1;=0A=
=20=0A=
+static off_t format_proc_meminfo (char *destbuf, size_t maxsize);=0A=
+static off_t format_proc_stat (char *destbuf, size_t maxsize);=0A=
+static off_t format_proc_uptime (char *destbuf, size_t maxsize);=0A=
+=0A=
 /* auxillary function that returns the fhandler associated with the given =
path=0A=
  * this is where it would be nice to have pattern matching in C - polymorp=
hism=0A=
  * just doesn't cut it=0A=
@@ -291,44 +306,216 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
       res =3D 0;=0A=
       goto out;=0A=
     }=0A=
-  switch (proc_file_no)=0A=
+=0A=
+  fileid =3D proc_file_no;=0A=
+  fill_filebuf ();=0A=
+=0A=
+  if (flags & O_APPEND)=0A=
+    position =3D filesize;=0A=
+  else=0A=
+    position =3D 0;=0A=
+=0A=
+success:=0A=
+  res =3D 1;=0A=
+  set_open_status ();=0A=
+  set_flags (flags);=0A=
+out:=0A=
+  syscall_printf ("%d =3D fhandler_proc::open (%p, %d)", res, flags, mode)=
;=0A=
+  return res;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_proc::fill_filebuf ()=0A=
+{=0A=
+  switch (fileid)=0A=
     {=0A=
     case PROC_VERSION:=0A=
       {=0A=
+        if (!filebuf)=0A=
+          {=0A=
         struct utsname uts_name;=0A=
         uname (&uts_name);=0A=
-        filesize =3D bufalloc =3D strlen (uts_name.sysname) + 1 +=0A=
-          strlen (uts_name.release) + 1 + strlen (uts_name.version) + 2;=
=0A=
+            bufalloc =3D strlen (uts_name.sysname) + 1 + strlen (uts_name.=
release) +=0A=
+                      1 + strlen (uts_name.version) + 2;=0A=
         filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc);=0A=
-        __small_sprintf (filebuf, "%s %s %s\n", uts_name.sysname,=0A=
+            filesize =3D __small_sprintf (filebuf, "%s %s %s\n", uts_name.=
sysname,=0A=
                          uts_name.release, uts_name.version);=0A=
+          }=0A=
         break;=0A=
       }=0A=
     case PROC_UPTIME:=0A=
       {=0A=
-        /* GetTickCount() wraps after 49 days - on WinNT/2000/XP, should u=
se=0A=
-         * perfomance counters but I don't know Redhat's policy on=0A=
-         * NT only dependancies.=0A=
+        if (!filebuf)=0A=
+          filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 80);=0A=
+        filesize =3D format_proc_uptime (filebuf, bufalloc);=0A=
+        break;=0A=
+      }=0A=
+    case PROC_STAT:=0A=
+      {=0A=
+        if (!filebuf)=0A=
+          filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 2048);=0A=
+        filesize =3D format_proc_stat (filebuf, bufalloc);=0A=
+        break;=0A=
+      }=0A=
+    case PROC_LOADAVG:=0A=
+      {=0A=
+        /*=0A=
+         * not really supported - Windows doesn't keep track of these valu=
es=0A=
+         * Windows 95/98/me does have the KERNEL/CPUUsage performance coun=
ter=0A=
+         * which is similar.=0A=
          */=0A=
-        DWORD ticks =3D GetTickCount ();=0A=
-        filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 40);=0A=
-        __small_sprintf (filebuf, "%d.%02d\n", ticks / 1000,=0A=
-                         (ticks / 10) % 100);=0A=
-        filesize =3D strlen (filebuf);=0A=
+        if (!filebuf)=0A=
+          filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 16);=0A=
+        filesize =3D __small_sprintf (filebuf, "%u.%02u %u.%02u %u.%02u",=
=0A=
+                                    0, 0, 0, 0, 0, 0);=0A=
+        break;=0A=
+      }=0A=
+    case PROC_MEMINFO:=0A=
+      {=0A=
+        if (!filebuf)=0A=
+          filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 2048);=0A=
+        filesize =3D format_proc_meminfo (filebuf, bufalloc);=0A=
         break;=0A=
       }=0A=
     }=0A=
+}=0A=
=20=0A=
-  if (flags & O_APPEND)=0A=
-    position =3D filesize;=0A=
+static=0A=
+off_t=0A=
+format_proc_meminfo (char *destbuf, size_t maxsize)=0A=
+{=0A=
+  unsigned long mem_total =3D 0UL, mem_free =3D 0UL, swap_total =3D 0UL,=
=0A=
+                swap_free =3D 0UL;=0A=
+  MEMORYSTATUS memory_status;=0A=
+  GlobalMemoryStatus (&memory_status);=0A=
+  mem_total =3D memory_status.dwTotalPhys;=0A=
+  mem_free =3D memory_status.dwAvailPhys;=0A=
+  swap_total =3D memory_status.dwTotalPageFile;=0A=
+  swap_free =3D memory_status.dwAvailPageFile;=0A=
+  return __small_sprintf (destbuf, "         total:      used:      free:\=
n"=0A=
+                                   "Mem:  %10lu %10lu %10lu\n"=0A=
+                                   "Swap: %10lu %10lu %10lu\n"=0A=
+                                   "MemTotal:     %10lu kB\n"=0A=
+                                   "MemFree:      %10lu kB\n"=0A=
+                                   "MemShared:             0 kB\n"=0A=
+                                   "HighTotal:             0 kB\n"=0A=
+                                   "HighFree:              0 kB\n"=0A=
+                                   "LowTotal:     %10lu kB\n"=0A=
+                                   "LowFree:      %10lu kB\n"=0A=
+                                   "SwapTotal:    %10lu kB\n"=0A=
+                                   "SwapFree:     %10lu kB\n",=0A=
+                                   mem_total, mem_total - mem_free, mem_fr=
ee,=0A=
+                                   swap_total, swap_total - swap_free, swa=
p_free,=0A=
+                                   mem_total >> 10, mem_free >> 10,=0A=
+                                   mem_total >> 10, mem_free >> 10,=0A=
+                                   swap_total >> 10, swap_free >> 10);=0A=
+}=0A=
+=0A=
+static=0A=
+off_t=0A=
+format_proc_uptime (char *destbuf, size_t maxsize)=0A=
+{=0A=
+  unsigned long long uptime =3D 0ULL, idle_time =3D 0ULL;=0A=
+  if (wincap.is_winnt ())=0A=
+    {=0A=
+      NTSTATUS ret;=0A=
+      SYSTEM_PROCESSOR_TIMES spt;=0A=
+      ret =3D ZwQuerySystemInformation (SystemProcessorTimes,=0A=
+                                      (PVOID) &spt,=0A=
+                                      sizeof spt, NULL);=0A=
+      if (ret !=3D STATUS_SUCCESS)=0A=
+        {=0A=
+          __seterrno_from_win_error (RtlNtStatusToDosError (ret));=0A=
+          debug_printf("NtQuerySystemInformation: ret =3D %d, "=0A=
+                       "Dos(ret) =3D %d",=0A=
+                       ret, RtlNtStatusToDosError (ret));=0A=
+          return 0;=0A=
+        }=0A=
+      idle_time =3D spt.IdleTime.QuadPart / 100000ULL;=0A=
+      uptime =3D (spt.InterruptTime.QuadPart + spt.KernelTime.QuadPart +=
=0A=
+                spt.IdleTime.QuadPart + spt.UserTime.QuadPart +=0A=
+                spt.DpcTime.QuadPart) / 100000ULL;=0A=
+    }=0A=
   else=0A=
-    position =3D 0;=0A=
+    {=0A=
+      uptime =3D GetTickCount() / 10;=0A=
+    }=0A=
+  return __small_sprintf (destbuf, "%U.%02u %U.%02u\n",=0A=
+                          uptime / 100, long (uptime % 100),=0A=
+                          idle_time / 100, long (idle_time % 100));=0A=
+}=0A=
=20=0A=
-success:=0A=
-  res =3D 1;=0A=
-  set_open_status ();=0A=
-  set_flags (flags);=0A=
-out:=0A=
-  syscall_printf ("%d =3D fhandler_proc::open (%p, %d)", res, flags, mode)=
;=0A=
-  return res;=0A=
+static=0A=
+off_t=0A=
+format_proc_stat (char *destbuf, size_t maxsize)=0A=
+{=0A=
+  unsigned long long user_time =3D 0ULL, kernel_time =3D 0ULL, idle_time =
=3D 0ULL;=0A=
+  unsigned long pages_in =3D 0UL, pages_out =3D 0UL, interrupt_count =3D 0=
UL,=0A=
+                context_switches =3D 0UL, swap_in =3D 0UL, swap_out =3D 0U=
L;=0A=
+  time_t boot_time =3D 0;=0A=
+=0A=
+  if (wincap.is_winnt ())=0A=
+    {=0A=
+      NTSTATUS ret;=0A=
+      SYSTEM_PROCESSOR_TIMES spt;=0A=
+      SYSTEM_PERFORMANCE_INFORMATION spi;=0A=
+      SYSTEM_TIME_OF_DAY_INFORMATION stodi;=0A=
+      ret =3D ZwQuerySystemInformation (SystemProcessorTimes,=0A=
+                                      (PVOID) &spt,=0A=
+                                      sizeof spt, NULL);=0A=
+      if (ret =3D=3D STATUS_SUCCESS)=0A=
+        ret =3D ZwQuerySystemInformation (SystemPerformanceInformation,=0A=
+                                        (PVOID) &spi,=0A=
+                                        sizeof spi, NULL);=0A=
+      if (ret =3D=3D STATUS_SUCCESS)=0A=
+        ret =3D ZwQuerySystemInformation (SystemTimeOfDayInformation,=0A=
+                                        (PVOID) &stodi,=0A=
+                                        sizeof stodi, NULL);=0A=
+      if (ret !=3D STATUS_SUCCESS)=0A=
+        {=0A=
+          __seterrno_from_win_error (RtlNtStatusToDosError (ret));=0A=
+          debug_printf("NtQuerySystemInformation: ret =3D %d, "=0A=
+                       "Dos(ret) =3D %d",=0A=
+                       ret, RtlNtStatusToDosError (ret));=0A=
+          return 0;=0A=
+        }=0A=
+      kernel_time =3D (spt.KernelTime.QuadPart + spt.InterruptTime.QuadPar=
t + spt.DpcTime.QuadPart) / 100000ULL;=0A=
+      user_time =3D spt.UserTime.QuadPart / 100000ULL;=0A=
+      idle_time =3D spt.IdleTime.QuadPart / 100000ULL;=0A=
+      interrupt_count =3D spt.InterruptCount;=0A=
+      pages_in =3D spi.PagesRead;=0A=
+      pages_out =3D spi.PagefilePagesWritten + spi.MappedFilePagesWritten;=
=0A=
+      /*=0A=
+       * Note: there is no distinction made in this structure between page=
s=0A=
+       * read from the page file and pages read from mapped files, but the=
re=0A=
+       * is such a distinction made when it comes to writing. Goodness kno=
ws=0A=
+       * why. The value of swap_in, then, will obviously be wrong but its =
our=0A=
+       * best guess.=0A=
+       */=0A=
+      swap_in =3D spi.PagesRead;=0A=
+      swap_out =3D spi.PagefilePagesWritten;=0A=
+      context_switches =3D spi.ContextSwitches;=0A=
+      boot_time =3D to_time_t ((FILETIME *) &stodi.BootTime.QuadPart);=0A=
+    }=0A=
+  /*=0A=
+   * else=0A=
+   *   {=0A=
+   * There are only two relevant performance counters on Windows 95/98/me,=
=0A=
+   * VMM/cPageIns and VMM/cPageOuts. The extra effort needed to read these=
=0A=
+   * counters is by no means worth it.=0A=
+   *   }=0A=
+   */=0A=
+  return __small_sprintf (destbuf, "cpu %U %U %U %U\n"=0A=
+                                   "page %u %u\n"=0A=
+                                   "swap %u %u\n"=0A=
+                                   "intr %u\n"=0A=
+                                   "ctxt %u\n"=0A=
+                                   "btime %u\n",=0A=
+                          user_time, 0ULL,=0A=
+                          kernel_time, idle_time,=0A=
+                          pages_in, pages_out,=0A=
+                          swap_in, swap_out,=0A=
+                          interrupt_count,=0A=
+                          context_switches,=0A=
+                          boot_time);=0A=
 }=0A=
Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.4=0A=
diff -u -3 -p -u -p -b -B -r1.4 fhandler_process.cc=0A=
--- fhandler_process.cc	4 May 2002 03:24:35 -0000	1.4=0A=
+++ fhandler_process.cc	9 May 2002 23:14:42 -0000=0A=
@@ -14,6 +14,7 @@ details. */=0A=
 #include <unistd.h>=0A=
 #include <stdlib.h>=0A=
 #include <sys/cygwin.h>=0A=
+#include <ntdef.h>=0A=
 #include "cygerrno.h"=0A=
 #include "security.h"=0A=
 #include "fhandler.h"=0A=
@@ -23,6 +24,7 @@ details. */=0A=
 #include "shared_info.h"=0A=
 #include "dtable.h"=0A=
 #include "cygheap.h"=0A=
+#include "ntdll.h"=0A=
 #include <assert.h>=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
@@ -38,6 +40,8 @@ static const int PROCESS_GID =3D 8;=0A=
 static const int PROCESS_PGID =3D 9;=0A=
 static const int PROCESS_SID =3D 10;=0A=
 static const int PROCESS_CTTY =3D 11;=0A=
+static const int PROCESS_STAT =3D 12;=0A=
+static const int PROCESS_STATM =3D 13;=0A=
=20=0A=
 static const char *process_listing[] =3D {=0A=
   ".",=0A=
@@ -52,11 +56,20 @@ static const char *process_listing[] =3D {=0A=
   "pgid",=0A=
   "sid",=0A=
   "ctty",=0A=
+  "stat",=0A=
+  "statm",=0A=
   NULL=0A=
 };=0A=
=20=0A=
 static const int PROCESS_LINK_COUNT =3D (sizeof(process_listing) / sizeof(=
const char *)) - 1;=0A=
=20=0A=
+static off_t format_process_stat (_pinfo *p, char *destbuf, size_t maxsize=
);=0A=
+static off_t format_process_status (_pinfo *p, char *destbuf, size_t maxsi=
ze);=0A=
+static off_t format_process_statm (_pinfo *p, char *destbuf, size_t maxsiz=
e);=0A=
+static int get_process_state (DWORD dwProcessId);=0A=
+static bool get_mem_values(DWORD dwProcessId, unsigned long *vmsize, unsig=
ned long *vmrss, unsigned long *vmtext,=0A=
+                           unsigned long *vmdata, unsigned long *vmlib, un=
signed long *vmshare);=0A=
+=0A=
 /* Returns 0 if path doesn't exist, >0 if path is a directory,=0A=
  * <0 if path is a file.=0A=
  */=0A=
@@ -84,8 +97,26 @@ fhandler_process::fhandler_process ():=0A=
 int=0A=
 fhandler_process::fstat (struct __stat64 *buf, path_conv *pc)=0A=
 {=0A=
-  int file_type =3D exists (get_name ());=0A=
+  const char *path =3D get_name ();=0A=
+  int file_type =3D exists (path);=0A=
   (void) fhandler_base::fstat (buf, pc);=0A=
+  path +=3D proc_len + 1;=0A=
+  int pid =3D atoi (path);=0A=
+  winpids pids;=0A=
+  _pinfo *p;=0A=
+  for (unsigned i =3D 0; i < pids.npids; i++)=0A=
+    {=0A=
+      p =3D pids[i];=0A=
+=0A=
+      if (!proc_exists (p))=0A=
+        continue;=0A=
+=0A=
+      if (p->pid =3D=3D pid)=0A=
+        goto found;=0A=
+    }=0A=
+  set_errno(ENOENT);=0A=
+  return -1;=0A=
+found:=0A=
   buf->st_mode &=3D ~_IFMT & NO_W;=0A=
=20=0A=
   switch (file_type)=0A=
@@ -97,12 +128,18 @@ fhandler_process::fstat (struct __stat64=0A=
       buf->st_mode |=3D S_IFDIR | S_IXUSR | S_IXGRP | S_IXOTH;=0A=
       return 0;=0A=
     case 2:=0A=
+      buf->st_ctime =3D buf->st_mtime =3D p->start_time;=0A=
+      buf->st_atime =3D time(NULL);=0A=
+      buf->st_uid =3D p->uid;=0A=
+      buf->st_gid =3D p->gid;=0A=
       buf->st_mode |=3D S_IFDIR | S_IXUSR | S_IXGRP | S_IXOTH;=0A=
       buf->st_nlink =3D PROCESS_LINK_COUNT;=0A=
       return 0;=0A=
     default:=0A=
     case -1:=0A=
-      buf->st_mode |=3D S_IFREG;=0A=
+      buf->st_uid =3D p->uid;=0A=
+      buf->st_gid =3D p->gid;=0A=
+      buf->st_mode |=3D S_IFREG | S_IRUSR | S_IRGRP | S_IROTH;=0A=
       return 0;=0A=
     }=0A=
 }=0A=
@@ -198,7 +235,36 @@ fhandler_process::open (path_conv *pc, i=0A=
   res =3D 0;=0A=
   goto out;=0A=
 found:=0A=
-  switch (process_file_no)=0A=
+  fileid =3D process_file_no;=0A=
+  saved_pid =3D pid;=0A=
+  saved_p =3D p;=0A=
+  fill_filebuf ();=0A=
+=0A=
+  if (flags & O_APPEND)=0A=
+    position =3D filesize;=0A=
+  else=0A=
+    position =3D 0;=0A=
+=0A=
+success:=0A=
+  res =3D 1;=0A=
+  set_open_status ();=0A=
+  set_flags (flags);=0A=
+out:=0A=
+  syscall_printf ("%d =3D fhandler_proc::open (%p, %d)", res, flags, mode)=
;=0A=
+  return res;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_process::fill_filebuf ()=0A=
+{=0A=
+  // has this process gone away?=0A=
+  if (!proc_exists (saved_p) || saved_p->pid !=3D saved_pid)=0A=
+    {=0A=
+      if (filebuf)=0A=
+        cfree(filebuf);=0A=
+      filesize =3D 0; bufalloc =3D (size_t) -1;=0A=
+    }=0A=
+  switch (fileid)=0A=
     {=0A=
     case PROCESS_UID:=0A=
     case PROCESS_GID:=0A=
@@ -207,25 +273,31 @@ found:=0A=
     case PROCESS_CTTY:=0A=
     case PROCESS_PPID:=0A=
       {=0A=
+        if (!filebuf)=0A=
         filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 40);=0A=
         int num;=0A=
-        switch (process_file_no)=0A=
+        switch (fileid)=0A=
           {=0A=
           case PROCESS_PPID:=0A=
-            num =3D p->ppid;=0A=
+            num =3D saved_p->ppid;=0A=
             break;=0A=
           case PROCESS_UID:=0A=
-            num =3D p->uid;=0A=
+            num =3D saved_p->uid;=0A=
             break;=0A=
           case PROCESS_PGID:=0A=
-            num =3D p->pgid;=0A=
+            num =3D saved_p->pgid;=0A=
             break;=0A=
           case PROCESS_SID:=0A=
-            num =3D p->sid;=0A=
+            num =3D saved_p->sid;=0A=
+            break;=0A=
+          case PROCESS_GID:=0A=
+            num =3D saved_p->gid;=0A=
             break;=0A=
-	  default:=0A=
           case PROCESS_CTTY:=0A=
-            num =3D p->ctty;=0A=
+            num =3D saved_p->ctty;=0A=
+            break;=0A=
+          default: // what's this here for?=0A=
+            num =3D 0;=0A=
             break;=0A=
           }=0A=
         __small_sprintf (filebuf, "%d\n", num);=0A=
@@ -234,12 +306,13 @@ found:=0A=
       }=0A=
     case PROCESS_EXENAME:=0A=
       {=0A=
+        if (!filebuf)=0A=
         filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D MAX_PATH);=0A=
-        if (p->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
+        if (saved_p->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
           strcpy (filebuf, "<defunct>");=0A=
         else=0A=
           {=0A=
-            mount_table->conv_to_posix_path (p->progname, filebuf, 1);=0A=
+            mount_table->conv_to_posix_path (saved_p->progname, filebuf, 1=
);=0A=
             int len =3D strlen (filebuf);=0A=
             if (len > 4)=0A=
               {=0A=
@@ -253,47 +326,428 @@ found:=0A=
       }=0A=
     case PROCESS_WINPID:=0A=
       {=0A=
+        if (!filebuf)=0A=
         filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 40);=0A=
-        __small_sprintf (filebuf, "%d\n", p->dwProcessId);=0A=
+        __small_sprintf (filebuf, "%d\n", saved_p->dwProcessId);=0A=
         filesize =3D strlen (filebuf);=0A=
         break;=0A=
       }=0A=
     case PROCESS_WINEXENAME:=0A=
       {=0A=
-        int len =3D strlen (p->progname);=0A=
+        int len =3D strlen (saved_p->progname);=0A=
+        if (!filebuf)=0A=
         filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D (len + 2));=
=0A=
-        strcpy (filebuf, p->progname);=0A=
+        strcpy (filebuf, saved_p->progname);=0A=
         filebuf[len] =3D '\n';=0A=
         filesize =3D len + 1;=0A=
         break;=0A=
       }=0A=
     case PROCESS_STATUS:=0A=
       {=0A=
-        filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 3);=0A=
-        filebuf[0] =3D ' ';=0A=
-        filebuf[1] =3D '\n';=0A=
-        filebuf[2] =3D 0;=0A=
-        if (p->process_state & PID_STOPPED)=0A=
-          filebuf[0] =3D 'S';=0A=
-        else if (p->process_state & PID_TTYIN)=0A=
-          filebuf[0] =3D 'I';=0A=
-        else if (p->process_state & PID_TTYOU)=0A=
-          filebuf[0] =3D 'O';=0A=
-        filesize =3D 2;=0A=
+        if (!filebuf)=0A=
+          filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 2048);=0A=
+        filesize =3D format_process_status (saved_p, filebuf, bufalloc);=
=0A=
         break;=0A=
       }=0A=
+    case PROCESS_STAT:=0A=
+      {=0A=
+        if (!filebuf)=0A=
+          filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 2048);=0A=
+        filesize =3D format_process_stat (saved_p, filebuf, bufalloc);=0A=
+        break;=0A=
+      }=0A=
+    case PROCESS_STATM:=0A=
+      {=0A=
+        if (!filebuf)=0A=
+          filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 2048);=0A=
+        filesize =3D format_process_statm (saved_p, filebuf, bufalloc);=0A=
+        break;=0A=
     }=0A=
+    }=0A=
+}=0A=
=20=0A=
-  if (flags & O_APPEND)=0A=
-    position =3D filesize;=0A=
+static=0A=
+off_t=0A=
+format_process_stat (_pinfo *p, char *destbuf, size_t maxsize)=0A=
+{=0A=
+  char cmd[MAX_PATH];=0A=
+  int state =3D 'R';=0A=
+  unsigned long fault_count =3D 0UL,=0A=
+                utime =3D 0UL, stime =3D 0UL,=0A=
+                start_time =3D 0UL,=0A=
+                vmsize =3D 0UL, vmrss =3D 0UL, vmmaxrss =3D 0UL;=0A=
+  int priority =3D 0;=0A=
+  if (p->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
+    strcpy (cmd, "<defunct");=0A=
   else=0A=
-    position =3D 0;=0A=
+    {=0A=
+      strcpy(cmd, p->progname);=0A=
+      char *last_slash =3D strrchr (cmd, '\\');=0A=
+      if (last_slash !=3D NULL)=0A=
+        strcpy (cmd, last_slash + 1);=0A=
+      int len =3D strlen (cmd);=0A=
+      if (len > 4)=0A=
+        {=0A=
+          char *s =3D cmd + len - 4;=0A=
+          if (strcasecmp (s, ".exe") =3D=3D 0)=0A=
+            *s =3D 0;=0A=
+         }=0A=
+    }=0A=
+  /*=0A=
+   * Note: under Windows, a _process_ is always running - it's only _threa=
ds_=0A=
+   * that get suspended. Therefore the default state is R (runnable).=0A=
+   */=0A=
+  if (p->process_state & PID_ZOMBIE)=0A=
+    state =3D 'Z';=0A=
+  else if (p->process_state & PID_STOPPED)=0A=
+    state =3D 'T';=0A=
+  else if (wincap.is_winnt ())=0A=
+    state =3D get_process_state (p->dwProcessId);=0A=
+ if (wincap.is_winnt ())=0A=
+    {=0A=
+      NTSTATUS ret;=0A=
+      HANDLE hProcess;=0A=
+      VM_COUNTERS vmc;=0A=
+      KERNEL_USER_TIMES put;=0A=
+      PROCESS_BASIC_INFORMATION pbi;=0A=
+      QUOTA_LIMITS ql;=0A=
+      SYSTEM_TIME_OF_DAY_INFORMATION stodi;=0A=
+      SYSTEM_PROCESSOR_TIMES spt;=0A=
+      hProcess =3D OpenProcess (PROCESS_VM_READ | PROCESS_QUERY_INFORMATIO=
N,=0A=
+                              FALSE, p->dwProcessId);=0A=
+      if (hProcess !=3D NULL)=0A=
+        {=0A=
+          ret =3D ZwQueryInformationProcess (hProcess,=0A=
+                                           ProcessVmCounters,=0A=
+                                           (PVOID) &vmc,=0A=
+                                           sizeof vmc, NULL);=0A=
+          if (ret =3D=3D STATUS_SUCCESS)=0A=
+            ret =3D ZwQueryInformationProcess (hProcess,=0A=
+                                             ProcessTimes,=0A=
+                                             (PVOID) &put,=0A=
+                                             sizeof put, NULL);=0A=
+          if (ret =3D=3D STATUS_SUCCESS)=0A=
+            ret =3D ZwQueryInformationProcess (hProcess,=0A=
+                                             ProcessBasicInformation,=0A=
+                                             (PVOID) &pbi,=0A=
+                                             sizeof pbi, NULL);=0A=
+          if (ret =3D=3D STATUS_SUCCESS)=0A=
+            ret =3D ZwQueryInformationProcess (hProcess,=0A=
+                                             ProcessQuotaLimits,=0A=
+                                             (PVOID) &ql,=0A=
+                                             sizeof ql, NULL);=0A=
+          CloseHandle (hProcess);=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          DWORD error =3D GetLastError ();=0A=
+          __seterrno_from_win_error (error);=0A=
+          debug_printf("OpenProcess: ret =3D %d",=0A=
+                        error);=0A=
+          return 0;=0A=
+        }=0A=
+      if (ret =3D=3D STATUS_SUCCESS)=0A=
+        ret =3D ZwQuerySystemInformation (SystemTimeOfDayInformation,=0A=
+                                        (PVOID) &stodi,=0A=
+                                        sizeof stodi, NULL);=0A=
+      if (ret =3D=3D STATUS_SUCCESS)=0A=
+        ret =3D ZwQuerySystemInformation (SystemProcessorTimes,=0A=
+                                        (PVOID) &spt,=0A=
+                                        sizeof spt, NULL);=0A=
+      if (ret !=3D STATUS_SUCCESS)=0A=
+        {=0A=
+          __seterrno_from_win_error (RtlNtStatusToDosError (ret));=0A=
+          debug_printf("NtQueryInformationProcess: ret =3D %d, "=0A=
+                       "Dos(ret) =3D %d",=0A=
+                       ret, RtlNtStatusToDosError (ret));=0A=
+          return 0;=0A=
+        }=0A=
+       fault_count =3D vmc.PageFaultCount;=0A=
+       utime =3D put.UserTime.QuadPart / 100000ULL;=0A=
+       stime =3D put.KernelTime.QuadPart / 100000ULL;=0A=
+       if (stodi.CurrentTime.QuadPart > put.CreateTime.QuadPart)=0A=
+         start_time =3D (spt.InterruptTime.QuadPart + spt.KernelTime.QuadP=
art +=0A=
+                       spt.IdleTime.QuadPart + spt.UserTime.QuadPart +=0A=
+                       spt.DpcTime.QuadPart - stodi.CurrentTime.QuadPart +=
=0A=
+                       put.CreateTime.QuadPart) / 100000ULL;=0A=
+       else=0A=
+         /*=0A=
+          * sometimes stodi.CurrentTime is a bit behind=0A=
+          * Note: some older versions of procps are broken and can't cope=
=0A=
+          * with process start times > time(NULL).=0A=
+          */=0A=
+         start_time =3D (spt.InterruptTime.QuadPart + spt.KernelTime.QuadP=
art +=0A=
+                       spt.IdleTime.QuadPart + spt.UserTime.QuadPart +=0A=
+                       spt.DpcTime.QuadPart) / 100000ULL;=0A=
+       priority =3D pbi.BasePriority;=0A=
+       unsigned page_size =3D getpagesize();=0A=
+       vmsize =3D vmc.VirtualSize;=0A=
+       vmrss =3D vmc.WorkingSetSize / page_size;=0A=
+       vmmaxrss =3D ql.MaximumWorkingSetSize / page_size;=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      start_time =3D (GetTickCount() / 1000 - time(NULL) + p->start_time) =
* 100;=0A=
+    }=0A=
+  return __small_sprintf (destbuf, "%d (%s) %c "=0A=
+                                   "%d %d %d %d %d "=0A=
+                                   "%lu %lu %lu %lu %lu %lu %lu "=0A=
+                                   "%ld %ld %ld %ld %ld %ld "=0A=
+                                   "%lu %lu "=0A=
+                                   "%ld "=0A=
+                                   "%lu",=0A=
+                          p->pid, cmd,=0A=
+                          state,=0A=
+                          p->ppid, p->pgid, p->sid, p->ctty, -1,=0A=
+                          0, fault_count, fault_count, 0, 0, utime, stime,=
=0A=
+                          utime, stime, priority, 0, 0, 0,=0A=
+                          start_time, vmsize,=0A=
+                          vmrss, vmmaxrss=0A=
+                          );=0A=
+}=0A=
=20=0A=
-success:=0A=
-  res =3D 1;=0A=
-  set_open_status ();=0A=
-  set_flags (flags);=0A=
+static=0A=
+off_t=0A=
+format_process_status (_pinfo *p, char *destbuf, size_t maxsize)=0A=
+{=0A=
+  char cmd[MAX_PATH];=0A=
+  int state =3D 'R';=0A=
+  const char *state_str =3D "unknown";=0A=
+  unsigned long vmsize =3D 0UL, vmrss =3D 0UL, vmdata =3D 0UL, vmlib =3D 0=
UL, vmtext =3D 0UL,=0A=
+                vmshare =3D 0UL;=0A=
+  if (p->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
+    strcpy (cmd, "<defunct>");=0A=
+  else=0A=
+    {=0A=
+      strcpy(cmd, p->progname);=0A=
+      char *last_slash =3D strrchr (cmd, '\\');=0A=
+      if (last_slash !=3D NULL)=0A=
+        strcpy (cmd, last_slash + 1);=0A=
+      int len =3D strlen (cmd);=0A=
+      if (len > 4)=0A=
+        {=0A=
+          char *s =3D cmd + len - 4;=0A=
+          if (strcasecmp (s, ".exe") =3D=3D 0)=0A=
+            *s =3D 0;=0A=
+         }=0A=
+    }=0A=
+  /*=0A=
+   * Note: under Windows, a _process_ is always running - it's only _threa=
ds_=0A=
+   * that get suspended. Therefore the default state is R (runnable).=0A=
+   */=0A=
+  if (p->process_state & PID_ZOMBIE)=0A=
+    state =3D 'Z';=0A=
+  else if (p->process_state & PID_STOPPED)=0A=
+    state =3D 'T';=0A=
+  else if (wincap.is_winnt ())=0A=
+    state =3D get_process_state (p->dwProcessId);=0A=
+  switch (state)=0A=
+    {=0A=
+    case 'O':=0A=
+      state_str =3D "running";=0A=
+      break;=0A=
+    case 'D':=0A=
+    case 'S':=0A=
+      state_str =3D "sleeping";=0A=
+      break;=0A=
+    case 'R':=0A=
+      state_str =3D "runnable";=0A=
+      break;=0A=
+    case 'Z':=0A=
+      state_str =3D "zombie";=0A=
+      break;=0A=
+    case 'T':=0A=
+      state_str =3D "stopped";=0A=
+      break;=0A=
+    }=0A=
+  if (wincap.is_winnt ())=0A=
+    {=0A=
+      if (!get_mem_values (p->dwProcessId, &vmsize, &vmrss, &vmtext, &vmda=
ta, &vmlib, &vmshare))=0A=
+        return 0;=0A=
+      unsigned page_size =3D getpagesize();=0A=
+      vmsize *=3D page_size; vmrss *=3D page_size; vmdata *=3D page_size;=
=0A=
+      vmtext *=3D page_size; vmlib *=3D page_size;=0A=
+    }=0A=
+  return __small_sprintf (destbuf, "Name:   %s\n"=0A=
+                                   "State:  %c (%s)\n"=0A=
+                                   "Tgid:   %d\n"=0A=
+                                   "Pid:    %d\n"=0A=
+                                   "PPid:   %d\n"=0A=
+                                   "Uid:    %d %d %d %d\n"=0A=
+                                   "Gid:    %d %d %d %d\n"=0A=
+                                   "VmSize: %8d kB\n"=0A=
+                                   "VmLck:  %8d kB\n"=0A=
+                                   "VmRSS:  %8d kB\n"=0A=
+                                   "VmData: %8d kB\n"=0A=
+                                   "VmStk:  %8d kB\n"=0A=
+                                   "VmExe:  %8d kB\n"=0A=
+                                   "VmLib:  %8d kB\n"=0A=
+                                   "SigPnd: %016x\n"=0A=
+                                   "SigBlk: %016x\n"=0A=
+                                   "SigIgn: %016x\n",=0A=
+                          cmd,=0A=
+                          state, state_str,=0A=
+                          p->pgid,=0A=
+                          p->pid,=0A=
+                          p->ppid,=0A=
+                          p->uid, cygheap->user.real_uid, cygheap->user.re=
al_uid, p->uid,=0A=
+                          p->gid, cygheap->user.real_gid, cygheap->user.re=
al_gid, p->gid,=0A=
+                          vmsize >> 10, 0, vmrss >> 10, vmdata >> 10, 0, v=
mtext >> 10, vmlib >> 10,=0A=
+                          0, 0, p->getsigmask ()=0A=
+                          );=0A=
+}=0A=
+=0A=
+static=0A=
+off_t=0A=
+format_process_statm (_pinfo *p, char *destbuf, size_t maxsize)=0A=
+{=0A=
+  unsigned long vmsize =3D 0UL, vmrss =3D 0UL, vmtext =3D 0UL, vmdata =3D =
0UL, vmlib =3D 0UL,=0A=
+                vmshare =3D 0UL;=0A=
+  if (wincap.is_winnt ())=0A=
+    {=0A=
+      if (!get_mem_values (p->dwProcessId, &vmsize, &vmrss, &vmtext, &vmda=
ta, &vmlib, &vmshare))=0A=
+        return 0;=0A=
+    }=0A=
+  return __small_sprintf (destbuf, "%ld %ld %ld %ld %ld %ld %ld",=0A=
+                          vmsize, vmrss, vmshare, vmtext, vmlib, vmdata, 0=
=0A=
+                          );=0A=
+}=0A=
+=0A=
+static=0A=
+int=0A=
+get_process_state (DWORD dwProcessId)=0A=
+{=0A=
+  /*=0A=
+   * This isn't really heavy magic - just go through the processes'=0A=
+   * threads one by one and return a value accordingly=0A=
+   * Errors are silently ignored.=0A=
+   */=0A=
+  NTSTATUS ret;=0A=
+  SYSTEM_PROCESSES *sp;=0A=
+  ULONG n =3D 0x1000;=0A=
+  PULONG p =3D new ULONG[n];=0A=
+  int state =3D' ';=0A=
+  while (STATUS_INFO_LENGTH_MISMATCH =3D=3D=0A=
+         (ret =3D ZwQuerySystemInformation (SystemProcessesAndThreadsInfor=
mation,=0A=
+                                         (PVOID) p,=0A=
+                                         n * sizeof *p, NULL)))=0A=
+    delete [] p, p =3D new ULONG[n *=3D 2];=0A=
+  if (ret !=3D STATUS_SUCCESS)=0A=
+    {=0A=
+      debug_printf("NtQuerySystemInformation: ret =3D %d, "=0A=
+                   "Dos(ret) =3D %d",=0A=
+                   ret, RtlNtStatusToDosError (ret));=0A=
+      goto out;=0A=
+    }=0A=
+  state =3D 'Z';=0A=
+  sp =3D (SYSTEM_PROCESSES *) p;=0A=
+  for (;;)=0A=
+    {=0A=
+      if (sp->ProcessId =3D=3D dwProcessId)=0A=
+        {=0A=
+          SYSTEM_THREADS *st;=0A=
+          if (wincap.has_process_io_counters ())=0A=
+            /*=0A=
+             * Windows 2000 and XP have an extra member in SYSTEM_PROCESSE=
S=0A=
+             * which means the offset of the first SYSTEM_THREADS entry is=
=0A=
+             * different on these operating systems compared to NT 4.=0A=
+             */=0A=
+            st =3D &sp->Threads[0];=0A=
+          else=0A=
+            /*=0A=
+             * 136 is the offset of the first SYSTEM_THREADS entry on=0A=
+             * Windows NT 4.=0A=
+             */=0A=
+            st =3D (SYSTEM_THREADS *) ((char *) sp + 136);=0A=
+          state =3D 'S';=0A=
+          for (unsigned i =3D 0; i < sp->ThreadCount; i++)=0A=
+            {=0A=
+              if (st->State =3D=3D StateRunning ||=0A=
+                  st->State =3D=3D StateReady)=0A=
+                {=0A=
+                  state =3D 'R';=0A=
+                  goto out;=0A=
+                }=0A=
+              st++;=0A=
+            }=0A=
+          break;=0A=
+        }=0A=
+      if (!sp->NextEntryDelta)=0A=
+         break;=0A=
+      sp =3D (SYSTEM_PROCESSES *) ((char *) sp + sp->NextEntryDelta);=0A=
+    }=0A=
 out:=0A=
-  syscall_printf ("%d =3D fhandler_proc::open (%p, %d)", res, flags, mode)=
;=0A=
+  delete [] p;=0A=
+  return state;=0A=
+}=0A=
+=0A=
+static=0A=
+bool=0A=
+get_mem_values(DWORD dwProcessId, unsigned long *vmsize, unsigned long *vm=
rss, unsigned long *vmtext,=0A=
+               unsigned long *vmdata, unsigned long *vmlib, unsigned long =
*vmshare)=0A=
+{=0A=
+  bool res =3D true;=0A=
+  NTSTATUS ret;=0A=
+  HANDLE hProcess;=0A=
+  VM_COUNTERS vmc;=0A=
+  MEMORY_WORKING_SET_LIST *mwsl;=0A=
+  ULONG n =3D 0x1000, length;=0A=
+  PULONG p =3D new ULONG[n];=0A=
+  unsigned page_size =3D getpagesize();=0A=
+  hProcess =3D OpenProcess (PROCESS_QUERY_INFORMATION,=0A=
+                          FALSE, dwProcessId);=0A=
+  if (hProcess =3D=3D NULL)=0A=
+    {=0A=
+      DWORD error =3D GetLastError();=0A=
+      __seterrno_from_win_error (error);=0A=
+      debug_printf("OpenProcess: ret =3D %d",=0A=
+                    error);=0A=
+      return false;=0A=
+    }=0A=
+  while ((ret =3D ZwQueryVirtualMemory (hProcess, 0,=0A=
+                                      MemoryWorkingSetList,=0A=
+                                      (PVOID) p,=0A=
+                                      n * sizeof *p, &length)),=0A=
+         (ret =3D=3D STATUS_SUCCESS || ret =3D=3D STATUS_INFO_LENGTH_MISMA=
TCH) &&=0A=
+         length >=3D n * sizeof *p)=0A=
+    delete [] p, p =3D new ULONG[n *=3D 2];=0A=
+  if (ret !=3D STATUS_SUCCESS)=0A=
+    {=0A=
+      debug_printf("NtQueryVirtualMemory: ret =3D %d, "=0A=
+                   "Dos(ret) =3D %d",=0A=
+                   ret, RtlNtStatusToDosError (ret));=0A=
+      res =3D false;=0A=
+      goto out;=0A=
+    }=0A=
+  mwsl =3D (MEMORY_WORKING_SET_LIST *) p;=0A=
+  for (unsigned long i =3D 0; i < mwsl->NumberOfPages; i++)=0A=
+    {=0A=
+      ++*vmrss;=0A=
+      unsigned flags =3D mwsl->WorkingSetList[i] & 0x0FFF;=0A=
+      if (flags & (WSLE_PAGE_EXECUTE | WSLE_PAGE_SHAREABLE) =3D=3D (WSLE_P=
AGE_EXECUTE | WSLE_PAGE_SHAREABLE))=0A=
+          ++*vmlib;=0A=
+      else if (flags & WSLE_PAGE_SHAREABLE)=0A=
+          ++*vmshare;=0A=
+      else if (flags & WSLE_PAGE_EXECUTE)=0A=
+          ++*vmtext;=0A=
+      else=0A=
+          ++*vmdata;=0A=
+    }=0A=
+  ret =3D ZwQueryInformationProcess (hProcess,=0A=
+                                   ProcessVmCounters,=0A=
+                                   (PVOID) &vmc,=0A=
+                                   sizeof vmc, NULL);=0A=
+  if (ret !=3D STATUS_SUCCESS)=0A=
+    {=0A=
+      debug_printf("NtQueryInformationProcess: ret =3D %d, "=0A=
+                   "Dos(ret) =3D %d",=0A=
+                   ret, RtlNtStatusToDosError (ret));=0A=
+      res =3D false;=0A=
+      goto out;=0A=
+    }=0A=
+  *vmsize =3D vmc.VirtualSize / page_size;=0A=
+out:=0A=
+  delete [] p;=0A=
+  CloseHandle (hProcess);=0A=
   return res;=0A=
 }=0A=
Index: fhandler_registry.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_registry.cc,v=0A=
retrieving revision 1.3=0A=
diff -u -3 -p -u -p -b -B -r1.3 fhandler_registry.cc=0A=
--- fhandler_registry.cc	4 May 2002 03:24:35 -0000	1.3=0A=
+++ fhandler_registry.cc	9 May 2002 23:14:43 -0000=0A=
@@ -292,7 +292,7 @@ fhandler_registry::telldir (DIR * dir)=0A=
 }=0A=
=20=0A=
 void=0A=
-fhandler_registry::seekdir (DIR * dir, __off32_t loc)=0A=
+fhandler_registry::seekdir (DIR * dir, __off64_t loc)=0A=
 {=0A=
   /* Unfortunately cannot simply set __d_position due to transition from s=
ub-keys to=0A=
    * values.=0A=
@@ -488,6 +488,11 @@ out:=0A=
     RegCloseKey (hKey);=0A=
   syscall_printf ("%d =3D fhandler_registry::open (%p, %d)", res, flags, m=
ode);=0A=
   return res;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_registry::fill_filebuf ()=0A=
+{=0A=
 }=0A=
=20=0A=
 /* Auxillary member function to open registry keys.  */=0A=
Index: fhandler_virtual.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v=0A=
retrieving revision 1.3=0A=
diff -u -3 -p -u -p -b -B -r1.3 fhandler_virtual.cc=0A=
--- fhandler_virtual.cc	4 May 2002 03:24:35 -0000	1.3=0A=
+++ fhandler_virtual.cc	9 May 2002 23:14:44 -0000=0A=
@@ -27,7 +27,8 @@ details. */=0A=
 #include <dirent.h>=0A=
=20=0A=
 fhandler_virtual::fhandler_virtual (DWORD devtype):=0A=
-  fhandler_base (devtype), filebuf (NULL), bufalloc (-1)=0A=
+  fhandler_base (devtype), filebuf (NULL), bufalloc ((size_t) -1),=0A=
+  fileid (-1)=0A=
 {=0A=
 }=0A=
=20=0A=
@@ -89,7 +90,7 @@ __off64_t fhandler_virtual::telldir (DIR=0A=
 }=0A=
=20=0A=
 void=0A=
-fhandler_virtual::seekdir (DIR * dir, __off32_t loc)=0A=
+fhandler_virtual::seekdir (DIR * dir, __off64_t loc)=0A=
 {=0A=
   dir->__d_position =3D loc;=0A=
   return;=0A=
@@ -109,8 +110,13 @@ fhandler_virtual::closedir (DIR * dir)=0A=
 }=0A=
=20=0A=
 __off64_t=0A=
-fhandler_virtual::lseek (__off32_t offset, int whence)=0A=
+fhandler_virtual::lseek (__off64_t offset, int whence)=0A=
 {=0A=
+  /*=0A=
+   * On Linux, when you lseek within a /proc file,=0A=
+   * the contents of the file are updated.=0A=
+   */=0A=
+  fill_filebuf ();=0A=
   switch (whence)=0A=
     {=0A=
     case SEEK_SET:=0A=
@@ -124,7 +130,7 @@ fhandler_virtual::lseek (__off32_t offse=0A=
       break;=0A=
     default:=0A=
       set_errno (EINVAL);=0A=
-      return (__off32_t) -1;=0A=
+      return (__off64_t) -1;=0A=
     }=0A=
   return position;=0A=
 }=0A=
@@ -213,4 +219,9 @@ int=0A=
 fhandler_virtual::exists (const char *path)=0A=
 {=0A=
   return 0;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_virtual::fill_filebuf ()=0A=
+{=0A=
 }=0A=
Index: ntdll.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/ntdll.h,v=0A=
retrieving revision 1.9=0A=
diff -u -3 -p -u -p -b -B -r1.9 ntdll.h=0A=
--- ntdll.h	16 Oct 2001 14:53:26 -0000	1.9=0A=
+++ ntdll.h	9 May 2002 23:14:45 -0000=0A=
@@ -10,11 +10,28 @@=0A=
=20=0A=
 #define STATUS_INFO_LENGTH_MISMATCH ((NTSTATUS) 0xc0000004)=0A=
 #define FILE_SYNCHRONOUS_IO_NONALERT 32=0A=
+#define PDI_MODULES 0x01=0A=
+#define PDI_HEAPS 0x04=0A=
+#define LDRP_IMAGE_DLL 0x00000004=0A=
+#define WSLE_PAGE_READONLY 0x001=0A=
+#define WSLE_PAGE_EXECUTE 0x002=0A=
+#define WSLE_PAGE_EXECUTE_READ 0x003=0A=
+#define WSLE_PAGE_READWRITE 0x004=0A=
+#define WSLE_PAGE_WRITECOPY 0x005=0A=
+#define WSLE_PAGE_EXECUTE_READWRITE 0x006=0A=
+#define WSLE_PAGE_EXECUTE_WRITECOPY 0x007=0A=
+#define WSLE_PAGE_SHARE_COUNT_MASK 0x0E0=0A=
+#define WSLE_PAGE_SHAREABLE 0x100=0A=
+=0A=
+typedef ULONG KAFFINITY;=0A=
=20=0A=
 typedef enum _SYSTEM_INFORMATION_CLASS=0A=
 {=0A=
   SystemBasicInformation =3D 0,=0A=
+  SystemPerformanceInformation =3D 2,=0A=
+  SystemTimeOfDayInformation =3D 3,=0A=
   SystemProcessesAndThreadsInformation =3D 5,=0A=
+  SystemProcessorTimes =3D 8,=0A=
   /* There are a lot more of these... */=0A=
 } SYSTEM_INFORMATION_CLASS;=0A=
=20=0A=
@@ -30,9 +47,19 @@ typedef struct _SYSTEM_BASIC_INFORMATION=0A=
   ULONG LowestUserAddress;=0A=
   ULONG HighestUserAddress;=0A=
   ULONG ActiveProcessors;=0A=
-  ULONG NumberProcessors;=0A=
+  UCHAR NumberProcessors;=0A=
 } SYSTEM_BASIC_INFORMATION, *PSYSTEM_BASIC_INFORMATION;=0A=
=20=0A=
+typedef struct _SYSTEM_PROCESSOR_TIMES=0A=
+{=0A=
+  LARGE_INTEGER IdleTime;=0A=
+  LARGE_INTEGER KernelTime;=0A=
+  LARGE_INTEGER UserTime;=0A=
+  LARGE_INTEGER DpcTime;=0A=
+  LARGE_INTEGER InterruptTime;=0A=
+  ULONG InterruptCount;=0A=
+} SYSTEM_PROCESSOR_TIMES, *PSYSTEM_PROCESSOR_TIMES;=0A=
+=0A=
 typedef LONG KPRIORITY;=0A=
 typedef struct _VM_COUNTERS=0A=
 {=0A=
@@ -112,12 +139,13 @@ typedef struct _SYSTEM_THREADS=0A=
   ULONG ContextSwitchCount;=0A=
   THREAD_STATE State;=0A=
   KWAIT_REASON WaitReason;=0A=
+  DWORD Reserved;=0A=
 } SYSTEM_THREADS, *PSYSTEM_THREADS;=0A=
=20=0A=
 typedef struct _SYSTEM_PROCESSES=0A=
 {=0A=
   ULONG NextEntryDelta;=0A=
-  ULONG Threadcount;=0A=
+  ULONG ThreadCount;=0A=
   ULONG Reserved1[6];=0A=
   LARGE_INTEGER CreateTime;=0A=
   LARGE_INTEGER UserTime;=0A=
@@ -139,6 +167,180 @@ typedef struct _IO_STATUS_BLOCK=0A=
   ULONG Information;=0A=
 } IO_STATUS_BLOCK, *PIO_STATUS_BLOCK;=0A=
=20=0A=
+typedef struct _SYSTEM_PERFORMANCE_INFORMATION=0A=
+{=0A=
+  LARGE_INTEGER IdleTime;=0A=
+  LARGE_INTEGER ReadTransferCount;=0A=
+  LARGE_INTEGER WriteTransferCount;=0A=
+  LARGE_INTEGER OtherTransferCount;=0A=
+  ULONG ReadOperationCount;=0A=
+  ULONG WriteOperationCount;=0A=
+  ULONG OtherOperationCount;=0A=
+  ULONG AvailablePages;=0A=
+  ULONG TotalCommittedPages;=0A=
+  ULONG TotalCommitLimit;=0A=
+  ULONG PeakCommitment;=0A=
+  ULONG PageFaults;=0A=
+  ULONG WriteCopyFaults;=0A=
+  ULONG TransitionFaults;=0A=
+  ULONG Reserved1;=0A=
+  ULONG DemandZeroFaults;=0A=
+  ULONG PagesRead;=0A=
+  ULONG PageReadIos;=0A=
+  ULONG Reserved2[2];=0A=
+  ULONG PagefilePagesWritten;=0A=
+  ULONG PagefilePageWriteIos;=0A=
+  ULONG MappedFilePagesWritten;=0A=
+  ULONG MappedFilePageWriteIos;=0A=
+  ULONG PagedPoolUsage;=0A=
+  ULONG NonPagedPoolUsage;=0A=
+  ULONG PagedPoolAllocs;=0A=
+  ULONG PagedPoolFrees;=0A=
+  ULONG NonPagedPoolAllocs;=0A=
+  ULONG NonPagedPoolFrees;=0A=
+  ULONG TotalFreeSystemPtes;=0A=
+  ULONG SystemCodePage;=0A=
+  ULONG TotalSystemDriverPages;=0A=
+  ULONG TotalSystemCodePages;=0A=
+  ULONG SmallNonPagedLookasideListAllocateHits;=0A=
+  ULONG SmallPagedLookasideListAllocateHits;=0A=
+  ULONG Reserved3;=0A=
+  ULONG MmSystemCachePage;=0A=
+  ULONG PagedPoolPage;=0A=
+  ULONG SystemDriverPage;=0A=
+  ULONG FastReadNoWait;=0A=
+  ULONG FastReadWait;=0A=
+  ULONG FastReadResourceMiss;=0A=
+  ULONG FastReadNotPossible;=0A=
+  ULONG FastMdlReadNoWait;=0A=
+  ULONG FastMdlReadWait;=0A=
+  ULONG FastMdlReadResourceMiss;=0A=
+  ULONG FastMdlReadNotPossible;=0A=
+  ULONG MapDataNoWait;=0A=
+  ULONG MapDataWait;=0A=
+  ULONG MapDataNoWaitMiss;=0A=
+  ULONG MapDataWaitMiss;=0A=
+  ULONG PinMappedDataCount;=0A=
+  ULONG PinReadNoWait;=0A=
+  ULONG PinReadWait;=0A=
+  ULONG PinReadNoWaitMiss;=0A=
+  ULONG PinReadWaitMiss;=0A=
+  ULONG CopyReadNoWait;=0A=
+  ULONG CopyReadWait;=0A=
+  ULONG CopyReadNoWaitMiss;=0A=
+  ULONG CopyReadWaitMiss;=0A=
+  ULONG MdlReadNoWait;=0A=
+  ULONG MdlReadWait;=0A=
+  ULONG MdlReadNoWaitMiss;=0A=
+  ULONG MdlReadWaitMiss;=0A=
+  ULONG ReadAheadIos;=0A=
+  ULONG LazyWriteIos;=0A=
+  ULONG LazyWritePages;=0A=
+  ULONG DataFlushes;=0A=
+  ULONG DataPages;=0A=
+  ULONG ContextSwitches;=0A=
+  ULONG FirstLevelTbFills;=0A=
+  ULONG SecondLevelTbFills;=0A=
+  ULONG SystemCalls;=0A=
+} SYSTEM_PERFORMANCE_INFORMATION, *PSYSTEM_PERFORMANCE_INFORMATION;=0A=
+=0A=
+typedef struct _SYSTEM_TIME_OF_DAY_INFORMATION=0A=
+{=0A=
+  LARGE_INTEGER BootTime;=0A=
+  LARGE_INTEGER CurrentTime;=0A=
+  LARGE_INTEGER TimeZoneBias;=0A=
+  ULONG CurrentTimeZoneId;=0A=
+} SYSTEM_TIME_OF_DAY_INFORMATION, *PSYSTEM_TIME_OF_DAY_INFORMATION;=0A=
+=0A=
+typedef enum _PROCESSINFOCLASS=0A=
+{=0A=
+  ProcessBasicInformation =3D 0,=0A=
+  ProcessQuotaLimits =3D 1,=0A=
+  ProcessVmCounters =3D 3,=0A=
+  ProcessTimes =3D4,=0A=
+} PROCESSINFOCLASS;=0A=
+=0A=
+typedef struct _DEBUG_BUFFER=0A=
+{=0A=
+  HANDLE SectionHandle;=0A=
+  PVOID SectionBase;=0A=
+  PVOID RemoteSectionBase;=0A=
+  ULONG SectionBaseDelta;=0A=
+  HANDLE EventPairHandle;=0A=
+  ULONG Unknown[2];=0A=
+  HANDLE RemoteThreadHandle;=0A=
+  ULONG InfoClassMask;=0A=
+  ULONG SizeOfInfo;=0A=
+  ULONG AllocatedSize;=0A=
+  ULONG SectionSize;=0A=
+  PVOID ModuleInformation;=0A=
+  PVOID BackTraceInformation;=0A=
+  PVOID HeapInformation;=0A=
+  PVOID LockInformation;=0A=
+  PVOID Reserved[9];=0A=
+} DEBUG_BUFFER, *PDEBUG_BUFFER;=0A=
+=0A=
+typedef struct _DEBUG_HEAP_INFORMATION=0A=
+{=0A=
+  ULONG Base;=0A=
+  ULONG Flags;=0A=
+  USHORT Granularity;=0A=
+  USHORT Unknown;=0A=
+  ULONG Allocated;=0A=
+  ULONG Committed;=0A=
+  ULONG TagCount;=0A=
+  ULONG BlockCount;=0A=
+  ULONG Reserved[7];=0A=
+  PVOID Tags;=0A=
+  PVOID Blocks;=0A=
+} DEBUG_HEAP_INFORMATION, *PDEBUG_HEAP_INFORMATION;=0A=
+=0A=
+typedef struct _DEBUG_MODULE_INFORMATION=0A=
+{=0A=
+  ULONG Reserved[2];=0A=
+  ULONG Base;=0A=
+  ULONG Size;=0A=
+  ULONG Flags;=0A=
+  USHORT Index;=0A=
+  USHORT Unknown;=0A=
+  USHORT LoadCount;=0A=
+  USHORT ModuleNameOffset;=0A=
+  CHAR ImageName[256];=0A=
+} DEBUG_MODULE_INFORMATION, *PDEBUG_MODULE_INFORMATION;=0A=
+=0A=
+typedef struct _KERNEL_USER_TIMES=0A=
+{=0A=
+  LARGE_INTEGER CreateTime;=0A=
+  LARGE_INTEGER ExitTime;=0A=
+  LARGE_INTEGER KernelTime;=0A=
+  LARGE_INTEGER UserTime;=0A=
+} KERNEL_USER_TIMES, *PKERNEL_USER_TIMES;=0A=
+=0A=
+typedef void *PPEB;=0A=
+=0A=
+typedef struct _PROCESS_BASIC_INFORMATION=0A=
+{=0A=
+  NTSTATUS ExitStatus;=0A=
+  PPEB PebBaseAddress;=0A=
+  KAFFINITY AffinityMask;=0A=
+  KPRIORITY BasePriority;=0A=
+  ULONG UniqueProcessId;=0A=
+  ULONG InheritedFromUniqueProcessId;=0A=
+} PROCESS_BASIC_INFORMATION, *PPROCESS_BASIC_INFORMATION;=0A=
+=0A=
+typedef enum _MEMORY_INFORMATION_CLASS=0A=
+{=0A=
+  MemoryBasicInformation,=0A=
+  MemoryWorkingSetList,=0A=
+  MemorySectionName,=0A=
+  MemoryBaiscVlmInformation=0A=
+} MEMORY_INFORMATION_CLASS;=0A=
+=0A=
+typedef struct _MEMORY_WORKING_SET_LIST {=0A=
+  ULONG NumberOfPages;=0A=
+  ULONG WorkingSetList[1];=0A=
+} MEMORY_WORKING_SET_LIST, *PMEMORY_WORKING_SET_LIST;=0A=
+=0A=
 /* Function declarations for ntdll.dll.  These don't appear in any=0A=
    standard Win32 header.  */=0A=
 extern "C"=0A=
@@ -162,4 +364,8 @@ extern "C"=0A=
   NTSTATUS NTAPI ZwQuerySystemInformation (IN SYSTEM_INFORMATION_CLASS,=0A=
 					   IN OUT PVOID, IN ULONG,=0A=
 					   OUT PULONG);=0A=
+  NTSTATUS NTAPI ZwQueryInformationProcess (IN HANDLE, IN PROCESSINFOCLASS=
,=0A=
+                                            OUT PVOID, IN ULONG, OUT PULON=
G);=0A=
+  NTSTATUS NTAPI ZwQueryVirtualMemory (IN HANDLE, IN PVOID, IN MEMORY_INFO=
RMATION_CLASS,=0A=
+                                       OUT PVOID, IN ULONG, OUT PULONG);=
=0A=
 }=0A=
Index: sysconf.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/sysconf.cc,v=0A=
retrieving revision 1.22=0A=
diff -u -3 -p -u -p -b -B -r1.22 sysconf.cc=0A=
Index: wincap.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/wincap.cc,v=0A=
retrieving revision 1.10=0A=
diff -u -3 -p -u -p -b -B -r1.10 wincap.cc=0A=
--- wincap.cc	25 Feb 2002 17:47:47 -0000	1.10=0A=
+++ wincap.cc	9 May 2002 23:14:46 -0000=0A=
@@ -46,6 +46,7 @@ static NO_COPY wincaps wincap_unknown =3D=20=0A=
   has_raw_devices:false,=0A=
   has_valid_processorlevel:false,=0A=
   has_64bit_file_access:false,=0A=
+  has_process_io_counters:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_95 =3D {=0A=
@@ -83,6 +84,7 @@ static NO_COPY wincaps wincap_95 =3D {=0A=
   has_raw_devices:false,=0A=
   has_valid_processorlevel:false,=0A=
   has_64bit_file_access:false,=0A=
+  has_process_io_counters:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_95osr2 =3D {=0A=
@@ -120,6 +122,7 @@ static NO_COPY wincaps wincap_95osr2 =3D {=0A=
   has_raw_devices:false,=0A=
   has_valid_processorlevel:false,=0A=
   has_64bit_file_access:false,=0A=
+  has_process_io_counters:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_98 =3D {=0A=
@@ -157,6 +160,7 @@ static NO_COPY wincaps wincap_98 =3D {=0A=
   has_raw_devices:false,=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:false,=0A=
+  has_process_io_counters:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_98se =3D {=0A=
@@ -194,6 +198,7 @@ static NO_COPY wincaps wincap_98se =3D {=0A=
   has_raw_devices:false,=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:false,=0A=
+  has_process_io_counters:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_me =3D {=0A=
@@ -231,6 +236,7 @@ static NO_COPY wincaps wincap_me =3D {=0A=
   has_raw_devices:false,=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:false,=0A=
+  has_process_io_counters:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_nt3 =3D {=0A=
@@ -268,6 +274,7 @@ static NO_COPY wincaps wincap_nt3 =3D {=0A=
   has_raw_devices:true,=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
+  has_process_io_counters:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_nt4 =3D {=0A=
@@ -305,6 +312,7 @@ static NO_COPY wincaps wincap_nt4 =3D {=0A=
   has_raw_devices:true,=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
+  has_process_io_counters:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_nt4sp4 =3D {=0A=
@@ -342,6 +350,7 @@ static NO_COPY wincaps wincap_nt4sp4 =3D {=0A=
   has_raw_devices:true,=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
+  has_process_io_counters:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_2000 =3D {=0A=
@@ -379,6 +388,7 @@ static NO_COPY wincaps wincap_2000 =3D {=0A=
   has_raw_devices:true,=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
+  has_process_io_counters:true,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_xp =3D {=0A=
@@ -416,6 +426,7 @@ static NO_COPY wincaps wincap_xp =3D {=0A=
   has_raw_devices:true,=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
+  has_process_io_counters:true,=0A=
 };=0A=
=20=0A=
 wincapc NO_COPY wincap;=0A=
Index: wincap.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/wincap.h,v=0A=
retrieving revision 1.7=0A=
diff -u -3 -p -u -p -b -B -r1.7 wincap.h=0A=
--- wincap.h	25 Feb 2002 17:47:47 -0000	1.7=0A=
+++ wincap.h	9 May 2002 23:14:46 -0000=0A=
@@ -47,6 +47,7 @@ struct wincaps=0A=
   unsigned has_raw_devices				: 1;=0A=
   unsigned has_valid_processorlevel			: 1;=0A=
   unsigned has_64bit_file_access			: 1;=0A=
+  unsigned has_process_io_counters                      : 1;=0A=
 };=0A=
=20=0A=
 class wincapc=0A=
@@ -99,6 +100,7 @@ public:=0A=
   bool  IMPLEMENT (has_raw_devices)=0A=
   bool  IMPLEMENT (has_valid_processorlevel)=0A=
   bool  IMPLEMENT (has_64bit_file_access)=0A=
+  bool  IMPLEMENT (has_process_io_counters)=0A=
=20=0A=
 #undef IMPLEMENT=0A=
 };=0A=

------=_NextPart_000_05CA_01C1F7BA.0BD264C0
Content-Type: text/plain;
	name="ChangeLog.4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.4.txt"
Content-length: 2228

2002-05-10  Christopher January <chris@atomice.net>

	* autoload.cc: Add dynamic load statements for 'ZwQueryInformationProcess'
	and 'ZwQueryVirtualMemory'.
	* fhandler.h: Change type of bufalloc and filesize members of
	fhandler_virtual from int to size_t.
	Change type of position member from __off32_t to __off64_t.
	Add new fileid member to fhandler_virtual class.
	Make seekdir take an __off64_t argument.
	Make lseek take an __off64_t argument.
	Add fill_filebuf method to fhandler_virtual.
	Add fill_filebuf method to fhandler_proc.
	Add fill_filebuf method to fhandler_registry.
	Add fill_filebuf method to fhandler_process.
	Add saved_pid and saved_p members to fhandler_process.
	* fhandler_proc.cc: Add 'loadavg', 'meminfo', and 'stat' files to
	proc_listing array.
	Add corresponding entries in proc_fhandlers array.
	(fhandler_proc::open): Use fill_filebuf to flesh out the file contents.
	(fhandler_proc::fill_filebuf): New method.
	(fhandler_proc::format_proc_meminfo): Ditto.
	(fhandler_proc::format_proc_stat): Ditto.
	(fhandler_proc::format_proc_uptime): Ditto.
	* fhandler_process.cc: Add 'stat' and 'statm' files to process_listing
	array.
	(fhandler_process::fstat): Find the _pinfo structure for the process
	named in the filename. Return ENOENT if the process is no longer around.
	Set the gid and uid fields of the stat structure.
	(fhandler_process::open): Store pid and pointer to _pinfo structure in
	saved_pid and saved_p respectively. Use fill_filebuf to flesh out file
	contents.
	(fhandler_proc::fill_filebuf): New method.
	(format_process_stat): New function.
	(format_process_status): Ditto.
	(format_process_statm): Ditto.
	(get_process_state): Ditto.
	(get_mem_values): Ditto.
	* fhandler_registry.cc (fhandler_registry::seekdir): Change argument type
	from __off32_t to __off64_t.
	(fhandler_registry::fill_filebuf): New method.	
	* fhandler_virtual.cc (fhandler_virtual::seekdir): Change argument type
	from __off32_t to __off64_t. 
	(fhandler_virtual::lseek): Ditto.
	(fhandler_virtual::fill_filebuf): New method.
	(fhandler_virtual::fhandler_virtual): Initialise fileid to -1.
	* wincap.cc: Set flag has_process_io_counters  appropriately.
	* wincap.h: Add flag has_process_io_counters.
	
------=_NextPart_000_05CA_01C1F7BA.0BD264C0--
