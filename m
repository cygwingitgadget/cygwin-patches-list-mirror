Return-Path: <cygwin-patches-return-3410-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1660 invoked by alias); 16 Jan 2003 06:57:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1613 invoked from network); 16 Jan 2003 06:57:49 -0000
Message-Id: <3.0.5.32.20030116015721.007ee100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 16 Jan 2003 06:57:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: etc_changed, passwd & group.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1042718241==_"
X-SW-Source: 2003-q1/txt/msg00059.txt.bz2

--=====================_1042718241==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1582

Chris,

Here is the code as it stands. It compiles & runs, and passes
fork tests correctly. Feel free to takeover or at least
have a look. I will continue testing tomorrow evening.

I include only the 5 files that are related to etc_changed,
the 5 others (setuid on Win9X) can wait.

Pierre

P.S. Does GetFileInformationByHandle () work reliably on network drives
(sse MSDN warnings)? If so, in pwdgrp.h read () it could replace 
GetFileSize and GetFileTime and one could also verify that the file hasn't
mutated into a directory.

2003/01/16  Pierre Humblet  <pierre.humblet@ieee.org>

	* cygheap.h (struct init_cygheap): Remove etc_changed_h and 
	etc_changed members. 
	* cygheap.cc (init_cygheap::etc_changed): Delete.
	* pwdgroup.h (class pwdgrp_check): Delete.
	(class pwdgrp_read): Delete.
	(enum etc_changed_bits): Create.
	(struct etc_change): Create.
	(class pwdgrp_file): Create.
	* passwd.cc: Major changes to use class pwdgrp_file instead of classes 
	pwdgrp_check and pwdgrp_read.
	(etc_change::etc_watch): Create.
	(etc_change::etc_changed): Create.
	(grab_int): Replace almost_null by "".
	(read_etc_passwd): On NT, add a line for uid = -1. Use same default uid
	for Win95 and NT. Call cygheap_user::ontherange to initialize HOME. 
	* grp.cc: Major changes to use class pwdgrp_file instead of classes 
	pwdgrp_check and pwdgrp_read.
	(read_etc_group): On NT, add a line for gid = -1. Change name "unknown"
	to "mkgroup". 
	(internal_getgrgid): Do not return default in nontsec case.
	(internal_getgroups): Add argument srchsid and look for it in groups
	if not NULL.
--=====================_1042718241==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="etc.diff"
Content-length: 17946

Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.56
diff -u -p -r1.56 cygheap.h
--- cygheap.h	22 Oct 2002 16:18:55 -0000	1.56
+++ cygheap.h	16 Jan 2003 06:47:32 -0000
@@ -216,15 +216,12 @@ struct init_cygheap
   mode_t umask;
   HANDLE shared_h;
   HANDLE console_h;
-  HANDLE etc_changed_h;
   char *cygwin_regname;
   cwdstuff cwd;
   dtable fdtab;
 #ifdef DEBUGGING
   cygheap_debug debug;
 #endif
-
-  bool etc_changed ();
 };

 #define CYGHEAPSIZE (sizeof (init_cygheap) + (16000 * sizeof (fhandler_uni=
on)) + (4 * 65536))
Index: cygheap.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.cc,v
retrieving revision 1.75
diff -u -p -r1.75 cygheap.cc
--- cygheap.cc	15 Jan 2003 17:27:20 -0000	1.75
+++ cygheap.cc	16 Jan 2003 06:47:38 -0000
@@ -380,39 +380,6 @@ cstrdup1 (const char *s)
   return p;
 }

