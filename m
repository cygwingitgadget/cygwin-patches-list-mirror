Return-Path: <cygwin-patches-return-4372-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9456 invoked by alias); 14 Nov 2003 12:01:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9446 invoked from network); 14 Nov 2003 12:01:51 -0000
Message-ID: <3FB4C443.2040301@cygwin.com>
Date: Fri, 14 Nov 2003 12:01:00 -0000
From: Robert Collins <rbcollins@cygwin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com,  rdparker@butlermfg.com
Subject: thunking, the next step
Content-Type: multipart/mixed;
 boundary="------------010209050301040505070400"
X-SW-Source: 2003-q4/txt/msg00091.txt.bz2

This is a multi-part message in MIME format.
--------------010209050301040505070400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1406

Ok, I've now integrated and generalised Ron's unicode support mini-patch.

So, here tis a version that, well the changelog explains the overview, 
and io.h the detail.

Overhead wise, this is reasonably low:
1 strlen() per IO call minimum.
1 unicode conversion, only if needed.
inlined code, so no additional function calls.

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
	* autoload.cc: Add ...W functions for the thunked functions.
         * wincap.cc:  Add has_unicode_io capability.
         * wincap.h:  Add has_unicode_io capability.

--------------010209050301040505070400
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

--------------010209050301040505070400
Content-Type: text/plain;
 name="proof-of-concept-thunks.changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proof-of-concept-thunks.changelog"
Content-length: 796

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
	* wincap.cc:  Add has_unicode_io capability.
	* wincap.h:  Add has_unicode_io capability.

--------------010209050301040505070400
Content-Type: text/plain;
 name="proof-of-concept-thunks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proof-of-concept-thunks.diff"
Content-length: 29340

? cvs.exe.stackdump
? cygwin_daemon.patch
? io.h
? localdiff
? notes
? pthread_cancel.patch
? pthread_fix.patch
? pthread_fork_save_keys.patch
? pthread_mutex.patch
? t
Index: assert.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/assert.cc,v
retrieving revision 1.9
diff -u -p -r1.9 assert.cc
--- assert.cc	19 Sep 2002 15:12:48 -0000	1.9
+++ assert.cc	14 Nov 2003 11:54:36 -0000
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
+++ autoload.cc	14 Nov 2003 11:54:36 -0000
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
Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.189
diff -u -p -r1.189 dcrt0.cc
--- dcrt0.cc	16 Oct 2003 14:08:27 -0000	1.189
+++ dcrt0.cc	14 Nov 2003 11:54:37 -0000
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
Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.76
diff -u -p -r1.76 dir.cc
--- dir.cc	25 Sep 2003 00:37:16 -0000	1.76
+++ dir.cc	14 Nov 2003 11:54:37 -0000
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
Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.173
diff -u -p -r1.173 exceptions.cc
--- exceptions.cc	4 Nov 2003 15:48:18 -0000	1.173
+++ exceptions.cc	14 Nov 2003 11:54:38 -0000
@@ -25,6 +25,7 @@ details. */
 #include "shared_info.h"
 #include "perprocess.h"
 #include "security.h"
+#include "io.h"
 
 #define CALL_HANDLER_RETRY 20
 
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
Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.161
diff -u -p -r1.161 fhandler.cc
--- fhandler.cc	25 Oct 2003 12:32:56 -0000	1.161
+++ fhandler.cc	14 Nov 2003 11:54:38 -0000
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
+++ fhandler_console.cc	14 Nov 2003 11:54:41 -0000
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
+++ fhandler_disk_file.cc	14 Nov 2003 11:54:41 -0000
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
Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.37
diff -u -p -r1.37 fhandler_proc.cc
--- fhandler_proc.cc	23 Oct 2003 08:54:00 -0000	1.37
+++ fhandler_proc.cc	14 Nov 2003 11:54:41 -0000
@@ -28,6 +28,7 @@ details. */
 #include "ntdll.h"
 #include <winioctl.h>
 #include "cpuid.h"
+#include "io.h"
 
 #define _COMPILING_NEWLIB
 #include <dirent.h>
@@ -865,19 +866,19 @@ format_proc_partitions (char *destbuf, s
 	  CHAR szDriveName[MAX_PATH];
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
Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.111
diff -u -p -r1.111 fhandler_socket.cc
--- fhandler_socket.cc	25 Sep 2003 03:51:50 -0000	1.111
+++ fhandler_socket.cc	14 Nov 2003 11:54:42 -0000
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
Index: fork.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.114
diff -u -p -r1.114 fork.cc
--- fork.cc	26 Sep 2003 03:20:30 -0000	1.114
+++ fork.cc	14 Nov 2003 11:54:42 -0000
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
Index: ntea.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntea.cc,v
retrieving revision 1.11
diff -u -p -r1.11 ntea.cc
--- ntea.cc	2 Jul 2003 03:16:00 -0000	1.11
+++ ntea.cc	14 Nov 2003 11:54:43 -0000
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
+++ path.cc	14 Nov 2003 11:54:44 -0000
@@ -73,6 +73,7 @@ details. */
 #include "shared_info.h"
 #include "registry.h"
 #include <assert.h>
+#include "io.h"
 
 #ifdef _MT_SAFE
 #define iteration _reent_winsup ()->_iteration
@@ -2567,7 +2568,7 @@ symlink_worker (const char *topath, cons
     set_security_attribute (S_IFLNK | STD_RBITS | STD_WBITS,
 			    &sa, alloca (4096), 4096);
 
-  h = CreateFile (win32_path, GENERIC_WRITE, 0, &sa, create_how,
+  h = cygwin_create_file (win32_path, GENERIC_WRITE, 0, &sa, create_how,
 		  FILE_ATTRIBUTE_NORMAL, 0);
   if (h == INVALID_HANDLE_VALUE)
     __seterrno ();
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
Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.154
diff -u -p -r1.154 security.cc
--- security.cc	16 Oct 2003 23:20:41 -0000	1.154
+++ security.cc	14 Nov 2003 11:54:46 -0000
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
Index: spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.137
diff -u -p -r1.137 spawn.cc
--- spawn.cc	27 Sep 2003 01:58:23 -0000	1.137
+++ spawn.cc	14 Nov 2003 11:54:54 -0000
@@ -34,6 +34,7 @@ details. */
 #include "registry.h"
 #include "environ.h"
 #include "cygthread.h"
+#include "io.h"
 
 #define LINE_BUF_CHUNK (MAX_PATH * 2)
 
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
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.299
diff -u -p -r1.299 syscalls.cc
--- syscalls.cc	8 Nov 2003 16:38:34 -0000	1.299
+++ syscalls.cc	14 Nov 2003 11:54:54 -0000
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
 
@@ -714,10 +715,10 @@ link (const char *a, const char *b)
 
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
Index: times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.49
diff -u -p -r1.49 times.cc
--- times.cc	25 Sep 2003 00:37:17 -0000	1.49
+++ times.cc	14 Nov 2003 11:54:56 -0000
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
+++ uinfo.cc	14 Nov 2003 11:54:57 -0000
@@ -29,6 +29,7 @@ details. */
 #include "child_info.h"
 #include "environ.h"
 #include "pwdgrp.h"
+#include "io.h"
 
 /* Initialize the part of cygheap_user that does not depend on files.
    The information is used in shared.cc for the user shared.
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
+++ wincap.cc	14 Nov 2003 11:54:57 -0000
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
+++ wincap.h	14 Nov 2003 11:54:57 -0000
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

--------------010209050301040505070400--
