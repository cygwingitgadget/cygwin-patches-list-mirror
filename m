Return-Path: <cygwin-patches-return-3465-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23603 invoked by alias); 25 Jan 2003 04:29:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23590 invoked from network); 25 Jan 2003 04:29:55 -0000
Message-Id: <3.0.5.32.20030124232917.007f1ae0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sat, 25 Jan 2003 04:29:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: setuid on Win95 
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1043486957==_"
X-SW-Source: 2003-q1/txt/msg00114.txt.bz2

--=====================_1043486957==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 946


Corinna,

This patch brings seteuid on Win95 up to Posix and fixes
a handle leak on NT.

During testing (WinME) I noticed that "id" has stopped reporting
the supplementary groups present in /etc/group. Thus it is likely
that the suppl. groups are broken in is_grp_member() on NT.

Pierre

2003/01/25  Pierre Humblet  <pierre.humblet@ieee.org>

	* syscalls.cc (seteuid32): On Win95 get the pw entry. If it exists
	update the euid and call cygheap->user.set_name. Remove special handling 
	of ILLEGAL_UID.
	(setgid32): Add a debug_printf. On Win95, always set the egid. 
	Remove special handling of ILLEGAL_GID. Do not compare gid and gr_gid.
	* child_info.h (class cygheap_exec_info): Remove uid.
	* spawn.cc (spawn_guts): Do not set ciresrv.moreinfo->uid.
	* dcrto.cc (dll_crt0_1): Always call uinfo_init.
	* uinfo.cc (uinfo_init): Reorganize and close handle if needed.
	(cygheap_user::ontherange): Do not call internal_getpwnam if pw is NULL.

--=====================_1043486957==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ntsec.diff"
Content-length: 6231

Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.241
diff -u -p -r1.241 syscalls.cc
--- syscalls.cc	24 Jan 2003 15:23:15 -0000	1.241
+++ syscalls.cc	25 Jan 2003 00:03:04 -0000
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
@@ -2160,22 +2154,21 @@ setreuid (__uid16_t ruid, __uid16_t euid
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
+++ child_info.h	25 Jan 2003 00:03:51 -0000
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
+++ spawn.cc	25 Jan 2003 00:04:20 -0000
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
retrieving revision 1.169
diff -u -p -r1.169 dcrt0.cc
--- dcrt0.cc	17 Jan 2003 18:05:32 -0000	1.169
+++ dcrt0.cc	25 Jan 2003 00:04:46 -0000
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
retrieving revision 1.104
diff -u -p -r1.104 uinfo.cc
--- uinfo.cc	24 Jan 2003 03:53:46 -0000	1.104
+++ uinfo.cc	25 Jan 2003 00:05:54 -0000
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

--=====================_1043486957==_--