-bool
-init_cygheap::etc_changed ()
-{
-  bool res =3D 0;
-
-  if (!etc_changed_h)
-    {
-      path_conv pwd ("/etc");
-      etc_changed_h =3D FindFirstChangeNotification (pwd, FALSE,
-					      FILE_NOTIFY_CHANGE_LAST_WRITE);
-      if (etc_changed_h =3D=3D INVALID_HANDLE_VALUE)
-	system_printf ("Can't open /etc for checking, %E", (char *) pwd,
-		       etc_changed_h);
-      else if (!DuplicateHandle (hMainProc, etc_changed_h, hMainProc,
-				 &etc_changed_h, 0, TRUE,
-				 DUPLICATE_SAME_ACCESS | DUPLICATE_CLOSE_SOURCE))
-	{
-	  system_printf ("Can't inherit /etc handle, %E", (char *) pwd,
-			 etc_changed_h);
-	  etc_changed_h =3D INVALID_HANDLE_VALUE;
-	}
-    }
-
-   if (etc_changed_h !=3D INVALID_HANDLE_VALUE
-       && WaitForSingleObject (etc_changed_h, 0) =3D=3D WAIT_OBJECT_0)
-     {
-       (void) FindNextChangeNotification (etc_changed_h);
-       res =3D 1;
-     }
-
-  return res;
-}
-
 void
 cygheap_root::set (const char *posix, const char *native)
 {
Index: pwdgrp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pwdgrp.h,v
retrieving revision 1.8
diff -u -p -r1.8 pwdgrp.h
--- pwdgrp.h	10 Dec 2002 12:43:49 -0000	1.8
+++ pwdgrp.h	16 Jan 2003 06:47:44 -0000
@@ -19,74 +19,101 @@ extern struct __group32 *internal_getgrs
 extern struct __group32 *internal_getgrgid (__gid32_t gid, BOOL =3D FALSE);
 extern struct __group32 *internal_getgrnam (const char *, BOOL =3D FALSE);
 extern struct __group32 *internal_getgrent (int);
-int internal_getgroups (int, __gid32_t *);
+int internal_getgroups (int, __gid32_t *, cygsid * =3D NULL);
+
+enum etc_changed_bits
+{
+  ETC_PASSWD =3D 1,
+  ETC_GROUP=3D 2
+};
+
+struct etc_change
+{
+  HANDLE etc_changed_h;
+  int etc_changed_flags;
+  void etc_watch ();
+  bool etc_changed (etc_changed_bits);
+};

 enum pwdgrp_state {
   uninitialized =3D 0,
   initializing,
-  loaded
+  stable
 };

-class pwdgrp_check {
-  pwdgrp_state	state;
-  FILETIME	last_modified;
-  char		file_w32[MAX_PATH];
+class pwdgrp_file {
+  path_conv pc;
+  pwdgrp_state	*stateptr; /* state itself is NO_COPY */
+  const char *posix_fname;
+  etc_changed_bits me;
+  HANDLE fh;
+  FILETIME last_modified;
+  char *buf;
+  char *lptr, *eptr;
+  static struct etc_change NO_COPY etc;

 public:
-  pwdgrp_check () : state (uninitialized) {}
-  BOOL isinitializing ()
+  pwdgrp_file (const char *fname, pwdgrp_state * statep, etc_changed_bits =
who)
+    {
+      posix_fname =3D fname;
+      stateptr =3D statep;
+      me =3D who;
+    }
+  bool setpc ()
     {
-      if (state <=3D initializing)
-	state =3D initializing;
-      else if (cygheap->etc_changed ())
+      if (!pc.exists ())
         {
-	  if (!file_w32[0])
-	    state =3D initializing;
-	  else
+	  pc.check (posix_fname);
+	  if (pc.error || !pc.exists () || !pc.isdisk () || pc.isdir ())
 	    {
-	      HANDLE h;
-	      WIN32_FIND_DATA data;
-
-	      if ((h =3D FindFirstFile (file_w32, &data)) !=3D INVALID_HANDLE_VAL=
UE)
-	        {
-		  if (CompareFileTime (&data.ftLastWriteTime, &last_modified) > 0)
-		    state =3D initializing;
-		  FindClose (h);
-		}
+	      pc.check ("");
+	      return false;
 	    }
 	}
-      return state =3D=3D initializing;
+      return true;
     }
-  void operator =3D (pwdgrp_state nstate)
+  bool iamchanged ()
     {
-      state =3D nstate;
+      HANDLE h;
+      WIN32_FIND_DATA data;
+      bool ret =3D false;
+
+      if ((h =3D FindFirstFile (pc, &data)) !=3D INVALID_HANDLE_VALUE)
+        {
+	  ret =3D (CompareFileTime (&data.ftLastWriteTime, &last_modified) > 0);
+	  FindClose (h);
+	}
+      return ret;
+    }
+  BOOL isuninitialized ()
+    {
+       if (*stateptr !=3D uninitialized)
+	 return false;
+       /* start watching /etc */
+       etc.etc_watch ();
+       /* buf isn't null when forked with file loaded */
+       if (setpc () && buf && !iamchanged ())
+         {
+	    *stateptr =3D stable;
+	    return false;
+	 }
+       return true;
     }
-  BOOL isuninitialized () const { return state =3D=3D uninitialized; }
-  void set_last_modified (HANDLE fh, const char *name)
+  BOOL isinitializing ()
     {
-      if (!file_w32[0])
-	strcpy (file_w32, name);
-      GetFileTime (fh, NULL, NULL, &last_modified);
+      if (*stateptr <=3D initializing)
+        return true;
+      else if (!etc.etc_changed (me) || !setpc () || !iamchanged ())
+	return false;
+      *stateptr =3D initializing;
+      return true;
     }
-};
-
-class pwdgrp_read {
-  path_conv pc;
-  HANDLE fh;
-  char *buf;
-  char *lptr, *eptr;
-
-public:
-  bool open (const char *posix_fname)
+  bool read ()
   {
     if (buf)
       free (buf);
     buf =3D lptr =3D eptr =3D NULL;

-    pc.check (posix_fname);
-    if (pc.error || !pc.exists () || !pc.isdisk () || pc.isdir ())
-      return false;
-
     fh =3D CreateFile (pc, GENERIC_READ, wincap.shared (), NULL, OPEN_EXIS=
TING,
 		     FILE_ATTRIBUTE_NORMAL, 0);
     if (fh !=3D INVALID_HANDLE_VALUE)
@@ -98,14 +125,16 @@ public:
 	    if (buf)
 	      free (buf);
 	    buf =3D NULL;
-	    CloseHandle (fh);
-	    fh =3D NULL;
-	    return false;
 	  }
-	buf[read_bytes] =3D '\0';
-	return true;
+	else
+	  {
+	    buf[read_bytes] =3D '\0';
+	    GetFileTime (fh, NULL, NULL, &last_modified);
+	  }
+	CloseHandle (fh);
       }
-    return false;
+    *stateptr =3D stable;
+    return (buf !=3D NULL);
   }
   char *gets ()
   {
@@ -125,13 +154,5 @@ public:
 	*eptr++ =3D '\0';
       }
     return lptr;
-  }
-  inline HANDLE get_fhandle () { return fh; }
-  inline const char *get_fname () { return pc; }
-  void close ()
-  {
-    if (fh)
-      CloseHandle (fh);
-    fh =3D NULL;
   }
 };
