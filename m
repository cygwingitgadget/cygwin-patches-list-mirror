Return-Path: <cygwin-patches-return-3428-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23791 invoked by alias); 21 Jan 2003 02:54:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23772 invoked from network); 21 Jan 2003 02:54:29 -0000
Message-Id: <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Tue, 21 Jan 2003 02:54:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: etc_changed, passwd & group
In-Reply-To: <3.0.5.32.20030118000310.007fc7c0@h00207811519c.ne.client2.
 attbi.com>
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1043135491==_"
X-SW-Source: 2003-q1/txt/msg00077.txt.bz2

--=====================_1043135491==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 5695

Mostly good news recently:

1) Chris' 51 line ChangeLog on 01-19 is his personal best since Sept 2000.
When combined with the 31 line ChangeLog on 01-16, they exceed by
far his record for the millennium (67 lines in Sept 2000).
This is in a thread that has "Hmm.  I have a slightly less 
intrusive idea for how to handle this.  I'll check it in shortly."
Sorry Chris, I can't stop chuckling. It relieves the frustration
you mentioned, but no hard feelings.

2) The code contains nice features and seems to work, although I find
it needlessly confusing and don't fully understand it. I attach a few 
changes (mostly deletions and reversions) that IMO simplify it 
significantly while keeping Chris's code partitioning:
- "change_possible" is back to boolean instead of ternary values.
- arrays are back to size MAX_ETC_FILES
- no duplicated calls to test_file_change on Novell
- other useless etc::file_changed and etc::init calls avoided. 

3) For future reference, the way the modified code works
can be explained relatively simply, to the point where
I feel I could write a formal proof.
a) Initially the pwdgrp::state is "uninitialized". This causes
  all internal and external get{pw,gr}XX functions to call 
  read_etc_{passwd,group} and thus pwdgrp::load(filename).
b) When pwdgrp::load is called in the uninitialized state, it
  calls etc::init, which allocates an "ix handle", records a 
  pointer to the w32 path, and calls etc::file_changed, thus
  indirectly etc::dir_changed (with "change_possible" initialized
  to false). If the /etc handle is NULL, FindFirstFileNotification
  is called and the "change_possible" array is set to true.
  If the handle is not NULL, change_possible is already true.
  The current filetime is recorded and the "change_possible"
  entry of the file itself is set to false.
  load() then loads the file and changes the state to "loaded".
c) Subsequent calls to get{pw,gr}XX invoke pwdgrp::isinitializing,
  which calls etc::file_changed if the state is "loaded".
  etc::file_changed first calls etc::dir_changed, which returns
  true if change_possible is true or if /etc is on Novell or if 
  /etc has changed. In this last case the array change_possible is
  set to true to force time stamp checks on all files.
  If dir_changed returns true, the file time is checked and file_changed
  returns true, always resetting change_possible for the file to false.
  If file_changed returns true, isinitializing () changes the state 
  to "initializing" (insuring that it returns the same value 
  when called several times in a row, e.g. due to mutex checks).
  read_etc_yy and pwdgrp::load are called, loading the file and 
  setting the state to "loaded" (without calling etc::init).
  Possible changes in the w32 path are recorded by load and will 
  be taken into account in future calls to etc::file_changed. 
d) Following a fork in the loaded state, the first call (in the child)
  to dir_changed (from 3) with false change_possible will detect that 
  the NO_COPY /etc handle has been reset to NULL. As in (2) it calls 
  FindFirstFileNotification and sets the change_possible array to true, 
  which will eventually trigger a check of the timestamps.
  
  Note that: 
  -any change to /etc/ or a fork will trigger a timestamp check. 
  -a timestamp check is only performed: a) Initially (to set the time)
   b) Following a change to /etc c) After a fork  d) On Novell.
  

4) To finish off the work and leave the code in a newly minted state, I 
suggest the following cleanup (mostly deletions):
- class pwdgrp
     Delete operator = 

