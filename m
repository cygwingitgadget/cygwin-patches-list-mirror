Return-Path: <cygwin-patches-return-2589-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10853 invoked by alias); 3 Jul 2002 12:48:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10774 invoked from network); 3 Jul 2002 12:48:55 -0000
X-WM-Posted-At: avacado.atomice.net; Wed, 3 Jul 02 13:48:47 +0100
Message-ID: <011a01c2228f$f91fbe30$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: UTF8 patch
Date: Wed, 03 Jul 2002 05:48:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0117_01C22298.5ABC52E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00037.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0117_01C22298.5ABC52E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1706

This patch adds UTF8 support to Cygwin. It's a quick hack, so may not be
complete or perfect.

Chris

---
2002-07-03  Christopher January <chris@atomice.net>

 * autoload.cc (GetFileSecurityW): Define new autoload function.
 (CreateFileW): Ditto.
 (CreateHardLinkW): Ditto.
 (CreateDirectoryW): Ditto.
 (DeleteFileW): Ditto.
 (FindFirstFileW): Ditto.
 (FindNextFileW): Ditto.
 (GetCurrentDirectoryW): Ditto.
 (GetFileAttributesW): Ditto.
 (MoveFileW): Ditto.
 (MoveFileExW): Ditto.
 (RemoveDirectoryW): Ditto.
 (SetCurrentDirectoryW): Ditto.
 (SetFileAttributesW): Ditto.
 * dcrt0.cc (use_utf8): New global flag.
 * dir.cc (mkdir): Add UTF8 support.
 (rmdir): Add UTF8 support.
 * dtable.cc (handle_to_fn): Add UTF8 support.
 * environ.cc (known): Add utf8 flag.
 * fhandler.cc (fhandler_base::open): Add UTF8 support.
 * fhandler_disk_file.cc (fhandler_disk_file::fstat): Add UTF8 support.
 (fhandler_disk_file::open): Add UTF8 support.
 (fhandler_disk_file::readdir): Add UTF8 support.
 * miscfuncs.cc (sys_wcstoutf8): New function.
 (sys_utf8towcs): New function.
 * path.cc (path_conv::check): Add UTF8 support.
 (symlink): Add UTF8 support.
 (symlink_info::check): Add UTF8 support.
 (chdir): Add UTF8 support.
 (cwdstuff:get_initial): Add UTF8 support.
 * security.cc (read_sd): Add UTF8 support.
 (write_sd): Add UTF8 support.
 * syscalls.cc (_unlink): Add UTF8 support.
 (_link): Add UTF8 support.
 (chmod): Add UTF8 support.
 (_rename): Add UTF8 support.
 * wincap.cc: Add supports_unicode and supports_utf8 flags.
 * wincap.h: Add supports_unicode and supports_utf8 flags.
 * winsup.h: Add prototypes for sys_wcstoutf8 and sys_utf8towcs.
 Add CP_UTF8 macro. Add extern declaration for use_utf8.


------=_NextPart_000_0117_01C22298.5ABC52E0
Content-Type: application/octet-stream;
	name="utf8.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="utf8.patch"
Content-length: 48618