Index: passwd.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.57
diff -u -p -r1.57 passwd.cc
--- passwd.cc	10 Jan 2003 12:32:46 -0000	1.57
+++ passwd.cc	16 Jan 2003 06:47:49 -0000
@@ -23,14 +23,53 @@ details. */
 #include <sys/termios.h>
 #include "pwdgrp.h"

+/* Per process data */
+struct etc_change NO_COPY pwdgrp_file::etc;
+static pwdgrp_state NO_COPY state;
+
+void
+etc_change::etc_watch ()
+{
+  if (!etc_changed_h)
+    {
+      path_conv pwd ("/etc");
+      etc_changed_h =3D FindFirstChangeNotification (pwd, FALSE,
+						   FILE_NOTIFY_CHANGE_LAST_WRITE);
+      if (etc_changed_h =3D=3D INVALID_HANDLE_VALUE)
+	system_printf ("Can't open /etc for checking, %E", (char *) pwd,
+		       etc_changed_h);
+    }
+}
+bool
+etc_change::etc_changed (etc_changed_bits who)
+{
+  bool res =3D 0;
+
+  if (etc_changed_h !=3D INVALID_HANDLE_VALUE)
+    {
+      if (etc_changed_flags & who)
+        {
+	  etc_changed_flags &=3D ~who;
+	  res =3D 1;
+	}
+      else if (WaitForSingleObject (etc_changed_h, 0) =3D=3D WAIT_OBJECT_0)
+        {
+	  (void) FindNextChangeNotification (etc_changed_h);
+	  etc_changed_flags |=3D ~who;
+	  res =3D 1;
+	}
+    }
+  return res;
+}
+
+
 /* Read /etc/passwd only once for better performance.  This is done
    on the first call that needs information from it. */

 static struct passwd *passwd_buf;	/* passwd contents in memory */
 static int curr_lines;
 static int max_lines;