- pwdgrp::load 
     Delete "fh = NULL" and use a common CloseHandle, instead of 
     duplicating it.
     Instead of having type bool just to produce an "it failed" message,
     use type void and put a debug_printf on lines that have "res = false".

- etc::file_changed
     Remove the test (!fn[n]) because a) it is never true (pc will always
     return a pointer to its path) and b) even if it was true, NULL is
     legal in FindFirstFile.
     If you insist on keeping it, move the test to init().

- etc::test_file_changed
     Consider reverting the code back to etc::file_changed. It is only 
     called from that very short function.  

- etc::change_possible
     For modularity move "change_possible[n] = 0;" from file_changed
     to dir_changed.  
     Move definition of "change_possible" from etc class to a static 
     in dir_changed, exactly as changed_h already is.
     Alternatively put the handle and the string "/etc" in the etc class,
     to make it applicable to any directory.
      
- etc::last_modified
     Remove from etc class and declare static inside test_file_changed,
     see change_possible above.


5) The not so good news: apparently dir_changed() is not triggered by a 
mv or an rm (WinME). cp and file edits do trigger it.
 
2003/01/20  Pierre Humblet  <pierre.humblet@ieee.org>

	* pwdgrp.h (pwdgrp::isinitializing): Do not change the state when
	it is uninitialized.
	* uinfo.cc (pwdfrp::load): Only call etc::init when the state is
	uninitialized.
	* path.h: (class etc): Revert the type of change_possible to bool
	and the array sizes to MAX_ETC_FILES.
	* path.cc: (etc::change_possible): Revert type to bool and size
	to MAX_ETC_FILES.
	(etc::fn): Revert size to MAX_ETC_FILES.
	(etc::last_modified): Ditto.
	(etc::init): Delete first argument. Return curr_ix as handle. 
	Call file_changed() instead of test_file_changed().
	(etc::test_file_change): Do not test for negative values of 
	change_possible and do not set it to -res.
	(etc::dir_changed): When the handle is NULL, call memset instead
	of test_file_changed. When the handle is invalid, return true.	 
--=====================_1043135491==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="try.diff"
Content-length: 5337

Index: pwdgrp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pwdgrp.h,v
retrieving revision 1.12
diff -u -p -r1.12 pwdgrp.h
--- pwdgrp.h	20 Jan 2003 02:57:54 -0000	1.12
+++ pwdgrp.h	21 Jan 2003 00:09:57 -0000
@@ -53,11 +53,10 @@ public:
   void add_line (char *);
   bool isinitializing ()
   {
-    if (state <=3D initializing)
+    if (state =3D=3D loaded
+	&& etc::file_changed (pwd_ix))
       state =3D initializing;
-    else if (etc::file_changed (pwd_ix))
-      state =3D initializing;
-    return state =3D=3D initializing;
+    return state <=3D initializing;
   }
   void operator =3D (pwdgrp_state nstate) { state =3D nstate; }
   bool isuninitialized () const { return state =3D=3D uninitialized; }
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.101
diff -u -p -r1.101 uinfo.cc
--- uinfo.cc	20 Jan 2003 02:57:54 -0000	1.101
+++ uinfo.cc	21 Jan 2003 00:10:08 -0000
@@ -429,7 +429,8 @@ pwdgrp::load (const char *posix_fname)
   buf =3D NULL;

   pc.check (posix_fname);
-  pwd_ix =3D etc::init (pwd_ix, pc);
+  if (state =3D=3D uninitialized)
+    pwd_ix =3D etc::init (pc);

   paranoid_printf ("%s", posix_fname);

