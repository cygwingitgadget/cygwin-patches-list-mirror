Return-Path: <cygwin-patches-return-3500-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 403 invoked by alias); 5 Feb 2003 16:44:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 394 invoked from network); 5 Feb 2003 16:44:26 -0000
Message-Id: <3.0.5.32.20030205114159.00800620@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Wed, 05 Feb 2003 16:44:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: ntsec odds and ends
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1044481319==_"
X-SW-Source: 2003-q1/txt/msg00149.txt.bz2

--=====================_1044481319==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 696

Corinna,

This is hopefully the last installment for a while. Just minor cleanups.
- Now that Win95 and NT behave more similarly, there is no need
  for DEFAULT_UID_NT and I changed to more meaningful names.
- In grp.cc, I used more explicit group names to indicate trouble. 

Pierre

2003-02-05  Pierre Humblet  <pierre.humblet@ieee.org>

	* security.h: Introduce names UNKNOWN_UID and UNKNOWN_GID and delete
	declaration of is_grp_member.
	* uinfo.cc (internal_getlogin): Use UNKNOWN_GID.
	* passwd.cc (pwdgrp::read_passwd): Use UNKNOWN_UID.
	* grp.cc (pwdgrp::read_group): Change group names to provide better
	feedback.
	(getgrgid): Use gid16togid32.
	* sec_helper.cc (is_grp_member): Delete.
--=====================_1044481319==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="final.diff"
Content-length: 5936

Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.38
diff -u -p -r1.38 security.h
--- security.h	4 Feb 2003 14:58:04 -0000	1.38
+++ security.h	5 Feb 2003 15:28:25 -0000
@@ -11,8 +11,8 @@ details. */
 #include <accctrl.h>

 #define DEFAULT_UID DOMAIN_USER_RID_ADMIN
-#define DEFAULT_UID_NT 400 /* Non conflicting number */
-#define DEFAULT_GID 401
+#define UNKNOWN_UID 400 /* Non conflicting number */
+#define UNKNOWN_GID 401

 #define MAX_SID_LEN 40
 #define MAX_DACL_LEN(n) (sizeof (ACL) \