-
-static pwdgrp_check passwd_state;
+static pwdgrp_file pwd_file ("/etc/passwd", &state, ETC_PASSWD);


 /* Position in the passwd cache */
@@ -40,7 +79,7 @@ static pwdgrp_check passwd_state;
 static int pw_pos =3D 0;
 #endif

-/* Remove a : teminated string from the buffer, and increment the pointer =
*/
+/* Remove a : terminated string from the buffer, and increment the pointer=
 */
 static char *
 grab_string (char **p)
 {
@@ -65,7 +104,7 @@ grab_int (char **p)
 {
   char *src =3D *p;
   unsigned int val =3D strtoul (src, p, 10);
-  *p =3D (*p =3D=3D src || **p !=3D ':') ? almost_null : *p + 1;
+  *p =3D (*p =3D=3D src || **p !=3D ':') ? (char *) "" : *p + 1;
   return val;
 }

@@ -127,7 +166,6 @@ pthread_mutex_t NO_COPY passwd_lock::mut
 static void
 read_etc_passwd ()
 {
-  static pwdgrp_read pr;

   /* A mutex is ok for speed here - pthreads will use critical sections not
    * mutexes for non-shared mutexes in the future. Also, this function will
@@ -136,34 +174,31 @@ read_etc_passwd ()
   passwd_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_passwd may have been process=
ed */
-  if (passwd_state.isinitializing ())
+  if (pwd_file.isinitializing ())
     {
       curr_lines =3D 0;
-      if (pr.open ("/etc/passwd"))
+      if (pwd_file.read ())
 	{
 	  char *line;
-	  while ((line =3D pr.gets ()) !=3D NULL)
+	  while ((line =3D pwd_file.gets ()) !=3D NULL)
 	    add_pwd_line (line);

-	  passwd_state.set_last_modified (pr.get_fhandle (), pr.get_fname ());
-	  pr.close ();
 	  debug_printf ("Read /etc/passwd, %d lines", curr_lines);
 	}
-      passwd_state =3D loaded;

       static char linebuf[1024];
       char strbuf[128] =3D "";
       BOOL searchentry =3D TRUE;
-      __uid32_t default_uid =3D DEFAULT_UID;
       struct passwd *pw;

       if (wincap.has_security ())
 	{
+	  static char pretty_ls[] =3D "????????:*:-1:-1:";
+	  add_pwd_line (pretty_ls);
 	  cygsid tu =3D cygheap->user.sid ();
 	  tu.string (strbuf);
-	  if (myself->uid =3D=3D ILLEGAL_UID
-	      && (searchentry =3D !internal_getpwsid (tu)))
-	    default_uid =3D DEFAULT_UID_NT;
+	  if (myself->uid =3D=3D ILLEGAL_UID)
+	    searchentry =3D !internal_getpwsid (tu);
 	}
       else if (myself->uid =3D=3D ILLEGAL_UID)
         searchentry =3D !internal_getpwuid (DEFAULT_UID);
@@ -173,11 +208,12 @@ read_etc_passwd ()
 	    myself->uid !=3D (__uid32_t) pw->pw_uid  &&
 	    !internal_getpwuid (myself->uid))))
 	{
+	  (void) cygheap->user.ontherange (CH_HOME, NULL);
 	  snprintf (linebuf, sizeof (linebuf), "%s:*:%lu:%lu:,%s:%s:/bin/sh",
 		    cygheap->user.name (),
-		    myself->uid =3D=3D ILLEGAL_UID ? default_uid : myself->uid,
+		    myself->uid =3D=3D ILLEGAL_UID ? DEFAULT_UID_NT : myself->uid,
 		    myself->gid,
-		    strbuf, getenv ("HOME") ?: "/");
+		    strbuf, getenv ("HOME") ?: "");
 	  debug_printf ("Completing /etc/passwd: %s", linebuf);
 	  add_pwd_line (linebuf);
 	}
