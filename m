Return-Path: <cygwin-patches-return-2574-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22690 invoked by alias); 2 Jul 2002 00:56:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22575 invoked from network); 2 Jul 2002 00:56:21 -0000
X-WM-Posted-At: avacado.atomice.net; Tue, 2 Jul 02 01:56:14 +0100
Message-ID: <014401c22163$43bd8d10$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: Patch for /proc/registry and other /proc stuff
Date: Mon, 01 Jul 2002 17:56:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0141_01C2216B.A5433E60"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00022.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0141_01C2216B.A5433E60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 3041

* fixed bug where EISDIR was not set when trying to open a registry key.
* lseek now refreshes the file contents buffer for registry values.
* typo fixed (s/<defunct/<defunct>).
* fixed bug where contents of /proc/<pid>/<file> where not updated when
lseek was called.
* fstat now returns useful information about registry keys.
* cleaned up handling of access permissions on registry keys.
* new function in security.cc returns security information for NT objects.

Chris

---
2002-07-02  Christopher January  <chris@atomice.net>

 * autoload.cc (GetSecurityInfo): Define new autoload function.
 (RegQueryInfoKeyA): Ditto.
 * fhandler.h (fhandler_virtual::fill_filebuf): Change return type to bool.
 (fhandler_proc::fill_filebuf): Ditto.
 (fhandler_registry::fill_filebuf): Ditto.
 (fhandler_process::fill_filebuf): Ditto.
 (fhandler_registry::value_name): Add new member.
 (fhandler_registry::close): Add new method.
 (fhandler_process::p): Remove member.
 * fhandler_proc.cc (fhandler_proc::open): Add set_nohandle after calling
 superclass method. Check return value of fill_filebuf.
 (fhandler_proc::fill_filebuf): Change return type to bool. Add return
 statement.
 * fhandler_process.cc (fhandler_process::open): Add set_nohandle after
 calling superclass method. Remove references to p. Check return value of
 fill_filebuf.
 (fhandler_process::fill_filebuf): Change return type to bool. Don't use
 dereference operator on p. Add return statement.
 (fhandler_process::format_process_stat): Fix typo.
 * fhandler_registry.cc: Add static open_key declaration.
 (fhandler_registry::exists): Assume path is already normalised. Try
 opening the path as a key in its own right first, before reverting to
 enumerating subkeys and values of the parent key.
 (fhandler_registry::fstat): Add additional code to return more relevant
 information about the registry key/value.
 (fhandler_registry::readdir): Explicitly set desired access when opening
 registry key. Remove output of buf from debug_printf format string.
 (fhandler_registry::open): Use set_io_handle to store registry key handle.
 Set value_name member. Move code to read a value from the registry to
 fill_filebuf. Add call to fill_filebuf.
 (fhandler_registry::close): New method.
 (fhandler_registry::fill_filebuf): Change return type to bool. Add code
 to read a value from registry.
 (fhandler_registry::open_key): Make function static. Use KEY_READ as
 desired access unless this is the last path component. Check the return
 value of RegOpenKeyEx for an error instead of hKey.
 * fhandler_virtual.cc (fhandler_virtual::lseek): Check the return value of
 fill_filebuf.
 (fhandler_virtual::open): Remove call to set_nohandle.
 (fhandler_virtual::fill_filebuf): Change return type to bool. Add return
 statement.
 * security.cc (get_nt_object_attribute): New function.
 (get_object_attribute): New function.
 * security.h: Only include definitions of SE_OBJECT_TYPE and INHERITY_ONLY
 if the _ACCCTRL_H macro is not defined.
 (get_object_attribute): New function declaration.


------=_NextPart_000_0141_01C2216B.A5433E60
Content-Type: text/plain;
	name="ChangeLog.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.6.txt"
Content-length: 2565

2002-07-02  Christopher January  <chris@atomice.net>

	* autoload.cc (GetSecurityInfo): Define new autoload function.
	(RegQueryInfoKeyA): Ditto.
	* fhandler.h (fhandler_virtual::fill_filebuf): Change return type to bool.
	(fhandler_proc::fill_filebuf): Ditto.
	(fhandler_registry::fill_filebuf): Ditto.
	(fhandler_process::fill_filebuf): Ditto.
	(fhandler_registry::value_name): Add new member.
	(fhandler_registry::close): Add new method.
	(fhandler_process::p): Remove member.
	* fhandler_proc.cc (fhandler_proc::open): Add set_nohandle after calling
	superclass method. Check return value of fill_filebuf.
	(fhandler_proc::fill_filebuf): Change return type to bool. Add return
	statement.
	* fhandler_process.cc (fhandler_process::open): Add set_nohandle after
	calling superclass method. Remove references to p. Check return value of
	fill_filebuf.
	(fhandler_process::fill_filebuf): Change return type to bool. Don't use
	dereference operator on p. Add return statement.
	(fhandler_process::format_process_stat): Fix typo.
	* fhandler_registry.cc: Add static open_key declaration.
	(fhandler_registry::exists): Assume path is already normalised. Try
	opening the path as a key in its own right first, before reverting to
	enumerating subkeys and values of the parent key.
	(fhandler_registry::fstat): Add additional code to return more relevant
	information about the registry key/value.
	(fhandler_registry::readdir): Explicitly set desired access when opening
	registry key. Remove output of buf from debug_printf format string.
	(fhandler_registry::open): Use set_io_handle to store registry key handle.
	Set value_name member. Move code to read a value from the registry to
	fill_filebuf. Add call to fill_filebuf.
	(fhandler_registry::close): New method.
	(fhandler_registry::fill_filebuf): Change return type to bool. Add code
	to read a value from registry. 
	(fhandler_registry::open_key): Make function static. Use KEY_READ as
	desired access unless this is the last path component. Check the return
	value of RegOpenKeyEx for an error instead of hKey.
	* fhandler_virtual.cc (fhandler_virtual::lseek): Check the return value of
	fill_filebuf.
	(fhandler_virtual::open): Remove call to set_nohandle.
	(fhandler_virtual::fill_filebuf): Change return type to bool. Add return
	statement.
	* security.cc (get_nt_object_attribute): New function.
	(get_object_attribute): New function.
	* security.h: Only include definitions of SE_OBJECT_TYPE and INHERITY_ONLY
	if the _ACCCTRL_H macro is not defined.
	(get_object_attribute): New function declaration.
	