Index: autoload.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v=0A=
retrieving revision 1.52=0A=
diff -u -3 -p -u -p -r1.52 autoload.cc=0A=
--- autoload.cc	3 Jul 2002 09:20:24 -0000	1.52=0A=
+++ autoload.cc	3 Jul 2002 12:32:02 -0000=0A=
@@ -321,6 +321,7 @@ LoadDLLfuncEx (DuplicateTokenEx, 24, adv=0A=
 LoadDLLfunc (EqualSid, 8, advapi32)=0A=
 LoadDLLfunc (GetAce, 12, advapi32)=0A=
 LoadDLLfunc (GetFileSecurityA, 20, advapi32)=0A=
+LoadDLLfuncEx (GetFileSecurityW, 20, advapi32, 1)=0A=
 LoadDLLfunc (GetKernelObjectSecurity, 20, advapi32)=0A=
 LoadDLLfunc (GetLengthSid, 4, advapi32)=0A=
 LoadDLLfunc (GetSecurityDescriptorDacl, 16, advapi32)=0A=
@@ -491,11 +492,24 @@ LoadDLLfunc (CoUninitialize, 0, ole32)=0A=
 LoadDLLfunc (CoCreateInstance, 20, ole32)=0A=
=20=0A=
 LoadDLLfuncEx (CancelIo, 4, kernel32, 1)=0A=
+LoadDLLfuncEx (CreateFileW, 28, kernel32, 1)=0A=
 LoadDLLfuncEx (CreateHardLinkA, 12, kernel32, 1)=0A=
+LoadDLLfuncEx (CreateHardLinkW, 12, kernel32, 1)=0A=
+LoadDLLfuncEx (CreateDirectoryW, 8, kernel32, 1)=0A=
 LoadDLLfuncEx (CreateToolhelp32Snapshot, 8, kernel32, 1)=0A=
+LoadDLLfuncEx (DeleteFileW, 4, kernel32, 1)=0A=
+LoadDLLfuncEx (FindFirstFileW, 8, kernel32, 1)=0A=
+LoadDLLfuncEx (FindNextFileW, 8, kernel32, 1)=0A=
+LoadDLLfuncEx (GetCurrentDirectoryW, 8, kernel32, 1)=0A=
+LoadDLLfuncEx (GetFileAttributesW, 4, kernel32, 1)=0A=
 LoadDLLfuncEx2 (IsDebuggerPresent, 0, kernel32, 1, 1)=0A=
+LoadDLLfuncEx (MoveFileW, 8, kernel32, 1)=0A=
+LoadDLLfuncEx (MoveFileExW, 12, kernel32, 1)=0A=
 LoadDLLfuncEx (Process32First, 8, kernel32, 1)=0A=
 LoadDLLfuncEx (Process32Next, 8, kernel32, 1)=0A=
+LoadDLLfuncEx (RemoveDirectoryW, 4, kernel32, 1)=0A=
+LoadDLLfuncEx (SetCurrentDirectoryW, 4, kernel32, 1)=0A=
+LoadDLLfuncEx (SetFileAttributesW, 8, kernel32, 1)=0A=
 LoadDLLfuncEx (SignalObjectAndWait, 16, kernel32, 1)=0A=
 LoadDLLfunc (TryEnterCriticalSection, 4, kernel32)=0A=
=20=0A=
Index: dcrt0.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v=0A=
retrieving revision 1.135=0A=
diff -u -3 -p -u -p -r1.135 dcrt0.cc=0A=
--- dcrt0.cc	27 Jun 2002 20:44:27 -0000	1.135=0A=
+++ dcrt0.cc	3 Jul 2002 12:32:05 -0000=0A=
@@ -57,6 +57,7 @@ per_thread NO_COPY *threadstuff[] =3D {&wa=0A=
 BOOL display_title;=0A=
 BOOL strip_title_path;=0A=
 BOOL allow_glob =3D TRUE;=0A=
+BOOL use_utf8 =3D FALSE;=0A=
 codepage_type current_codepage =3D ansi_cp;=0A=
=20=0A=
 int cygwin_finished_initializing;=0A=
Index: delqueue.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/delqueue.cc,v=0A=
retrieving revision 1.9=0A=
diff -u -3 -p -u -p -r1.9 delqueue.cc=0A=
--- delqueue.cc	12 Sep 2001 17:46:35 -0000	1.9=0A=
+++ delqueue.cc	3 Jul 2002 12:32:06 -0000=0A=
@@ -20,6 +20,8 @@ details. */=0A=
 	and move delqueue files to some special location or some such=0A=
 	hack... */=0A=
=20=0A=
+/* FIXME: does not support Unicode filenames */=0A=
+=0A=
 void=0A=
 delqueue_list::init ()=0A=
 {=0A=
Index: dir.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v=0A=
retrieving revision 1.66=0A=
diff -u -3 -p -u -p -r1.66 dir.cc=0A=
--- dir.cc	5 Jun 2002 16:01:55 -0000	1.66=0A=
+++ dir.cc	3 Jul 2002 12:32:07 -0000=0A=
@@ -248,7 +248,17 @@ mkdir (const char *dir, mode_t mode)=0A=
     set_security_attribute (S_IFDIR | ((mode & 07777) & ~cygheap->umask),=
=0A=
 			    &sa, alloca (4096), 4096);=0A=
=20=0A=
-  if (CreateDirectoryA (real_dir.get_win32 (), &sa))=0A=
+  BOOL success;=0A=
+  WCHAR *wbuf;=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      wbuf =3D (WCHAR *) alloca (MAX_PATH * sizeof (WCHAR));=0A=
+      sys_utf8towcs (wbuf, real_dir.get_win32(), MAX_PATH);=0A=
+      success =3D CreateDirectoryW (wbuf, &sa);=0A=
+    }=0A=
+  else=0A=
+    success =3D CreateDirectoryA (real_dir.get_win32 (), &sa);=0A=
+  if (success)=0A=
     {=0A=
       if (!allow_ntsec && allow_ntea)=0A=
 	set_file_attribute (real_dir.has_acls (), real_dir.get_win32 (),=0A=
@@ -256,7 +266,12 @@ mkdir (const char *dir, mode_t mode)=0A=
 #ifdef HIDDEN_DOT_FILES=0A=
       char *c =3D strrchr (real_dir.get_win32 (), '\\');=0A=
       if ((c && c[1] =3D=3D '.') || *real_dir.get_win32 () =3D=3D '.')=0A=
-	SetFileAttributes (real_dir.get_win32 (), FILE_ATTRIBUTE_HIDDEN);=0A=
+        {=0A=
+          if (use_utf8)=0A=
+            SetFileAttributesW (wbuf, FILE_ATTRIBUTE_HIDDEN);=0A=
+          else=0A=
+	        SetFileAttributesA (real_dir.get_win32 (), FILE_ATTRIBUTE_HIDDEN)=
;=0A=
+        }=0A=
 #endif=0A=
       res =3D 0;=0A=
     }=0A=
@@ -277,6 +292,13 @@ rmdir (const char *dir)=0A=
=20=0A=
   path_conv real_dir (dir, PC_SYM_NOFOLLOW);=0A=
=20=0A=
+  WCHAR *wbuf;=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      wbuf =3D (WCHAR *)alloca (MAX_PATH * sizeof (WCHAR));=0A=
+      sys_utf8towcs (wbuf, real_dir.get_win32(), MAX_PATH);=0A=
+    }=0A=
+=0A=
   if (real_dir.error)=0A=
     set_errno (real_dir.error);=0A=
   else if ((devn =3D real_dir.get_devn ()) =3D=3D FH_PROC || devn =3D=3D F=
H_REGISTRY=0A=
@@ -290,15 +312,31 @@ rmdir (const char *dir)=0A=
     {=0A=
       /* Even own directories can't be removed if R/O attribute is set. */=
=0A=
       if (real_dir.has_attribute (FILE_ATTRIBUTE_READONLY))=0A=
-	SetFileAttributes (real_dir,=0A=
-			   (DWORD) real_dir & ~FILE_ATTRIBUTE_READONLY);=0A=
-=0A=
-      if (RemoveDirectory (real_dir))=0A=
+        {=0A=
+           if (use_utf8)=0A=
+             SetFileAttributesW (wbuf,=0A=
+                                (DWORD) real_dir & ~FILE_ATTRIBUTE_READONL=
Y);=0A=
+           else=0A=
+             SetFileAttributesA (real_dir,=0A=
+                                (DWORD) real_dir & ~FILE_ATTRIBUTE_READONL=
Y);=0A=
+        }=0A=
+=0A=
+      BOOL success;=0A=
+      if (use_utf8)=0A=
+        success =3D RemoveDirectoryW (wbuf);=0A=
+      else=0A=
+        success =3D RemoveDirectoryA (real_dir);=0A=
+      if (success)=0A=
 	{=0A=
 	  /* RemoveDirectory on a samba drive doesn't return an error if the=0A=
 	     directory can't be removed because it's not empty. Checking for=0A=
 	     existence afterwards keeps us informed about success. */=0A=
-	  if (GetFileAttributes (real_dir) !=3D INVALID_FILE_ATTRIBUTES)=0A=
+      DWORD fileattr;=0A=
+      if (use_utf8)=0A=
+        fileattr =3D GetFileAttributesW (wbuf);=0A=
+      else=0A=
+        fileattr =3D GetFileAttributesA (real_dir);=0A=
+	  if (fileattr !=3D INVALID_FILE_ATTRIBUTES)=0A=
 	    set_errno (ENOTEMPTY);=0A=
 	  else=0A=
 	    res =3D 0;=0A=
@@ -320,10 +358,25 @@ rmdir (const char *dir)=0A=
 	      && !strcasematch ("c:\\", cygheap->cwd.win32))=0A=
 	    {=0A=
 	      DWORD err =3D GetLastError ();=0A=
+=0A=
 	      if (!SetCurrentDirectory ("c:\\"))=0A=
 		SetLastError (err);=0A=
 	      else if ((res =3D rmdir (dir)))=0A=
-		SetCurrentDirectory (cygheap->cwd.win32);=0A=
+            {=0A=
+              WCHAR cwd_wbuf[MAX_PATH];=0A=
+              if (use_utf8)=0A=
+                {=0A=
+                  if (sys_utf8towcs (cwd_wbuf, cygheap->cwd.win32, MAX_PAT=
H) =3D=3D 0)=0A=
+                    {=0A=
+                      __seterrno ();=0A=
+                      /* PANIC! : haven't set directory back! */=0A=
+                      return -1;=0A=
+                    }=0A=
+                    SetCurrentDirectoryW (cwd_wbuf);=0A=
+                }=0A=
+              else=0A=
+                SetCurrentDirectoryA (cygheap->cwd.win32);=0A=
+            }=0A=
 	    }=0A=
 	  if (res)=0A=
 	    {=0A=
@@ -337,7 +390,12 @@ rmdir (const char *dir)=0A=
=20=0A=
 	      /* If directory still exists, restore R/O attribute. */=0A=
 	      if (real_dir.has_attribute (FILE_ATTRIBUTE_READONLY))=0A=
-		SetFileAttributes (real_dir, real_dir);=0A=
+            {=0A=
+              if (use_utf8)=0A=
+                SetFileAttributesW (wbuf, real_dir);=0A=
+              else=0A=
+                SetFileAttributesA (real_dir, real_dir);=0A=
+            }=0A=
 	    }=0A=
 	}=0A=
     }=0A=
Index: dtable.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v=0A=
retrieving revision 1.98=0A=
diff -u -3 -p -u -p -r1.98 dtable.cc=0A=
--- dtable.cc	3 Jul 2002 03:20:50 -0000	1.98=0A=
+++ dtable.cc	3 Jul 2002 12:32:09 -0000=0A=
@@ -725,12 +725,15 @@ handle_to_fn (HANDLE h, char *posix_fn)=0A=
   ntfn->Name.Buffer[ntfn->Name.Length / sizeof (WCHAR)] =3D 0;=0A=
=20=0A=
   char win32_fn[MAX_PATH + 100];=0A=
-  sys_wcstombs (win32_fn, ntfn->Name.Buffer, ntfn->Name.Length);=0A=
+  if (use_utf8)=0A=
+    sys_wcstoutf8 (win32_fn, ntfn->Name.Buffer, ntfn->Name.Length);=0A=
+  else=0A=
+    sys_wcstombcs (win32_fn, ntfn->Name.Buffer, ntfn->Name.Length);=0A=
   debug_printf ("nt name '%s'", win32_fn);=0A=
   if (!strncasematch (win32_fn, DEVICE_PREFIX, DEVICE_PREFIX_LEN)=0A=
       || !QueryDosDevice (NULL, fnbuf, sizeof (fnbuf)))=0A=
     return strcpy (posix_fn, win32_fn);=0A=
-=20=20=0A=
+=0A=
   char *p =3D strchr (win32_fn + DEVICE_PREFIX_LEN, '\\');=0A=
   if (!p)=0A=
     p =3D strchr (win32_fn + DEVICE_PREFIX_LEN, '\0');=0A=
Index: environ.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v=0A=
retrieving revision 1.85=0A=
diff -u -3 -p -u -p -r1.85 environ.cc=0A=
--- environ.cc	1 Jul 2002 02:11:30 -0000	1.85=0A=
+++ environ.cc	3 Jul 2002 12:32:12 -0000=0A=
@@ -7,6 +7,8 @@ This software is a copyrighted work lice=0A=
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
 details. */=0A=
=20=0A=
+/* FIXME: does not convert Unicode PATH, etc. to UTF-8 */=0A=
+=0A=
 #include "winsup.h"=0A=
 #include <errno.h>=0A=
 #include <stdlib.h>=0A=
@@ -34,6 +36,7 @@ extern BOOL allow_ntea;=0A=
 extern BOOL allow_smbntsec;=0A=
 extern BOOL allow_winsymlinks;=0A=
 extern BOOL strip_title_path;=0A=
+extern BOOL use_utf8;=0A=
 extern int pcheck_case;=0A=
 extern int subauth_id;=0A=
 BOOL reset_com =3D FALSE;=0A=
@@ -521,6 +524,7 @@ static struct parse_thing=0A=
   {"subauth_id", {func: &subauth_id_init}, isfunc, NULL, {{0}, {0}}},=0A=
   {"title", {&display_title}, justset, NULL, {{FALSE}, {TRUE}}},=0A=
   {"tty", {NULL}, set_process_state, NULL, {{0}, {PID_USETTY}}},=0A=
+  {"utf8", {&use_utf8}, justset, NULL, {{FALSE}, {TRUE}}},=0A=
   {"winsymlinks", {&allow_winsymlinks}, justset, NULL, {{FALSE}, {TRUE}}},=
=0A=
   {NULL, {0}, justset, 0, {{0}, {0}}}=0A=
 };=0A=
Index: fhandler.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v=0A=
retrieving revision 1.130=0A=
diff -u -3 -p -u -p -r1.130 fhandler.cc=0A=
--- fhandler.cc	24 Jun 2002 02:23:14 -0000	1.130=0A=
+++ fhandler.cc	3 Jul 2002 12:32:14 -0000=0A=
@@ -424,8 +424,20 @@ fhandler_base::open (path_conv *pc, int=20=0A=
   if (flags & O_CREAT && get_device () =3D=3D FH_DISK && allow_ntsec && ha=
s_acls ())=0A=
     set_security_attribute (mode, &sa, alloca (4096), 4096);=0A=
=20=0A=
-  x =3D CreateFile (get_win32_name (), access, shared, &sa, creation_distr=
ibution,=0A=
-		  file_attributes, 0);=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      WCHAR wbuf[MAX_PATH];=0A=
+      if (sys_utf8towcs (wbuf, get_win32_name(), MAX_PATH) =3D=3D 0)=0A=
+        {=0A=
+          __seterrno ();=0A=
+          goto done;=0A=
+        }=0A=
+      x =3D CreateFileW (wbuf, access, shared, &sa, creation_distribution,=
=0A=
+                       file_attributes, 0);=0A=
+    }=0A=
+  else=0A=
+    x =3D CreateFileA (get_win32_name (), access, shared, &sa, creation_di=
stribution,=0A=
+		    file_attributes, 0);=0A=
=20=0A=
   syscall_printf ("%p =3D CreateFileA (%s, %p, %p, %p, %p, %p, 0)",=0A=
 		  x, get_win32_name (), access, shared, &sa,=0A=
Index: fhandler_disk_file.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v=0A=
retrieving revision 1.27=0A=
diff -u -3 -p -u -p -r1.27 fhandler_disk_file.cc=0A=
--- fhandler_disk_file.cc	27 Jun 2002 03:06:44 -0000	1.27=0A=
+++ fhandler_disk_file.cc	3 Jul 2002 12:32:17 -0000=0A=
@@ -100,7 +100,10 @@ fhandler_disk_file::fstat_by_name (struc=0A=
 {=0A=
   int res;=0A=
   HANDLE handle;=0A=
-  WIN32_FIND_DATA local;=0A=
+  union {=0A=
+      WIN32_FIND_DATAA ansi_find_data;=0A=
+      WIN32_FIND_DATAW unicode_find_data;=0A=
+  } local;=0A=
=20=0A=
   if (!pc->exists ())=0A=
     {=0A=
@@ -125,7 +128,15 @@ fhandler_disk_file::fstat_by_name (struc=0A=
 	  name =3D drivebuf;=0A=
 	}=0A=
=20=0A=
-      if ((handle =3D FindFirstFile (name, &local)) =3D=3D INVALID_HANDLE_=
VALUE)=0A=
+      if (use_utf8)=0A=
+        {=0A=
+          WCHAR wbuf[MAX_PATH];=0A=
+          sys_utf8towcs (wbuf, name, MAX_PATH);=0A=
+          handle =3D FindFirstFileW (wbuf, &local.unicode_find_data);=0A=
+        }=0A=
+      else=0A=
+        handle =3D FindFirstFileA (name, &local.ansi_find_data);=0A=
+      if (handle =3D=3D INVALID_HANDLE_VALUE)=0A=
       {=0A=
 	debug_printf ("FindFirstFile failed for '%s', %E", name);=0A=
 	__seterrno ();=0A=
@@ -135,13 +146,14 @@ fhandler_disk_file::fstat_by_name (struc=0A=
       {=0A=
 	FindClose (handle);=0A=
 	res =3D fstat_helper (buf, pc,=0A=
-			    local.ftCreationTime,=0A=
-			    local.ftLastAccessTime,=0A=
-			    local.ftLastWriteTime,=0A=
-			    local.nFileSizeHigh,=0A=
-			    local.nFileSizeLow);=0A=
+                local.ansi_find_data.ftCreationTime,=0A=
+                local.ansi_find_data.ftLastAccessTime,=0A=
+                local.ansi_find_data.ftLastWriteTime,=0A=
+                local.ansi_find_data.nFileSizeHigh,=0A=
+                local.ansi_find_data.nFileSizeLow);=0A=
       }=0A=
     }=0A=
+out:=0A=
   return res;=0A=
 }=0A=
=20=0A=
@@ -623,14 +635,24 @@ fhandler_disk_file::opendir (path_conv&=20=0A=
 struct dirent *=0A=
 fhandler_disk_file::readdir (DIR *dir)=0A=
 {=0A=
-  WIN32_FIND_DATA buf;=0A=
+  union {=0A=
+    WIN32_FIND_DATAA ansi_find_data;=0A=
+    WIN32_FIND_DATAW unicode_find_data;=0A=
+  } buf;=0A=
   HANDLE handle;=0A=
   struct dirent *res =3D NULL;=0A=
=20=0A=
   if (dir->__d_u.__d_data.__handle =3D=3D INVALID_HANDLE_VALUE=0A=
       && dir->__d_position =3D=3D 0)=0A=
     {=0A=
-      handle =3D FindFirstFileA (dir->__d_dirname, &buf);=0A=
+      if (use_utf8)=0A=
+        {=0A=
+          WCHAR wbuf[MAX_PATH];=0A=
+          sys_utf8towcs (wbuf, dir->__d_dirname, MAX_PATH);=0A=
+          handle =3D FindFirstFileW (wbuf, &buf.unicode_find_data);=0A=
+        }=0A=
+      else=0A=
+        handle =3D FindFirstFileA (dir->__d_dirname, &buf.ansi_find_data);=
=0A=
       DWORD lasterr =3D GetLastError ();=0A=
       dir->__d_u.__d_data.__handle =3D handle;=0A=
       if (handle =3D=3D INVALID_HANDLE_VALUE && (lasterr !=3D ERROR_NO_MOR=
E_FILES))=0A=
@@ -643,25 +665,36 @@ fhandler_disk_file::readdir (DIR *dir)=0A=
     {=0A=
       return res;=0A=
     }=0A=
-  else if (!FindNextFileA (dir->__d_u.__d_data.__handle, &buf))=0A=
+  else=0A=
     {=0A=
-      DWORD lasterr =3D GetLastError ();=0A=
-      (void) FindClose (dir->__d_u.__d_data.__handle);=0A=
-      dir->__d_u.__d_data.__handle =3D INVALID_HANDLE_VALUE;=0A=
-      /* POSIX says you shouldn't set errno when readdir can't=0A=
-	 find any more files; so, if another error we leave it set. */=0A=
-      if (lasterr !=3D ERROR_NO_MORE_FILES)=0A=
-	  seterrno_from_win_error (__FILE__, __LINE__, lasterr);=0A=
-      syscall_printf ("%p =3D readdir (%p)", res, dir);=0A=
-      return res;=0A=
+      BOOL success;=0A=
+      if (use_utf8)=0A=
+        success =3D FindNextFileW (dir->__d_u.__d_data.__handle, &buf.unic=
ode_find_data);=0A=
+      else=0A=
+        success =3D FindNextFileA (dir->__d_u.__d_data.__handle, &buf.ansi=
_find_data);=0A=
+      if (!success)=0A=
+        {=0A=
+          DWORD lasterr =3D GetLastError ();=0A=
+          (void) FindClose (dir->__d_u.__d_data.__handle);=0A=
+          dir->__d_u.__d_data.__handle =3D INVALID_HANDLE_VALUE;=0A=
+          /* POSIX says you shouldn't set errno when readdir can't=0A=
+	      find any more files; so, if another error we leave it set. */=0A=
+          if (lasterr !=3D ERROR_NO_MORE_FILES)=0A=
+	      seterrno_from_win_error (__FILE__, __LINE__, lasterr);=0A=
+          syscall_printf ("%p =3D readdir (%p)", res, dir);=0A=
+          return res;=0A=
+        }=0A=
     }=0A=
=20=0A=
   /* We get here if `buf' contains valid data.  */=0A=
-  strcpy (dir->__d_dirent->d_name, buf.cFileName);=0A=
+  if (use_utf8)=0A=
+    sys_wcstoutf8 (dir->__d_dirent->d_name, buf.unicode_find_data.cFileNam=
e, MAX_PATH);=0A=
+  else=0A=
+    strcpy (dir->__d_dirent->d_name, buf.ansi_find_data.cFileName);=0A=
=20=0A=
   /* Check for Windows shortcut. If it's a Cygwin or U/WIN=0A=
      symlink, drop the .lnk suffix. */=0A=
-  if (buf.dwFileAttributes & FILE_ATTRIBUTE_READONLY)=0A=
+  if (buf.ansi_find_data.dwFileAttributes & FILE_ATTRIBUTE_READONLY)=0A=
     {=0A=
       char *c =3D dir->__d_dirent->d_name;=0A=
       int len =3D strlen (c);=0A=
@@ -679,7 +712,7 @@ fhandler_disk_file::readdir (DIR *dir)=0A=
   dir->__d_position++;=0A=
   res =3D dir->__d_dirent;=0A=
   syscall_printf ("%p =3D readdir (%p) (%s)",=0A=
-		  &dir->__d_dirent, dir, buf.cFileName);=0A=
+          &dir->__d_dirent, dir, dir->__d_dirent->d_name);=0A=
   return res;=0A=
 }=0A=
=20=0A=
Index: miscfuncs.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v=0A=
retrieving revision 1.12=0A=
diff -u -3 -p -u -p -r1.12 miscfuncs.cc=0A=
--- miscfuncs.cc	26 Jun 2002 05:29:41 -0000	1.12=0A=
+++ miscfuncs.cc	3 Jul 2002 12:32:17 -0000=0A=
@@ -196,3 +196,31 @@ sys_mbstowcs (WCHAR *tgt, const char *sr=0A=
 {=0A=
   return MultiByteToWideChar (get_cp (), 0, src, -1, tgt, len);=0A=
 }=0A=
+=0A=
+int __stdcall=0A=
+sys_wcstoutf8 (char *tgt, const WCHAR *src, int len)=0A=
+{=0A=
+  int res =3D WideCharToMultiByte (CP_UTF8, 0, src, -1, tgt, len, NULL, NU=
LL);=0A=
+  if (res =3D=3D 0)=0A=
+    {=0A=
+       DWORD lasterr =3D GetLastError ();=0A=
+       if (lasterr =3D=3D ERROR_INVALID_FLAGS ||=0A=
+           lasterr =3D=3D ERROR_INVALID_PARAMETER)=0A=
+         api_fatal ("UTF8 conversion is not supported by this system");=0A=
+    }=0A=
+  return res;=0A=
+}=0A=
+=0A=
+int __stdcall=0A=
+sys_utf8towcs (WCHAR *tgt, const char *src, int len)=0A=
+{=0A=
+  int res =3D MultiByteToWideChar (CP_UTF8, 0, src, -1, tgt, len);=0A=
+  if (res =3D=3D 0)=0A=
+    {=0A=
+       DWORD lasterr =3D GetLastError ();=0A=
+       if (lasterr =3D=3D ERROR_INVALID_FLAGS ||=0A=
+           lasterr =3D=3D ERROR_INVALID_PARAMETER)=0A=
+         api_fatal ("UTF8 conversion is not supported by this system");=0A=
+    }=0A=
+  return res;=0A=
+}=0A=
Index: path.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v=0A=
retrieving revision 1.225=0A=
diff -u -3 -p -u -p -r1.225 path.cc=0A=
--- path.cc	1 Jul 2002 19:03:26 -0000	1.225=0A=
+++ path.cc	3 Jul 2002 12:32:27 -0000=0A=
@@ -387,7 +387,7 @@ path_conv::fillin (HANDLE h)=0A=
       fs.serial =3D local.dwVolumeSerialNumber;=0A=
     }=0A=
     fs.drive_type =3D DRIVE_UNKNOWN;=0A=
-}=20=0A=
+}=0A=
=20=0A=
 /* Convert an arbitrary path SRC to a pure Win32 path, suitable for=0A=
    passing to Win32 API routines.=0A=
@@ -519,7 +519,14 @@ path_conv::check (const char *src, unsig=0A=
 	      else=0A=
 		{=0A=
 		  devn =3D FH_BAD;=0A=
-		  fileattr =3D GetFileAttributes (this->path);=0A=
+          if (use_utf8)=0A=
+            {=0A=
+              WCHAR wbuf[MAX_PATH];=0A=
+              sys_utf8towcs (wbuf, this->path, MAX_PATH);=0A=
+              fileattr =3D GetFileAttributesW (wbuf);=0A=
+            }=0A=
+          else=0A=
+		    fileattr =3D GetFileAttributesA (this->path);=0A=
 		}=0A=
 	      goto out;=0A=
 	    }=0A=
@@ -578,7 +585,14 @@ path_conv::check (const char *src, unsig=0A=
=20=0A=
 	  if ((opt & PC_SYM_IGNORE) && pcheck_case =3D=3D PCHECK_RELAXED)=0A=
 	    {=0A=
-	      fileattr =3D GetFileAttributes (this->path);=0A=
+          if (use_utf8)=0A=
+            {=0A=
+              WCHAR wbuf[MAX_PATH];=0A=
+              sys_utf8towcs (wbuf, this->path, MAX_PATH);=0A=
+              fileattr =3D GetFileAttributesW (wbuf);=0A=
+            }=0A=
+          else=0A=
+            fileattr =3D GetFileAttributesA (this->path);=0A=
 	      goto out;=0A=
 	    }=0A=
=20=0A=
@@ -2557,6 +2571,7 @@ symlink (const char *topath, const char=20=0A=
   char w32topath[MAX_PATH + 1];=0A=
   DWORD written;=0A=
   SECURITY_ATTRIBUTES sa =3D sec_none_nih;=0A=
+  WCHAR *wbuf =3D NULL;=0A=
=20=0A=
   /* POSIX says that empty 'frompath' is invalid input whlie empty=0A=
      'topath' is valid -- it's symlink resolver job to verify if=0A=
@@ -2593,6 +2608,12 @@ symlink (const char *topath, const char=20=0A=
       goto done;=0A=
     }=0A=
=20=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      wbuf =3D (WCHAR *) alloca (MAX_PATH * sizeof (WCHAR));=0A=
+      sys_utf8towcs (wbuf, w32topath, MAX_PATH);=0A=
+    }=0A=
+=0A=
   if (allow_winsymlinks)=0A=
     {=0A=
       if (!isabspath (topath))=0A=
@@ -2606,7 +2627,12 @@ symlink (const char *topath, const char=20=0A=
 	    }=0A=
 	  backslashify (topath, w32topath, 0);=0A=
 	}=0A=
-      if (!cp || GetFileAttributes (w32topath) =3D=3D INVALID_FILE_ATTRIBU=
TES)=0A=
+      DWORD fileattr;=0A=
+      if (use_utf8)=0A=
+        fileattr =3D GetFileAttributesW (wbuf);=0A=
+      else=0A=
+        fileattr =3D GetFileAttributesA (w32topath);=0A=
+      if (!cp || fileattr =3D=3D INVALID_FILE_ATTRIBUTES)=0A=
 	{=0A=
 	  win32_topath.check (topath, PC_SYM_NOFOLLOW);=0A=
 	  if (!cp || win32_topath.error !=3D ENOENT)=0A=
@@ -2623,8 +2649,15 @@ symlink (const char *topath, const char=20=0A=
     set_security_attribute (S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO,=0A=
 			    &sa, alloca (4096), 4096);=0A=
=20=0A=
-  h =3D CreateFileA(win32_path, GENERIC_WRITE, 0, &sa,=0A=
-		  CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      sys_utf8towcs (wbuf, win32_path, MAX_PATH);=0A=
+      h =3D CreateFileW(wbuf, GENERIC_WRITE, 0, &sa,=0A=
+              CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);=0A=
+    }=0A=
+  else=0A=
+    h =3D CreateFileA(win32_path, GENERIC_WRITE, 0, &sa,=0A=
+		    CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);=0A=
   if (h =3D=3D INVALID_HANDLE_VALUE)=0A=
     __seterrno ();=0A=
   else=0A=
@@ -2678,7 +2711,10 @@ symlink (const char *topath, const char=20=0A=
 	  if ((cp && cp[1] =3D=3D '.') || *win32_path =3D=3D '.')=0A=
 	    attr |=3D FILE_ATTRIBUTE_HIDDEN;=0A=
 #endif=0A=
-	  SetFileAttributes (win32_path.get_win32 (), attr);=0A=
+      if (use_utf8)=0A=
+        SetFileAttributesW (wbuf, attr);=0A=
+      else=0A=
+	    SetFileAttributesA (win32_path.get_win32 (), attr);=0A=
=20=0A=
 	  if (win32_path.fs_fast_ea ())=0A=
 	    set_symlink_ea (win32_path, topath);=0A=
@@ -2688,7 +2724,10 @@ symlink (const char *topath, const char=20=0A=
 	{=0A=
 	  __seterrno ();=0A=
 	  CloseHandle (h);=0A=
-	  DeleteFileA (win32_path.get_win32 ());=0A=
+      if (use_utf8)=0A=
+        DeleteFileW (wbuf);=0A=
+      else=0A=
+    	DeleteFileA (win32_path.get_win32 ());=0A=
 	}=0A=
     }=0A=
=20=0A=
@@ -2907,7 +2946,14 @@ symlink_info::check (char *path, const s=0A=
   while (suffix.next ())=0A=
     {=0A=
       error =3D 0;=0A=
-      fileattr =3D GetFileAttributes (suffix.path);=0A=
+      if (use_utf8)=0A=
+        {=0A=
+          WCHAR wbuf[MAX_PATH];=0A=
+          sys_utf8towcs (wbuf, suffix.path, MAX_PATH);=0A=
+          fileattr =3D GetFileAttributesW (wbuf);=0A=
+        }=0A=
+      else=0A=
+        fileattr =3D GetFileAttributesA (suffix.path);=0A=
       if (fileattr =3D=3D INVALID_FILE_ATTRIBUTES)=0A=
 	{=0A=
 	  /* The GetFileAttributes call can fail for reasons that don't=0A=
@@ -2955,8 +3001,16 @@ symlink_info::check (char *path, const s=0A=
=20=0A=
       /* Open the file.  */=0A=
=20=0A=
-      h =3D CreateFileA (suffix.path, GENERIC_READ, FILE_SHARE_READ, &sec_=
none_nih, OPEN_EXISTING,=0A=
-		       FILE_ATTRIBUTE_NORMAL, 0);=0A=
+      if (use_utf8)=0A=
+        {=0A=
+          WCHAR wbuf[MAX_PATH];=0A=
+          sys_utf8towcs (wbuf, suffix.path, MAX_PATH);=0A=
+          h =3D CreateFileW (wbuf, GENERIC_READ, FILE_SHARE_READ, &sec_non=
e_nih, OPEN_EXISTING,=0A=
+                           FILE_ATTRIBUTE_NORMAL, 0);=0A=
+        }=0A=
+      else=0A=
+        h =3D CreateFileA (suffix.path, GENERIC_READ, FILE_SHARE_READ, &se=
c_none_nih, OPEN_EXISTING,=0A=
+		         FILE_ATTRIBUTE_NORMAL, 0);=0A=
       res =3D -1;=0A=
       if (h =3D=3D INVALID_HANDLE_VALUE)=0A=
 	goto file_not_symlink;=0A=
@@ -3231,7 +3285,16 @@ chdir (const char *in_dir)=0A=
   int res;=0A=
   int devn =3D path.get_devn();=0A=
   if (!isvirtual_dev (devn))=0A=
-    res =3D SetCurrentDirectory (native_dir) ? 0 : -1;=0A=
+    {=0A=
+      if (use_utf8)=0A=
+        {=0A=
+          WCHAR wbuf[MAX_PATH];=0A=
+          sys_utf8towcs (wbuf, native_dir, MAX_PATH);=0A=
+          res =3D SetCurrentDirectoryW (wbuf) ? 0 : -1;=0A=
+        }=0A=
+      else=0A=
+        res =3D SetCurrentDirectoryA (native_dir) ? 0 : -1;=0A=
+    }=0A=
   else if (!path.exists ())=0A=
     {=0A=
       set_errno (ENOENT);=0A=
@@ -3568,11 +3631,27 @@ cwdstuff::get_initial ()=0A=
=20=0A=
   int i;=0A=
   DWORD len, dlen;=0A=
-  for (i =3D 0, dlen =3D MAX_PATH, len =3D 0; i < 3; dlen *=3D 2, i++)=0A=
+  if (use_utf8)=0A=
     {=0A=
-      win32 =3D (char *) crealloc (win32, dlen + 2);=0A=
-      if ((len =3D GetCurrentDirectoryA (dlen, win32)) < dlen)=0A=
-	break;=0A=
+      WCHAR *wbuf =3D NULL;=0A=
+      for (i =3D 0, dlen =3D MAX_PATH, len =3D 0; i < 3; dlen *=3D 2, i++)=
=0A=
+        {=0A=
+          wbuf =3D (WCHAR *) crealloc (wbuf, dlen + 2);=0A=
+          if ((len =3D GetCurrentDirectoryW (dlen, wbuf)) < dlen)=0A=
+            break;=0A=
+        }=0A=
+      int alen =3D sys_wcstoutf8 (NULL, wbuf, 0);=0A=
+      win32 =3D (char *) crealloc (win32, alen);=0A=
+      sys_wcstoutf8 (win32, wbuf, alen);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      for (i =3D 0, dlen =3D MAX_PATH, len =3D 0; i < 3; dlen *=3D 2, i++)=
=0A=
+        {=0A=
+          win32 =3D (char *) crealloc (win32, dlen + 2);=0A=
+          if ((len =3D GetCurrentDirectoryA (dlen, win32)) < dlen)=0A=
+            break;=0A=
+        }=0A=
     }=0A=
=20=0A=
   if (len =3D=3D 0)=0A=
Index: security.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v=0A=
retrieving revision 1.112=0A=
diff -u -3 -p -u -p -r1.112 security.cc=0A=
--- security.cc	2 Jul 2002 09:02:53 -0000	1.112=0A=
+++ security.cc	3 Jul 2002 12:32:31 -0000=0A=
@@ -1023,11 +1023,24 @@ read_sd (const char *file, PSECURITY_DES=0A=
       pfile =3D fbuf;=0A=
     }=0A=
=20=0A=
-  if (!GetFileSecurity (pfile,=0A=
-			OWNER_SECURITY_INFORMATION=0A=
-			 | GROUP_SECURITY_INFORMATION=0A=
-			 | DACL_SECURITY_INFORMATION,=0A=
-			 sd_buf, *sd_size, &len))=0A=
+  BOOL res;=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      WCHAR wbuf[MAX_PATH];=0A=
+      sys_utf8towcs (wbuf, file, MAX_PATH);=0A=
+      res =3D GetFileSecurityW (wbuf,=0A=
+                 OWNER_SECURITY_INFORMATION=0A=
+                  | GROUP_SECURITY_INFORMATION=0A=
+                  | DACL_SECURITY_INFORMATION,=0A=
+                  sd_buf, *sd_size, &len);=0A=
+    }=0A=
+  else=0A=
+    res =3D GetFileSecurityA (pfile,=0A=
+               OWNER_SECURITY_INFORMATION=0A=
+                | GROUP_SECURITY_INFORMATION=0A=
+                | DACL_SECURITY_INFORMATION,=0A=
+                sd_buf, *sd_size, &len);=0A=
+  if (!res)=0A=
     {=0A=
       __seterrno ();=0A=
       return -1;=0A=
@@ -1060,13 +1073,26 @@ write_sd (const char *file, PSECURITY_DE=0A=
     }=0A=
=20=0A=
   HANDLE fh;=0A=
-  fh =3D CreateFile (file,=0A=
-		   WRITE_OWNER | WRITE_DAC,=0A=
-		   FILE_SHARE_READ | FILE_SHARE_WRITE,=0A=
-		   &sec_none_nih,=0A=
-		   OPEN_EXISTING,=0A=
-		   FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,=0A=
-		   NULL);=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      WCHAR wbuf[MAX_PATH];=0A=
+      sys_utf8towcs (wbuf, file, MAX_PATH);=0A=
+      fh =3D CreateFileW (wbuf,=0A=
+               WRITE_OWNER | WRITE_DAC,=0A=
+               FILE_SHARE_READ | FILE_SHARE_WRITE,=0A=
+               &sec_none_nih,=0A=
+               OPEN_EXISTING,=0A=
+               FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,=0A=
+               NULL);=0A=
+    }=0A=
+  else=0A=
+    fh =3D CreateFileA (file,=0A=
+		     WRITE_OWNER | WRITE_DAC,=0A=
+		     FILE_SHARE_READ | FILE_SHARE_WRITE,=0A=
+		     &sec_none_nih,=0A=
+		     OPEN_EXISTING,=0A=
+		     FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,=0A=
+		     NULL);=0A=
=20=0A=
   if (fh =3D=3D INVALID_HANDLE_VALUE)=0A=
     {=0A=
Index: syscalls.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v=0A=
retrieving revision 1.214=0A=
diff -u -3 -p -u -p -r1.214 syscalls.cc=0A=
--- syscalls.cc	2 Jul 2002 03:06:32 -0000	1.214=0A=
+++ syscalls.cc	3 Jul 2002 12:32:37 -0000=0A=
@@ -95,6 +95,7 @@ _unlink (const char *ourname)=0A=
 {=0A=
   int res =3D -1;=0A=
   DWORD devn;=0A=
+  WCHAR *wbuf =3D NULL;=0A=
   sigframe thisframe (mainthread);=0A=
=20=0A=
   path_conv win32_name (ourname, PC_SYM_NOFOLLOW | PC_FULL);=0A=
@@ -134,19 +135,35 @@ _unlink (const char *ourname)=0A=
       goto done;=0A=
     }=0A=
=20=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      wbuf =3D (WCHAR *) alloca (MAX_PATH * sizeof (WCHAR));=0A=
+      sys_utf8towcs (wbuf, win32_name, MAX_PATH);=0A=
+    }=0A=
+=0A=
   /* Check for shortcut as symlink condition. */=0A=
   if (win32_name.has_attribute (FILE_ATTRIBUTE_READONLY))=0A=
     {=0A=
       int len =3D strlen (win32_name);=0A=
       if (len > 4 && strcasematch ((char *) win32_name + len - 4, ".lnk"))=
=0A=
-	SetFileAttributes (win32_name, (DWORD) win32_name & ~FILE_ATTRIBUTE_READO=
NLY);=0A=
+        {=0A=
+           if (use_utf8)=0A=
+             SetFileAttributesW (wbuf, (DWORD) win32_name & ~FILE_ATTRIBUT=
E_READONLY);=0A=
+           else=0A=
+             SetFileAttributesA (win32_name, (DWORD) win32_name & ~FILE_AT=
TRIBUTE_READONLY);=0A=
+        }=0A=
     }=0A=
=20=0A=
   DWORD lasterr;=0A=
   lasterr =3D 0;=0A=
   for (int i =3D 0; i < 2; i++)=0A=
     {=0A=
-      if (DeleteFile (win32_name))=0A=
+      BOOL success;=0A=
+      if (use_utf8)=0A=
+        success =3D DeleteFileW (wbuf);=0A=
+      else=0A=
+        success =3D DeleteFileA (win32_name);=0A=
+      if (success)=0A=
 	{=0A=
 	  syscall_printf ("DeleteFile succeeded");=0A=
 	  goto ok;=0A=
@@ -188,8 +205,12 @@ _unlink (const char *ourname)=0A=
   /* Attempt to use "delete on close" semantics to handle removing=0A=
      a file which may be open. */=0A=
   HANDLE h;=0A=
-  h =3D CreateFile (win32_name, GENERIC_READ, FILE_SHARE_READ, &sec_none_n=
ih,=0A=
-		  OPEN_EXISTING, FILE_FLAG_DELETE_ON_CLOSE, 0);=0A=
+  if (use_utf8)=0A=
+    h =3D CreateFileW (wbuf, GENERIC_READ, FILE_SHARE_READ, &sec_none_nih,=
=0A=
+            OPEN_EXISTING, FILE_FLAG_DELETE_ON_CLOSE, 0);=0A=
+  else=0A=
+    h =3D CreateFileA (win32_name, GENERIC_READ, FILE_SHARE_READ, &sec_non=
e_nih,=0A=
+		    OPEN_EXISTING, FILE_FLAG_DELETE_ON_CLOSE, 0);=0A=
   if (h =3D=3D INVALID_HANDLE_VALUE)=0A=
     {=0A=
       if (GetLastError () =3D=3D ERROR_FILE_NOT_FOUND)=0A=
@@ -201,7 +222,12 @@ _unlink (const char *ourname)=0A=
       syscall_printf ("CreateFile/CloseHandle succeeded");=0A=
       /* Everything is fine if the file has disappeared or if we know that=
 the=0A=
 	 FILE_FLAG_DELETE_ON_CLOSE will eventually work. */=0A=
-      if (GetFileAttributes (win32_name) =3D=3D INVALID_FILE_ATTRIBUTES=0A=
+      DWORD fileattr;=0A=
+      if (use_utf8)=0A=
+        fileattr =3D GetFileAttributesW (wbuf);=0A=
+      else=0A=
+        fileattr =3D GetFileAttributesA (win32_name);=0A=
+      if (fileattr =3D=3D INVALID_FILE_ATTRIBUTES=0A=
 	  || delete_on_close_ok)=0A=
 	goto ok;	/* The file is either gone already or will eventually be=0A=
 			   deleted by the OS. */=0A=
@@ -614,6 +640,7 @@ extern "C" int=0A=
 _link (const char *a, const char *b)=0A=
 {=0A=
   int res =3D -1;=0A=
+  WCHAR *wbuf_a =3D NULL, *wbuf_b =3D NULL;=0A=
   sigframe thisframe (mainthread);=0A=
   path_conv real_b (b, PC_SYM_NOFOLLOW | PC_FULL);=0A=
   path_conv real_a (a, PC_SYM_NOFOLLOW | PC_FULL);=0A=
@@ -644,10 +671,23 @@ _link (const char *a, const char *b)=0A=
       goto done;=0A=
     }=0A=
=20=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      wbuf_a =3D (WCHAR *) alloca (MAX_PATH * sizeof (WCHAR));=0A=
+      wbuf_b =3D (WCHAR *) alloca (MAX_PATH * sizeof (WCHAR));=0A=
+      sys_utf8towcs (wbuf_a, real_a, MAX_PATH);=0A=
+      sys_utf8towcs (wbuf_b, real_b, MAX_PATH);=0A=
+    }=0A=
+=0A=
   /* Try to make hard link first on Windows NT */=0A=
   if (wincap.has_hard_links ())=0A=
     {=0A=
-      if (CreateHardLinkA (real_b, real_a, NULL))=0A=
+      BOOL success;=0A=
+      if (use_utf8)=0A=
+        success =3D (BOOL) CreateHardLinkW (wbuf_b, wbuf_a, NULL);=0A=
+      else=0A=
+        success =3D (BOOL) CreateHardLinkA (real_b, real_a, NULL);=0A=
+      if (success)=0A=
 	{=0A=
 	  res =3D 0;=0A=
 	  goto done;=0A=
@@ -664,7 +704,18 @@ _link (const char *a, const char *b)=0A=
=20=0A=
       BOOL bSuccess;=0A=
=20=0A=
-      hFileSource =3D CreateFile (=0A=
+      if (use_utf8)=0A=
+        hFileSource =3D CreateFileW (=0A=
+    wbuf_a,=0A=
+    FILE_WRITE_ATTRIBUTES,=0A=
+    FILE_SHARE_READ | FILE_SHARE_WRITE /*| FILE_SHARE_DELETE*/,=0A=
+    &sec_none_nih, // sa=0A=
+    OPEN_EXISTING,=0A=
+    0,=0A=
+    NULL=0A=
+    );=0A=
+      else=0A=
+        hFileSource =3D CreateFileA (=0A=
 	real_a,=0A=
 	FILE_WRITE_ATTRIBUTES,=0A=
 	FILE_SHARE_READ | FILE_SHARE_WRITE /*| FILE_SHARE_DELETE*/,=0A=
@@ -743,7 +794,12 @@ _link (const char *a, const char *b)=0A=
     }=0A=
 docopy:=0A=
   /* do this with a copy */=0A=
-  if (CopyFileA (real_a, real_b, 1))=0A=
+  BOOL success;=0A=
+  if (use_utf8)=0A=
+    success =3D CopyFileW (wbuf_a, wbuf_b, 1);=0A=
+  else=0A=
+    success =3D CopyFileA (real_a, real_b, 1);=0A=
+  if (success)=0A=
     res =3D 0;=0A=
   else=0A=
     __seterrno ();=0A=
@@ -900,6 +956,7 @@ extern "C" int=0A=
 chmod (const char *path, mode_t mode)=0A=
 {=0A=
   int res =3D -1;=0A=
+  WCHAR *wbuf =3D NULL;=0A=
   sigframe thisframe (mainthread);=0A=
=20=0A=
   path_conv win32_path (path);=0A=
@@ -923,7 +980,14 @@ chmod (const char *path, mode_t mode)=0A=
   else=0A=
     {=0A=
       /* temporary erase read only bit, to be able to set file security */=
=0A=
-      SetFileAttributes (win32_path, (DWORD) win32_path & ~FILE_ATTRIBUTE_=
READONLY);=0A=
+      if (use_utf8)=0A=
+        {=0A=
+          wbuf =3D (WCHAR *) alloca (MAX_PATH * sizeof (WCHAR));=0A=
+          sys_utf8towcs (wbuf, win32_path, MAX_PATH);=0A=
+          SetFileAttributesW (wbuf, (DWORD) win32_path & ~FILE_ATTRIBUTE_R=
EADONLY);=0A=
+        }=0A=
+      else=0A=
+        SetFileAttributesA (win32_path, (DWORD) win32_path & ~FILE_ATTRIBU=
TE_READONLY);=0A=
=20=0A=
       __uid32_t uid;=0A=
       __gid32_t gid;=0A=
@@ -951,7 +1015,12 @@ chmod (const char *path, mode_t mode)=0A=
       if (S_ISLNK (mode) || S_ISSOCK (mode))=0A=
 	(DWORD) win32_path |=3D FILE_ATTRIBUTE_SYSTEM;=0A=
=20=0A=
-      if (!SetFileAttributes (win32_path, win32_path))=0A=
+      BOOL success;=0A=
+      if (use_utf8)=0A=
+        success =3D SetFileAttributesW (wbuf, win32_path);=0A=
+      else=0A=
+        success =3D SetFileAttributesA (win32_path, win32_path);=0A=
+      if (!success)=0A=
 	__seterrno ();=0A=
       else=0A=
 	{=0A=
@@ -1251,6 +1320,7 @@ _rename (const char *oldpath, const char=0A=
   sigframe thisframe (mainthread);=0A=
   int res =3D 0;=0A=
   char *lnk_suffix =3D NULL;=0A=
+  WCHAR *wbuf_old =3D NULL, *wbuf_new =3D NULL;=0A=
=20=0A=
   path_conv real_old (oldpath, PC_SYM_NOFOLLOW);=0A=
=20=0A=
@@ -1298,10 +1368,23 @@ _rename (const char *oldpath, const char=0A=
        return (-1);=0A=
     }=0A=
=20=0A=
+  if (use_utf8)=0A=
+    {=0A=
+      wbuf_old =3D (WCHAR *) alloca (MAX_PATH * sizeof (WCHAR));=0A=
+      wbuf_new =3D (WCHAR *) alloca (MAX_PATH * sizeof (WCHAR));=0A=
+      sys_utf8towcs (wbuf_old, real_old, MAX_PATH);=0A=
+      sys_utf8towcs (wbuf_new, real_new, MAX_PATH);=0A=
+    }=0A=
+=0A=
   /* Destination file exists and is read only, change that or else=0A=
      the rename won't work. */=0A=
   if (real_new.has_attribute (FILE_ATTRIBUTE_READONLY))=0A=
-    SetFileAttributes (real_new, (DWORD) real_new & ~FILE_ATTRIBUTE_READON=
LY);=0A=
+    {=0A=
+      if (use_utf8)=0A=
+        SetFileAttributesW (wbuf_new, (DWORD) real_new & ~FILE_ATTRIBUTE_R=
EADONLY);=0A=
+      else=0A=
+        SetFileAttributesA (real_new, (DWORD) real_new & ~FILE_ATTRIBUTE_R=
EADONLY);=0A=
+    }=0A=
=20=0A=
   /* Shortcut hack No. 2, part 1 */=0A=
   if (!real_old.issymlink () && !real_new.error && real_new.issymlink () &=
&=0A=
@@ -1309,7 +1392,12 @@ _rename (const char *oldpath, const char=0A=
       (lnk_suffix =3D strrchr (real_new.get_win32 (), '.')))=0A=
      *lnk_suffix =3D '\0';=0A=
=20=0A=
-  if (!MoveFile (real_old, real_new))=0A=
+  BOOL success;=0A=
+  if (use_utf8)=0A=
+    success =3D MoveFileW (wbuf_old, wbuf_new);=0A=
+  else=0A=
+    success =3D MoveFileA (real_old, real_new);=0A=
+  if (success)=0A=
     res =3D -1;=0A=
=20=0A=
   if (res =3D=3D 0 || (GetLastError () !=3D ERROR_ALREADY_EXISTS=0A=
@@ -1318,8 +1406,12 @@ _rename (const char *oldpath, const char=0A=
=20=0A=
   if (wincap.has_move_file_ex ())=0A=
     {=0A=
-      if (MoveFileEx (real_old.get_win32 (), real_new.get_win32 (),=0A=
-		      MOVEFILE_REPLACE_EXISTING))=0A=
+      if (use_utf8)=0A=
+        success =3D MoveFileExW (wbuf_old, wbuf_new,=0A=
+              MOVEFILE_REPLACE_EXISTING);=0A=
+      else=0A=
+        success =3D MoveFileExA (real_old.get_win32 (), real_new.get_win32=
 (),=0A=
+		      MOVEFILE_REPLACE_EXISTING);=0A=
 	res =3D 0;=0A=
     }=0A=
   else=0A=
@@ -1327,18 +1419,29 @@ _rename (const char *oldpath, const char=0A=
       syscall_printf ("try win95 hack");=0A=
       for (int i =3D 0; i < 2; i++)=0A=
 	{=0A=
-	  if (!DeleteFileA (real_new.get_win32 ()) &&=0A=
+      if (use_utf8)=0A=
+        success =3D DeleteFileW (wbuf_new);=0A=
+      else=0A=
+        success =3D DeleteFileA (real_new.get_win32());=0A=
+	  if (!success &&=0A=
 	      GetLastError () !=3D ERROR_FILE_NOT_FOUND)=0A=
 	    {=0A=
 	      syscall_printf ("deleting %s to be paranoid",=0A=
 			      real_new.get_win32 ());=0A=
 	      break;=0A=
 	    }=0A=
-	  else if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))=0A=
-	    {=0A=
-	      res =3D 0;=0A=
-	      break;=0A=
-	    }=0A=
+	  else=0A=
+        {=0A=
+          if (use_utf8)=0A=
+            success =3D MoveFileW (wbuf_old, wbuf_new);=0A=
+          else=0A=
+            success =3D MoveFileA (real_old.get_win32 (), real_new.get_win=
32 ());=0A=
+          if (success)=0A=
+	      {=0A=
+	        res =3D 0;=0A=
+	        break;=0A=
+	      }=0A=
+        }=0A=
 	}=0A=
     }=0A=
=20=0A=
@@ -1348,7 +1451,12 @@ done:=0A=
       __seterrno ();=0A=
       /* Reset R/O attributes if neccessary. */=0A=
       if (real_new.has_attribute (FILE_ATTRIBUTE_READONLY))=0A=
-	SetFileAttributes (real_new, real_new);=0A=
+        {=0A=
+          if (use_utf8)=0A=
+            SetFileAttributesW (wbuf_new, real_new);=0A=
+          else=0A=
+	        SetFileAttributesA (real_new, real_new);=0A=
+        }=0A=
     }=0A=
   else=0A=
     {=0A=
@@ -1362,7 +1470,10 @@ done:=0A=
       if ((c && c[1] =3D=3D '.') || *real_new.get_win32 () =3D=3D '.')=0A=
 	attr |=3D FILE_ATTRIBUTE_HIDDEN;=0A=
 #endif=0A=
-      SetFileAttributes (real_new, attr);=0A=
+      if (use_utf8)=0A=
+        SetFileAttributesW (wbuf_new, attr);=0A=
+      else=0A=
+        SetFileAttributesA (real_new, attr);=0A=
=20=0A=
       /* Shortcut hack, No. 2, part 2 */=0A=
       /* if the new filename was an existing shortcut, remove it now if th=
e=0A=
@@ -1370,7 +1481,10 @@ done:=0A=
       if (lnk_suffix)=0A=
 	{=0A=
 	  *lnk_suffix =3D '.';=0A=
-	  DeleteFile (real_new);=0A=
+      if (use_utf8)=0A=
+    	DeleteFileW (wbuf_new);=0A=
+      else=0A=
+        DeleteFileA (real_new);=0A=
 	}=0A=
     }=0A=
=20=0A=
Index: wincap.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/wincap.cc,v=0A=
retrieving revision 1.14=0A=
diff -u -3 -p -u -p -r1.14 wincap.cc=0A=
--- wincap.cc	10 Jun 2002 17:08:09 -0000	1.14=0A=
+++ wincap.cc	3 Jul 2002 12:32:39 -0000=0A=
@@ -46,6 +46,8 @@ static NO_COPY wincaps wincap_unknown =3D=20=0A=
   has_valid_processorlevel:false,=0A=
   has_64bit_file_access:false,=0A=
   has_process_io_counters:false,=0A=
+  supports_unicode:false,=0A=
+  supports_utf8:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_95 =3D {=0A=
@@ -83,6 +85,8 @@ static NO_COPY wincaps wincap_95 =3D {=0A=
   has_valid_processorlevel:false,=0A=
   has_64bit_file_access:false,=0A=
   has_process_io_counters:false,=0A=
+  supports_unicode:false,=0A=
+  supports_utf8:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_95osr2 =3D {=0A=
@@ -120,6 +124,8 @@ static NO_COPY wincaps wincap_95osr2 =3D {=0A=
   has_valid_processorlevel:false,=0A=
   has_64bit_file_access:false,=0A=
   has_process_io_counters:false,=0A=
+  supports_unicode:false,=0A=
+  supports_utf8:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_98 =3D {=0A=
@@ -157,6 +163,8 @@ static NO_COPY wincaps wincap_98 =3D {=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:false,=0A=
   has_process_io_counters:false,=0A=
+  supports_unicode:false,=0A=
+  supports_utf8:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_98se =3D {=0A=
@@ -194,6 +202,8 @@ static NO_COPY wincaps wincap_98se =3D {=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:false,=0A=
   has_process_io_counters:false,=0A=
+  supports_unicode:false,=0A=
+  supports_utf8:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_me =3D {=0A=
@@ -231,6 +241,8 @@ static NO_COPY wincaps wincap_me =3D {=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:false,=0A=
   has_process_io_counters:false,=0A=
+  supports_unicode:false,=0A=
+  supports_utf8:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_nt3 =3D {=0A=
@@ -268,6 +280,8 @@ static NO_COPY wincaps wincap_nt3 =3D {=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
   has_process_io_counters:false,=0A=
+  supports_unicode:true,=0A=
+  supports_utf8:false,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_nt4 =3D {=0A=
@@ -305,6 +319,8 @@ static NO_COPY wincaps wincap_nt4 =3D {=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
   has_process_io_counters:false,=0A=
+  supports_unicode:true,=0A=
+  supports_utf8:true,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_nt4sp4 =3D {=0A=
@@ -342,6 +358,8 @@ static NO_COPY wincaps wincap_nt4sp4 =3D {=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
   has_process_io_counters:false,=0A=
+  supports_unicode:true,=0A=
+  supports_utf8:true,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_2000 =3D {=0A=
@@ -379,6 +397,8 @@ static NO_COPY wincaps wincap_2000 =3D {=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
   has_process_io_counters:true,=0A=
+  supports_unicode:true,=0A=
+  supports_utf8:true,=0A=
 };=0A=
=20=0A=
 static NO_COPY wincaps wincap_xp =3D {=0A=
@@ -416,6 +436,8 @@ static NO_COPY wincaps wincap_xp =3D {=0A=
   has_valid_processorlevel:true,=0A=
   has_64bit_file_access:true,=0A=
   has_process_io_counters:true,=0A=
+  supports_unicode:true,=0A=
+  supports_utf8:true,=0A=
 };=0A=
=20=0A=
 wincapc wincap;=0A=
Index: wincap.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/wincap.h,v=0A=
retrieving revision 1.11=0A=
diff -u -3 -p -u -p -r1.11 wincap.h=0A=
--- wincap.h	13 Jun 2002 17:28:11 -0000	1.11=0A=
+++ wincap.h	3 Jul 2002 12:32:39 -0000=0A=
@@ -47,6 +47,8 @@ struct wincaps=0A=
   unsigned has_valid_processorlevel			: 1;=0A=
   unsigned has_64bit_file_access			: 1;=0A=
   unsigned has_process_io_counters                      : 1;=0A=
+  unsigned supports_unicode                             : 1;=0A=
+  unsigned supports_utf8                                : 1;=0A=
 };=0A=
=20=0A=
 class wincapc=0A=
@@ -98,6 +100,8 @@ public:=0A=
   bool  IMPLEMENT (has_valid_processorlevel)=0A=
   bool  IMPLEMENT (has_64bit_file_access)=0A=
   bool  IMPLEMENT (has_process_io_counters)=0A=
+  bool  IMPLEMENT (supports_unicode)=0A=
+  bool  IMPLEMENT (supports_utf8)=0A=
=20=0A=
 #undef IMPLEMENT=0A=
 };=0A=
Index: winsup.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v=0A=
retrieving revision 1.96=0A=
diff -u -3 -p -u -p -r1.96 winsup.h=0A=
--- winsup.h	27 Jun 2002 20:44:27 -0000	1.96=0A=
+++ winsup.h	3 Jul 2002 12:32:40 -0000=0A=
@@ -76,6 +76,12 @@ int __stdcall sys_wcstombs(char *, const=0A=
 int __stdcall sys_mbstowcs(WCHAR *, const char *, int)=0A=
   __attribute__ ((regparm(3)));=0A=
=20=0A=
+int __stdcall sys_wcstoutf8 (char *, const WCHAR *, int)=0A=
+  __attribute__ ((regparm(3)));=0A=
+=0A=
+int __stdcall sys_utf8towcs (WCHAR *, const char *, int)=0A=
+  __attribute__ ((regparm(3)));=0A=
+=0A=
 /* Used to check if Cygwin DLL is dynamically loaded. */=0A=
 extern int dynamically_loaded;=0A=
=20=0A=
@@ -260,6 +266,7 @@ extern SYSTEM_INFO system_info;=0A=
 /*************************** Unsorted ******************************/=0A=
=20=0A=
 #define WM_ASYNCIO	0x8000		// WM_APP=0A=
+#define CP_UTF8                   65001=0A=
=20=0A=
 /* Note that MAX_PATH is defined in the windows headers */=0A=
 /* There is also PATH_MAX and MAXPATHLEN.=0A=
@@ -287,6 +294,8 @@ extern HANDLE hMainProc;=0A=
 extern bool cygwin_testing;=0A=
 extern unsigned _cygwin_testing_magic;=0A=
 extern HMODULE cygwin_hmodule;=0A=
+=0A=
+extern BOOL use_utf8;=0A=
=20=0A=
 extern char almost_null[];=0A=
=20=0A=

------=_NextPart_000_0117_01C22298.5ABC52E0
Content-Type: application/octet-stream;
	name="ChangeLog.utf8"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.utf8"
Content-length: 1600

2002-07-03  Christopher January <chris@atomice.net>

	* autoload.cc (GetFileSecurityW): Define new autoload function.
	(CreateFileW): Ditto.
	(CreateHardLinkW): Ditto.
	(CreateDirectoryW): Ditto.
	(DeleteFileW): Ditto.
	(FindFirstFileW): Ditto.
	(FindNextFileW): Ditto.
	(GetCurrentDirectoryW): Ditto.
	(GetFileAttributesW): Ditto.
	(MoveFileW): Ditto.
	(MoveFileExW): Ditto.
	(RemoveDirectoryW): Ditto.
	(SetCurrentDirectoryW): Ditto.
	(SetFileAttributesW): Ditto.
	* dcrt0.cc (use_utf8): New global flag.
	* dir.cc (mkdir): Add UTF8 support.
	(rmdir): Add UTF8 support.
	* dtable.cc (handle_to_fn): Add UTF8 support.
	* environ.cc (known): Add utf8 flag.
	* fhandler.cc (fhandler_base::open): Add UTF8 support.
	* fhandler_disk_file.cc (fhandler_disk_file::fstat): Add UTF8 support.
	(fhandler_disk_file::open): Add UTF8 support.
	(fhandler_disk_file::readdir): Add UTF8 support.
	* miscfuncs.cc (sys_wcstoutf8): New function.
	(sys_utf8towcs): New function.
	* path.cc (path_conv::check): Add UTF8 support.
	(symlink): Add UTF8 support.
	(symlink_info::check): Add UTF8 support.
	(chdir): Add UTF8 support.
	(cwdstuff:get_initial): Add UTF8 support.
	* security.cc (read_sd): Add UTF8 support.
	(write_sd): Add UTF8 support.
	* syscalls.cc (_unlink): Add UTF8 support.
	(_link): Add UTF8 support.
	(chmod): Add UTF8 support.
	(_rename): Add UTF8 support.
	* wincap.cc: Add supports_unicode and supports_utf8 flags.
	* wincap.h: Add supports_unicode and supports_utf8 flags.
	* winsup.h: Add prototypes for sys_wcstoutf8 and sys_utf8towcs.
	Add	CP_UTF8 macro. Add extern declaration for use_utf8.
	
------=_NextPart_000_0117_01C22298.5ABC52E0--