Index: path.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.49
diff -u -p -r1.49 path.h
--- path.h	20 Jan 2003 02:57:54 -0000	1.49
+++ path.h	21 Jan 2003 00:10:16 -0000
@@ -213,13 +213,12 @@ int path_prefix_p (const char *path1, co
 class etc
 {
   static int curr_ix;
-  static signed char change_possible[MAX_ETC_FILES + 1];
-  static const char *fn[MAX_ETC_FILES + 1];
-  static FILETIME last_modified[MAX_ETC_FILES + 1];
+  static bool change_possible[MAX_ETC_FILES];
+  static const char *fn[MAX_ETC_FILES];
+  static FILETIME last_modified[MAX_ETC_FILES];
   static bool dir_changed (int);
-  static int init (int, const char *);
+  static int init (const char *);
   static bool file_changed (int);
-  static void set_last_modified (int, FILETIME&);
   static bool test_file_change (int);
   friend class pwdgrp;
 };
Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.240
diff -u -p -r1.240 path.cc
--- path.cc	20 Jan 2003 02:57:54 -0000	1.240
+++ path.cc	21 Jan 2003 00:10:31 -0000
@@ -3756,25 +3756,23 @@ out:

 int etc::curr_ix =3D 0;
 /* Note that the first elements of the below arrays are unused */
-signed char etc::change_possible[MAX_ETC_FILES + 1];
-const char *etc::fn[MAX_ETC_FILES + 1];
-FILETIME etc::last_modified[MAX_ETC_FILES + 1];
+bool etc::change_possible[MAX_ETC_FILES];
+const char *etc::fn[MAX_ETC_FILES];
+FILETIME etc::last_modified[MAX_ETC_FILES];

 int
-etc::init (int n, const char *etc_fn)
+etc::init (const char *etc_fn)
 {
-  if (n > 0)
-    /* ok */;
-  else if (++curr_ix <=3D MAX_ETC_FILES)
-    n =3D curr_ix;
+  if (curr_ix < MAX_ETC_FILES)
+    {
+      fn[curr_ix] =3D etc_fn;
+      (void) file_changed (curr_ix);
+    }
   else
     api_fatal ("internal error");

-  fn[n] =3D etc_fn;
-  change_possible[n] =3D false;
-  (void) test_file_change (n);
-  paranoid_printf ("fn[%d] %s, curr_ix %d", n, fn[n], curr_ix);
-  return n;
+  paranoid_printf ("fn[%d] %s, curr_ix %d", curr_ix, fn[curr_ix], curr_ix);
+  return curr_ix++;
 }

 bool
@@ -3784,12 +3782,7 @@ etc::test_file_change (int n)
   WIN32_FIND_DATA data;
   bool res;

-  if (change_possible[n] < 0)
-    {
-      res =3D true;
-      paranoid_printf ("fn[%d] %s, already marked changed", n, fn[n]);
-    }
-  else if ((h =3D FindFirstFile (fn[n], &data)) =3D=3D INVALID_HANDLE_VALU=
E)
+  if ((h =3D FindFirstFile (fn[n], &data)) =3D=3D INVALID_HANDLE_VALUE)
     {
       res =3D true;
       memset (last_modified + n, 0, sizeof (last_modified[n]));
@@ -3800,7 +3793,6 @@ etc::test_file_change (int n)
       FindClose (h);
       res =3D CompareFileTime (&data.ftLastWriteTime, last_modified + n) >=
 0;
       last_modified[n] =3D data.ftLastWriteTime;
-      change_possible[n] =3D -res;
       debug_printf ("FindFirstFile succeeded");
     }

@@ -3825,12 +3817,11 @@ etc::dir_changed (int n)
 	    system_printf ("Can't open /etc for checking, %E", (char *) pwd,
 			   changed_h);
 #endif
-	  for (int i =3D 1; i <=3D curr_ix; i++)
-	    (void) test_file_change (i);
+	  memset (change_possible, true, sizeof change_possible);
 	}

       if (changed_h =3D=3D INVALID_HANDLE_VALUE)
-	(void) test_file_change (n);	/* semi-brute-force way */
+	return true;
       else if (WaitForSingleObject (changed_h, 0) =3D=3D WAIT_OBJECT_0)
 	{
 	  (void) FindNextChangeNotification (changed_h);

--=====================_1043135491==_--