------=_NextPart_000_0141_01C2216B.A5433E60
Content-Type: application/octet-stream;
	name="proc.patch.6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.patch.6"
Content-length: 33181

Index: autoload.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v=0A=
retrieving revision 1.50=0A=
diff -u -3 -p -u -p -r1.50 autoload.cc=0A=
--- autoload.cc	29 Jun 2002 22:05:30 -0000	1.50=0A=
+++ autoload.cc	2 Jul 2002 00:40:06 -0000=0A=
@@ -326,6 +326,7 @@ LoadDLLfunc (GetLengthSid, 4, advapi32)=0A=
 LoadDLLfunc (GetSecurityDescriptorDacl, 16, advapi32)=0A=
 LoadDLLfunc (GetSecurityDescriptorGroup, 12, advapi32)=0A=
 LoadDLLfunc (GetSecurityDescriptorOwner, 12, advapi32)=0A=
+LoadDLLfunc (GetSecurityInfo, 32, advapi32)=0A=
 LoadDLLfunc (GetSidIdentifierAuthority, 4, advapi32)=0A=
 LoadDLLfunc (GetSidSubAuthority, 8, advapi32)=0A=
 LoadDLLfunc (GetSidSubAuthorityCount, 4, advapi32)=0A=
@@ -358,6 +359,7 @@ LoadDLLfunc (RegLoadKeyA, 12, advapi32)=0A=
 LoadDLLfunc (RegEnumKeyExA, 32, advapi32)=0A=
 LoadDLLfunc (RegEnumValueA, 32, advapi32)=0A=
 LoadDLLfunc (RegOpenKeyExA, 20, advapi32)=0A=
+LoadDLLfunc (RegQueryInfoKeyA, 48, advapi32)=0A=
 LoadDLLfunc (RegQueryValueExA, 24, advapi32)=0A=
 LoadDLLfunc (RegSetValueExA, 24, advapi32)=0A=
 LoadDLLfunc (RegisterEventSourceA, 8, advapi32)=0A=
Index: fhandler.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v=0A=
retrieving revision 1.126=0A=
diff -u -3 -p -u -p -r1.126 fhandler.h=0A=
--- fhandler.h	30 Jun 2002 23:02:58 -0000	1.126=0A=
+++ fhandler.h	2 Jul 2002 00:40:28 -0000=0A=
@@ -1090,7 +1090,7 @@ class fhandler_virtual : public fhandler=0A=
   int open (path_conv *, int flags, mode_t mode =3D 0);=0A=
   int close (void);=0A=
   int __stdcall fstat (struct stat *buf, path_conv *pc) __attribute__ ((re=
gparm (3)));=0A=
-  virtual void fill_filebuf ();=0A=
+  virtual bool fill_filebuf ();=0A=
 };=0A=
=20=0A=
 class fhandler_proc: public fhandler_virtual=0A=
@@ -1104,11 +1104,13 @@ class fhandler_proc: public fhandler_vir=0A=
=20=0A=
   int open (path_conv *real_path, int flags, mode_t mode =3D 0);=0A=
   int __stdcall fstat (struct __stat64 *buf, path_conv *) __attribute__ ((=
regparm (3)));=0A=
-  void fill_filebuf ();=0A=
+  bool fill_filebuf ();=0A=
 };=0A=
=20=0A=
 class fhandler_registry: public fhandler_proc=0A=
 {=0A=
+ private:=0A=
+  char *value_name;=0A=
  public:=0A=
   fhandler_registry ();=0A=
   int exists();=0A=
@@ -1120,22 +1122,21 @@ class fhandler_registry: public fhandler=0A=
=20=0A=
   int open (path_conv *real_path, int flags, mode_t mode =3D 0);=0A=
   int __stdcall fstat (struct __stat64 *buf, path_conv *) __attribute__ ((=
regparm (3)));=0A=
-  HKEY open_key(const char *name, REGSAM access =3D KEY_READ, bool isValue=
 =3D false);=0A=
-  void fill_filebuf ();=0A=
+  bool fill_filebuf ();=0A=
+  int close (void);=0A=
 };=0A=
=20=0A=
 class pinfo;=0A=
 class fhandler_process: public fhandler_proc=0A=
 {=0A=
   pid_t pid;=0A=
-  pinfo *p;=0A=
  public:=0A=
   fhandler_process ();=0A=
   int exists();=0A=
   struct dirent *readdir (DIR *);=0A=
   int open (path_conv *real_path, int flags, mode_t mode =3D 0);=0A=
   int __stdcall fstat (struct __stat64 *buf, path_conv *) __attribute__ ((=
regparm (3)));=0A=
-  void fill_filebuf ();=0A=
+  bool fill_filebuf ();=0A=
 };=0A=
=20=0A=
 typedef union=0A=
Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.13=0A=
diff -u -3 -p -u -p -r1.13 fhandler_proc.cc=0A=
--- fhandler_proc.cc	1 Jul 2002 19:03:26 -0000	1.13=0A=
+++ fhandler_proc.cc	2 Jul 2002 00:40:33 -0000=0A=
@@ -216,6 +216,8 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
   if (!res)=0A=
     goto out;=0A=
=20=0A=
+  set_nohandle (true);=0A=
+=0A=
   const char *path;=0A=
=20=0A=
   path =3D get_name () + proc_len;=0A=
@@ -291,7 +293,11 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
     }=0A=
=20=0A=
   fileid =3D proc_file_no;=0A=
-  fill_filebuf ();=0A=
+  if (!fill_filebuf ())=0A=
+    {=0A=
+      res =3D 0;=0A=
+      goto out;=0A=
+	}=0A=
=20=0A=
   if (flags & O_APPEND)=0A=
     position =3D filesize;=0A=
@@ -307,7 +313,7 @@ out:=0A=
   return res;=0A=
 }=0A=
=20=0A=
-void=0A=
+bool=0A=
 fhandler_proc::fill_filebuf ()=0A=
 {=0A=
   switch (fileid)=0A=
@@ -361,6 +367,7 @@ fhandler_proc::fill_filebuf ()=0A=
 	break;=0A=
       }=0A=
     }=0A=
+    return true;=0A=
 }=0A=