@@ -192,7 +228,7 @@ internal_getpwsid (cygsid &sid)
   char *ptr1, *ptr2, *endptr;
   char sid_string[128] =3D {0,','};

-  if (passwd_state.isuninitialized ())
+  if (pwd_file.isuninitialized ())
     read_etc_passwd ();

   if (sid.string (sid_string + 2))
@@ -211,8 +247,8 @@ internal_getpwsid (cygsid &sid)
 struct passwd *
 internal_getpwuid (__uid32_t uid, BOOL check)
 {
-  if (passwd_state.isuninitialized ()
-      || (check && passwd_state.isinitializing ()))
+  if (pwd_file.isuninitialized ()
+      || (check && pwd_file.isinitializing ()))
     read_etc_passwd ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -224,8 +260,8 @@ internal_getpwuid (__uid32_t uid, BOOL c
 struct passwd *
 internal_getpwnam (const char *name, BOOL check)
 {
-  if (passwd_state.isuninitialized ()
-      || (check && passwd_state.isinitializing ()))
+  if (pwd_file.isuninitialized ()
+      || (check && pwd_file.isinitializing ()))
     read_etc_passwd ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -347,7 +383,7 @@ getpwnam_r (const char *nam, struct pass
 extern "C" struct passwd *
 getpwent (void)
 {
-  if (passwd_state.isinitializing ())
+  if (pwd_file.isinitializing ())
     read_etc_passwd ();

   if (pw_pos < curr_lines)
@@ -390,7 +426,7 @@ getpass (const char * prompt)
 #endif
   struct termios ti, newti;

-  if (passwd_state.isinitializing ())
+  if (pwd_file.isinitializing ())
     read_etc_passwd ();

   cygheap_fdget fhstdin (0);
Index: grp.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.61
diff -u -p -r1.61 grp.cc
--- grp.cc	10 Dec 2002 12:43:49 -0000	1.61
+++ grp.cc	16 Jan 2003 06:47:57 -0000
@@ -29,9 +29,13 @@ details. */
 /* Read /etc/group only once for better performance.  This is done
    on the first call that needs information from it. */

+/* Per process data */
+static pwdgrp_state NO_COPY state;
+
 static struct __group32 *group_buf;		/* group contents in memory */
 static int curr_lines;
 static int max_lines;
+static pwdgrp_file grp_file ("/etc/group", &state, ETC_GROUP);

 /* Position in the group cache */
 #ifdef _MT_SAFE
@@ -40,7 +44,6 @@ static int max_lines;
 static int grp_pos =3D 0;
 #endif

-static pwdgrp_check group_state;
 static char * NO_COPY null_ptr =3D NULL;

 static int
@@ -129,35 +132,29 @@ pthread_mutex_t NO_COPY group_lock::mute
 static void
 read_etc_group ()
 {
-  static pwdgrp_read gr;
-
   group_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_group may have been processe=
d */
-  if (group_state.isinitializing ())
+  if (grp_file.isinitializing ())
     {
       for (int i =3D 0; i < curr_lines; i++)
 	if ((group_buf + i)->gr_mem !=3D &null_ptr)
 	  free ((group_buf + i)->gr_mem);

       curr_lines =3D 0;
-      if (gr.open ("/etc/group"))
+      if (grp_file.read ())
 	{
 	  char *line;
-	  while ((line =3D gr.gets ()) !=3D NULL)
+	  while ((line =3D grp_file.gets ()) !=3D NULL)
             add_grp_line (line);

-	  group_state.set_last_modified (gr.get_fhandle (), gr.get_fname ());
-	  gr.close ();
 	  debug_printf ("Read /etc/group, %d lines", curr_lines);
 	}
-      group_state =3D loaded;
-
       /* Complete /etc/group in memory if needed */
       if (!internal_getgrgid (myself->gid))
         {
 	  static char linebuf [200];
-	  char group_name [UNLEN + 1] =3D "unknown";
+	  char group_name [UNLEN + 1] =3D "mkgroup";
 	  char strbuf[128] =3D "";

 	  if (wincap.has_security ())
@@ -173,6 +170,9 @@ read_etc_group ()
 	  debug_printf ("Completing /etc/group: %s", linebuf);
 	  add_grp_line (linebuf);
 	}
+      static char pretty_ls[] =3D "????????::-1:";
+      if (wincap.has_security ())
+	add_grp_line (pretty_ls);
     }
   return;
 }
@@ -182,7 +182,7 @@ internal_getgrsid (cygsid &sid)
 {
   char sid_string[128];

-  if (group_state.isuninitialized ())
+  if (grp_file.isuninitialized ())
     read_etc_group ();

   if (sid.string (sid_string))
@@ -195,27 +195,21 @@ internal_getgrsid (cygsid &sid)
 struct __group32 *
 internal_getgrgid (__gid32_t gid, BOOL check)
 {
-  struct __group32 * default_grp =3D NULL;
-
-  if (group_state.isuninitialized ()
-      || (check && group_state.isinitializing ()))
+  if (grp_file.isuninitialized ()
+      || (check && grp_file.isinitializing ()))
     read_etc_group ();

   for (int i =3D 0; i < curr_lines; i++)
-    {
-      if (group_buf[i].gr_gid =3D=3D myself->gid)
-	default_grp =3D group_buf + i;
-      if (group_buf[i].gr_gid =3D=3D gid)
-	return group_buf + i;
-    }
-  return allow_ntsec || gid !=3D ILLEGAL_GID ? NULL : default_grp;
+    if (group_buf[i].gr_gid =3D=3D gid)
+      return group_buf + i;
+  return NULL;
 }

 struct __group32 *
 internal_getgrnam (const char *name, BOOL check)
 {
-  if (group_state.isuninitialized ()
-      || (check && group_state.isinitializing ()))
+  if (grp_file.isuninitialized ()
+      || (check && grp_file.isinitializing ()))
     read_etc_group ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -280,7 +274,7 @@ endgrent ()
 extern "C" struct __group32 *
 getgrent32 ()
 {
-  if (group_state.isinitializing ())
+  if (grp_file.isinitializing ())
     read_etc_group ();

   if (grp_pos < curr_lines)
@@ -307,7 +301,7 @@ setgrent ()
 struct __group32 *
 internal_getgrent (int pos)
 {
-  if (group_state.isuninitialized ())
+  if (grp_file.isuninitialized ())
     read_etc_group ();

   if (pos < curr_lines)
@@ -316,7 +310,7 @@ internal_getgrent (int pos)
 }

 int
-internal_getgroups (int gidsetsize, __gid32_t *grouplist)
+internal_getgroups (int gidsetsize, __gid32_t *grouplist, cygsid * srchsid)
 {
   HANDLE hToken =3D NULL;
   DWORD size;
@@ -345,6 +339,13 @@ internal_getgroups (int gidsetsize, __gi
 	    {
 	      cygsid sid;

+	      if (srchsid)
+	        {
+		  for (DWORD pg =3D 0; pg < groups->GroupCount; ++pg)
+		    if (*srchsid =3D=3D groups->Groups[pg].Sid)
+		      return 1;
+		  return 0;
+		}
 	      for (int gidx =3D 0; (gr =3D internal_getgrent (gidx)); ++gidx)
 		if (sid.getfromgr (gr))
 		  for (DWORD pg =3D 0; pg < groups->GroupCount; ++pg)

--=====================_1042718241==_--
