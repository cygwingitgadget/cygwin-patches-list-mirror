Return-Path: <cygwin-patches-return-4379-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2408 invoked by alias); 14 Nov 2003 13:26:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2289 invoked from network); 14 Nov 2003 13:26:34 -0000
Message-ID: <3FB4D81C.6010808@cygwin.com>
Date: Fri, 14 Nov 2003 13:26:00 -0000
From: Robert Collins <rbcollins@cygwin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com,  rdparker@butlermfg.com
Subject: For masochists: the leap o faith
Content-Type: multipart/mixed;
 boundary="------------010802060506030706050607"
X-SW-Source: 2003-q4/txt/msg00098.txt.bz2

This is a multi-part message in MIME format.
--------------010802060506030706050607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1898

Ok, so this it for tonight, my bed is calling me.

If playing with this, be sure to:
rebuild libc as well as cygwin1.dll.
be setup to debug cygwin1.dll.

I don't *think* I've changed the size of the shared stuff, but then 
again, I'm pretty tired, so I'll believe anything right now.

My plan is to unbreak cygwin tomorrow, and then work through the list of 
potentially update-requiring API calls:
DeleteFile
CopyFile
MoveFileEx
FindFirstFileEx
FindFirstFile
CreateHardLink
GetModuleFileName
GetFullPathName
GetSystemDirectory
GetWindowsDirectory
CreateMutex et al.

is my list so far.

I'll be a very happy chappie if someone picks this up and takes it the 
next little step :}.

Cheers, and good night.


2003-11-11  Robert Collins <rbtcollins@hotmail.com>
             Ron Parker <rdparker@butlermfg.com>

         Rename thunked functions to cygwin_function_name,
         create unicode capable thunks, and add autoload support, for:

           CreateFile
           CreateDirectory
           SetFileAttributes
           GetFileAttributes
           MoveFile
           MoveFileEx

         * assert.cc: Ditto.
         * dcrt0.cc: Ditto.
         * dir.cc: Ditto.
         * exceptions.cc: Ditto.
         * fhandler.cc: Ditto.
         * fhandler_console.cc: Ditto.
         * fhandler_disk_file.cc: Ditto.
         * fhandler_proc.cc: Ditto.
         * fhandler_socket.cc: Ditto.
         * fork.cc: Ditto.
         * ntea.cc: Ditto.
         * path.cc: Ditto.
         * security.cc: Ditto.
         * spawn.cc: Ditto.
         * syscalls.cc: Ditto.
         * times.cc: Ditto.
         * uinfo.cc: Ditto.
         * autoload.cc: Add appropriate ...W autoload stubs.
         * wincap.cc:  Add has_unicode_io capability.
         * wincap.h:  Add has_unicode_io capability.

         Update cygwin throughout to use CYG_MAX_PATH rather than MAX_PATH.
         Watch cygwin die badly.


--------------010802060506030706050607
Content-Type: text/plain;
 name="broken-long-paths.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="broken-long-paths.diff"
Content-length: 76331

? cvs.exe.stackdump
? io.h
? localdiff
? notes
? t
Index: assert.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/assert.cc,v
retrieving revision 1.9
diff -u -p -r1.9 assert.cc
--- assert.cc	19 Sep 2002 15:12:48 -0000	1.9
+++ assert.cc	14 Nov 2003 13:20:18 -0000
@@ -16,6 +16,7 @@ details. */
 #include <assert.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include "io.h"
 
 /* This function is called when the assert macro fails.  This will
    override the function of the same name in newlib.  */