=20=0A=
 static=0A=
Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.17=0A=
diff -u -3 -p -u -p -r1.17 fhandler_process.cc=0A=
--- fhandler_process.cc	1 Jul 2002 19:03:26 -0000	1.17=0A=
+++ fhandler_process.cc	2 Jul 2002 00:40:34 -0000=0A=
@@ -159,6 +159,8 @@ fhandler_process::open (path_conv *pc, i=0A=
   if (!res)=0A=
     goto out;=0A=
=20=0A=
+  set_nohandle (true);=0A=
+=0A=
   const char *path;=0A=
   path =3D get_name () + proc_len + 1;=0A=
   pid =3D atoi (path);=0A=
@@ -215,25 +217,17 @@ fhandler_process::open (path_conv *pc, i=0A=
       goto out;=0A=
     }=0A=
=20=0A=
-  {=0A=
-  pinfo p (pid);=0A=
-  if (!p)=0A=
-    {=0A=
-      set_errno (ENOENT);=0A=
-      res =3D 0;=0A=
-      goto out;=0A=
-    }=0A=
-=0A=
   fileid =3D process_file_no;=0A=
-  this->p =3D &p;=0A=
-  fill_filebuf ();=0A=
+  if (!fill_filebuf ())=0A=
+  	{=0A=
+	  res =3D 0;=0A=
+	  goto out;=0A=
+	}=0A=
=20=0A=
   if (flags & O_APPEND)=0A=
     position =3D filesize;=0A=
   else=0A=
     position =3D 0;=0A=
-  this->p =3D NULL;=0A=
-  }=0A=
=20=0A=
 success:=0A=
   res =3D 1;=0A=
@@ -244,20 +238,18 @@ out:=0A=
   return res;=0A=
 }=0A=