@@ -244,7 +244,6 @@ void extract_nt_dom_user (const struct p
 BOOL get_logon_server (const char * domain, char * server, WCHAR *wserver =
=3D NULL);

 /* sec_helper.cc: Security helper functions. */
-BOOL __stdcall is_grp_member (__uid32_t uid, __gid32_t gid);
 int set_process_privilege (const char *privilege, bool enable =3D true, bo=
ol use_thread =3D false);

 /* shared.cc: */
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.110
diff -u -p -r1.110 uinfo.cc
--- uinfo.cc	27 Jan 2003 00:31:30 -0000	1.110
+++ uinfo.cc	5 Feb 2003 15:28:32 -0000
@@ -37,7 +37,7 @@ internal_getlogin (cygheap_user &user)
   struct passwd *pw =3D NULL;
   HANDLE ptok =3D INVALID_HANDLE_VALUE;

-  myself->gid =3D DEFAULT_GID;
+  myself->gid =3D UNKNOWN_GID;
   if (wincap.has_security ())
     {
       DWORD siz;
Index: passwd.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.69
diff -u -p -r1.69 passwd.cc
--- passwd.cc	4 Feb 2003 14:58:04 -0000	1.69
+++ passwd.cc	5 Feb 2003 15:28:39 -0000
@@ -87,7 +87,7 @@ pwdgrp::read_passwd ()
       (void) cygheap->user.ontherange (CH_HOME, NULL);
       snprintf (linebuf, sizeof (linebuf), "%s:*:%lu:%lu:,%s:%s:/bin/sh",
 		cygheap->user.name (),
-		myself->uid =3D=3D ILLEGAL_UID ? DEFAULT_UID_NT : myself->uid,
+		myself->uid =3D=3D ILLEGAL_UID ? UNKNOWN_UID : myself->uid,
 		myself->gid,
 		strbuf, getenv ("HOME") ?: "");
       debug_printf ("Completing /etc/passwd: %s", linebuf);
Index: grp.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.76
diff -u -p -r1.76 grp.cc
--- grp.cc	4 Feb 2003 17:53:08 -0000	1.76
+++ grp.cc	5 Feb 2003 15:28:46 -0000
@@ -84,7 +84,7 @@ pwdgrp::read_group ()
   if (!internal_getgrgid (myself->gid))
     {
       static char linebuf [200];
-      char group_name [UNLEN + 1] =3D "mkgroup";
+      char group_name [UNLEN + 1] =3D "run mkgroup";
       char strbuf[128] =3D "";

       if (wincap.has_security ())
@@ -95,6 +95,8 @@ pwdgrp::read_group ()
 	  if ((gr =3D internal_getgrsid (cygheap->user.groups.pgsid)))
 	    strlcpy (group_name, gr->gr_name, sizeof (group_name));
 	}
+      if (myself->uid =3D=3D UNKNOWN_UID)
+	strcpy (group_name, "run mkpasswd"); /* Feedback... */
       snprintf (linebuf, sizeof (linebuf), "%s:%s:%lu:%s",
 		group_name, strbuf, myself->gid, cygheap->user.name ());
       debug_printf ("Completing /etc/group: %s", linebuf);
@@ -171,7 +173,7 @@ getgrgid (__gid16_t gid)
 {
   static struct __group16 g16;	/* FIXME: thread-safe? */

-  return grp32togrp16 (&g16, getgrgid32 ((__gid32_t) gid));
+  return grp32togrp16 (&g16, getgrgid32 (gid16togid32 (gid)));
 }

 extern "C" struct __group32 *
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.35
diff -u -p -r1.35 sec_helper.cc
--- sec_helper.cc	5 Feb 2003 13:47:47 -0000	1.35
+++ sec_helper.cc	5 Feb 2003 15:28:56 -0000
@@ -223,47 +223,6 @@ get_sids_info (cygpsid owner_sid, cygpsi
   return ret;
 }

-BOOL
-is_grp_member (__uid32_t uid, __gid32_t gid)
-{
-  struct passwd *pw;
-  struct __group32 *gr;
-  int idx;
-
-  /* Evaluate current user info by examining the info given in cygheap and
-     the current access token if ntsec is on. */
-  if (uid =3D=3D myself->uid)
-    {
-      /* If gid =3D=3D primary group of current user, return immediately. =
*/
-      if (gid =3D=3D myself->gid)
-	return TRUE;
-      /* Calling getgroups only makes sense when reading the access token.=
 */
-      if (allow_ntsec)
-	{
-	  __gid32_t grps[NGROUPS_MAX];
-	  int cnt =3D internal_getgroups (NGROUPS_MAX, grps);
-	  for (idx =3D 0; idx < cnt; ++idx)
-	    if (grps[idx] =3D=3D gid)
-	      return TRUE;
-	  return FALSE;
-	}
-    }
-
-  /* Otherwise try getting info from examining passwd and group files. */
-  if ((pw =3D internal_getpwuid (uid)))
-    {
-      /* If gid =3D=3D primary group of uid, return immediately. */
-      if ((__gid32_t) pw->pw_gid =3D=3D gid)
-	return TRUE;
-      /* Otherwise search for supplementary user list of this group. */
-      if ((gr =3D internal_getgrgid (gid)))
-	for (idx =3D 0; gr->gr_mem[idx]; ++idx)
-	  if (strcasematch (cygheap->user.name (), gr->gr_mem[idx]))
-	    return TRUE;
-    }
-  return FALSE;
-}
-
 #if 0 // unused
 #define SIDLEN	(sidlen =3D MAX_SID_LEN, &sidlen)
 #define DOMLEN	(domlen =3D INTERNET_MAX_HOST_NAME_LENGTH, &domlen)

--=====================_1044481319==_--