@@ -28,8 +29,9 @@ __assert (const char *file, int line, co
   /* If we don't have a console in a Windows program, then bring up a
      message box for the assertion failure.  */
 
-  h = CreateFile ("CONOUT$", GENERIC_WRITE, FILE_SHARE_WRITE, &sec_none_nih,
-		  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+  h = cygwin_create_file ("CONOUT$", GENERIC_WRITE, FILE_SHARE_WRITE,
+		  	  &sec_none_nih, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL,
+			  NULL);
   if (h == INVALID_HANDLE_VALUE)
     {
       char *buf;
Index: autoload.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.75
diff -u -p -r1.75 autoload.cc
--- autoload.cc	27 Sep 2003 03:44:31 -0000	1.75
+++ autoload.cc	14 Nov 2003 13:20:18 -0000
@@ -502,17 +502,23 @@ LoadDLLfunc (CoUninitialize, 0, ole32)
 LoadDLLfunc (CoCreateInstance, 20, ole32)
 
 LoadDLLfuncEx (CancelIo, 4, kernel32, 1)
+LoadDLLfunc (CreateDirectoryW, 8, kernel32)
+LoadDLLfunc (CreateFileW, 28, kernel32)
 LoadDLLfuncEx (CreateHardLinkA, 12, kernel32, 1)
 LoadDLLfuncEx (CreateToolhelp32Snapshot, 8, kernel32, 1)
 LoadDLLfuncEx2 (GetCompressedFileSizeA, 8, kernel32, 1, 0xffffffff)
 LoadDLLfuncEx (GetConsoleWindow, 0, kernel32, 1)
 LoadDLLfuncEx (GetDiskFreeSpaceEx, 16, kernel32, 1)
+LoadDLLfunc (GetFileAttributesW, 4, kernel32)
 LoadDLLfuncEx (GetSystemTimes, 12, kernel32, 1)
 LoadDLLfuncEx2 (IsDebuggerPresent, 0, kernel32, 1, 1)
 LoadDLLfunc (IsProcessorFeaturePresent, 4, kernel32);
+LoadDLLfunc (MoveFileW, 8, kernel32)
+LoadDLLfunc (MoveFileExW, 12, kernel32)
 LoadDLLfuncEx (Process32First, 8, kernel32, 1)
 LoadDLLfuncEx (Process32Next, 8, kernel32, 1)
 LoadDLLfuncEx (RegisterServiceProcess, 8, kernel32, 1)
+LoadDLLfunc (SetFileAttributesW, 8, kernel32)
 LoadDLLfuncEx (SignalObjectAndWait, 16, kernel32, 1)
 LoadDLLfuncEx (SwitchToThread, 0, kernel32, 1)
 LoadDLLfunc (TryEnterCriticalSection, 4, kernel32)
Index: bsdlib.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/bsdlib.cc,v
retrieving revision 1.2
diff -u -p -r1.2 bsdlib.cc
--- bsdlib.cc	6 Nov 2003 21:31:24 -0000	1.2
+++ bsdlib.cc	14 Nov 2003 13:20:18 -0000
@@ -115,7 +115,7 @@ openpty (int *amaster, int *aslave, char
 	 struct winsize *winp)
 {
   int master, slave;
-  char pts[MAX_PATH];
+  char pts[CYG_MAX_PATH];
 
   if ((master = open ("/dev/ptmx", O_RDWR | O_NOCTTY)) >= 0)
     {
Index: cygheap.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.67
diff -u -p -r1.67 cygheap.h
--- cygheap.h	27 Sep 2003 01:56:36 -0000	1.67
+++ cygheap.h	14 Nov 2003 13:20:18 -0000
@@ -42,9 +42,9 @@ struct _cmalloc_entry
 
 struct cygheap_root_mount_info
 {
-  char posix_path[MAX_PATH];
+  char posix_path[CYG_MAX_PATH];
   unsigned posix_pathlen;
-  char native_path[MAX_PATH];
+  char native_path[CYG_MAX_PATH];
   unsigned native_pathlen;
 };
 
@@ -215,7 +215,7 @@ struct cwdstuff
   char *win32;
   DWORD hash;
   muto *cwd_lock;
-  char *get (char *buf, int need_posix = 1, int with_chroot = 0, unsigned ulen = MAX_PATH);
+  char *get (char *buf, int need_posix = 1, int with_chroot = 0, unsigned ulen = CYG_MAX_PATH);
   DWORD get_hash ();
   void init ();
   void fixup_after_exec (char *win32, char *posix, DWORD hash);
Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.189
diff -u -p -r1.189 dcrt0.cc
--- dcrt0.cc	16 Oct 2003 14:08:27 -0000	1.189
+++ dcrt0.cc	14 Nov 2003 13:20:19 -0000
@@ -34,6 +34,7 @@ details. */
 #include "dll_init.h"
 #include "cygthread.h"
 #include "sync.h"
+#include "io.h"
 
 #define MAX_AT_FILE_LEVEL 10
 
@@ -164,13 +165,13 @@ insert_file (char *name, char *&cmd)
   HANDLE f;
   DWORD size;
 
-  f = CreateFile (name + 1,
-		  GENERIC_READ,		 /* open for reading	*/
-		  FILE_SHARE_READ,       /* share for reading	*/
-		  &sec_none_nih,	 /* no security		*/
-		  OPEN_EXISTING,	 /* existing file only	*/
-		  FILE_ATTRIBUTE_NORMAL, /* normal file		*/
-		  NULL);		 /* no attr. template	*/
+  f = cygwin_create_file (name + 1,
+			  GENERIC_READ,		 /* open for reading	*/
+			  FILE_SHARE_READ,       /* share for reading	*/
+			  &sec_none_nih,	 /* no security		*/
+			  OPEN_EXISTING,	 /* existing file only	*/
+			  FILE_ATTRIBUTE_NORMAL, /* normal file		*/
+			  NULL);		 /* no attr. template	*/
 
   if (f == INVALID_HANDLE_VALUE)
     {
@@ -722,7 +723,7 @@ dll_crt0_1 ()
 	 win32 style. */
       if ((strchr (__argv[0], ':')) || (strchr (__argv[0], '\\')))
 	{
-	  char *new_argv0 = (char *) alloca (MAX_PATH);
+	  char *new_argv0 = (char *) alloca (CYG_MAX_PATH);
 	  cygwin_conv_to_posix_path (__argv[0], new_argv0);
 	  __argv[0] = new_argv0;
 	}
@@ -805,20 +806,20 @@ void
 initial_env ()
 {
   DWORD len;
-  char buf[MAX_PATH + 1];
+  char buf[CYG_MAX_PATH + 1];
 #ifdef DEBUGGING
   if (GetEnvironmentVariable ("CYGWIN_SLEEP", buf, sizeof (buf) - 1))
     {
       DWORD ms = atoi (buf);
       buf[0] = '\0';
-      len = GetModuleFileName (NULL, buf, MAX_PATH);
+      len = GetModuleFileName (NULL, buf, CYG_MAX_PATH);
       console_printf ("Sleeping %d, pid %u %s\n", ms, GetCurrentProcessId (), buf);
       Sleep (ms);
     }
   if (GetEnvironmentVariable ("CYGWIN_DEBUG", buf, sizeof (buf) - 1))
     {
-      char buf1[MAX_PATH + 1];
-      len = GetModuleFileName (NULL, buf1, MAX_PATH);
+      char buf1[CYG_MAX_PATH + 1];
+      len = GetModuleFileName (NULL, buf1, CYG_MAX_PATH);
       strlwr (buf1);
       strlwr (buf);
       char *p = strchr (buf, ':');
@@ -838,7 +839,7 @@ initial_env ()
   if (GetEnvironmentVariable ("CYGWIN_TESTING", buf, sizeof (buf) - 1))
     {
       _cygwin_testing = 1;
-      if ((len = GetModuleFileName (cygwin_hmodule, buf, MAX_PATH))
+      if ((len = GetModuleFileName (cygwin_hmodule, buf, CYG_MAX_PATH))
 	  && len > sizeof ("new-cygwin1.dll")
 	  && strcasematch (buf + len - sizeof ("new-cygwin1.dll"),
 			   "\\new-cygwin1.dll"))
@@ -1107,9 +1108,9 @@ __api_fatal (const char *fmt, ...)
      a serious error. */
   if (GetFileType (GetStdHandle (STD_ERROR_HANDLE)) != FILE_TYPE_CHAR)
     {
-      HANDLE h = CreateFile ("CONOUT$", GENERIC_READ | GENERIC_WRITE,
-			     FILE_SHARE_WRITE | FILE_SHARE_WRITE,
-			     &sec_none, OPEN_EXISTING, 0, 0);
+      HANDLE h = cygwin_create_file ("CONOUT$", GENERIC_READ | GENERIC_WRITE,
+				     FILE_SHARE_WRITE | FILE_SHARE_WRITE,
+				     &sec_none, OPEN_EXISTING, 0, 0);
       if (h != INVALID_HANDLE_VALUE)
 	(void) WriteFile (h, buf, len, &done, 0);
     }
Index: delqueue.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/delqueue.cc,v
retrieving revision 1.10
diff -u -p -r1.10 delqueue.cc
--- delqueue.cc	23 Sep 2002 00:31:30 -0000	1.10
+++ delqueue.cc	14 Nov 2003 13:20:19 -0000
@@ -30,7 +30,7 @@ delqueue_list::init ()
 void
 delqueue_list::queue_file (const char *dosname)
 {
-  char temp[MAX_PATH], *end;
+  char temp[CYG_MAX_PATH], *end;
   GetFullPathName (dosname, sizeof (temp), temp, &end);
 
   /* Note about race conditions: The only time we get to this point is
Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.76
diff -u -p -r1.76 dir.cc
--- dir.cc	25 Sep 2003 00:37:16 -0000	1.76
+++ dir.cc	14 Nov 2003 13:20:19 -0000
@@ -23,6 +23,7 @@ details. */
 #include "fhandler.h"
 #include "dtable.h"
 #include "cygheap.h"
+#include "io.h"
 
 /* Cygwin internal */
 /* Return whether the directory of a file is writable.  Return 1 if it
@@ -280,7 +281,7 @@ mkdir (const char *dir, mode_t mode)
     set_security_attribute (S_IFDIR | ((mode & 07777) & ~cygheap->umask),
 			    &sa, alloca (4096), 4096);
 
-  if (CreateDirectoryA (real_dir.get_win32 (), &sa))
+  if (cygwin_create_directory (real_dir.get_win32 (), &sa))
     {
       if (!allow_ntsec && allow_ntea)
 	set_file_attribute (real_dir.has_acls (), real_dir.get_win32 (),
Index: dlfcn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dlfcn.cc,v
retrieving revision 1.19
diff -u -p -r1.19 dlfcn.cc
--- dlfcn.cc	25 Sep 2003 00:37:16 -0000	1.19
+++ dlfcn.cc	14 Nov 2003 13:20:19 -0000
@@ -49,7 +49,7 @@ get_full_path_of_dll (const char* str, c
   int len = strlen (str);
 
   /* empty string or too long to be legal win32 pathname? */
-  if (len == 0 || len >= MAX_PATH - 1)
+  if (len == 0 || len >= CYG_MAX_PATH - 1)
     return str;		/* Yes.  Let caller deal with it. */
 
   const char *ret;
@@ -93,7 +93,7 @@ dlopen (const char *name, int)
     ret = (void *) GetModuleHandle (NULL); /* handle for the current module */
   else
     {
-      char buf[MAX_PATH];
+      char buf[CYG_MAX_PATH];
       /* handle for the named library */
       const char *fullpath = get_full_path_of_dll (name, buf);
       if (!fullpath)
Index: dll_init.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dll_init.cc,v
retrieving revision 1.38
diff -u -p -r1.38 dll_init.cc
--- dll_init.cc	25 Sep 2003 00:37:16 -0000	1.38
+++ dll_init.cc	14 Nov 2003 13:20:19 -0000
@@ -103,7 +103,7 @@ dll_list::operator[] (const char *name)
 dll *
 dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
 {
-  char name[MAX_PATH + 1];
+  char name[CYG_MAX_PATH + 1];
   DWORD namelen = GetModuleFileName (h, name, sizeof (name));
 
   /* Already loaded? */
Index: dll_init.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dll_init.h,v
retrieving revision 1.8
diff -u -p -r1.8 dll_init.h
--- dll_init.h	14 Nov 2002 04:29:39 -0000	1.8
+++ dll_init.h	14 Nov 2003 13:20:19 -0000
@@ -51,7 +51,7 @@ struct dll
   int count;
   dll_type type;
   int namelen;
-  char name[MAX_PATH + 1];
+  char name[CYG_MAX_PATH + 1];
   void detach ();
   int init ();
 };
Index: dtable.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.119
diff -u -p -r1.119 dtable.cc
--- dtable.cc	1 Oct 2003 12:36:39 -0000	1.119
+++ dtable.cc	14 Nov 2003 13:20:20 -0000
@@ -251,7 +251,7 @@ dtable::init_std_file_from_handle (int f
 	dev.parse ("/dev/ttyS0");
       else
 	{
-	  name = handle_to_fn (handle, (char *) alloca (MAX_PATH + 100));
+	  name = handle_to_fn (handle, (char *) alloca (CYG_MAX_PATH + 100));
 	  bin = 0;
 	}
     }
@@ -774,7 +774,7 @@ handle_to_fn (HANDLE h, char *posix_fn)
 
   ntfn->Name.Buffer[ntfn->Name.Length / sizeof (WCHAR)] = 0;
 
-  char win32_fn[MAX_PATH + 100];
+  char win32_fn[CYG_MAX_PATH + 100];
   sys_wcstombs (win32_fn, ntfn->Name.Buffer, ntfn->Name.Length);
   debug_printf ("nt name '%s'", win32_fn);
   if (!strncasematch (win32_fn, DEVICE_PREFIX, DEVICE_PREFIX_LEN)
@@ -788,8 +788,8 @@ handle_to_fn (HANDLE h, char *posix_fn)
   char *maxmatchdos = NULL;
   for (char *s = fnbuf; *s; s = strchr (s, '\0') + 1)
     {
-      char device[MAX_PATH + 10];
-      device[MAX_PATH + 9] = '\0';
+      char device[CYG_MAX_PATH + 10];
+      device[CYG_MAX_PATH + 9] = '\0';
       if (strchr (s, ':') == NULL)
 	continue;
       if (!QueryDosDevice (s, device, sizeof (device) - 1))
Index: environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.96
diff -u -p -r1.96 environ.cc
--- environ.cc	25 Sep 2003 00:37:16 -0000	1.96
+++ environ.cc	14 Nov 2003 13:20:20 -0000
@@ -53,7 +53,7 @@ static char **lastenviron;
    PATH needs to be here because CreateProcess uses it and gdb uses
    CreateProcess.  HOME is here because most shells use it and would be
    confused by Windows style path names.  */
-static int return_MAX_PATH (const char *) {return MAX_PATH;}
+static int return_MAX_PATH (const char *) {return CYG_MAX_PATH;}
 static NO_COPY win_env conv_envvars[] =
   {
     {NL ("PATH="), NULL, NULL, cygwin_win32_to_posix_path_list,
@@ -539,7 +539,7 @@ parse_options (char *buf)
 
   if (buf == NULL)
     {
-      char newbuf[MAX_PATH + 7];
+      char newbuf[CYG_MAX_PATH + 7];
       newbuf[0] = '\0';
       for (k = known; k->name != NULL; k++)
 	if (k->remember)
@@ -624,7 +624,7 @@ regopt (const char *name)
   bool parsed_something = false;
   /* FIXME: should not be under mount */
   reg_key r (KEY_READ, CYGWIN_INFO_PROGRAM_OPTIONS_NAME, NULL);
-  char buf[MAX_PATH];
+  char buf[CYG_MAX_PATH];
   char lname[strlen (name) + 1];
   strlwr (strcpy (lname, name));
 
Index: environ.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.h,v
retrieving revision 1.7
diff -u -p -r1.7 environ.h
--- environ.h	29 Jun 2002 02:36:08 -0000	1.7
+++ environ.h	14 Nov 2003 13:20:20 -0000
@@ -16,7 +16,7 @@ void environ_init (char **, int)
    file specs.  Currently, only PATH and HOME are converted, but PATH
    needs to use a "convert path list" function while HOME needs a simple
    "convert to posix/win32".  For the simple case, where a calculated length
-   is required, just return MAX_PATH.  *FIXME* */
+   is required, just return CYG_MAX_PATH.  *FIXME* */
 struct win_env
   {
     const char *name;
Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.173
diff -u -p -r1.173 exceptions.cc
--- exceptions.cc	4 Nov 2003 15:48:18 -0000	1.173
+++ exceptions.cc	14 Nov 2003 13:20:21 -0000
@@ -25,10 +25,11 @@ details. */
 #include "shared_info.h"
 #include "perprocess.h"
 #include "security.h"
+#include "io.h"
 
 #define CALL_HANDLER_RETRY 20
 
-char debugger_command[2 * MAX_PATH + 20];
+char debugger_command[2 * CYG_MAX_PATH + 20];
 
 extern "C" {
 static int handle_exceptions (EXCEPTION_RECORD *, void *, CONTEXT *, void *);
@@ -141,8 +142,8 @@ error_start_init (const char *buf)
       return;
     }
 
-  char pgm[MAX_PATH + 1];
-  if (!GetModuleFileName (NULL, pgm, MAX_PATH))
+  char pgm[CYG_MAX_PATH + 1];
+  if (!GetModuleFileName (NULL, pgm, CYG_MAX_PATH))
     strcpy (pgm, "cygwin1.dll");
   for (char *p = strchr (pgm, '\\'); p; p = strchr (p, '\\'))
     *p = '/';
@@ -165,8 +166,8 @@ open_stackdumpfile ()
 	p = myself->progname;
       char corefile[strlen (p) + sizeof (".stackdump")];
       __small_sprintf (corefile, "%s.stackdump", p);
-      HANDLE h = CreateFile (corefile, GENERIC_WRITE, 0, &sec_none_nih,
-			     CREATE_ALWAYS, 0, 0);
+      HANDLE h = cygwin_create_file (corefile, GENERIC_WRITE, 0, &sec_none_nih,
+				     CREATE_ALWAYS, 0, 0);
       if (h != INVALID_HANDLE_VALUE)
 	{
 	  if (!myself->ppid_handle)
@@ -1125,7 +1126,7 @@ void
 events_init (void)
 {
   char *name;
-  char mutex_name[MAX_PATH];
+  char mutex_name[CYG_MAX_PATH];
   /* title_mutex protects modification of console title. It's necessary
      while finding console window handle */
 
Index: external.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/external.cc,v
retrieving revision 1.58
diff -u -p -r1.58 external.cc
--- external.cc	8 Nov 2003 09:48:48 -0000	1.58
+++ external.cc	14 Nov 2003 13:20:21 -0000
@@ -114,8 +114,8 @@ get_cygdrive_info (char *user, char *sys
 static DWORD
 get_cygdrive_prefixes (char *user, char *system)
 {
-  char user_flags[MAX_PATH];
-  char system_flags[MAX_PATH];
+  char user_flags[CYG_MAX_PATH];
+  char system_flags[CYG_MAX_PATH];
   DWORD res = get_cygdrive_info (user, system, user_flags, system_flags);
   return res;
 }
Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.161
diff -u -p -r1.161 fhandler.cc
--- fhandler.cc	25 Oct 2003 12:32:56 -0000	1.161
+++ fhandler.cc	14 Nov 2003 13:20:23 -0000
@@ -27,6 +27,7 @@ details. */
 #include <assert.h>
 #include <limits.h>
 #include <winioctl.h>
+#include "io.h"
 
 static NO_COPY const int CHUNK_SIZE = 1024; /* Used for crlf conversions */
 
@@ -404,7 +405,7 @@ fhandler_base::open (int flags, mode_t m
     }
 #endif
 
-  /* CreateFile() with dwDesiredAccess == 0 when called on remote
+  /* cygwin_create_file() with dwDesiredAccess == 0 when called on remote
      share returns some handle, even if file doesn't exist. This code
      works around this bug. */
   if (get_query_open () && isremote () &&
@@ -423,8 +424,8 @@ fhandler_base::open (int flags, mode_t m
   if (flags & O_CREAT && get_device () == FH_FS && allow_ntsec && has_acls ())
     set_security_attribute (mode, &sa, alloca (4096), 4096);
 
-  x = CreateFile (get_win32_name (), access, shared, &sa, creation_distribution,
-		  file_attributes, 0);
+  x = cygwin_create_file (get_win32_name (), access, shared, &sa,
+			  creation_distribution, file_attributes, 0);
 
   if (x == INVALID_HANDLE_VALUE)
     {
@@ -445,7 +446,7 @@ fhandler_base::open (int flags, mode_t m
        goto done;
    }
 
-  syscall_printf ("%p = CreateFile (%s, %p, %p, %p, %p, %p, 0)",
+  syscall_printf ("%p = cygwin_create_file (%s, %p, %p, %p, %p, %p, 0)",
 		  x, get_win32_name (), access, shared, &sa,
 		  creation_distribution, file_attributes);
 
Index: fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.117
diff -u -p -r1.117 fhandler_console.cc
--- fhandler_console.cc	16 Oct 2003 14:08:28 -0000	1.117
+++ fhandler_console.cc	14 Nov 2003 13:20:24 -0000
@@ -29,6 +29,7 @@ details. */
 #include "pinfo.h"
 #include "shared_info.h"
 #include "cygthread.h"
+#include "io.h"
 
 #define CONVERT_LIMIT 16384
 
@@ -146,9 +147,9 @@ tty_list::get_tty (int n)
 int __stdcall
 set_console_state_for_spawn ()
 {
-  HANDLE h = CreateFile ("CONIN$", GENERIC_READ, FILE_SHARE_WRITE,
-			 &sec_none_nih, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL,
-			 NULL);
+  HANDLE h = cygwin_create_file ("CONIN$", GENERIC_READ, FILE_SHARE_WRITE,
+				 &sec_none_nih, OPEN_EXISTING,
+				 FILE_ATTRIBUTE_NORMAL, NULL);
 
   if (h == INVALID_HANDLE_VALUE)
     return 0;
@@ -627,9 +628,9 @@ fhandler_console::open (int flags, mode_
   set_flags ((flags & ~O_TEXT) | O_BINARY);
 
   /* Open the input handle as handle_ */
-  h = CreateFile ("CONIN$", GENERIC_READ | GENERIC_WRITE,
-		  FILE_SHARE_READ | FILE_SHARE_WRITE, &sec_none,
-		  OPEN_EXISTING, 0, 0);
+  h = cygwin_create_file ("CONIN$", GENERIC_READ | GENERIC_WRITE,
+			  FILE_SHARE_READ | FILE_SHARE_WRITE, &sec_none,
+			  OPEN_EXISTING, 0, 0);
 
   if (h == INVALID_HANDLE_VALUE)
     {
@@ -639,9 +640,9 @@ fhandler_console::open (int flags, mode_
   set_io_handle (h);
   set_r_no_interrupt (1);	// Handled explicitly in read code
 
-  h = CreateFile ("CONOUT$", GENERIC_READ | GENERIC_WRITE,
-		  FILE_SHARE_READ | FILE_SHARE_WRITE, &sec_none,
-		  OPEN_EXISTING, 0, 0);
+  h = cygwin_create_file ("CONOUT$", GENERIC_READ | GENERIC_WRITE,
+			  FILE_SHARE_READ | FILE_SHARE_WRITE, &sec_none,
+			  OPEN_EXISTING, 0, 0);
 
   if (h == INVALID_HANDLE_VALUE)
     {
Index: fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.68
diff -u -p -r1.68 fhandler_disk_file.cc
--- fhandler_disk_file.cc	7 Nov 2003 18:21:05 -0000	1.68
+++ fhandler_disk_file.cc	14 Nov 2003 13:20:24 -0000
@@ -402,7 +402,7 @@ fhandler_base::open_fs (int flags, mode_
   if (!res)
     goto out;
 
-  /* This is for file systems known for having a buggy CreateFile call
+  /* This is for file systems known for having a buggy cygwin_create_file call
      which might return a valid HANDLE without having actually opened
      the file.
      The only known file system to date is the SUN NFS Solstice Client 3.1
@@ -418,7 +418,7 @@ fhandler_base::open_fs (int flags, mode_
 
   /* Attributes may be set only if a file is _really_ created.
      This code is now only used for ntea here since the files
-     security attributes are set in CreateFile () now. */
+     security attributes are set in cygwin_create_file () now. */
   if (flags & O_CREAT
       && GetLastError () != ERROR_ALREADY_EXISTS
       && !allow_ntsec && allow_ntea)
@@ -611,7 +611,7 @@ fhandler_disk_file::opendir ()
 
   if (!pc.isdir ())
     set_errno (ENOTDIR);
-  else if ((len = strlen (pc))> MAX_PATH - 3)
+  else if ((len = strlen (pc))> CYG_MAX_PATH - 3)
     set_errno (ENAMETOOLONG);
   else if ((dir = (DIR *) malloc (sizeof (DIR))) == NULL)
     set_errno (ENOMEM);
@@ -718,7 +718,7 @@ fhandler_disk_file::readdir (DIR *dir)
       int len = strlen (c);
       if (strcasematch (c + len - 4, ".lnk"))
 	{
-	  char fbuf[MAX_PATH + 1];
+	  char fbuf[CYG_MAX_PATH + 1];
 	  strcpy (fbuf, dir->__d_dirname);
 	  strcpy (fbuf + strlen (fbuf) - 1, dir->__d_dirent->d_name);
 	  path_conv fpath (fbuf, PC_SYM_NOFOLLOW);
Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.37
diff -u -p -r1.37 fhandler_proc.cc
--- fhandler_proc.cc	23 Oct 2003 08:54:00 -0000	1.37
+++ fhandler_proc.cc	14 Nov 2003 13:20:25 -0000
@@ -28,6 +28,7 @@ details. */
 #include "ntdll.h"
 #include <winioctl.h>
 #include "cpuid.h"
+#include "io.h"
 
 #define _COMPILING_NEWLIB
 #include <dirent.h>
@@ -862,22 +863,22 @@ format_proc_partitions (char *destbuf, s
     {
       for (int drive_number=0;;drive_number++)
 	{
-	  CHAR szDriveName[MAX_PATH];
+	  CHAR szDriveName[CYG_MAX_PATH];
 	  __small_sprintf (szDriveName, "\\\\.\\PHYSICALDRIVE%d", drive_number);
 	  HANDLE hDevice;
-	  hDevice = CreateFile (szDriveName,
-				GENERIC_READ,
-				FILE_SHARE_READ | FILE_SHARE_WRITE,
-				NULL,
-				OPEN_EXISTING,
-				0,
-				NULL);
+	  hDevice = cygwin_create_file (szDriveName,
+					GENERIC_READ,
+					FILE_SHARE_READ | FILE_SHARE_WRITE,
+					NULL,
+					OPEN_EXISTING,
+					0,
+					NULL);
 	  if (hDevice == INVALID_HANDLE_VALUE)
 	    {
 	      if (GetLastError () == ERROR_PATH_NOT_FOUND)
 		  break;
 	      __seterrno ();
-	      debug_printf ("CreateFile %d %E", GetLastError ());
+	      debug_printf ("cygwin_create_file %d %E", GetLastError ());
 	      break;
 	    }
 	  else
Index: fhandler_process.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v
retrieving revision 1.39
diff -u -p -r1.39 fhandler_process.cc
--- fhandler_process.cc	27 Sep 2003 02:30:46 -0000	1.39
+++ fhandler_process.cc	14 Nov 2003 13:20:25 -0000
@@ -305,7 +305,7 @@ fhandler_process::fill_filebuf ()
       }
     case PROCESS_EXENAME:
       {
-	filebuf = (char *) realloc (filebuf, bufalloc = MAX_PATH);
+	filebuf = (char *) realloc (filebuf, bufalloc = CYG_MAX_PATH);
 	if (p->process_state & (PID_ZOMBIE | PID_EXITED))
 	  strcpy (filebuf, "<defunct>");
 	else
@@ -364,7 +364,7 @@ fhandler_process::fill_filebuf ()
 static _off64_t
 format_process_stat (_pinfo *p, char *destbuf, size_t maxsize)
 {
-  char cmd[MAX_PATH];
+  char cmd[CYG_MAX_PATH];
   int state = 'R';
   unsigned long fault_count = 0UL,
 		utime = 0UL, stime = 0UL,
@@ -501,7 +501,7 @@ format_process_stat (_pinfo *p, char *de
 static _off64_t
 format_process_status (_pinfo *p, char *destbuf, size_t maxsize)
 {
-  char cmd[MAX_PATH];
+  char cmd[CYG_MAX_PATH];
   int state = 'R';
   const char *state_str = "unknown";
   unsigned long vmsize = 0UL, vmrss = 0UL, vmdata = 0UL, vmlib = 0UL, vmtext = 0UL,
Index: fhandler_raw.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_raw.cc,v
retrieving revision 1.36
diff -u -p -r1.36 fhandler_raw.cc
--- fhandler_raw.cc	30 Sep 2003 21:43:40 -0000	1.36
+++ fhandler_raw.cc	14 Nov 2003 13:20:25 -0000
@@ -183,7 +183,7 @@ fhandler_dev_raw::open (int flags, mode_
 
   extern void str2buf2uni (UNICODE_STRING &, WCHAR *, const char *);
   UNICODE_STRING dev;
-  WCHAR devname[MAX_PATH + 1];
+  WCHAR devname[CYG_MAX_PATH + 1];
   str2buf2uni (dev, devname, get_win32_name ());
   OBJECT_ATTRIBUTES attr;
   InitializeObjectAttributes (&attr, &dev, OBJ_CASE_INSENSITIVE, NULL, NULL);
Index: fhandler_registry.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_registry.cc,v
retrieving revision 1.22
diff -u -p -r1.22 fhandler_registry.cc
--- fhandler_registry.cc	25 Sep 2003 00:37:16 -0000	1.22
+++ fhandler_registry.cc	14 Nov 2003 13:20:26 -0000
@@ -97,7 +97,7 @@ int
 fhandler_registry::exists ()
 {
   int file_type = 0, index = 0, pathlen;
-  DWORD buf_size = MAX_PATH;
+  DWORD buf_size = CYG_MAX_PATH;
   LONG error;
   char buf[buf_size];
   const char *file;
@@ -152,7 +152,7 @@ fhandler_registry::exists ()
 	      file_type = 1;
 	      goto out;
 	    }
-	  buf_size = MAX_PATH;
+	  buf_size = CYG_MAX_PATH;
 	}
       if (error != ERROR_NO_MORE_ITEMS)
 	{
@@ -160,7 +160,7 @@ fhandler_registry::exists ()
 	  goto out;
 	}
       index = 0;
-      buf_size = MAX_PATH;
+      buf_size = CYG_MAX_PATH;
       while (ERROR_SUCCESS ==
 	     (error = RegEnumValue (hKey, index++, buf, &buf_size, NULL, NULL,
 				    NULL, NULL))
@@ -172,7 +172,7 @@ fhandler_registry::exists ()
 	      file_type = -1;
 	      goto out;
 	    }
-	  buf_size = MAX_PATH;
+	  buf_size = CYG_MAX_PATH;
 	}
       if (error != ERROR_NO_MORE_ITEMS)
 	{
@@ -276,7 +276,7 @@ fhandler_registry::fstat (struct __stat6
 struct dirent *
 fhandler_registry::readdir (DIR * dir)
 {
-  DWORD buf_size = MAX_PATH;
+  DWORD buf_size = CYG_MAX_PATH;
   char buf[buf_size];
   HANDLE handle;
   struct dirent *res = NULL;
@@ -324,7 +324,7 @@ retry:
     {
       /* If we're finished with sub-keys, start on values under this key.  */
       dir->__d_position |= REG_ENUM_VALUES_MASK;
-      buf_size = MAX_PATH;
+      buf_size = CYG_MAX_PATH;
       goto retry;
     }
   if (error != ERROR_SUCCESS && error != ERROR_MORE_DATA)
@@ -592,7 +592,7 @@ fhandler_registry::fill_filebuf ()
     }
   return true;
 value_not_found:
-  DWORD buf_size = MAX_PATH;
+  DWORD buf_size = CYG_MAX_PATH;
   char buf[buf_size];
   int index = 0;
   while (ERROR_SUCCESS ==
@@ -604,7 +604,7 @@ value_not_found:
 	  set_errno (EISDIR);
 	  return false;
 	}
-      buf_size = MAX_PATH;
+      buf_size = CYG_MAX_PATH;
     }
   if (error != ERROR_NO_MORE_ITEMS)
     {
@@ -622,7 +622,7 @@ open_key (const char *name, REGSAM acces
   HKEY hKey = (HKEY) INVALID_HANDLE_VALUE;
   HKEY hParentKey = (HKEY) INVALID_HANDLE_VALUE;
   bool parentOpened = false;
-  char component[MAX_PATH];
+  char component[CYG_MAX_PATH];
 
   while (*name)
     {
Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.111
diff -u -p -r1.111 fhandler_socket.cc
--- fhandler_socket.cc	25 Sep 2003 03:51:50 -0000	1.111
+++ fhandler_socket.cc	14 Nov 2003 13:20:26 -0000
@@ -34,6 +34,7 @@
 #include "cygthread.h"
 #include "select.h"
 #include <unistd.h>
+#include "io.h"
 
 extern bool fdsock (cygheap_fdmanip& fd, const device *, SOCKET soc);
 extern "C" {
@@ -84,8 +85,9 @@ get_inet_addr (const struct sockaddr *in
 	  set_errno (EBADF);
 	  return 0;
 	}
-      HANDLE fh = CreateFile (pc, GENERIC_READ, wincap.shared (), &sec_none,
-			      OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
+      HANDLE fh = cygwin_create_file (pc, GENERIC_READ, wincap.shared (),
+				      &sec_none, OPEN_EXISTING,
+				      FILE_ATTRIBUTE_NORMAL, 0);
       if (fh == INVALID_HANDLE_VALUE)
 	{
 	  __seterrno ();
@@ -189,7 +191,7 @@ fhandler_socket::create_secret_event (in
       return NULL;
     }
 
-  char event_name[MAX_PATH];
+  char event_name[CYG_MAX_PATH];
   secret_event_name (event_name, sin.sin_port, secret ?: connect_secret);
   LPSECURITY_ATTRIBUTES sec = get_inheritance (true);
   secret_event = CreateEvent (sec, FALSE, FALSE, event_name);
@@ -230,7 +232,7 @@ int
 fhandler_socket::check_peer_secret_event (struct sockaddr_in* peer, int* secret)
 {
 
-  char event_name[MAX_PATH];
+  char event_name[CYG_MAX_PATH];
 
   secret_event_name (event_name, peer->sin_port, secret ?: connect_secret);
   HANDLE ev = CreateEvent (&sec_all_nih, FALSE, FALSE, event_name);
@@ -444,7 +446,8 @@ fhandler_socket::bind (const struct sock
       SECURITY_ATTRIBUTES sa = sec_none;
       if (allow_ntsec && pc.has_acls ())
 	set_security_attribute (mode, &sa, alloca (4096), 4096);
-      HANDLE fh = CreateFile (pc, GENERIC_WRITE, 0, &sa, CREATE_NEW, attr, 0);
+      HANDLE fh = cygwin_create_file (pc, GENERIC_WRITE, 0, &sa, CREATE_NEW,
+				      attr, 0);
       if (fh == INVALID_HANDLE_VALUE)
 	{
 	  if (GetLastError () == ERROR_ALREADY_EXISTS)
Index: fhandler_virtual.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v
retrieving revision 1.21
diff -u -p -r1.21 fhandler_virtual.cc
--- fhandler_virtual.cc	25 Sep 2003 02:29:05 -0000	1.21
+++ fhandler_virtual.cc	14 Nov 2003 13:20:26 -0000
@@ -52,7 +52,7 @@ fhandler_virtual::opendir ()
 
   if (exists () <= 0)
     set_errno (ENOTDIR);
-  else if ((len = strlen (get_name ())) > MAX_PATH - 3)
+  else if ((len = strlen (get_name ())) > CYG_MAX_PATH - 3)
     set_errno (ENAMETOOLONG);
   else if ((dir = (DIR *) malloc (sizeof (DIR))) == NULL)
     set_errno (ENOMEM);
Index: fork.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.114
diff -u -p -r1.114 fork.cc
--- fork.cc	26 Sep 2003 03:20:30 -0000	1.114
+++ fork.cc	14 Nov 2003 13:20:28 -0000
@@ -30,6 +30,7 @@ details. */
 #include "shared_info.h"
 #include "cygmalloc.h"
 #include "cygthread.h"
+#include "io.h"
 
 #ifdef DEBUGGING
 static int npid;
@@ -364,10 +365,10 @@ fork_parent (HANDLE& hParent, dll *&firs
 
   /* If we don't have a console, then don't create a console for the
      child either.  */
-  HANDLE console_handle = CreateFile ("CONOUT$", GENERIC_WRITE,
-				      FILE_SHARE_WRITE, &sec_none_nih,
-				      OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL,
-				      NULL);
+  HANDLE console_handle = cygwin_create_file ("CONOUT$", GENERIC_WRITE,
+					      FILE_SHARE_WRITE, &sec_none_nih,
+					      OPEN_EXISTING,
+					      FILE_ATTRIBUTE_NORMAL, NULL);
 
   if (console_handle != INVALID_HANDLE_VALUE)
     CloseHandle (console_handle);
Index: miscfuncs.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.24
diff -u -p -r1.24 miscfuncs.cc
--- miscfuncs.cc	10 Nov 2003 21:28:02 -0000	1.24
+++ miscfuncs.cc	14 Nov 2003 13:20:28 -0000
@@ -147,7 +147,7 @@ strcasestr (const char *searchee, const 
 int __stdcall
 check_null_str (const char *name)
 {
-  if (name && !IsBadStringPtr (name, MAX_PATH))
+  if (name && !IsBadStringPtr (name, CYG_MAX_PATH))
     return 0;
 
   return EFAULT;
@@ -156,7 +156,7 @@ check_null_str (const char *name)
 int __stdcall
 check_null_empty_str (const char *name)
 {
-  if (name && !IsBadStringPtr (name, MAX_PATH))
+  if (name && !IsBadStringPtr (name, CYG_MAX_PATH))
     return !*name ? ENOENT : 0;
 
   return EFAULT;
Index: mmap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mmap.cc,v
retrieving revision 1.88
diff -u -p -r1.88 mmap.cc
--- mmap.cc	6 Nov 2003 14:33:16 -0000	1.88
+++ mmap.cc	14 Nov 2003 13:20:28 -0000
@@ -900,7 +900,7 @@ fhandler_disk_file::mmap (caddr_t *addr,
       /* Grrr, the whole stuff is just needed to try to get a reliable
 	 mapping of the same file. Even that uprising isn't bullet
 	 proof but it does it's best... */
-      char namebuf[MAX_PATH];
+      char namebuf[CYG_MAX_PATH];
       cygwin_conv_to_full_posix_path (get_name (), namebuf);
       for (int i = strlen (namebuf) - 1; i >= 0; --i)
 	namebuf[i] = cyg_tolower (namebuf [i]);
Index: netdb.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/netdb.cc,v
retrieving revision 1.3
diff -u -p -r1.3 netdb.cc
--- netdb.cc	14 Dec 2002 16:59:59 -0000	1.3
+++ netdb.cc	14 Nov 2003 13:20:28 -0000
@@ -30,17 +30,17 @@ details. */
 static FILE *
 open_system_file (const char *relative_path)
 {
-  char win32_name[MAX_PATH];
-  char posix_name[MAX_PATH];
+  char win32_name[CYG_MAX_PATH];
+  char posix_name[CYG_MAX_PATH];
   if (wincap.is_winnt ())
     {
-      if (!GetSystemDirectory (win32_name, MAX_PATH))
+      if (!GetSystemDirectory (win32_name, CYG_MAX_PATH))
 	return NULL;
       strcat (win32_name, "\\drivers\\etc\\");
     }
   else
     {
-      if (!GetWindowsDirectory (win32_name, MAX_PATH))
+      if (!GetWindowsDirectory (win32_name, CYG_MAX_PATH))
 	return NULL;
       strcat (win32_name, "\\");
     }
Index: ntea.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntea.cc,v
retrieving revision 1.11
diff -u -p -r1.11 ntea.cc
--- ntea.cc	2 Jul 2003 03:16:00 -0000	1.11
+++ ntea.cc	14 Nov 2003 13:20:28 -0000
@@ -14,6 +14,7 @@ details. */
 #include <stdio.h>
 #include <stdlib.h>
 #include "security.h"
+#include "io.h"
 
 /* Default to not using NTEA information */
 bool allow_ntea;
@@ -90,12 +91,12 @@ NTReadEA (const char *file, const char *
     PFILE_FULL_EA_INFORMATION ea, sea;
     int easize;
 
-    hFileSource = CreateFile (file, FILE_READ_EA,
-			      FILE_SHARE_READ | FILE_SHARE_WRITE,
-			      &sec_none_nih, // sa
-			      OPEN_EXISTING,
-			      FILE_FLAG_BACKUP_SEMANTICS,
-			      NULL);
+    hFileSource = cygwin_create_file (file, FILE_READ_EA,
+				      FILE_SHARE_READ | FILE_SHARE_WRITE,
+				      &sec_none_nih, // sa
+				      OPEN_EXISTING,
+				      FILE_FLAG_BACKUP_SEMANTICS,
+				      NULL);
 
     if (hFileSource == INVALID_HANDLE_VALUE)
 	return 0;
@@ -258,12 +259,12 @@ NTWriteEA (const char *file, const char 
   BOOL bSuccess=FALSE;
   PFILE_FULL_EA_INFORMATION ea;
 
-  hFileSource = CreateFile (file, FILE_WRITE_EA,
-			    FILE_SHARE_READ | FILE_SHARE_WRITE,
-			    &sec_none_nih, // sa
-			    OPEN_EXISTING,
-			    FILE_FLAG_BACKUP_SEMANTICS,
-			    NULL);
+  hFileSource = cygwin_create_file (file, FILE_WRITE_EA,
+				    FILE_SHARE_READ | FILE_SHARE_WRITE,
+				    &sec_none_nih, // sa
+				    OPEN_EXISTING,
+				    FILE_FLAG_BACKUP_SEMANTICS,
+				    NULL);
 
   if (hFileSource == INVALID_HANDLE_VALUE)
     return FALSE;
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.278
diff -u -p -r1.278 path.cc
--- path.cc	29 Oct 2003 01:15:12 -0000	1.278
+++ path.cc	14 Nov 2003 13:20:37 -0000
@@ -73,6 +73,7 @@ details. */
 #include "shared_info.h"
 #include "registry.h"
 #include <assert.h>
+#include "io.h"
 
 #ifdef _MT_SAFE
 #define iteration _reent_winsup ()->_iteration
@@ -88,7 +89,7 @@ static void backslashify (const char *sr
 
 struct symlink_info
 {
-  char contents[MAX_PATH + 4];
+  char contents[CYG_MAX_PATH + 4];
   char *ext_here;
   int extn;
   unsigned pflags;
@@ -302,7 +303,7 @@ normalize_posix_path (const char *src, c
 
 	  *dst++ = '/';
 	}
-	if ((dst - dst_start) >= MAX_PATH)
+	if ((dst - dst_start) >= CYG_MAX_PATH)
 	  {
 	    debug_printf ("ENAMETOOLONG = normalize_posix_path (%s)", src);
 	    return ENAMETOOLONG;
@@ -333,7 +334,7 @@ static void __stdcall mkrelpath (char *d
 static void __stdcall
 mkrelpath (char *path)
 {
-  char cwd_win32[MAX_PATH];
+  char cwd_win32[CYG_MAX_PATH];
   if (!cygheap->cwd.get (cwd_win32, 0))
     return;
 
@@ -359,8 +360,8 @@ mkrelpath (char *path)
 bool
 fs_info::update (const char *win32_path)
 {
-  char tmp_buf [MAX_PATH];
-  strncpy (tmp_buf, win32_path, MAX_PATH);
+  char tmp_buf [CYG_MAX_PATH];
+  strncpy (tmp_buf, win32_path, CYG_MAX_PATH);
 
   if (!rootdir (tmp_buf))
     {
@@ -373,7 +374,7 @@ fs_info::update (const char *win32_path)
   if (strcmp (tmp_buf, root_dir_storage) == 0)
     return 1;
 
-  strncpy (root_dir_storage, tmp_buf, MAX_PATH);
+  strncpy (root_dir_storage, tmp_buf, CYG_MAX_PATH);
   drive_type_storage = GetDriveType (root_dir_storage);
   if (drive_type_storage == DRIVE_REMOTE || (drive_type_storage == DRIVE_UNKNOWN && (root_dir_storage[0] == '\\' && root_dir_storage[1] == '\\')))
     is_remote_drive_storage = 1;
@@ -449,11 +450,11 @@ void
 path_conv::check (const char *src, unsigned opt,
 		  const suffix_info *suffixes)
 {
-  /* This array is used when expanding symlinks.  It is MAX_PATH * 2
+  /* This array is used when expanding symlinks.  It is CYG_MAX_PATH * 2
      in length so that we can hold the expanded symlink plus a
      trailer.  */
-  char path_copy[MAX_PATH + 3];
-  char tmp_buf[2 * MAX_PATH + 3];
+  char path_copy[CYG_MAX_PATH + 3];
+  char tmp_buf[2 * CYG_MAX_PATH + 3];
   symlink_info sym;
   bool need_directory = 0;
   bool saw_symlinks = 0;
@@ -463,7 +464,7 @@ path_conv::check (const char *src, unsig
 
 #if 0
   static path_conv last_path_conv;
-  static char last_src[MAX_PATH + 1];
+  static char last_src[CYG_MAX_PATH + 1];
 
   if (*last_src && strcmp (last_src, src) == 0)
     {
@@ -529,7 +530,7 @@ path_conv::check (const char *src, unsig
       for (;;)
 	{
 	  const suffix_info *suff;
-	  char pathbuf[MAX_PATH];
+	  char pathbuf[CYG_MAX_PATH];
 	  char *full_path;
 
 	  /* Don't allow symlink.check to set anything in the path_conv
@@ -737,7 +738,7 @@ path_conv::check (const char *src, unsig
 	 \0 added to path_copy above. */
       int taillen = strlen (++tail);
       int buflen = strlen (sym.contents);
-      if (buflen + taillen > MAX_PATH)
+      if (buflen + taillen > CYG_MAX_PATH)
 	  {
 	    error = ENAMETOOLONG;
 	    strcpy (path, "::ENAMETOOLONG::");
@@ -953,7 +954,7 @@ normalize_win32_path (const char *src, c
 		  *p = '\0';
 	    }
 	}
-      if (strlen (dst) + 1 + strlen (src) >= MAX_PATH)
+      if (strlen (dst) + 1 + strlen (src) >= CYG_MAX_PATH)
 	{
 	  debug_printf ("ENAMETOOLONG = normalize_win32_path (%s)", src);
 	  return ENAMETOOLONG;
@@ -998,7 +999,7 @@ normalize_win32_path (const char *src, c
 	    *dst++ = *src;
 	  ++src;
 	}
-      if ((dst - dst_start) >= MAX_PATH)
+      if ((dst - dst_start) >= CYG_MAX_PATH)
 	return ENAMETOOLONG;
     }
   *dst = 0;
@@ -1103,8 +1104,8 @@ conv_path_list (const char *src, char *d
     {
       s = strccpy (srcbuf, &src, src_delim);
       int len = s - srcbuf;
-      if (len >= MAX_PATH)
-	srcbuf[MAX_PATH - 1] = '\0';
+      if (len >= CYG_MAX_PATH)
+	srcbuf[CYG_MAX_PATH - 1] = '\0';
       (*conv_fn) (len ? srcbuf : ".", d);
       if (!*src++)
 	break;
@@ -1301,7 +1302,7 @@ mount_item::build_win32 (char *dst, cons
 
    The result is zero for success, or an errno value.
 
-   {,full_}win32_path must have sufficient space (i.e. MAX_PATH bytes).  */
+   {,full_}win32_path must have sufficient space (i.e. CYG_MAX_PATH bytes).  */
 
 int
 mount_info::conv_to_win32_path (const char *src_path, char *dst, device& dev,
@@ -1325,7 +1326,7 @@ mount_info::conv_to_win32_path (const ch
   *flags = 0;
   debug_printf ("conv_to_win32_path (%s)", src_path);
 
-  if (src_path_len >= MAX_PATH)
+  if (src_path_len >= CYG_MAX_PATH)
     {
       debug_printf ("ENAMETOOLONG = conv_to_win32_path (%s)", src_path);
       return ENAMETOOLONG;
@@ -1333,7 +1334,7 @@ mount_info::conv_to_win32_path (const ch
 
   int i, rc;
   mount_item *mi = NULL;	/* initialized to avoid compiler warning */
-  char pathbuf[MAX_PATH];
+  char pathbuf[CYG_MAX_PATH];
 
   if (dst == NULL)
     goto out;		/* Sanity check. */
@@ -1530,7 +1531,7 @@ mount_info::cygdrive_win32_path (const c
 /* conv_to_posix_path: Ensure src_path is a POSIX path.
 
    The result is zero for success, or an errno value.
-   posix_path must have sufficient space (i.e. MAX_PATH bytes).
+   posix_path must have sufficient space (i.e. CYG_MAX_PATH bytes).
    If keep_rel_p is non-zero, relative paths stay that way.  */
 
 int
@@ -1554,7 +1555,7 @@ mount_info::conv_to_posix_path (const ch
 		trailing_slash_p ? "add-slash" : "no-add-slash");
   MALLOC_CHECK;
 
-  if (src_path_len >= MAX_PATH)
+  if (src_path_len >= CYG_MAX_PATH)
     {
       debug_printf ("ENAMETOOLONG");
       return ENAMETOOLONG;
@@ -1570,7 +1571,7 @@ mount_info::conv_to_posix_path (const ch
       return 0;
     }
 
-  char pathbuf[MAX_PATH];
+  char pathbuf[CYG_MAX_PATH];
   int rc = normalize_win32_path (src_path, pathbuf);
   if (rc != 0)
     {
@@ -1600,7 +1601,7 @@ mount_info::conv_to_posix_path (const ch
 	nextchar = 1;
 
       int addslash = nextchar > 0 ? 1 : 0;
-      if ((mi.posix_pathlen + (pathbuflen - mi.native_pathlen) + addslash) >= MAX_PATH)
+      if ((mi.posix_pathlen + (pathbuflen - mi.native_pathlen) + addslash) >= CYG_MAX_PATH)
 	return ENAMETOOLONG;
       strcpy (posix_path, mi.posix_path);
       if (addslash)
@@ -1617,7 +1618,7 @@ mount_info::conv_to_posix_path (const ch
 	}
       if (mi.flags & MOUNT_ENC)
 	{
-	  char tmpbuf[MAX_PATH + 1];
+	  char tmpbuf[CYG_MAX_PATH + 1];
 	  if (fnunmunge (tmpbuf, posix_path))
 	    strcpy (posix_path, tmpbuf);
 	}
@@ -1680,7 +1681,7 @@ mount_info::set_flags_from_win32_path (c
 void
 mount_info::read_mounts (reg_key& r)
 {
-  char posix_path[MAX_PATH];
+  char posix_path[CYG_MAX_PATH];
   HKEY key = r.get_key ();
   DWORD i, posix_path_size;
   int res;
@@ -1691,13 +1692,13 @@ mount_info::read_mounts (reg_key& r)
      arbitrarily large number of mounts. */
   for (i = 0; ; i++)
     {
-      char native_path[MAX_PATH];
+      char native_path[CYG_MAX_PATH];
       int mount_flags;
 
-      posix_path_size = MAX_PATH;
+      posix_path_size = CYG_MAX_PATH;
       /* FIXME: if maximum posix_path_size is 256, we're going to
 	 run into problems if we ever try to store a mount point that's
-	 over 256 but is under MAX_PATH. */
+	 over 256 but is under CYG_MAX_PATH. */
       res = RegEnumKeyEx (key, i, posix_path, &posix_path_size, NULL,
 			  NULL, NULL, NULL);
 
@@ -1987,7 +1988,7 @@ mount_info::get_cygdrive_info (char *use
 {
   /* Get the user path prefix from HKEY_CURRENT_USER. */
   reg_key r;
-  int res = r.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, user, MAX_PATH, "");
+  int res = r.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, user, CYG_MAX_PATH, "");
 
   /* Get the user flags, if appropriate */
   if (res == ERROR_SUCCESS)
@@ -2001,7 +2002,7 @@ mount_info::get_cygdrive_info (char *use
 	      CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
 	      CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
 	      NULL);
-  int res2 = r2.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, system, MAX_PATH, "");
+  int res2 = r2.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, system, CYG_MAX_PATH, "");
 
   /* Get the system flags, if appropriate */
   if (res2 == ERROR_SUCCESS)
@@ -2121,8 +2122,8 @@ mount_info::add_item (const char *native
     }
 
   /* Make sure both paths do not end in /. */
-  char nativetmp[MAX_PATH];
-  char posixtmp[MAX_PATH];
+  char nativetmp[CYG_MAX_PATH];
+  char posixtmp[CYG_MAX_PATH];
 
   backslashify (native, nativetmp, 0);
   nofinalslash (nativetmp, nativetmp);
@@ -2181,7 +2182,7 @@ mount_info::add_item (const char *native
 int
 mount_info::del_item (const char *path, unsigned flags, int reg_p)
 {
-  char pathtmp[MAX_PATH];
+  char pathtmp[CYG_MAX_PATH];
   int posix_path_p = false;
 
   /* Something's wrong if path is NULL or empty. */
@@ -2304,7 +2305,7 @@ static struct mntent *
 cygdrive_getmntent ()
 {
   char native_path[4];
-  char posix_path[MAX_PATH];
+  char posix_path[CYG_MAX_PATH];
   DWORD mask = 1, drive = 'a';
   struct mntent *ret = NULL;
 
@@ -2486,9 +2487,9 @@ symlink_worker (const char *topath, cons
   HANDLE h;
   int res = -1;
   path_conv win32_path, win32_topath;
-  char from[MAX_PATH + 5];
-  char cwd[MAX_PATH + 1], *cp = NULL, c = 0;
-  char w32topath[MAX_PATH + 1];
+  char from[CYG_MAX_PATH + 5];
+  char cwd[CYG_MAX_PATH + 1], *cp = NULL, c = 0;
+  char w32topath[CYG_MAX_PATH + 1];
   DWORD written;
   SECURITY_ATTRIBUTES sa = sec_none_nih;
 
@@ -2499,7 +2500,7 @@ symlink_worker (const char *topath, cons
       check_null_empty_str_errno (frompath))
     goto done;
 
-  if (strlen (topath) >= MAX_PATH)
+  if (strlen (topath) >= CYG_MAX_PATH)
     {
       set_errno (ENAMETOOLONG);
       goto done;
@@ -2540,7 +2541,7 @@ symlink_worker (const char *topath, cons
     {
       if (!isabspath (topath))
 	{
-	  getcwd (cwd, MAX_PATH + 1);
+	  getcwd (cwd, CYG_MAX_PATH + 1);
 	  if ((cp = strrchr (from, '/')) || (cp = strrchr (from, '\\')))
 	    {
 	      c = *cp;
@@ -2567,7 +2568,7 @@ symlink_worker (const char *topath, cons
     set_security_attribute (S_IFLNK | STD_RBITS | STD_WBITS,
 			    &sa, alloca (4096), 4096);
 
-  h = CreateFile (win32_path, GENERIC_WRITE, 0, &sa, create_how,
+  h = cygwin_create_file (win32_path, GENERIC_WRITE, 0, &sa, create_how,
 		  FILE_ATTRIBUTE_NORMAL, 0);
   if (h == INVALID_HANDLE_VALUE)
     __seterrno ();
@@ -2597,7 +2598,7 @@ symlink_worker (const char *topath, cons
       else
 	{
 	  /* This is the old technique creating a symlink. */
-	  char buf[sizeof (SYMLINK_COOKIE) + MAX_PATH + 10];
+	  char buf[sizeof (SYMLINK_COOKIE) + CYG_MAX_PATH + 10];
 
 	  __small_sprintf (buf, "%s%s", SYMLINK_COOKIE, topath);
 	  DWORD len = strlen (buf) + 1;
@@ -2677,7 +2678,7 @@ check_shortcut (const char *path, DWORD 
       *error = EIO;
       goto close_it;
     }
-  if (got != sizeof len || len == 0 || len > MAX_PATH)
+  if (got != sizeof len || len == 0 || len > CYG_MAX_PATH)
     goto file_not_symlink;
   /* Now read description entry. */
   if (!ReadFile (h, contents, len, &got, 0))
@@ -2723,7 +2724,7 @@ check_sysfile (const char *path, DWORD f
       /* It's a symlink.  */
       *pflags = PATH_SYMLINK;
 
-      res = ReadFile (h, contents, MAX_PATH + 1, &got, 0);
+      res = ReadFile (h, contents, CYG_MAX_PATH + 1, &got, 0);
       if (!res)
 	{
 	  debug_printf ("ReadFile2 failed");
@@ -3010,8 +3011,9 @@ symlink_info::check (char *path, const s
 
       /* Open the file.  */
 
-      h = CreateFile (suffix.path, GENERIC_READ, FILE_SHARE_READ,
-		      &sec_none_nih, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
+      h = cygwin_create_file (suffix.path, GENERIC_READ, FILE_SHARE_READ,
+			      &sec_none_nih, OPEN_EXISTING,
+			      FILE_ATTRIBUTE_NORMAL, 0);
       res = -1;
       if (h == INVALID_HANDLE_VALUE)
 	goto file_not_symlink;
@@ -3219,7 +3221,7 @@ getcwd (char *buf, size_t ulen)
 extern "C" char *
 getwd (char *buf)
 {
-  return getcwd (buf, MAX_PATH);
+  return getcwd (buf, CYG_MAX_PATH);
 }
 
 /* chdir: POSIX 5.2.1.1 */
@@ -3640,7 +3642,7 @@ cwdstuff::get_initial ()
 
   int i;
   DWORD len, dlen;
-  for (i = 0, dlen = MAX_PATH, len = 0; i < 3; dlen *= 2, i++)
+  for (i = 0, dlen = CYG_MAX_PATH, len = 0; i < 3; dlen *= 2, i++)
     {
       win32 = (char *) crealloc (win32, dlen + 2);
       if ((len = GetCurrentDirectoryA (dlen, win32)) < dlen)
@@ -3665,7 +3667,7 @@ cwdstuff::get_initial ()
 void
 cwdstuff::set (const char *win32_cwd, const char *posix_cwd)
 {
-  char pathbuf[MAX_PATH];
+  char pathbuf[CYG_MAX_PATH];
 
   if (win32_cwd)
     {
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.56
diff -u -p -r1.56 path.h
--- path.h	25 Sep 2003 00:37:17 -0000	1.56
+++ path.h	14 Nov 2003 13:20:37 -0000
@@ -73,8 +73,8 @@ enum path_types
 class symlink_info;
 struct fs_info
 {
-  char name_storage[MAX_PATH];
-  char root_dir_storage[MAX_PATH];
+  char name_storage[CYG_MAX_PATH];
+  char root_dir_storage[CYG_MAX_PATH];
   DWORD flags_storage;
   DWORD serial_storage;
   DWORD sym_opt_storage; /* additional options to pass to symlink_info resolver */
@@ -199,7 +199,7 @@ class path_conv
   size_t normalized_path_size;
   void set_normalized_path (const char *) __attribute__ ((regparm (2)));
  private:
-  char path[MAX_PATH];
+  char path[CYG_MAX_PATH];
 };
 
 /* Symlink marker */
Index: pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.90
diff -u -p -r1.90 pinfo.cc
--- pinfo.cc	27 Sep 2003 02:30:46 -0000	1.90
+++ pinfo.cc	14 Nov 2003 13:20:37 -0000
@@ -146,7 +146,7 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
   for (int i = 0; i < 10; i++)
     {
       int created;
-      char mapname[MAX_PATH];
+      char mapname[MAX_PATH]; /* XXX Not a path */
       __small_sprintf (mapname, "cygpid.%x", n);
 
       int mapsize;
Index: pinfo.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.h,v
retrieving revision 1.53
diff -u -p -r1.53 pinfo.h
--- pinfo.h	27 Sep 2003 01:58:23 -0000	1.53
+++ pinfo.h	14 Nov 2003 13:20:37 -0000
@@ -66,7 +66,7 @@ public:
   DWORD dwProcessId;
 
   /* Used to spawn a child for fork(), among other things. */
-  char progname[MAX_PATH];
+  char progname[CYG_MAX_PATH];
 
   /* User information.
      The information is derived from the GetUserName system call,
Index: pthread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pthread.cc,v
retrieving revision 1.24
diff -u -p -r1.24 pthread.cc
--- pthread.cc	27 Oct 2003 11:48:29 -0000	1.24
+++ pthread.cc	14 Nov 2003 13:20:37 -0000
@@ -168,8 +168,8 @@ mangle_sem_name (char *mangled, const ch
   if (check_null_empty_str_errno (name))
     return false;
   int len = strlen (name);
-  if (len > MAX_PATH
-      || (wincap.has_terminal_services () && len > MAX_PATH - 7))
+  if (len > CYG_MAX_PATH
+      || (wincap.has_terminal_services () && len > CYG_MAX_PATH - 7))
     {
       set_errno (EINVAL);
       return false;
@@ -196,7 +196,7 @@ sem_open (const char *name, int oflag, .
       value = va_arg (ap, unsigned int);
       va_end (ap);
     }
-  char mangled_name[MAX_PATH + 1];
+  char mangled_name[CYG_MAX_PATH + 1];
   if (!mangle_sem_name (mangled_name, name))
     return NULL;
   return semaphore::open (mangled_name, oflag, mode, value);
Index: registry.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/registry.cc,v
retrieving revision 1.17
diff -u -p -r1.17 registry.cc
--- registry.cc	10 Sep 2003 21:01:40 -0000	1.17
+++ registry.cc	14 Nov 2003 13:20:37 -0000
@@ -226,7 +226,7 @@ void
 load_registry_hive (PSID psid)
 {
   char sid[256];
-  char path[MAX_PATH + 1];
+  char path[CYG_MAX_PATH + 1];
   HKEY hkey;
   LONG ret;
 
Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.154
diff -u -p -r1.154 security.cc
--- security.cc	16 Oct 2003 23:20:41 -0000	1.154
+++ security.cc	14 Nov 2003 13:20:39 -0000
@@ -39,6 +39,7 @@ details. */
 #include "ntdll.h"
 #include "lm.h"
 #include "pwdgrp.h"
+#include "io.h"
 
 bool allow_ntsec;
 /* allow_smbntsec is handled exclusively in path.cc (path_conv::check).
@@ -1145,13 +1146,13 @@ write_sd (const char *file, PSECURITY_DE
     return -1;
 
   HANDLE fh;
-  fh = CreateFile (file,
-		   WRITE_OWNER | WRITE_DAC,
-		   FILE_SHARE_READ | FILE_SHARE_WRITE,
-		   &sec_none_nih,
-		   OPEN_EXISTING,
-		   FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,
-		   NULL);
+  fh = cygwin_create_file (file,
+			   WRITE_OWNER | WRITE_DAC,
+			   FILE_SHARE_READ | FILE_SHARE_WRITE,
+			   &sec_none_nih,
+			   OPEN_EXISTING,
+			   FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,
+			   NULL);
 
   if (fh == INVALID_HANDLE_VALUE)
     {
Index: shared.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.77
diff -u -p -r1.77 shared.cc
--- shared.cc	10 Oct 2003 19:07:08 -0000	1.77
+++ shared.cc	14 Nov 2003 13:20:39 -0000
@@ -87,7 +87,7 @@ open_shared (const char *name, int n, HA
   if (!shared_h)
     {
       char *mapname;
-      char map_buf[MAX_PATH];
+      char map_buf[CYG_MAX_PATH];
       if (!name)
 	mapname = NULL;
       else
Index: shared_info.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
retrieving revision 1.37
diff -u -p -r1.37 shared_info.h
--- shared_info.h	25 Sep 2003 04:03:53 -0000	1.37
+++ shared_info.h	14 Nov 2003 13:20:39 -0000
@@ -20,11 +20,11 @@ class mount_item
      area [with the user being able to configure at runtime the max size].  */
   /* Win32-style mounted partition source ("C:\foo\bar").
      native_path[0] == 0 for unused entries.  */
-  char native_path[MAX_PATH];
+  char native_path[CYG_MAX_PATH];
   int native_pathlen;
 
   /* POSIX-style mount point ("/foo/bar") */
-  char posix_path[MAX_PATH];
+  char posix_path[CYG_MAX_PATH];
   int posix_pathlen;
 
   unsigned flags;
@@ -62,7 +62,7 @@ class mount_info
   /* cygdrive_prefix is used as the root of the path automatically
      prepended to a path when the path has no associated mount.
      cygdrive_flags are the default flags for the cygdrives. */
-  char cygdrive[MAX_PATH];
+  char cygdrive[CYG_MAX_PATH];
   size_t cygdrive_len;
   unsigned cygdrive_flags;
  private:
@@ -120,7 +120,7 @@ class mount_info
 
 class delqueue_list
 {
-  char name[MAX_DELQUEUES_PENDING][MAX_PATH];
+  char name[MAX_DELQUEUES_PENDING][CYG_MAX_PATH];
   char inuse[MAX_DELQUEUES_PENDING];
   int empty;
 
Index: smallprint.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/smallprint.c,v
retrieving revision 1.13
diff -u -p -r1.13 smallprint.c
--- smallprint.c	25 Sep 2003 00:37:17 -0000	1.13
+++ smallprint.c	14 Nov 2003 13:20:39 -0000
@@ -63,7 +63,7 @@ rn (char *dst, int base, int dosign, lon
 int
 __small_vsprintf (char *dst, const char *fmt, va_list ap)
 {
-  char tmp[MAX_PATH + 1];
+  char tmp[CYG_MAX_PATH + 1];
   char *orig = dst;
   const char *s;
 
@@ -149,7 +149,7 @@ __small_vsprintf (char *dst, const char 
 		  dst = rn (dst, 16, 0, va_arg (ap, long long), len, pad);
 		  break;
 		case 'P':
-		  if (!GetModuleFileName (NULL, tmp, MAX_PATH))
+		  if (!GetModuleFileName (NULL, tmp, CYG_MAX_PATH))
 		    s = "cygwin program";
 		  else
 		    s = tmp;
Index: spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.137
diff -u -p -r1.137 spawn.cc
--- spawn.cc	27 Sep 2003 01:58:23 -0000	1.137
+++ spawn.cc	14 Nov 2003 13:20:41 -0000
@@ -34,8 +34,9 @@ details. */
 #include "registry.h"
 #include "environ.h"
 #include "cygthread.h"
+#include "io.h"
 
-#define LINE_BUF_CHUNK (MAX_PATH * 2)
+#define LINE_BUF_CHUNK (CYG_MAX_PATH * 2)
 
 static suffix_info std_suffixes[] =
 {
@@ -88,7 +89,7 @@ find_exec (const char *name, path_conv& 
   const char *suffix = "";
   debug_printf ("find_exec (%s)", name);
   const char *retval = buf;
-  char tmp[MAX_PATH];
+  char tmp[CYG_MAX_PATH];
   const char *posix = (opt & FE_NATIVE) ? NULL : name;
   bool has_slash = strchr (name, '/');
 
@@ -307,7 +308,7 @@ av::unshift (const char *what, int conv)
 
   argv = av;
   memmove (argv + 1, argv, (argc + 1) * sizeof (char *));
-  char buf[MAX_PATH + 1];
+  char buf[CYG_MAX_PATH + 1];
   if (conv)
     {
       cygwin_conv_to_posix_path (what, buf);
@@ -450,10 +451,10 @@ spawn_guts (const char * prog_arg, const
      that it is NOT a script file */
   while (*ext == '\0')
     {
-      HANDLE hnd = CreateFile (real_path, GENERIC_READ,
-			       FILE_SHARE_READ | FILE_SHARE_WRITE,
-			       &sec_none_nih, OPEN_EXISTING,
-			       FILE_ATTRIBUTE_NORMAL, 0);
+      HANDLE hnd = cygwin_create_file (real_path, GENERIC_READ,
+				       FILE_SHARE_READ | FILE_SHARE_WRITE,
+				       &sec_none_nih, OPEN_EXISTING,
+				       FILE_ATTRIBUTE_NORMAL, 0);
       if (hnd == INVALID_HANDLE_VALUE)
 	{
 	  __seterrno ();
@@ -462,7 +463,7 @@ spawn_guts (const char * prog_arg, const
 
       DWORD done;
 
-      char buf[2 * MAX_PATH + 1];
+      char buf[2 * CYG_MAX_PATH + 1];
       buf[0] = buf[1] = buf[2] = buf[sizeof (buf) - 1] = '\0';
       if (!ReadFile (hnd, buf, sizeof (buf) - 1, &done, 0))
 	{
Index: strace.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strace.cc,v
retrieving revision 1.43
diff -u -p -r1.43 strace.cc
--- strace.cc	25 Sep 2003 00:37:17 -0000	1.43
+++ strace.cc	14 Nov 2003 13:20:41 -0000
@@ -133,7 +133,7 @@ strace::vsprntf (char *buf, const char *
     count = 0;
   else
     {
-      char *p, progname[MAX_PATH + 1];
+      char *p, progname[CYG_MAX_PATH + 1];
       if (!pn)
 	p = (char *) "*** unknown ***";
       else if ((p = strrchr (pn, '\\')) != NULL)
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.299
diff -u -p -r1.299 syscalls.cc
--- syscalls.cc	8 Nov 2003 16:38:34 -0000	1.299
+++ syscalls.cc	14 Nov 2003 13:20:42 -0000
@@ -39,6 +39,7 @@ details. */
 #include <wininet.h>
 #include <lmcons.h> /* for UNLEN */
 #include <rpc.h>
+#include "io.h"
 
 #undef fstat
 #undef lstat
@@ -174,7 +175,7 @@ unlink (const char *ourname)
   if (wincap.has_delete_on_close ())
     {
       HANDLE h;
-      h = CreateFile (win32_name, 0, FILE_SHARE_READ, &sec_none_nih,
+      h = cygwin_create_file (win32_name, 0, FILE_SHARE_READ, &sec_none_nih,
 		      OPEN_EXISTING, FILE_FLAG_DELETE_ON_CLOSE, 0);
       if (h != INVALID_HANDLE_VALUE)
 	{
@@ -185,12 +186,12 @@ unlink (const char *ourname)
 	  if (GetFileAttributes (win32_name) == INVALID_FILE_ATTRIBUTES
 	      || !win32_name.isremote ())
 	    {
-	      syscall_printf ("CreateFile (FILE_FLAG_DELETE_ON_CLOSE) succeeded");
+	      syscall_printf ("cygwin_create_file (FILE_FLAG_DELETE_ON_CLOSE) succeeded");
 	      goto ok;
 	    }
 	  else
 	    {
-	      syscall_printf ("CreateFile (FILE_FLAG_DELETE_ON_CLOSE) failed");
+	      syscall_printf ("cygwin_create_file (FILE_FLAG_DELETE_ON_CLOSE) failed");
 	      if (setattrs)
 		SetFileAttributes (win32_name, (DWORD) win32_name & ~(FILE_ATTRIBUTE_READONLY | FILE_ATTRIBUTE_SYSTEM));
 	    }
@@ -200,7 +201,7 @@ unlink (const char *ourname)
   /* Try a delete with attributes reset */
   if (DeleteFile (win32_name))
     {
-      syscall_printf ("DeleteFile after CreateFile/CloseHandle succeeded");
+      syscall_printf ("DeleteFile after cygwin_create_file/CloseHandle succeeded");
       goto ok;
     }
 
@@ -689,7 +690,7 @@ link (const char *a, const char *b)
     }
 
   /* Shortcut hack. */
-  char new_lnk_buf[MAX_PATH + 5];
+  char new_lnk_buf[CYG_MAX_PATH + 5];
   if (allow_winsymlinks && real_a.is_lnk_symlink () && !real_b.case_clash)
     {
       strcpy (new_lnk_buf, b);
@@ -710,14 +711,14 @@ link (const char *a, const char *b)
       LPVOID lpContext;
       DWORD cbPathLen;
       DWORD StreamSize;
-      WCHAR wbuf[MAX_PATH];
+      WCHAR wbuf[CYG_MAX_PATH];
 
       BOOL bSuccess;
 
-      hFileSource = CreateFile (real_a, FILE_WRITE_ATTRIBUTES,
-				FILE_SHARE_READ | FILE_SHARE_WRITE /*| FILE_SHARE_DELETE*/,
-				&sec_none_nih, // sa
-				OPEN_EXISTING, 0, NULL);
+      hFileSource = cygwin_create_file (real_a, FILE_WRITE_ATTRIBUTES,
+					FILE_SHARE_READ | FILE_SHARE_WRITE /*| FILE_SHARE_DELETE*/,
+					&sec_none_nih, // sa
+					OPEN_EXISTING, 0, NULL);
 
       if (hFileSource == INVALID_HANDLE_VALUE)
 	{
@@ -725,7 +726,7 @@ link (const char *a, const char *b)
 	  goto docopy;
 	}
 
-      cbPathLen = sys_mbstowcs (wbuf, real_b, MAX_PATH) * sizeof (WCHAR);
+      cbPathLen = sys_mbstowcs (wbuf, real_b, CYG_MAX_PATH) * sizeof (WCHAR);
 
       StreamId.dwStreamId = BACKUP_LINK;
       StreamId.dwStreamAttributes = 0;
@@ -1365,7 +1366,7 @@ rename (const char *oldpath, const char 
   path_conv real_new (newpath, PC_SYM_NOFOLLOW);
 
   /* Shortcut hack. */
-  char new_lnk_buf[MAX_PATH + 5];
+  char new_lnk_buf[CYG_MAX_PATH + 5];
   if (real_old.is_lnk_symlink () && !real_new.error && !real_new.case_clash)
     {
       strcpy (new_lnk_buf, newpath);
@@ -1405,7 +1406,7 @@ rename (const char *oldpath, const char 
       && (lnk_suffix = strrchr (real_new.get_win32 (), '.')))
      *lnk_suffix = '\0';
 
-  if (!MoveFile (real_old, real_new))
+  if (!cygwin_move_file (real_old, real_new))
     res = -1;
 
   if (res == 0 || (GetLastError () != ERROR_ALREADY_EXISTS
@@ -1414,7 +1415,7 @@ rename (const char *oldpath, const char 
 
   if (wincap.has_move_file_ex ())
     {
-      if (MoveFileEx (real_old.get_win32 (), real_new.get_win32 (),
+      if (cygwin_move_file_ex (real_old.get_win32 (), real_new.get_win32 (),
 		      MOVEFILE_REPLACE_EXISTING))
 	res = 0;
     }
@@ -1430,7 +1431,7 @@ rename (const char *oldpath, const char 
 			      real_new.get_win32 ());
 	      break;
 	    }
-	  else if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
+	  else if (cygwin_move_file (real_old.get_win32 (), real_new.get_win32 ()))
 	    {
 	      res = 0;
 	      break;
@@ -2044,7 +2045,7 @@ static int __stdcall
 mknod_worker (const char *path, mode_t type, mode_t mode, _major_t major,
 	      _minor_t minor)
 {
-  char buf[sizeof (":\\00000000:00000000:00000000") + MAX_PATH];
+  char buf[sizeof (":\\00000000:00000000:00000000") + CYG_MAX_PATH];
   sprintf (buf, ":\\%x:%x:%x", major, minor,
 	   type | (mode & (S_IRWXU | S_IRWXG | S_IRWXO)));
   return symlink_worker (buf, path, true, true);
@@ -2056,7 +2057,7 @@ mknod32 (const char *path, mode_t mode, 
   if (check_null_empty_str_errno (path))
     return -1;
 
-  if (strlen (path) >= MAX_PATH)
+  if (strlen (path) >= CYG_MAX_PATH)
     return -1;
 
   path_conv w32path (path, PC_SYM_NOFOLLOW | PC_FULL);
@@ -2595,7 +2596,7 @@ extern "C" void
 updwtmp (const char *wtmp_file, const struct utmp *ut)
 {
   /* Writing to wtmp must be atomic to prevent mixed up data. */
-  char mutex_name[MAX_PATH];
+  char mutex_name[CYG_MAX_PATH];
   HANDLE mutex;
   int fd;
 
@@ -2833,7 +2834,7 @@ pututline (struct utmp *ut)
 		ut->ut_user, ut->ut_host);
   /* Read/write to utmp must be atomic to prevent overriding data
      by concurrent processes. */
-  char mutex_name[MAX_PATH];
+  char mutex_name[CYG_MAX_PATH];
   HANDLE mutex = CreateMutex (NULL, FALSE,
 			      shared_name (mutex_name, "utmp_mutex", 0));
   if (mutex)
@@ -2987,7 +2988,7 @@ getusershell ()
     "/usr/bin/csh",
     NULL
   };
-  static char buf[MAX_PATH];
+  static char buf[CYG_MAX_PATH];
   int ch, buf_idx;
 
   if (!shell_fp && !(shell_fp = fopen64 (ETC_SHELLS, "rt")))
@@ -3002,11 +3003,11 @@ getusershell ()
   /* Get each non-whitespace character as part of the shell path as long as
      it fits in buf. */
   for (buf_idx = 0;
-       ch != EOF && !isspace (ch) && buf_idx < MAX_PATH;
+       ch != EOF && !isspace (ch) && buf_idx < CYG_MAX_PATH;
        buf_idx++, ch = getc (shell_fp))
     buf[buf_idx] = ch;
   /* Skip any trailing non-whitespace character not fitting in buf.  If the
-     path is longer than MAX_PATH, it's invalid anyway. */
+     path is longer than CYG_MAX_PATH, it's invalid anyway. */
   while (ch != EOF && !isspace (ch))
     ch = getc (shell_fp);
   if (buf_idx)
Index: thread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.76
diff -u -p -r1.76 thread.h
--- thread.h	31 Oct 2003 20:42:56 -0000	1.76
+++ thread.h	14 Nov 2003 13:20:44 -0000
@@ -78,8 +78,8 @@ struct _winsup_t
   DWORD available_drives;
   char mnt_type[80];
   char mnt_opts[80];
-  char mnt_fsname[MAX_PATH];
-  char mnt_dir[MAX_PATH];
+  char mnt_fsname[CYG_MAX_PATH];
+  char mnt_dir[CYG_MAX_PATH];
 
   /* strerror */
   char _strerror_buf[20];
Index: times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.49
diff -u -p -r1.49 times.cc
--- times.cc	25 Sep 2003 00:37:17 -0000	1.49
+++ times.cc	14 Nov 2003 13:20:44 -0000
@@ -21,6 +21,7 @@ details. */
 #include "fhandler.h"
 #include "pinfo.h"
 #include "hires.h"
+#include "io.h"
 
 #define FACTOR (0x19db1ded53e8000LL)
 #define NSPERSEC 10000000LL
@@ -467,11 +468,11 @@ utimes (const char *path, struct timeval
      the times of directories.  */
   /* Note: It's not documented in MSDN that FILE_WRITE_ATTRIBUTES is
      sufficient to change the timestamps... */
-  HANDLE h = CreateFile (win32, FILE_WRITE_ATTRIBUTES,
-			 FILE_SHARE_READ | FILE_SHARE_WRITE,
-			 &sec_none_nih, OPEN_EXISTING,
-			 FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,
-			 0);
+  HANDLE h = cygwin_create_file (win32, FILE_WRITE_ATTRIBUTES,
+				 FILE_SHARE_READ | FILE_SHARE_WRITE,
+				 &sec_none_nih, OPEN_EXISTING,
+				 FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,
+				 0);
 
   if (h == INVALID_HANDLE_VALUE)
     {
Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.121
diff -u -p -r1.121 uinfo.cc
--- uinfo.cc	27 Sep 2003 01:56:36 -0000	1.121
+++ uinfo.cc	14 Nov 2003 13:20:44 -0000
@@ -29,6 +29,7 @@ details. */
 #include "child_info.h"
 #include "environ.h"
 #include "pwdgrp.h"
+#include "io.h"
 
 /* Initialize the part of cygheap_user that does not depend on files.
    The information is used in shared.cc for the user shared.
@@ -254,7 +255,7 @@ cygheap_user::ontherange (homebodies wha
   LPUSER_INFO_3 ui = NULL;
   WCHAR wuser[UNLEN + 1];
   NET_API_STATUS ret;
-  char homepath_env_buf[MAX_PATH + 1];
+  char homepath_env_buf[CYG_MAX_PATH + 1];
   char homedrive_env_buf[3];
   char *newhomedrive = NULL;
   char *newhomepath = NULL;
@@ -287,8 +288,8 @@ cygheap_user::ontherange (homebodies wha
 	    setenv ("HOME", "/", 1);
 	  else
 	    {
-	      char home[MAX_PATH];
-	      char buf[MAX_PATH + 1];
+	      char home[CYG_MAX_PATH];
+	      char buf[CYG_MAX_PATH + 1];
 	      strcpy (buf, newhomedrive);
 	      strcat (buf, newhomepath);
 	      cygwin_conv_to_full_posix_path (buf, home);
@@ -315,11 +316,11 @@ cygheap_user::ontherange (homebodies wha
 	     sys_mbstowcs (wuser, winname (), sizeof (wuser) / sizeof (*wuser));
 	      if (!(ret = NetUserGetInfo (wlogsrv, wuser, 3,(LPBYTE *)&ui)))
 		{
-		  sys_wcstombs (homepath_env_buf, ui->usri3_home_dir, MAX_PATH);
+		  sys_wcstombs (homepath_env_buf, ui->usri3_home_dir, CYG_MAX_PATH);
 		  if (!homepath_env_buf[0])
 		    {
 		      sys_wcstombs (homepath_env_buf, ui->usri3_home_dir_drive,
-				    MAX_PATH);
+				    CYG_MAX_PATH);
 		      if (homepath_env_buf[0])
 			strcat (homepath_env_buf, "\\");
 		      else
@@ -421,7 +422,7 @@ cygheap_user::env_userprofile (const cha
   if (test_uid (puserprof, name, namelen))
     return puserprof;
 
-  char userprofile_env_buf[MAX_PATH + 1];
+  char userprofile_env_buf[CYG_MAX_PATH + 1];
   cfree_and_set (puserprof, almost_null);
   /* FIXME: Should this just be setting a puserprofile like everything else? */
   const char *myname = winname ();
@@ -521,11 +522,11 @@ pwdgrp::load (const char *posix_fname)
     }
   else
     {
-      HANDLE fh = CreateFile (pc, GENERIC_READ, wincap.shared (), NULL,
-			      OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
+      HANDLE fh = cygwin_create_file (pc, GENERIC_READ, wincap.shared (), NULL,
+				      OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
       if (fh == INVALID_HANDLE_VALUE)
 	{
-	  paranoid_printf ("%s CreateFile failed, %E");
+	  paranoid_printf ("%s cygwin_create_file failed, %E");
 	  res = failed;
 	}
       else
Index: wincap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wincap.cc,v
retrieving revision 1.26
diff -u -p -r1.26 wincap.cc
--- wincap.cc	27 Sep 2003 08:14:56 -0000	1.26
+++ wincap.cc	14 Nov 2003 13:20:44 -0000
@@ -51,7 +51,8 @@ static NO_COPY wincaps wincap_unknown = 
   needs_memory_protection:false,
   pty_needs_alloc_console:false,
   has_terminal_services:false,
-  has_switch_to_thread:false
+  has_switch_to_thread:false,
+  has_unicode_io:false
 };
 
 static NO_COPY wincaps wincap_95 = {
@@ -94,7 +95,8 @@ static NO_COPY wincaps wincap_95 = {
   needs_memory_protection:false,
   pty_needs_alloc_console:false,
   has_terminal_services:false,
-  has_switch_to_thread:false
+  has_switch_to_thread:false,
+  has_unicode_io:false
 };
 
 static NO_COPY wincaps wincap_95osr2 = {
@@ -137,7 +139,8 @@ static NO_COPY wincaps wincap_95osr2 = {
   needs_memory_protection:false,
   pty_needs_alloc_console:false,
   has_terminal_services:false,
-  has_switch_to_thread:false
+  has_switch_to_thread:false,
+  has_unicode_io:false
 };
 
 static NO_COPY wincaps wincap_98 = {
@@ -180,7 +183,8 @@ static NO_COPY wincaps wincap_98 = {
   needs_memory_protection:false,
   pty_needs_alloc_console:false,
   has_terminal_services:false,
-  has_switch_to_thread:false
+  has_switch_to_thread:false,
+  has_unicode_io:false
 };
 
 static NO_COPY wincaps wincap_98se = {
@@ -223,7 +227,8 @@ static NO_COPY wincaps wincap_98se = {
   needs_memory_protection:false,
   pty_needs_alloc_console:false,
   has_terminal_services:false,
-  has_switch_to_thread:false
+  has_switch_to_thread:false,
+  has_unicode_io:false
 };
 
 static NO_COPY wincaps wincap_me = {
@@ -266,7 +271,8 @@ static NO_COPY wincaps wincap_me = {
   needs_memory_protection:false,
   pty_needs_alloc_console:false,
   has_terminal_services:false,
-  has_switch_to_thread:false
+  has_switch_to_thread:false,
+  has_unicode_io:false
 };
 
 static NO_COPY wincaps wincap_nt3 = {
@@ -309,7 +315,8 @@ static NO_COPY wincaps wincap_nt3 = {
   needs_memory_protection:true,
   pty_needs_alloc_console:true,
   has_terminal_services:false,
-  has_switch_to_thread:false
+  has_switch_to_thread:false,
+  has_unicode_io:true
 };
 
 static NO_COPY wincaps wincap_nt4 = {
@@ -352,7 +359,8 @@ static NO_COPY wincaps wincap_nt4 = {
   needs_memory_protection:true,
   pty_needs_alloc_console:true,
   has_terminal_services:false,
-  has_switch_to_thread:true
+  has_switch_to_thread:true,
+  has_unicode_io:true
 };
 
 static NO_COPY wincaps wincap_nt4sp4 = {
@@ -395,7 +403,8 @@ static NO_COPY wincaps wincap_nt4sp4 = {
   needs_memory_protection:true,
   pty_needs_alloc_console:true,
   has_terminal_services:false,
-  has_switch_to_thread:true
+  has_switch_to_thread:true,
+  has_unicode_io:true
 };
 
 static NO_COPY wincaps wincap_2000 = {
@@ -438,7 +447,8 @@ static NO_COPY wincaps wincap_2000 = {
   needs_memory_protection:true,
   pty_needs_alloc_console:true,
   has_terminal_services:true,
-  has_switch_to_thread:true
+  has_switch_to_thread:true,
+  has_unicode_io:true
 };
 
 static NO_COPY wincaps wincap_xp = {
@@ -481,7 +491,8 @@ static NO_COPY wincaps wincap_xp = {
   needs_memory_protection:true,
   pty_needs_alloc_console:true,
   has_terminal_services:true,
-  has_switch_to_thread:true
+  has_switch_to_thread:true,
+  has_unicode_io:true
 };
 
 static NO_COPY wincaps wincap_2003 = {
@@ -524,7 +535,8 @@ static NO_COPY wincaps wincap_2003 = {
   needs_memory_protection:true,
   pty_needs_alloc_console:true,
   has_terminal_services:true,
-  has_switch_to_thread:true
+  has_switch_to_thread:true,
+  has_unicode_io:true
 };
 
 wincapc wincap;
Index: wincap.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wincap.h,v
retrieving revision 1.20
diff -u -p -r1.20 wincap.h
--- wincap.h	27 Sep 2003 03:44:31 -0000	1.20
+++ wincap.h	14 Nov 2003 13:20:44 -0000
@@ -53,6 +53,7 @@ struct wincaps
   unsigned pty_needs_alloc_console			: 1;
   unsigned has_terminal_services			: 1;
   unsigned has_switch_to_thread				: 1;
+  unsigned has_unicode_io				: 1;
 };
 
 class wincapc
@@ -110,6 +111,7 @@ public:
   bool  IMPLEMENT (pty_needs_alloc_console)
   bool  IMPLEMENT (has_terminal_services)
   bool  IMPLEMENT (has_switch_to_thread)
+  bool  IMPLEMENT (has_unicode_io)
 
 #undef IMPLEMENT
 };
Index: winsup.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.127
diff -u -p -r1.127 winsup.h
--- winsup.h	10 Nov 2003 21:28:02 -0000	1.127
+++ winsup.h	14 Nov 2003 13:20:44 -0000
@@ -55,6 +55,23 @@ extern unsigned long cygwin_inet_addr (c
 }
 #endif
 
+/* Note that MAX_PATH is defined in the windows headers */
+/* There is also PATH_MAX and MAXPATHLEN.
+   PATH_MAX is from Posix and does *not* include the trailing NUL.
+   MAXPATHLEN is from Unix.
+
+   Thou shalt use CYG_MAX_PATH throughout.  It avoids the NUL vs no-NUL
+   issue and is neither of the Unixy ones [so we can punt on which
+   one is the right one to use]. 
+   
+   Windows ANSI calls are limited to MAX_PATH in length. Cygwin calls that
+   thunk through to Windows Wide calls are limited to 32K. We define
+   CYG_MAX_PATH as a convenient, not to short, not too long 'happy medium'.
+   
+   */
+
+#define CYG_MAX_PATH (4096)
+
 #ifdef __cplusplus
 
 extern const char case_folded_lower[];
@@ -108,6 +125,7 @@ extern int cygserver_running;
 
 #define TITLESIZE 1024
 
+
 /* status bit manipulation */
 #define __ISSETF(what, x, prefix) \
   ((what)->status & prefix##_##x)
@@ -306,14 +324,6 @@ extern SYSTEM_INFO system_info;
 
 #define WM_ASYNCIO	0x8000		// WM_APP
 
-/* Note that MAX_PATH is defined in the windows headers */
-/* There is also PATH_MAX and MAXPATHLEN.
-   PATH_MAX is from Posix and does *not* include the trailing NUL.
-   MAXPATHLEN is from Unix.
-
-   Thou shalt use MAX_PATH throughout.  It avoids the NUL vs no-NUL
-   issue and is neither of the Unixy ones [so we can punt on which
-   one is the right one to use].  */
 
 #define STD_RBITS (S_IRUSR | S_IRGRP | S_IROTH)
 #define STD_WBITS (S_IWUSR)
Index: include/limits.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/limits.h,v
retrieving revision 1.6
diff -u -p -r1.6 limits.h
--- include/limits.h	8 Apr 2003 21:19:33 -0000	1.6
+++ include/limits.h	14 Nov 2003 13:20:44 -0000
@@ -125,7 +125,7 @@ details. */
 #define SSIZE_MAX (__LONG_MAX__)
 
 /* Maximum length of a path */
-#define PATH_MAX (260 - 1 /*NUL*/)
+#define PATH_MAX (4096 - 1 /*NUL*/)
 
 /* Max num groups for a user, value taken from NT documentation */
 /* Must match <sys/param.h> NGROUPS */
Index: include/cygwin/config.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/config.h,v
retrieving revision 1.3
diff -u -p -r1.3 config.h
--- include/cygwin/config.h	16 Jun 2003 03:24:13 -0000	1.3
+++ include/cygwin/config.h	14 Nov 2003 13:20:45 -0000
@@ -20,7 +20,7 @@ extern "C" {
 #define _CYGWIN_CONFIG_H
 
 #define __DYNAMIC_REENT__
-#define __FILENAME_MAX__ (260 - 1 /* NUL */)
+#define __FILENAME_MAX__ (4096 - 1 /* NUL */)
 #define _READ_WRITE_RETURN_TYPE _ssize_t
 #define __LARGE64_FILES 1
 #define __CYGWIN_USE_BIG_TYPES__ 1
Index: include/sys/param.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/param.h,v
retrieving revision 1.3
diff -u -p -r1.3 param.h
--- include/sys/param.h	12 Aug 2003 10:23:40 -0000	1.3
+++ include/sys/param.h	14 Nov 2003 13:20:45 -0000
@@ -31,7 +31,7 @@
 
 /* This is defined to be the same as MAX_PATH which is used internally.
    The Posix version is PATH_MAX.  */
-#define MAXPATHLEN      (260 - 1 /*NUL*/)
+#define MAXPATHLEN      (4096 - 1 /*NUL*/)
 
 /* This is the number of bytes per block given in the st_blocks stat member.
    It should be in sync with S_BLKSIZE in sys/stat.h.  S_BLKSIZE is the

--------------010802060506030706050607
Content-Type: text/plain;
 name="broken-long-paths.changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="broken-long-paths.changelog"
Content-length: 943

2003-11-11  Robert Collins <rbtcollins@hotmail.com>
	    Ron Parker <rdparker@butlermfg.com>

	Rename thunked functions to cygwin_function_name, 
	create unicode capable thunks, and add autoload support, for:

	  CreateFile
	  CreateDirectory
	  SetFileAttributes
	  GetFileAttributes
	  MoveFile
	  MoveFileEx
	
	* assert.cc: Ditto.
	* dcrt0.cc: Ditto.
	* dir.cc: Ditto.
	* exceptions.cc: Ditto.
	* fhandler.cc: Ditto.
	* fhandler_console.cc: Ditto.
	* fhandler_disk_file.cc: Ditto.
	* fhandler_proc.cc: Ditto.
	* fhandler_socket.cc: Ditto.
	* fork.cc: Ditto.
	* ntea.cc: Ditto.
	* path.cc: Ditto.
	* security.cc: Ditto.
	* spawn.cc: Ditto.
	* syscalls.cc: Ditto.
	* times.cc: Ditto.
	* uinfo.cc: Ditto.
	* autoload.cc: Add appropriate ...W autoload stubs.
	* wincap.cc:  Add has_unicode_io capability.
	* wincap.h:  Add has_unicode_io capability.

	Update cygwin throughout to use CYG_MAX_PATH rather than MAX_PATH.
	Watch cygwin die badly.

--------------010802060506030706050607
Content-Type: text/plain;
 name="io.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="io.h"
Content-length: 5153

/* io.h

   Copyright 2003 Robert Collins  <rbtcollins@hotmail.com>
   Copyright 2003 Ron Parker      <rdparker@butlermfg.com>

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#ifndef _IO_H_
#define _IO_H_


/* this file is a tuhnk layer to automatically use unicode calls when possible.
 * ALL routines presume that valid memory checks have already been carried out.
 */

inline bool cygwin_filename_is_dos(LPCTSTR file_name)
{
  return file_name[1] == ':';
}

class IOThunkState
{
  public:
    inline IOThunkState(LPCTSTR file_name);
    inline ~IOThunkState();
    enum Condition {FAILED, ANSI, WIDE} condition;
    inline WCHAR *getWide();

    /* Not implemented */
    inline IOThunkState(IOThunkState const &);
    inline IOThunkState& operator = (IOThunkState const &);
  private:
    size_t len;
    WCHAR *wfilename;  
    LPCTSTR file_name;/* pointer used during object life */
};

IOThunkState::IOThunkState(LPCTSTR filename): wfilename (NULL), file_name(filename)
{
  len = strlen(file_name);
  /* If it exceeds ANSI call length, fail. */
  if (!wincap.has_unicode_io() && len > MAX_PATH) 
    {
      SetLastError(111); /* The file name is too long. */
      condition = FAILED;
      return;
    }
  /* Call the ansi call if possible / required */
  if (!wincap.has_unicode_io() || !cygwin_filename_is_dos(file_name)
      || len <= MAX_PATH)
    {
      condition = ANSI;
      return;
    }
  /* we need to use unicode to support this call */
  getWide();
}

WCHAR *
IOThunkState::getWide()
{
  if (wfilename != NULL || condition == FAILED)
    return wfilename;
  if ((wfilename = (WCHAR *)malloc (sizeof(WCHAR) * (len + 4 + 1))) == NULL)
    {
      SetLastError(111); /* The file name is too long. */
      condition = FAILED;
      return NULL;
    }
  condition = WIDE;
  /* And convert */
  sys_mbstowcs (wfilename, "\\\\?\\", 5);
  sys_mbstowcs (wfilename + 4, file_name, len + 1);
  return wfilename;
}

IOThunkState::~IOThunkState()
{
  if (wfilename)
    free(wfilename);
}


inline HANDLE
cygwin_create_file (LPCTSTR filename, DWORD access, DWORD share_mode,
				  LPSECURITY_ATTRIBUTES sec_attr,
				  DWORD disposition, DWORD flags,
				  HANDLE template_file)
{
  IOThunkState state(filename);
  switch (state.condition) 
  {
    case IOThunkState::FAILED:
      return 0;
    case IOThunkState::ANSI:
      return CreateFileA (filename, access, share_mode, sec_attr, disposition,
                       flags, template_file);
    case IOThunkState::WIDE:
      return CreateFileW (state.getWide(), access, share_mode, sec_attr, disposition,
                      flags, template_file);
  };
}

inline 
BOOL cygwin_create_directory (LPCTSTR filename, LPSECURITY_ATTRIBUTES sec_attr)
{
  IOThunkState state(filename);
  switch (state.condition) 
  {
    case IOThunkState::FAILED:
      return 0;
    case IOThunkState::ANSI:
      return CreateDirectoryA (filename, sec_attr);
    case IOThunkState::WIDE:
      return CreateDirectoryW (state.getWide(), sec_attr);
  };
}

inline
DWORD cygwin_get_file_attributes(LPCTSTR filename)
{
  IOThunkState state(filename);
  switch (state.condition) 
  {
    case IOThunkState::FAILED:
      return INVALID_FILE_ATTRIBUTES;
    case IOThunkState::ANSI:
      return GetFileAttributesA (filename);
    case IOThunkState::WIDE:
      return GetFileAttributesW (state.getWide());
  };
}

inline
BOOL cygwin_set_file_attributes(LPCTSTR filename, DWORD attr)
{
  IOThunkState state(filename);
  switch (state.condition) 
  {
    case IOThunkState::FAILED:
      return 0;
    case IOThunkState::ANSI:
      return SetFileAttributesA(filename, attr);
    case IOThunkState::WIDE:
      return SetFileAttributesW(state.getWide(), attr);
  };
}

inline
BOOL cygwin_move_file(LPCTSTR oldfilename, LPCTSTR newfilename)
{
  IOThunkState oldstate(oldfilename);
  IOThunkState newstate(newfilename);

  if (oldstate.condition == IOThunkState::WIDE || newstate.condition == IOThunkState::WIDE)
  {
    /* get the wide string / trigger failures that may occur */
    oldstate.getWide();
    newstate.getWide();
  }
  if (oldstate.condition == IOThunkState::FAILED || newstate.condition == IOThunkState::FAILED)
    return 0;
  if (oldstate.condition == IOThunkState::ANSI)
    return MoveFileA(oldfilename,newfilename);
  return MoveFileW(oldstate.getWide(), newstate.getWide());
};

inline
BOOL cygwin_move_file_ex(LPCTSTR oldfilename, LPCTSTR newfilename, DWORD flags)
{
  IOThunkState oldstate(oldfilename);
  IOThunkState newstate(newfilename);

  if (oldstate.condition == IOThunkState::WIDE || newstate.condition == IOThunkState::WIDE)
  {
    /* get the wide string / trigger failures that may occur */
    oldstate.getWide();
    newstate.getWide();
  }
  if (oldstate.condition == IOThunkState::FAILED || newstate.condition == IOThunkState::FAILED)
    return 0;
  if (oldstate.condition == IOThunkState::ANSI)
    return MoveFileExA(oldfilename,newfilename, flags);
  return MoveFileExW(oldstate.getWide(), newstate.getWide(), flags);
};

#endif /* _IO_H_ */

--------------010802060506030706050607--