=20=0A=
-void=0A=
+bool=0A=
 fhandler_process::fill_filebuf ()=0A=
 {=0A=
-  pinfo pmaybe;=0A=
+  pinfo p;=0A=
=20=0A=
+  p.init (pid);=0A=
   if (!p)=0A=
     {=0A=
-      pmaybe.init (pid);=0A=
-      p =3D &pmaybe;=0A=
+	  set_errno (ENOENT);=0A=
+      return false;=0A=
     }=0A=
=20=0A=
-  if (!p)=0A=
-    return;=0A=
-=0A=
   switch (fileid)=0A=
     {=0A=
     case PROCESS_UID:=0A=
@@ -273,22 +265,22 @@ fhandler_process::fill_filebuf ()=0A=
 	switch (fileid)=0A=
 	  {=0A=
 	  case PROCESS_PPID:=0A=
-	    num =3D (*p)->ppid;=0A=
+	    num =3D p->ppid;=0A=
 	    break;=0A=
 	  case PROCESS_UID:=0A=
-	    num =3D (*p)->uid;=0A=
+	    num =3D p->uid;=0A=
 	    break;=0A=
 	  case PROCESS_PGID:=0A=
-	    num =3D (*p)->pgid;=0A=
+	    num =3D p->pgid;=0A=
 	    break;=0A=
 	  case PROCESS_SID:=0A=
-	    num =3D (*p)->sid;=0A=
+	    num =3D p->sid;=0A=
 	    break;=0A=
 	  case PROCESS_GID:=0A=
-	    num =3D (*p)->gid;=0A=
+	    num =3D p->gid;=0A=
 	    break;=0A=
 	  case PROCESS_CTTY:=0A=
-	    num =3D (*p)->ctty;=0A=
+	    num =3D p->ctty;=0A=
 	    break;=0A=
 	  default: // what's this here for?=0A=
 	    num =3D 0;=0A=
@@ -302,11 +294,11 @@ fhandler_process::fill_filebuf ()=0A=
       {=0A=
 	if (!filebuf)=0A=
 	filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D MAX_PATH);=0A=
-	if ((*p)->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
+	if (p->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
 	  strcpy (filebuf, "<defunct>");=0A=
 	else=0A=
 	  {=0A=
-	    mount_table->conv_to_posix_path ((*p)->progname, filebuf, 1);=0A=
+	    mount_table->conv_to_posix_path (p->progname, filebuf, 1);=0A=
 	    int len =3D strlen (filebuf);=0A=
 	    if (len > 4)=0A=
 	      {=0A=
@@ -322,16 +314,16 @@ fhandler_process::fill_filebuf ()=0A=
       {=0A=
 	if (!filebuf)=0A=
 	filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 40);=0A=
-	__small_sprintf (filebuf, "%d\n", (*p)->dwProcessId);=0A=
+	__small_sprintf (filebuf, "%d\n", p->dwProcessId);=0A=
 	filesize =3D strlen (filebuf);=0A=
 	break;=0A=
       }=0A=
     case PROCESS_WINEXENAME:=0A=
       {=0A=
-	int len =3D strlen ((*p)->progname);=0A=
+	int len =3D strlen (p->progname);=0A=
 	if (!filebuf)=0A=
 	filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D (len + 2));=0A=
-	strcpy (filebuf, (*p)->progname);=0A=
+	strcpy (filebuf, p->progname);=0A=
 	filebuf[len] =3D '\n';=0A=
 	filesize =3D len + 1;=0A=
 	break;=0A=
@@ -340,27 +332,26 @@ fhandler_process::fill_filebuf ()=0A=
       {=0A=
 	if (!filebuf)=0A=
 	  filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 2048);=0A=
-	filesize =3D format_process_status ((*p), filebuf, bufalloc);=0A=
+	filesize =3D format_process_status (*p, filebuf, bufalloc);=0A=
 	break;=0A=
       }=0A=
     case PROCESS_STAT:=0A=
       {=0A=
 	if (!filebuf)=0A=
 	  filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 2048);=0A=
-	filesize =3D format_process_stat ((*p), filebuf, bufalloc);=0A=
+	filesize =3D format_process_stat (*p, filebuf, bufalloc);=0A=
 	break;=0A=
       }=0A=
     case PROCESS_STATM:=0A=
       {=0A=
 	if (!filebuf)=0A=
 	  filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 2048);=0A=
-	filesize =3D format_process_statm ((*p), filebuf, bufalloc);=0A=
+	filesize =3D format_process_statm (*p, filebuf, bufalloc);=0A=
 	break;=0A=
       }=0A=
     }=0A=
=20=0A=
-  if (p =3D=3D &pmaybe)=0A=
-    p =3D NULL;=0A=
+  return true;=0A=
 }=0A=
=20=0A=
 static=0A=
@@ -375,7 +366,7 @@ format_process_stat (_pinfo *p, char *de=0A=
 		vmsize =3D 0UL, vmrss =3D 0UL, vmmaxrss =3D 0UL;=0A=
   int priority =3D 0;=0A=
   if (p->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
-    strcpy (cmd, "<defunct");=0A=
+    strcpy (cmd, "<defunct>");=0A=
   else=0A=
     {=0A=
       strcpy(cmd, p->progname);=0A=
Index: fhandler_registry.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_registry.cc,v=0A=
retrieving revision 1.9=0A=
diff -u -3 -p -u -p -r1.9 fhandler_registry.cc=0A=
--- fhandler_registry.cc	1 Jul 2002 19:03:26 -0000	1.9=0A=
+++ fhandler_registry.cc	2 Jul 2002 00:40:35 -0000=0A=
@@ -84,6 +84,9 @@ static const int SPECIAL_DOT_FILE_COUNT=20=0A=
 /* Name given to default values */=0A=
 static const char *DEFAULT_VALUE_NAME =3D "@";=0A=
=20=0A=
+static HKEY=0A=
+open_key (const char *name, REGSAM access, bool isValue);=0A=
+=0A=
 /* Returns 0 if path doesn't exist, >0 if path is a directory,=0A=
  * <0 if path is a file.=0A=
  *=0A=
@@ -103,10 +106,7 @@ fhandler_registry::exists ()=0A=
=20=0A=
   const char *path =3D get_name ();=0A=
   debug_printf ("exists (%s)", path);=0A=
-  path +=3D proc_len + 1 + registry_len;=0A=
-=0A=
-  while (SLASH_P (*path))=0A=
-    path++;=0A=
+  path +=3D proc_len + registry_len + 2;=0A=
   if (*path =3D=3D 0)=0A=
     {=0A=
       file_type =3D 2;=0A=
@@ -132,44 +132,50 @@ fhandler_registry::exists ()=0A=
       goto out;=0A=
     }=0A=
=20=0A=
-  hKey =3D open_key (path, KEY_READ, true);=0A=
-  if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
-    return 0;=0A=
-=0A=
-  while (ERROR_SUCCESS =3D=3D=0A=
-	 (error =3D RegEnumKeyEx (hKey, index++, buf, &buf_size, NULL, NULL,=0A=
-				NULL, NULL)) || (error =3D=3D ERROR_MORE_DATA))=0A=
-    {=0A=
-      if (pathmatch (buf, file))=0A=
-	{=0A=
-	  file_type =3D 1;=0A=
-	  goto out;=0A=
-	}=0A=
-      buf_size =3D MAX_PATH;=0A=
-    }=0A=
-  if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
-    {=0A=
-      seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
-      goto out;=0A=
-    }=0A=
-  index =3D 0;=0A=
-  buf_size =3D MAX_PATH;=0A=
-  while (ERROR_SUCCESS =3D=3D=0A=
-	 (error =3D RegEnumValue (hKey, index++, buf, &buf_size, NULL, NULL,=0A=
-				NULL, NULL)) || (error =3D=3D ERROR_MORE_DATA))=0A=
+  hKey =3D open_key (path, KEY_READ, false);=0A=
+  if (hKey !=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+    file_type =3D 1;=0A=
+  else=0A=
     {=0A=
-      if (pathmatch (buf, file) || (buf[0] =3D=3D '\0' &&=0A=
-				    pathmatch (file, DEFAULT_VALUE_NAME)))=0A=
-	{=0A=
-	  file_type =3D -1;=0A=
-	  goto out;=0A=
-	}=0A=
+      hKey =3D open_key (path, KEY_READ, true);=0A=
+      if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+        return 0;=0A=
+=0A=
+      while (ERROR_SUCCESS =3D=3D=0A=
+	         (error =3D RegEnumKeyEx (hKey, index++, buf, &buf_size, NULL, NU=
LL,=0A=
+                                    NULL, NULL)) || (error =3D=3D ERROR_MO=
RE_DATA))=0A=
+        {=0A=
+          if (pathmatch (buf, file))=0A=
+	        {=0A=
+	          file_type =3D 1;=0A=
+	          goto out;=0A=
+	        }=0A=
+          buf_size =3D MAX_PATH;=0A=
+        }=0A=
+      if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
+        {=0A=
+          seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+          goto out;=0A=
+        }=0A=
+      index =3D 0;=0A=
       buf_size =3D MAX_PATH;=0A=
-    }=0A=
-  if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
-    {=0A=
-      seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
-      goto out;=0A=
+      while (ERROR_SUCCESS =3D=3D=0A=
+	         (error =3D RegEnumValue (hKey, index++, buf, &buf_size, NULL, NU=
LL,=0A=
+                                    NULL, NULL)) || (error =3D=3D ERROR_MO=
RE_DATA))=0A=
+        {=0A=
+          if (pathmatch (buf, file) || (buf[0] =3D=3D '\0' &&=0A=
+              pathmatch (file, DEFAULT_VALUE_NAME)))=0A=
+            {=0A=
+              file_type =3D -1;=0A=
+	          goto out;=0A=
+            }=0A=
+          buf_size =3D MAX_PATH;=0A=
+        }=0A=
+      if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
+        {=0A=
+          seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+          goto out;=0A=
+        }=0A=
     }=0A=
 out:=0A=
   if (hKey !=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
@@ -206,6 +212,53 @@ fhandler_registry::fstat (struct __stat6=0A=
       buf->st_mode &=3D NO_X;=0A=
       break;=0A=
     }=0A=
+  if (file_type !=3D 0 && file_type !=3D 2)=0A=
+    {=0A=
+	  HKEY hKey;=0A=
+      const char *path =3D get_name () + proc_len + registry_len + 2;=0A=
+      hKey =3D open_key (path, STANDARD_RIGHTS_READ | KEY_QUERY_VALUE, (fi=
le_type < 0)?true:false);=0A=
+=0A=
+      if (hKey !=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+        {=0A=
+          FILETIME ftLastWriteTime;=0A=
+          DWORD subkey_count;=0A=
+          if (ERROR_SUCCESS =3D=3D RegQueryInfoKey (hKey, NULL, NULL, NULL=
, &subkey_count, NULL, NULL, NULL, NULL, NULL,=0A=
+                                                NULL, &ftLastWriteTime))=
=0A=
+            {=0A=
+  			  to_timestruc_t (&ftLastWriteTime, &buf->st_mtim);=0A=
+  			  buf->st_ctim =3D buf->st_mtim;=0A=
+      		  time_as_timestruc_t(&buf->st_atim);=0A=
+  			  if (file_type > 0)=0A=
+  			  	buf->st_nlink =3D subkey_count;=0A=
+  			  else=0A=
+  			    {=0A=
+  				  int pathlen =3D strlen (path);=0A=
+				  const char *value_name =3D path + pathlen - 1;=0A=
+  				  if (SLASH_P (*value_name) && pathlen > 1)=0A=
+    				value_name--;=0A=
+  				  while (!SLASH_P (*value_name))=0A=
+  				    value_name--;=0A=
+  				  value_name++;=0A=
+  				  DWORD dwSize;=0A=
+				  if (ERROR_SUCCESS =3D=3D RegQueryValueEx (hKey, value_name, NULL, NU=
LL, NULL, &dwSize))=0A=
+				  	buf->st_size =3D dwSize;=0A=
+			    }=0A=
+  			  __uid32_t uid;=0A=
+  			  __gid32_t gid;=0A=
+   		      if (get_object_attribute ((HANDLE) hKey, SE_REGISTRY_KEY, &buf-=
>st_mode, &uid, &gid) =3D=3D 0)=0A=
+   		        {=0A=
+				  buf->st_uid =3D uid;=0A=
+				  buf->st_gid =3D gid;=0A=
+				  buf->st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);=0A=
+				  if (file_type > 0)=0A=
+				  	buf->st_mode |=3D S_IFDIR;=0A=
+				  else=0A=
+				    buf->st_mode &=3D NO_X;=0A=
+			    }=0A=
+	        }=0A=
+	      RegCloseKey(hKey);=0A=
+	   }=0A=
+	}=0A=
   return 0;=0A=
 }=0A=
=20=0A=
@@ -230,8 +283,8 @@ fhandler_registry::readdir (DIR * dir)=0A=
   if (dir->__d_u.__d_data.__handle =3D=3D INVALID_HANDLE_VALUE=0A=
       && dir->__d_position =3D=3D 0)=0A=
     {=0A=
-      handle =3D open_key (path + 1);=0A=
-      dir->__d_u.__d_data.__handle =3D handle;;=0A=
+      handle =3D open_key (path + 1, KEY_READ, false);=0A=
+      dir->__d_u.__d_data.__handle =3D handle;=0A=
     }=0A=
   if (dir->__d_u.__d_data.__handle =3D=3D INVALID_HANDLE_VALUE)=0A=
     goto out;=0A=
@@ -280,7 +333,7 @@ retry:=0A=
     dir->__d_position +=3D 0x10000;=0A=
   res =3D dir->__d_dirent;=0A=
 out:=0A=
-  syscall_printf ("%p =3D readdir (%p) (%s)", &dir->__d_dirent, dir, buf);=
=0A=
+  syscall_printf ("%p =3D readdir (%p)", &dir->__d_dirent, dir);=0A=
   return res;=0A=
 }=0A=
=20=0A=
@@ -331,11 +384,9 @@ fhandler_registry::closedir (DIR * dir)=0A=
 int=0A=
 fhandler_registry::open (path_conv *pc, int flags, mode_t mode)=0A=
 {=0A=
-  DWORD type, size;=0A=
-  LONG error;=0A=
-  HKEY hKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
   int pathlen;=0A=
   const char *file;=0A=
+  HKEY handle;=0A=
=20=0A=
   int res =3D fhandler_virtual::open (pc, flags, mode);=0A=
   if (!res)=0A=
@@ -418,33 +469,87 @@ fhandler_registry::open (path_conv *pc,=20=0A=
       goto out;=0A=
     }=0A=
=20=0A=
-  hKey =3D open_key (path, KEY_READ, true);=0A=
-  if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+  handle =3D open_key (path, KEY_READ, true);=0A=
+  if (handle =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
     {=0A=
       res =3D 0;=0A=
       goto out;=0A=
     }=0A=
+=0A=
+  set_io_handle (handle);=0A=
+=0A=
   if (pathmatch (file, DEFAULT_VALUE_NAME))=0A=
-    file =3D "";=0A=
+    value_name =3D cstrdup ("");=0A=
+  else=0A=
+    value_name =3D cstrdup (file);=0A=
=20=0A=
-  if (hKey !=3D HKEY_PERFORMANCE_DATA)=0A=
+  if (!fill_filebuf ())=0A=
     {=0A=
-      error =3D RegQueryValueEx (hKey, file, NULL, &type, NULL, &size);=0A=
-      if (error !=3D ERROR_SUCCESS)=0A=
-	{=0A=
-	  seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
-	  res =3D -1;=0A=
+	  RegCloseKey (handle);=0A=
+	  res =3D 0;=0A=
 	  goto out;=0A=
 	}=0A=
+=0A=
+  if (flags & O_APPEND)=0A=
+    position =3D filesize;=0A=
+  else=0A=
+    position =3D 0;=0A=
+=0A=
+success:=0A=
+  res =3D 1;=0A=
+  set_flags ((flags & ~O_TEXT) | O_BINARY);=0A=
+  set_open_status ();=0A=
+out:=0A=
+  syscall_printf ("%d =3D fhandler_registry::open (%p, %d)", res, flags, m=
ode);=0A=
+  return res;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_registry::close ()=0A=
+{=0A=
+  int res =3D fhandler_virtual::close ();=0A=
+  if (res !=3D 0)=0A=
+  	return res;=0A=
+  HKEY handle =3D (HKEY) get_handle ();=0A=
+  if (handle !=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+    {=0A=
+	  if (RegCloseKey (handle) !=3D ERROR_SUCCESS)=0A=
+        {=0A=
+          __seterrno ();=0A=
+          res =3D -1;=0A=
+        }=0A=
+	}=0A=
+  if (value_name)=0A=
+    cfree (value_name);=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+bool=0A=
+fhandler_registry::fill_filebuf ()=0A=
+{=0A=
+  DWORD type, size;=0A=
+  LONG error;=0A=
+  HKEY handle =3D (HKEY) get_handle();=0A=
+  if (handle !=3D HKEY_PERFORMANCE_DATA)=0A=
+    {=0A=
+      error =3D RegQueryValueEx (handle, value_name, NULL, &type, NULL, &s=
ize);=0A=
+      if (error !=3D ERROR_SUCCESS)=0A=
+	    {=0A=
+		  if (error !=3D ERROR_FILE_NOT_FOUND)=0A=
+		    {=0A=
+	          seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+	          return false;=0A=
+			}=0A=
+          goto value_not_found;=0A=
+        }=0A=
       bufalloc =3D size;=0A=
       filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc);=0A=
       error =3D=0A=
-	RegQueryValueEx (hKey, file, NULL, NULL, (BYTE *) filebuf, &size);=0A=
+	RegQueryValueEx (handle, value_name, NULL, NULL, (BYTE *) filebuf, &size)=
;=0A=
       if (error !=3D ERROR_SUCCESS)=0A=
 	{=0A=
 	  seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
-	  res =3D 0;=0A=
-	  goto out;=0A=
+	  return true;=0A=
 	}=0A=
       filesize =3D size;=0A=
     }=0A=
@@ -460,43 +565,49 @@ fhandler_registry::open (path_conv *pc,=20=0A=
 	      filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc);=0A=
 	    }=0A=
 	  error =3D=0A=
-	    RegQueryValueEx (hKey, file, NULL, &type, (BYTE *) filebuf,=0A=
+	    RegQueryValueEx (handle, value_name, NULL, &type, (BYTE *) filebuf,=
=0A=
 			     &size);=0A=
-	  if (error !=3D ERROR_SUCCESS && res !=3D ERROR_MORE_DATA)=0A=
+	  if (error !=3D ERROR_SUCCESS && error !=3D ERROR_MORE_DATA)=0A=
 	    {=0A=
-	      seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
-	      res =3D 0;=0A=
-	      goto out;=0A=
+          if (error !=3D ERROR_FILE_NOT_FOUND)=0A=
+            {=0A=
+	          seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+	          return true;=0A=
+            }=0A=
+          goto value_not_found;=0A=
 	    }=0A=
 	}=0A=
       while (error =3D=3D ERROR_MORE_DATA);=0A=
       filesize =3D size;=0A=
     }=0A=
-=0A=
-  if (flags & O_APPEND)=0A=
-    position =3D filesize;=0A=
-  else=0A=
-    position =3D 0;=0A=
-=0A=
-success:=0A=
-  res =3D 1;=0A=
-  set_flags ((flags & ~O_TEXT) | O_BINARY);=0A=
-  set_open_status ();=0A=
-out:=0A=
-  if (hKey !=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
-    RegCloseKey (hKey);=0A=
-  syscall_printf ("%d =3D fhandler_registry::open (%p, %d)", res, flags, m=
ode);=0A=
-  return res;=0A=
-}=0A=
-=0A=
-void=0A=
-fhandler_registry::fill_filebuf ()=0A=
-{=0A=
+    return true;=0A=
+value_not_found:=0A=
+   DWORD buf_size =3D MAX_PATH;=0A=
+   char buf[buf_size];=0A=
+   int index =3D 0;=0A=
+   while (ERROR_SUCCESS =3D=3D=0A=
+          (error =3D RegEnumKeyEx (handle, index++, buf, &buf_size, NULL, =
NULL,=0A=
+                                 NULL, NULL)) || (error =3D=3D ERROR_MORE_=
DATA))=0A=
+     {=0A=
+       if (pathmatch (buf, value_name))=0A=
+         {=0A=
+           set_errno (EISDIR);=0A=
+           return false;=0A=
+         }=0A=
+         buf_size =3D MAX_PATH;=0A=
+     }=0A=
+   if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
+     {=0A=
+      seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+      return false;=0A=
+     }=0A=
+   set_errno (ENOENT);=0A=
+   return false;=0A=
 }=0A=
=20=0A=
 /* Auxillary member function to open registry keys.  */=0A=
-HKEY=0A=
-fhandler_registry::open_key (const char *name, REGSAM access, bool isValue=
)=0A=
+static HKEY=0A=
+open_key (const char *name, REGSAM access, bool isValue)=0A=
 {=0A=
   HKEY hKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
   HKEY hParentKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
@@ -513,14 +624,17 @@ fhandler_registry::open_key (const char=20=0A=
       if (*name)=0A=
 	name++;=0A=
       if (*name =3D=3D 0 && isValue =3D=3D true)=0A=
-	goto out;=0A=
+	    goto out;=0A=
=20=0A=
       if (hParentKey !=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
 	{=0A=
-	  hKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
-	  LONG error =3D RegOpenKeyEx (hParentKey, component, 0, access, &hKey);=
=0A=
-	  if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+	  REGSAM effective_access =3D KEY_READ;=0A=
+	  if ((strchr (name, '/') =3D=3D NULL && isValue =3D=3D true) || *name =
=3D=3D 0)=0A=
+		effective_access =3D access;=0A=
+	  LONG error =3D RegOpenKeyEx (hParentKey, component, 0, effective_access=
, &hKey);=0A=
+	  if (error !=3D ERROR_SUCCESS)=0A=
 	    {=0A=
+          hKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
 	      seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
 	      return hKey;=0A=
 	    }=0A=
Index: fhandler_virtual.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v=0A=
retrieving revision 1.8=0A=
diff -u -3 -p -u -p -r1.8 fhandler_virtual.cc=0A=
--- fhandler_virtual.cc	1 Jul 2002 19:03:26 -0000	1.8=0A=
+++ fhandler_virtual.cc	2 Jul 2002 00:40:39 -0000=0A=
@@ -115,7 +115,8 @@ fhandler_virtual::lseek (__off64_t offse=0A=
    * On Linux, when you lseek within a /proc file,=0A=
    * the contents of the file are updated.=0A=
    */=0A=
-  fill_filebuf ();=0A=
+  if (!fill_filebuf ())=0A=
+  	return (__off64_t) -1;=0A=
   switch (whence)=0A=
     {=0A=
     case SEEK_SET:=0A=
@@ -209,8 +210,6 @@ fhandler_virtual::open (path_conv *, int=0A=
=20=0A=
   set_flags ((flags & ~O_TEXT) | O_BINARY);=0A=
=20=0A=
-  set_nohandle (true);=0A=
-=0A=
   return 1;=0A=
 }=0A=
=20=0A=
@@ -220,7 +219,8 @@ fhandler_virtual::exists ()=0A=
   return 0;=0A=
 }=0A=
=20=0A=
-void=0A=
+bool=0A=
 fhandler_virtual::fill_filebuf ()=0A=
 {=0A=
+  return true;=0A=
 }=0A=
Index: security.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v=0A=
retrieving revision 1.109=0A=
diff -u -3 -p -u -p -r1.109 security.cc=0A=
--- security.cc	1 Jul 2002 02:36:04 -0000	1.109=0A=
+++ security.cc	2 Jul 2002 00:41:11 -0000=0A=
@@ -28,6 +28,7 @@ details. */=0A=
 #include <wininet.h>=0A=
 #include <ntsecapi.h>=0A=
 #include <subauth.h>=0A=
+#include <aclapi.h>=0A=
 #include "cygerrno.h"=0A=
 #include "security.h"=0A=
 #include "fhandler.h"=0A=
@@ -1299,6 +1300,174 @@ get_file_attribute (int use_ntsec, const=0A=
     *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;=0A=
=20=0A=
   return res > 0 ? 0 : -1;=0A=
+}=0A=
+=0A=
+static int=0A=
+get_nt_object_attribute (HANDLE handle, SE_OBJECT_TYPE object_type, int *a=
ttribute,=0A=
+		  __uid32_t *uidret, __gid32_t *gidret)=0A=
+{=0A=
+  if (!wincap.has_security ())=0A=
+    return 0;=0A=
+=0A=
+  PSECURITY_DESCRIPTOR psd =3D NULL;=0A=
+  PSID owner_sid;=0A=
+  PSID group_sid;=0A=
+  PACL acl;=0A=
+=0A=
+  if (ERROR_SUCCESS !=3D GetSecurityInfo (handle, object_type,=0A=
+                                        DACL_SECURITY_INFORMATION |=0A=
+                                        GROUP_SECURITY_INFORMATION |=0A=
+                                        OWNER_SECURITY_INFORMATION,=0A=
+                                        &owner_sid,=0A=
+                                        &group_sid,=0A=
+                                        &acl,=0A=
+                                        NULL,=0A=
+                                        &psd))=0A=
+	{=0A=
+	  __seterrno ();=0A=
+	  debug_printf ("GetSecurityInfo %E");=0A=
+	  return -1;=0A=
+    }=0A=
+=0A=
+  __uid32_t uid =3D cygsid (owner_sid).get_uid ();=0A=
+  __gid32_t gid =3D cygsid (group_sid).get_gid ();=0A=
+  if (uidret)=0A=
+    *uidret =3D uid;=0A=
+  if (gidret)=0A=
+    *gidret =3D gid;=0A=
+=0A=
+  if (!attribute)=0A=
+    {=0A=
+      syscall_printf ("uid %d, gid %d", uid, gid);=0A=
+      LocalFree (psd);=0A=
+      return 0;=0A=
+    }=0A=
+=0A=
+  BOOL grp_member =3D is_grp_member (uid, gid);=0A=
+=0A=
+  if (!acl)=0A=
+    {=0A=
+      *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;=0A=
+      syscall_printf ("No ACL =3D %x, uid %d, gid %d",=0A=
+		      *attribute, uid, gid);=0A=
+      LocalFree (psd);=0A=
+      return 0;=0A=
+    }=0A=
+=0A=
+  ACCESS_ALLOWED_ACE *ace;=0A=
+  int allow =3D 0;=0A=
+  int deny =3D 0;=0A=
+  int *flags, *anti;=0A=
+=0A=
+  for (DWORD i =3D 0; i < acl->AceCount; ++i)=0A=
+    {=0A=
+      if (!GetAce (acl, i, (PVOID *) &ace))=0A=
+	continue;=0A=
+      if (ace->Header.AceFlags & INHERIT_ONLY_ACE)=0A=
+	continue;=0A=
+      switch (ace->Header.AceType)=0A=
+	{=0A=
+	case ACCESS_ALLOWED_ACE_TYPE:=0A=
+	  flags =3D &allow;=0A=
+	  anti =3D &deny;=0A=
+	  break;=0A=
+	case ACCESS_DENIED_ACE_TYPE:=0A=
+	  flags =3D &deny;=0A=
+	  anti =3D &allow;=0A=
+	  break;=0A=
+	default:=0A=
+	  continue;=0A=
+	}=0A=
+=0A=
+      cygsid ace_sid ((PSID) &ace->SidStart);=0A=
+      if (owner_sid && ace_sid =3D=3D owner_sid)=0A=
+	{=0A=
+	  if (ace->Mask & FILE_READ_DATA)=0A=
+	    *flags |=3D S_IRUSR;=0A=
+	  if (ace->Mask & FILE_WRITE_DATA)=0A=
+	    *flags |=3D S_IWUSR;=0A=
+	  if (ace->Mask & FILE_EXECUTE)=0A=
+	    *flags |=3D S_IXUSR;=0A=
+	}=0A=
+      else if (group_sid && ace_sid =3D=3D group_sid)=0A=
+	{=0A=
+	  if (ace->Mask & FILE_READ_DATA)=0A=
+	    *flags |=3D S_IRGRP=0A=
+		      | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);=0A=
+	  if (ace->Mask & FILE_WRITE_DATA)=0A=
+	    *flags |=3D S_IWGRP=0A=
+		      | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);=0A=
+	  if (ace->Mask & FILE_EXECUTE)=0A=
+	    *flags |=3D S_IXGRP=0A=
+		      | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);=0A=
+	}=0A=
+      else if (ace_sid =3D=3D well_known_world_sid)=0A=
+	{=0A=
+	  if (ace->Mask & FILE_READ_DATA)=0A=
+	    *flags |=3D S_IROTH=0A=
+		      | ((!(*anti & S_IRGRP)) ? S_IRGRP : 0)=0A=
+		      | ((!(*anti & S_IRUSR)) ? S_IRUSR : 0);=0A=
+	  if (ace->Mask & FILE_WRITE_DATA)=0A=
+	    *flags |=3D S_IWOTH=0A=
+		      | ((!(*anti & S_IWGRP)) ? S_IWGRP : 0)=0A=
+		      | ((!(*anti & S_IWUSR)) ? S_IWUSR : 0);=0A=
+	  if (ace->Mask & FILE_EXECUTE)=0A=
+	    {=0A=
+	      *flags |=3D S_IXOTH=0A=
+			| ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)=0A=
+			| ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);=0A=
+	    }=0A=
+	  if ((*attribute & S_IFDIR) &&=0A=
+	      (ace->Mask & (FILE_WRITE_DATA | FILE_EXECUTE | FILE_DELETE_CHILD))=
=0A=
+	      =3D=3D (FILE_WRITE_DATA | FILE_EXECUTE))=0A=
+	    *flags |=3D S_ISVTX;=0A=
+	}=0A=
+      else if (ace_sid =3D=3D well_known_null_sid)=0A=
+	{=0A=
+	  /* Read SUID, SGID and VTX bits from NULL ACE. */=0A=
+	  if (ace->Mask & FILE_READ_DATA)=0A=
+	    *flags |=3D S_ISVTX;=0A=
+	  if (ace->Mask & FILE_WRITE_DATA)=0A=
+	    *flags |=3D S_ISGID;=0A=
+	  if (ace->Mask & FILE_APPEND_DATA)=0A=
+	    *flags |=3D S_ISUID;=0A=
+	}=0A=
+    }=0A=
+  *attribute &=3D ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_IS=
UID);=0A=
+  *attribute |=3D allow;=0A=
+  *attribute &=3D ~deny;=0A=
+=0A=
+  LocalFree (psd);=0A=
+=0A=
+  syscall_printf ("%x, uid %d, gid %d", *attribute, uid, gid);=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+get_object_attribute (HANDLE handle, SE_OBJECT_TYPE object_type,=0A=
+		    int *attribute, __uid32_t *uidret, __gid32_t *gidret)=0A=
+{=0A=
+  if (allow_ntsec)=0A=
+    {=0A=
+      int res =3D get_nt_object_attribute (handle, object_type, attribute,=
 uidret, gidret);=0A=
+      if (attribute && (*attribute & S_IFLNK) =3D=3D S_IFLNK)=0A=
+	*attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;=0A=
+      return res;=0A=
+    }=0A=
+=0A=
+  if (uidret)=0A=
+    *uidret =3D getuid32 ();=0A=
+  if (gidret)=0A=
+    *gidret =3D getgid32 ();=0A=
+=0A=
+  if (!attribute)=0A=
+    return 0;=0A=
+=0A=
+  /* symlinks are everything for everyone!*/=0A=
+  if ((*attribute & S_IFLNK) =3D=3D S_IFLNK)=0A=
+    *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;=0A=
+=0A=
+  return 0;=0A=
 }=0A=
=20=0A=
 BOOL=0A=
Index: security.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/security.h,v=0A=
retrieving revision 1.28=0A=
diff -u -3 -p -u -p -r1.28 security.h=0A=
--- security.h	24 Jun 2002 13:01:50 -0000	1.28=0A=
+++ security.h	2 Jul 2002 00:41:12 -0000=0A=
@@ -10,7 +10,6 @@ details. */=0A=
=20=0A=
 #define DONT_INHERIT (0)=0A=
 #define INHERIT_ALL  (CONTAINER_INHERIT_ACE|OBJECT_INHERIT_ACE)=0A=
-#define INHERIT_ONLY (INHERIT_ONLY_ACE|CONTAINER_INHERIT_ACE|OBJECT_INHERI=
T_ACE)=0A=
=20=0A=
 #define DEFAULT_UID DOMAIN_USER_RID_ADMIN=0A=
 #define DEFAULT_GID DOMAIN_ALIAS_RID_ADMINS=0A=
@@ -21,6 +20,26 @@ details. */=0A=
=20=0A=
 #define NO_SID ((PSID)NULL)=0A=
=20=0A=
+#ifndef _ACCCTRL_H=0A=
+#define INHERIT_ONLY (INHERIT_ONLY_ACE|CONTAINER_INHERIT_ACE|OBJECT_INHERI=
T_ACE)=0A=
+=0A=
+typedef enum _SE_OBJECT_TYPE {=0A=
+	SE_UNKNOWN_OBJECT_TYPE =3D 0,=0A=
+	SE_FILE_OBJECT,=0A=
+	SE_SERVICE,=0A=
+	SE_PRINTER,=0A=
+	SE_REGISTRY_KEY,=0A=
+	SE_LMSHARE,=0A=
+	SE_KERNEL_OBJECT,=0A=
+	SE_WINDOW_OBJECT,=0A=
+	SE_DS_OBJECT,=0A=
+	SE_DS_OBJECT_ALL,=0A=
+	SE_PROVIDER_DEFINED_OBJECT,=0A=
+	SE_WMIGUID_OBJECT=0A=
+} SE_OBJECT_TYPE;=0A=
+=0A=
+#endif=0A=
+=0A=
 class cygsid {=0A=
   PSID psid;=0A=
   char sbuf[MAX_SID_LEN];=0A=
@@ -169,6 +188,8 @@ int __stdcall get_file_attribute (int, c=0A=
 				  __uid32_t * =3D NULL, __gid32_t * =3D NULL);=0A=
 int __stdcall set_file_attribute (int, const char *, int);=0A=
 int __stdcall set_file_attribute (int, const char *, __uid32_t, __gid32_t,=
 int);=0A=
+int __stdcall get_object_attribute (HANDLE handle, SE_OBJECT_TYPE object_t=
ype, int *,=0A=
+				  __uid32_t * =3D NULL, __gid32_t * =3D NULL);=0A=
 LONG __stdcall read_sd(const char *file, PSECURITY_DESCRIPTOR sd_buf, LPDW=
ORD sd_size);=0A=
 LONG __stdcall write_sd(const char *file, PSECURITY_DESCRIPTOR sd_buf, DWO=
RD sd_size);=0A=
 BOOL __stdcall add_access_allowed_ace (PACL acl, int offset, DWORD attribu=
tes, PSID sid, size_t &len_add, DWORD inherit);=0A=

------=_NextPart_000_0141_01C2216B.A5433E60--
