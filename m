Return-Path: <cygwin-patches-return-3420-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29926 invoked by alias); 18 Jan 2003 04:41:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29914 invoked from network); 18 Jan 2003 04:41:52 -0000
Message-Id: <3.0.5.32.20030117233612.007ed390@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sat, 18 Jan 2003 04:41:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: etc_changed, passwd & group
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1042882572==_"
X-SW-Source: 2003-q1/txt/msg00069.txt.bz2

--=====================_1042882572==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 3589

Hello Chris,

I like your code, just made a few changes. The explanations below
are detailed and longer that the changes!

In load(), CloseFile wasn't called on read error, and it was called
before GetFileTime. 

It seems that declaring passwd_buf, group_buf etc NO_COPY means that
there will be a memory leak on fork, as the malloced buffers they point to
will be orphans. Thus I made them regular static variables and I reuse
the existing buffers on fork (same logic as it was before). Thus the pwdgrp
class cannot be NO_COPY either, nor etc::curr_ix. 
Reusing the buffers creates a problem because the file(s) may have been
touched
after the buffers were loaded in the parent, but before the fork.
dir_changed in the 
child will not observe the event. Thus on forks it is necessary to check
the file
dates when the buffers are already loaded, but not if they are not. 
This is achieved by having the default sawchange as forcing a date
comparison and
passing an argument to etc::init to set sawchange if the compare is not
needed.
The meaning of sawchange is changed: sawchange[n] is false if a change has
not been 
seen by n (seems logical).

sawchange[n] is now set in dir_changed itself, and not in file_changed
nor in set_last_modified(). Setting it in set_last_modified becomes
unnecessary
due to the way sawchange is initialized (also that created a tiny race
condition, I think). That made set_last_modified a one line function. 
I decided to get rid of it and to store last_modified in the pwdgrp
class itself, where it is easier to update it. By the same token I removed 
fn from etc, simply passing the filename in file_changed. 
 
In passwd.cc and grp.cc I reverted to the debug_printf giving the line count,
it has served me well in the past. The return value of load was then unused,
so I made it void, which simplified load a little.

This passes my test...

Pierre

P.S.: I have mixed feelings about having dir_changed always returning true if 
  FindFirstChangeNotification has failed. The etc_changed stuff has been
broken
  until now and this has generated only one complaint AFAIK. Users seem
  quite willing to restart their daemons after editing passwd. If only Novell
  users (with /etc on a share drive) need to do it now, that will already be 
  a big improvement.


2003/01/17  Pierre Humblet  <pierre.humblet@ieee.org>

	* pwdgrp.h (class etc): Remove members fn, last_modified and 
	set_last_modified. Change arguments of init and file changed.
	(class pwdgrp): Add member last_modified.
	(pwdgrp::isinitializing): White space. Add arguments to file_changed.
	(pwdgrp::load): Change type to void. Change second argument of etc::init.
	Close file on read error, but never before calling GetFileTime.
	Do not call etc::set_last_modified.
	* uinfo.cc: Remove definitions of etc::fn and etc::last_modified. Do not
	define etc::curr_ix NO_COPY.
	(etc::init): Use second argument to initialize sawchange. Do not initialize
	fn.
	(etc:::dir_changed): sawchange[n] is now false when a change has happened
	but has not been seen by n. Initialize res accordingly. On observing a 
	change set the sawchange array to false. Always set sawchange[n] to true.
	(etc::file_changed): Use new arguments. Do not set sawchange.
	Do not verify fn, FindFirstFile accepts NULL pointers.
	(etc::set_last_modified): Delete.
	* passwd.cc: Do not define passwd_buf, curr_lines, maxlines and pr NO_COPY.
	(read_etc_passwd): Revert to old style debug_printf. 
	* group.cc: Do not define group_buf, curr_lines, maxlines and gr NO_COPY.
	(read_etc_group): Revert to old style debug_printf. 
--=====================_1042882572==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pwgr.diff"
Content-length: 8545

Index: pwdgrp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pwdgrp.h,v
retrieving revision 1.11
diff -u -p -r1.11 pwdgrp.h
--- pwdgrp.h	17 Jan 2003 18:05:32 -0000	1.11
+++ pwdgrp.h	18 Jan 2003 04:16:15 -0000
@@ -32,12 +32,9 @@ class etc
 {
   static int curr_ix;
   static bool sawchange[MAX_ETC_FILES];
-  static const char *fn[MAX_ETC_FILES];
-  static FILETIME last_modified[MAX_ETC_FILES];
   static bool dir_changed (int);
-  static int init (int, const char *);
-  static bool file_changed (int);
-  static void set_last_modified (int, FILETIME&);
+  static int init (int, bool);
+  static bool file_changed (int, const char *, FILETIME *);
   friend class pwdgrp;
 };

