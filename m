Return-Path: <cygwin-patches-return-3390-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15427 invoked by alias); 15 Jan 2003 05:13:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15416 invoked from network); 15 Jan 2003 05:13:19 -0000
Message-Id: <3.0.5.32.20030115001238.00806440@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 15 Jan 2003 05:13:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: setuid on Win95 and etc_changed, passwd & group.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1042625558==_"
X-SW-Source: 2003-q1/txt/msg00039.txt.bz2

--=====================_1042625558==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 3299

Hello Corinna,

The following patches affect many files but they are simple.
They can wait for 1.3.20.

1) On Win95/98/ME, seteuid and setegid now change the uid/gid.
   Related to that are simplifications in spawn.cc and dcrt0.cc 
   and plugging a handle leak in uinfo.cc (5 first files).
2) passwd and group: various cleanup, plus fixing the following
   scenario that came to light while investigating etc_changed
   (but it doesn't cause any BSOD):
   t0: process starts, reads passwd and group
   t1: user updates /etc/group
   t2: program calls getpwuid. etc_changed returns TRUE. Timestamp
       of passwd file is old, no update. OK.
   t3: program calls getgrgid. etc_changed returns FALSE. 
       /etc/group is not updated. Bug.

During testing I noticed another issue. If etc_changed is initialized
in a parent and /etc/passwd is changed between the moments where a 
child is forked and where etc_changed is first called in the child, 
etc_changed unexpectedly returns false in the child (WinME).
Not sure how to fix that, short of always rereading the files in 
the child (when/if actually accessed). That would be an OK solution if
we hadn't just copied the data from the parent. Would it be possible
to store passwd and group in some other heap (from Windows?) that
doesn't get copied? If that was done, then the etc_changed handle
could be opened as needed instead of being inherited.

Incidentally while looking at cygheap.cc I noticed that the 
+ sizeof (_cmalloc_entry) on line 221 duplicates the one on line
234. I didn't change it in this patch as it is not related to the rest, 
but I have run with an abbreviated line 221 for a day.


2003/01/15  Pierre Humblet  <pierre.humblet@ieee.org>

	* syscalls.cc (seteuid32): On Win95 get the pw entry. If it exists
	update the euid and call cygheap->user.set_name. Remove special handling 
	of ILLEGAL_UID.
	(setgid32): Add a debug_printf. On Win95, always set the egid. 
	Remove special handling of ILLEGAL_GID. Do not compare gid and gr_gid.
	* child_info.h (class cygheap_exec_info): Remove uid.
	* spawn.cc (spawn_guts): Do not set ciresrv.moreinfo->uid.
	* dcrto.cc ( ): Always call uinfo_init.
	* uinfo.cc (uinfo_init): Reorganize and close handle if needed.
	(cygheap_user::ontherange): Do not call internal_getpwnam if pw is NULL.
	* cygheap.h (struct init_cygheap): Define type etc_changed_bits.
	Add etc_changed_flags member, and add argument to etc_changed. 
	* cygheap.cc (init_cygheap::etc_changed): Add argument. Use it in 
	conjunction with etc_changed_flags.
	* pwdgroup.h (class pwdgrp_check): Add member me, initialize it in 
	constructor. Add third argument to declaration of internal_getgroups.
	(pwdgrp_check::isinitializing): Add argument to etc_changed.
	(pwdgrp_check::isuninitialized): Add call to initialize etc_changed.	
	* passwd.cc: Add argument to declaration of passwd_state.
	(grab_int): replace almost_null by "".
	(read_etc_passwd): On NT, add a line for uid = -1. Use same default uid
	for Win95 and NT. Call cygheap_user::ontherange to initialize HOME. 
	* grp.cc (read_etc_group): On NT, add a line for gid = -1. Change name
	"unknown" to "mkgroup". 
	(internal_getgrgid): Do not return default in nontsec case.
	(internal_getgroups): Add argument srchsid and look for it in groups
	if not NULL.
--=====================_1042625558==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ntsec.diff"
Content-length: 15125

Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.239
diff -u -p -r1.239 syscalls.cc
--- syscalls.cc	14 Jan 2003 20:19:27 -0000	1.239
+++ syscalls.cc	15 Jan 2003 04:23:59 -0000
@@ -1948,22 +1948,14 @@ mkfifo (const char *_path, mode_t mode)
 extern "C" int
 seteuid32 (__uid32_t uid)
 {
+  debug_printf ("uid: %u myself->gid: %u", uid, myself->gid);

-  debug_printf ("uid: %d myself->gid: %d", uid, myself->gid);
-
-  if (!wincap.has_security ()
-      || (uid =3D=3D myself->uid && !cygheap->user.groups.ischanged))
+  if (uid =3D=3D myself->uid && !cygheap->user.groups.ischanged)
     {
       debug_printf ("Nothing happens");
       return 0;
     }

-  if (uid =3D=3D ILLEGAL_UID)
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
-
   sigframe thisframe (mainthread);
   cygsid usersid;
   user_groups &groups =3D cygheap->user.groups;
@@ -1974,6 +1966,8 @@ seteuid32 (__uid32_t uid)
   PSID origpsid, psid2 =3D NO_SID;

   pw_new =3D internal_getpwuid (uid);
+  if (!wincap.has_security () && pw_new)
+    goto success;
   if (!usersid.getfrompw (pw_new))
     {
       set_errno (EINVAL);
@@ -2092,9 +2086,9 @@ seteuid32 (__uid32_t uid)
       sav_token !=3D cygheap->user.token &&
       sav_token_is_internal_token)
       CloseHandle (sav_token);
-  cygheap->user.set_name (pw_new->pw_name);
   cygheap->user.set_sid (usersid);
 success:
+  cygheap->user.set_name (pw_new->pw_name);
   myself->uid =3D uid;
   groups.ischanged =3D FALSE;
   return 0;
@@ -2135,22 +2129,21 @@ setuid (__uid16_t uid)
 extern "C" int
 setegid32 (__gid32_t gid)
 {
-  if (!wincap.has_security () || gid =3D=3D myself->gid)
-    return 0;
+  debug_printf ("new egid: %u current: %u", gid, myself->gid);

-  if (gid =3D=3D ILLEGAL_GID)
+  if (gid =3D=3D myself->gid || !wincap.has_security ())
     {
-      set_errno (EINVAL);
-      return -1;
+      myself->gid =3D gid;
+      return 0;
     }

   sigframe thisframe (mainthread);
   user_groups * groups =3D &cygheap->user.groups;
   cygsid gsid;
   HANDLE ptok;
-
   struct __group32 * gr =3D internal_getgrgid (gid);
-  if (!gr || gr->gr_gid !=3D gid || !gsid.getfromgr (gr))
+
+  if (!gsid.getfromgr (gr))
     {
       set_errno (EINVAL);
       return -1;
Index: child_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/child_info.h,v
retrieving revision 1.36
diff -u -p -r1.36 child_info.h
--- child_info.h	15 Oct 2002 07:03:44 -0000	1.36
+++ child_info.h	15 Jan 2003 04:24:27 -0000
@@ -71,7 +71,6 @@ class fhandler_base;
 class cygheap_exec_info
 {
 public:
-  __uid32_t uid;
   char *old_title;
   int argc;
   char **argv;
Index: spawn.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.118
diff -u -p -r1.118 spawn.cc
--- spawn.cc	17 Oct 2002 17:45:09 -0000	1.118
+++ spawn.cc	15 Jan 2003 04:24:54 -0000
@@ -658,7 +658,6 @@ spawn_guts (const char * prog_arg, const
       char wstname[1024];
       char dskname[1024];

-      ciresrv.moreinfo->uid =3D ILLEGAL_UID;
       hwst =3D GetProcessWindowStation ();
       SetUserObjectSecurity (hwst, &dsi, get_null_sd ());
       GetUserObjectInformation (hwst, UOI_NAME, wstname, 1024, &n);
Index: dcrt0.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.168
diff -u -p -r1.168 dcrt0.cc
--- dcrt0.cc	10 Jan 2003 12:32:46 -0000	1.168
+++ dcrt0.cc	15 Jan 2003 04:25:17 -0000
@@ -684,9 +684,8 @@ dll_crt0_1 ()
   /* Init global well known SID objects */
   cygsid::init ();

-  /* Initialize uid, gid if necessary. */
-  if (child_proc_info =3D=3D NULL || spawn_info->moreinfo->uid =3D=3D ILLE=
GAL_UID)
-    uinfo_init ();
+  /* Initialize user info. */
+  uinfo_init ();

   /* Initialize signal/subprocess handling. */
   sigproc_init ();
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.97
diff -u -p -r1.97 uinfo.cc
--- uinfo.cc	10 Dec 2002 12:43:49 -0000	1.97
+++ uinfo.cc	15 Jan 2003 04:25:38 -0000
@@ -102,15 +102,18 @@ internal_getlogin (cygheap_user &user)
 void
 uinfo_init ()
 {
-  if (!child_proc_info)
-    internal_getlogin (cygheap->user); /* Set the cygheap->user. */
-
+  if (!child_proc_info || cygheap->user.token !=3D INVALID_HANDLE_VALUE)
+    {
+      if (!child_proc_info)
+	internal_getlogin (cygheap->user); /* Set the cygheap->user. */
+      else
+        CloseHandle (cygheap->user.token);
+      cygheap->user.set_orig_sid ();	/* Update the original sid */
+      cygheap->user.token =3D INVALID_HANDLE_VALUE; /* No token present */
+    }
   /* Real and effective uid/gid are identical on process start up. */
   cygheap->user.orig_uid =3D cygheap->user.real_uid =3D myself->uid;
   cygheap->user.orig_gid =3D cygheap->user.real_gid =3D myself->gid;
-  cygheap->user.set_orig_sid ();	/* Update the original sid */
-
-  cygheap->user.token =3D INVALID_HANDLE_VALUE; /* No token present */
 }

 extern "C" char *
@@ -214,8 +217,6 @@ cygheap_user::ontherange (homebodies wha
 	debug_printf ("HOME is already in the environment %s", p);
       else
 	{
-	  if (!pw)
-	    pw =3D internal_getpwnam (name ());
 	  if (pw && pw->pw_dir && *pw->pw_dir)
 	    {
 	      debug_printf ("Set HOME (from /etc/passwd) to %s", pw->pw_dir);
Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.56
diff -u -p -r1.56 cygheap.h
--- cygheap.h	22 Oct 2002 16:18:55 -0000	1.56
+++ cygheap.h	15 Jan 2003 04:26:26 -0000
@@ -206,6 +206,12 @@ struct user_heap_info
   unsigned chunk;
 };

+typedef enum
+{
+  ETC_PASSWD =3D 1,
+  ETC_GROUP=3D 2
+} etc_changed_bits;
+
 struct init_cygheap
 {
   _cmalloc_entry *chain;
@@ -223,8 +229,8 @@ struct init_cygheap
 #ifdef DEBUGGING
   cygheap_debug debug;
 #endif
-
-  bool etc_changed ();
+  int etc_changed_flags;
+  bool etc_changed (etc_changed_bits);
 };

 #define CYGHEAPSIZE (sizeof (init_cygheap) + (16000 * sizeof (fhandler_uni=
on)) + (4 * 65536))
Index: cygheap.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.cc,v
retrieving revision 1.74
diff -u -p -r1.74 cygheap.cc
--- cygheap.cc	22 Oct 2002 16:18:55 -0000	1.74
+++ cygheap.cc	15 Jan 2003 04:26:47 -0000
@@ -382,7 +382,7 @@ cstrdup1 (const char *s)
 }

 bool
-init_cygheap::etc_changed ()
+init_cygheap::etc_changed (etc_changed_bits who)
 {
   bool res =3D 0;

@@ -404,13 +404,20 @@ init_cygheap::etc_changed ()
 	}
     }

-   if (etc_changed_h !=3D INVALID_HANDLE_VALUE
-       && WaitForSingleObject (etc_changed_h, 0) =3D=3D WAIT_OBJECT_0)
-     {
-       (void) FindNextChangeNotification (etc_changed_h);
-       res =3D 1;
-     }
-
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
   return res;
 }

Index: pwdgrp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pwdgrp.h,v
retrieving revision 1.8
diff -u -p -r1.8 pwdgrp.h
--- pwdgrp.h	10 Dec 2002 12:43:49 -0000	1.8
+++ pwdgrp.h	15 Jan 2003 04:27:38 -0000
@@ -19,7 +19,7 @@ extern struct __group32 *internal_getgrs
 extern struct __group32 *internal_getgrgid (__gid32_t gid, BOOL =3D FALSE);
 extern struct __group32 *internal_getgrnam (const char *, BOOL =3D FALSE);
 extern struct __group32 *internal_getgrent (int);
-int internal_getgroups (int, __gid32_t *);
+int internal_getgroups (int, __gid32_t *, cygsid * =3D NULL);

 enum pwdgrp_state {
   uninitialized =3D 0,
@@ -31,14 +31,15 @@ class pwdgrp_check {
   pwdgrp_state	state;
   FILETIME	last_modified;
   char		file_w32[MAX_PATH];
+  etc_changed_bits me;

 public:
-  pwdgrp_check () : state (uninitialized) {}
+  pwdgrp_check (etc_changed_bits who) : state (uninitialized) { me =3D who=
; }
   BOOL isinitializing ()
     {
       if (state <=3D initializing)
-	state =3D initializing;
-      else if (cygheap->etc_changed ())
+        state =3D initializing;
+      else if (cygheap->etc_changed (me))
         {
 	  if (!file_w32[0])
 	    state =3D initializing;
@@ -61,7 +62,12 @@ public:
     {
       state =3D nstate;
     }
-  BOOL isuninitialized () const { return state =3D=3D uninitialized; }
+  BOOL isuninitialized () const
+    {
+       if (state =3D=3D uninitialized)
+	 (void) cygheap->etc_changed (me);
+       return (state =3D=3D uninitialized);
+    }
   void set_last_modified (HANDLE fh, const char *name)
     {
       if (!file_w32[0])
Index: passwd.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.57
diff -u -p -r1.57 passwd.cc
--- passwd.cc	10 Jan 2003 12:32:46 -0000	1.57
+++ passwd.cc	15 Jan 2003 04:28:01 -0000
@@ -30,7 +30,7 @@ static struct passwd *passwd_buf;	/* pas
 static int curr_lines;
 static int max_lines;

-static pwdgrp_check passwd_state;
+static pwdgrp_check passwd_state (ETC_PASSWD);


 /* Position in the passwd cache */
@@ -40,7 +40,7 @@ static pwdgrp_check passwd_state;
 static int pw_pos =3D 0;
 #endif

-/* Remove a : teminated string from the buffer, and increment the pointer =
*/
+/* Remove a : terminated string from the buffer, and increment the pointer=
 */
 static char *
 grab_string (char **p)
 {
@@ -65,7 +65,7 @@ grab_int (char **p)
 {
   char *src =3D *p;
   unsigned int val =3D strtoul (src, p, 10);
-  *p =3D (*p =3D=3D src || **p !=3D ':') ? almost_null : *p + 1;
+  *p =3D (*p =3D=3D src || **p !=3D ':') ? (char *) "" : *p + 1;
   return val;
 }

@@ -154,16 +154,16 @@ read_etc_passwd ()
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
@@ -173,11 +173,12 @@ read_etc_passwd ()
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
Index: grp.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.61
diff -u -p -r1.61 grp.cc
--- grp.cc	10 Dec 2002 12:43:49 -0000	1.61
+++ grp.cc	15 Jan 2003 04:28:25 -0000
@@ -40,7 +40,7 @@ static int max_lines;
 static int grp_pos =3D 0;
 #endif

-static pwdgrp_check group_state;
+static pwdgrp_check group_state (ETC_GROUP);
 static char * NO_COPY null_ptr =3D NULL;

 static int
@@ -157,7 +157,7 @@ read_etc_group ()
       if (!internal_getgrgid (myself->gid))
         {
 	  static char linebuf [200];
-	  char group_name [UNLEN + 1] =3D "unknown";
+	  char group_name [UNLEN + 1] =3D "mkgroup";
 	  char strbuf[128] =3D "";

 	  if (wincap.has_security ())
@@ -173,6 +173,9 @@ read_etc_group ()
 	  debug_printf ("Completing /etc/group: %s", linebuf);
 	  add_grp_line (linebuf);
 	}
+      static char pretty_ls[] =3D "????????::-1:";
+      if (wincap.has_security ())
+	add_grp_line (pretty_ls);
     }
   return;
 }
@@ -195,20 +198,14 @@ internal_getgrsid (cygsid &sid)
 struct __group32 *
 internal_getgrgid (__gid32_t gid, BOOL check)
 {
-  struct __group32 * default_grp =3D NULL;
-
   if (group_state.isuninitialized ()
       || (check && group_state.isinitializing ()))
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
@@ -316,7 +313,7 @@ internal_getgrent (int pos)
 }

 int
-internal_getgroups (int gidsetsize, __gid32_t *grouplist)
+internal_getgroups (int gidsetsize, __gid32_t *grouplist, cygsid * srchsid)
 {
   HANDLE hToken =3D NULL;
   DWORD size;
@@ -345,6 +342,13 @@ internal_getgroups (int gidsetsize, __gi
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

--=====================_1042625558==_--