@@ -46,6 +43,7 @@ class pwdgrp
   pwdgrp_state state;
   int pwd_ix;
   path_conv pc;
+  FILETIME last_modified;
   char *buf;
   char *lptr, *eptr;

@@ -71,38 +69,35 @@ class pwdgrp

 public:
   bool isinitializing ()
-    {
-      if (state <=3D initializing)
-	state =3D initializing;
-      else if (etc::file_changed (pwd_ix - 1))
-	state =3D initializing;
-      return state =3D=3D initializing;
-    }
+  {
+    if (state <=3D initializing)
+      state =3D initializing;
+    else if (etc::file_changed (pwd_ix - 1, pc, &last_modified))
+      state =3D initializing;
+    return state =3D=3D initializing;
+  }
   void operator =3D (pwdgrp_state nstate) { state =3D nstate; }
   bool isuninitialized () const { return state =3D=3D uninitialized; }

-  bool load (const char *posix_fname, void (* add_line) (char *))
+  void load (const char *posix_fname, void (* add_line) (char *))
   {
     if (buf)
       free (buf);
     buf =3D lptr =3D eptr =3D NULL;
-
+
     pc.check (posix_fname);
-    pwd_ix =3D etc::init (pwd_ix - 1, pc) + 1;
+    pwd_ix =3D etc::init (pwd_ix - 1, state !=3D loaded) + 1;

     paranoid_printf ("%s", posix_fname);
-
-    bool res;
-    if (pc.error || !pc.exists () || !pc.isdisk () || pc.isdir ())
-      res =3D false;
-    else
+
+    if (!pc.error && pc.exists () && pc.isdisk () && !pc.isdir ())
       {
+
 	HANDLE fh =3D CreateFile (pc, GENERIC_READ, wincap.shared (), NULL,
 				OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
-	if (fh =3D=3D INVALID_HANDLE_VALUE)
-	  res =3D false;
-	else
+	if (fh !=3D INVALID_HANDLE_VALUE)
 	  {
+
 	    DWORD size =3D GetFileSize (fh, NULL), read_bytes;
 	    buf =3D (char *) malloc (size + 1);
 	    if (!ReadFile (fh, buf, size, &read_bytes, NULL))
@@ -110,23 +105,20 @@ public:
 		if (buf)
 		  free (buf);
 		buf =3D NULL;
-		fh =3D NULL;
-		return false;
 	      }
-	    buf[read_bytes] =3D '\0';
-	    eptr =3D buf;
+	    else
+	      {
+		buf[read_bytes] =3D '\0';
+		eptr =3D buf;
+		GetFileTime (fh, NULL, NULL, &last_modified);
+		char *line;
+		while ((line =3D gets()) !=3D NULL)
+		  add_line (line);
+	      }
 	    CloseHandle (fh);
-	    FILETIME ft;
-	    if (GetFileTime (fh, NULL, NULL, &ft))
-	      etc::set_last_modified (pwd_ix - 1, ft);
-	    char *line;
-	    while ((line =3D gets()) !=3D NULL)
-	      add_line (line);
-	    res =3D true;
 	  }
       }
-
+
     state =3D loaded;
-    return res;
   }
 };
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.100
diff -u -p -r1.100 uinfo.cc
--- uinfo.cc	17 Jan 2003 05:43:43 -0000	1.100
+++ uinfo.cc	18 Jan 2003 04:16:38 -0000
@@ -390,13 +390,11 @@ cygheap_user::env_name (const char *name
   return pwinname;
 }

-int NO_COPY etc::curr_ix =3D -1;
+int etc::curr_ix =3D -1;
 bool NO_COPY etc::sawchange[MAX_ETC_FILES];
-const NO_COPY char *etc::fn[MAX_ETC_FILES];
-FILETIME NO_COPY etc::last_modified[MAX_ETC_FILES];

 int
-etc::init (int n, const char *etc_fn)
+etc::init (int n, bool isnew)
 {
   if (n >=3D 0)
     /* ok */;
@@ -405,8 +403,7 @@ etc::init (int n, const char *etc_fn)
   else
     api_fatal ("internal error");

-  fn[n] =3D etc_fn;
-  sawchange[n] =3D false;
+  sawchange[n] =3D isnew;
   paranoid_printf ("curr_ix %d, n %d", curr_ix, n);
   return curr_ix;
 }
@@ -414,7 +411,7 @@ etc::init (int n, const char *etc_fn)
 bool
 etc::dir_changed (int n)
 {
-  bool res =3D sawchange[n];
+  bool res =3D !sawchange[n];

   if (!res)
     {
@@ -436,43 +433,34 @@ etc::dir_changed (int n)
       else if (WaitForSingleObject (changed_h, 0) =3D=3D WAIT_OBJECT_0)
 	{
 	  (void) FindNextChangeNotification (changed_h);
-	  memset (sawchange, true, sizeof sawchange);
+	  memset (sawchange, false, sizeof sawchange);
 	  res =3D true;
 	}
     }
+  sawchange[n] =3D true;

-  paranoid_printf ("%s res %d", fn[n], res);
+  paranoid_printf ("%d res %d", n, res);
   return res;
 }

 bool
-etc::file_changed (int n)
+etc::file_changed (int n, const char * fn, FILETIME * last_modified)
 {
   bool res =3D false;
-  if (!fn[n])
-    res =3D true;
-  else if (dir_changed (n))
+  if (dir_changed (n))
     {
       HANDLE h;
       WIN32_FIND_DATA data;

-      if ((h =3D FindFirstFile (fn[n], &data)) =3D=3D INVALID_HANDLE_VALUE)
+      if ((h =3D FindFirstFile (fn, &data)) =3D=3D INVALID_HANDLE_VALUE)
 	res =3D true;
       else
 	{
 	  FindClose (h);
-	  if (CompareFileTime (&data.ftLastWriteTime, last_modified + n) > 0)
+	  if (CompareFileTime (&data.ftLastWriteTime, last_modified) > 0)
 	    res =3D true;
 	}
     }
-  sawchange[n] =3D false;
-  paranoid_printf ("%s res %d", fn[n], res);
+  paranoid_printf ("%s res %d", fn, res);
   return res;
-}
-
-void
-etc::set_last_modified (int n, FILETIME& ft)
-{
-  last_modified[n] =3D ft;
-  sawchange[n] =3D false;
 }
Index: passwd.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.59
diff -u -p -r1.59 passwd.cc
--- passwd.cc	17 Jan 2003 18:05:32 -0000	1.59
+++ passwd.cc	18 Jan 2003 04:16:50 -0000
@@ -26,11 +26,11 @@ details. */
 /* Read /etc/passwd only once for better performance.  This is done
    on the first call that needs information from it. */

-static struct passwd NO_COPY *passwd_buf;	/* passwd contents in memory */
-static int NO_COPY curr_lines;
-static int NO_COPY max_lines;
+static struct passwd *passwd_buf;	/* passwd contents in memory */
+static int curr_lines;
+static int max_lines;

-static NO_COPY pwdgrp pr;
+static pwdgrp pr;

 /* Position in the passwd cache */
 #define pw_pos  _reent_winsup ()->_pw_pos
@@ -132,8 +132,8 @@ read_etc_passwd ()
   if (pr.isinitializing ())
     {
       curr_lines =3D 0;
-      if (!pr.load ("/etc/passwd", add_pwd_line))
-	debug_printf ("pr.load failed");
+      pr.load ("/etc/passwd", add_pwd_line);
+      debug_printf ("Read /etc/passwd, %d lines", curr_lines);

       char strbuf[128] =3D "";
       bool searchentry =3D true;
Index: grp.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.64
diff -u -p -r1.64 grp.cc
--- grp.cc	17 Jan 2003 18:05:32 -0000	1.64
+++ grp.cc	18 Jan 2003 04:16:54 -0000
@@ -29,14 +29,14 @@ details. */
 /* Read /etc/group only once for better performance.  This is done
    on the first call that needs information from it. */

-static struct __group32 NO_COPY *group_buf;		/* group contents in memory */
-static int NO_COPY curr_lines;
-static int NO_COPY max_lines;
+static struct __group32 *group_buf;		/* group contents in memory */
+static int curr_lines;
+static int max_lines;

 /* Position in the group cache */
 #define grp_pos _reent_winsup ()->_grp_pos

-static pwdgrp NO_COPY gr;
+static pwdgrp gr;
 static char * NO_COPY null_ptr;

 static int
@@ -135,8 +135,8 @@ read_etc_group ()
 	  free ((group_buf + i)->gr_mem);

       curr_lines =3D 0;
-      if (!gr.load ("/etc/group", add_grp_line))
-	debug_printf ("gr.load failed");
+      gr.load ("/etc/group", add_grp_line);
+      debug_printf ("Read /etc/group, %d lines", curr_lines);

       /* Complete /etc/group in memory if needed */
       if (!internal_getgrgid (myself->gid))

--=====================_1042882572==_--
