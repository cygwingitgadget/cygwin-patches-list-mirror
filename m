Return-Path: <cygwin-patches-return-4214-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4173 invoked by alias); 14 Sep 2003 02:14:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4090 invoked from network); 14 Sep 2003 02:14:37 -0000
Message-Id: <3.0.5.32.20030913221257.00822e40@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 14 Sep 2003 02:14:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Oops] Part 2 of Fixing a security hole in pinfo.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1063519977==_"
X-SW-Source: 2003-q3/txt/msg00230.txt.bz2

--=====================_1063519977==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 20

Here is the patch.


--=====================_1063519977==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pinfo2.diff"
Content-length: 9150

Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.44
diff -u -p -r1.44 security.h
--- security.h	10 Sep 2003 02:12:25 -0000	1.44
+++ security.h	13 Sep 2003 21:29:56 -0000
@@ -256,9 +256,11 @@ SECURITY_DESCRIPTOR *__stdcall get_null_

 /* Various types of security attributes for use in Create* functions. */
 extern SECURITY_ATTRIBUTES sec_none, sec_none_nih, sec_all, sec_all_nih;
-extern SECURITY_ATTRIBUTES *__stdcall __sec_user (PVOID sa_buf, PSID sid2,=
 BOOL inherit)
+extern SECURITY_ATTRIBUTES *__stdcall __sec_user (PVOID sa_buf, PSID sid1,=
 PSID sid2,
+						  DWORD access2, BOOL inherit)
   __attribute__ ((regparm (3)));
-extern BOOL sec_acl (PACL acl, BOOL admins, PSID sid1 =3D NO_SID, PSID sid=
2 =3D NO_SID);
+extern BOOL sec_acl (PACL acl, bool original, bool admins, PSID sid1 =3D N=
O_SID,
+		     PSID sid2 =3D NO_SID, DWORD access2 =3D 0);

 int __stdcall NTReadEA (const char *file, const char *attrname, char *buf,=
 int len);
 BOOL __stdcall NTWriteEA (const char *file, const char *attrname, const ch=
ar *buf, int len);
@@ -266,14 +268,14 @@ PSECURITY_DESCRIPTOR alloc_sd (__uid32_t
 	  PSECURITY_DESCRIPTOR sd_ret, DWORD *sd_size_ret);

 extern inline SECURITY_ATTRIBUTES *
-sec_user_nih (char sa_buf[], PSID sid =3D NULL)
+sec_user_nih (char sa_buf[], PSID sid1 =3D NULL, PSID sid2 =3D NULL, DWORD=
 access2 =3D 0)
 {
-  return allow_ntsec ? __sec_user (sa_buf, sid, FALSE) : &sec_none_nih;
+  return __sec_user (sa_buf, sid1, sid2, access2, FALSE);
 }

 extern inline SECURITY_ATTRIBUTES *
-sec_user (char sa_buf[], PSID sid =3D NULL)
+sec_user (char sa_buf[], PSID sid1 =3D NULL, PSID sid2 =3D NULL, DWORD acc=
ess2 =3D 0)
 {
-  return allow_ntsec ? __sec_user (sa_buf, sid, TRUE) : &sec_none;
+  return __sec_user (sa_buf, sid1, sid2, access2, TRUE);
 }
 #endif /*_SECURITY_H*/
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.39
diff -u -p -r1.39 sec_helper.cc
--- sec_helper.cc	16 Jun 2003 03:24:11 -0000	1.39
+++ sec_helper.cc	13 Sep 2003 21:29:56 -0000
@@ -372,23 +372,29 @@ get_null_sd ()
 }

 BOOL
-sec_acl (PACL acl, BOOL admins, PSID sid1, PSID sid2)
+sec_acl (PACL acl, bool original, bool admins, PSID sid1, PSID sid2, DWORD=
 access2)
 {
   size_t acl_len =3D MAX_DACL_LEN(5);
+  cygpsid psid;

   if (!InitializeAcl (acl, acl_len, ACL_REVISION))
     {
       debug_printf ("InitializeAcl %E");
       return FALSE;
     }
-  if (sid2)
-    if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			      GENERIC_ALL, sid2))
-      debug_printf ("AddAccessAllowedAce(sid2) %E");
   if (sid1)
     if (!AddAccessAllowedAce (acl, ACL_REVISION,
 			      GENERIC_ALL, sid1))
       debug_printf ("AddAccessAllowedAce(sid1) %E");
+  if (original && (psid =3D cygheap->user.orig_sid ())
+      && psid !=3D sid1 && psid !=3D well_known_system_sid)
+    if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			      GENERIC_ALL, psid))
+      debug_printf ("AddAccessAllowedAce(original) %E");
+  if (sid2)
+    if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			      access2, sid2))
+      debug_printf ("AddAccessAllowedAce(sid2) %E");
   if (admins)
     if (!AddAccessAllowedAce (acl, ACL_REVISION,
 			      GENERIC_ALL, well_known_admins_sid))
@@ -396,26 +402,18 @@ sec_acl (PACL acl, BOOL admins, PSID sid
   if (!AddAccessAllowedAce (acl, ACL_REVISION,
 			    GENERIC_ALL, well_known_system_sid))
     debug_printf ("AddAccessAllowedAce(system) %E");
-#if 0 /* Does not seem to help */
-  if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			    GENERIC_ALL, well_known_creator_owner_sid))
-    debug_printf ("AddAccessAllowedAce(creator_owner) %E");
-#endif
   return TRUE;
 }

 PSECURITY_ATTRIBUTES __stdcall
-__sec_user (PVOID sa_buf, PSID sid2, BOOL inherit)
+__sec_user (PVOID sa_buf, PSID sid1, PSID sid2, DWORD access2, BOOL inheri=
t)
 {
   PSECURITY_ATTRIBUTES psa =3D (PSECURITY_ATTRIBUTES) sa_buf;
   PSECURITY_DESCRIPTOR psd =3D (PSECURITY_DESCRIPTOR)
 			     ((char *) sa_buf + sizeof (*psa));
   PACL acl =3D (PACL) ((char *) sa_buf + sizeof (*psa) + sizeof (*psd));

-  cygsid sid;
-
-  if (!(sid =3D cygheap->user.orig_sid ()) ||
-	  (!sec_acl (acl, TRUE, sid, sid2)))
+  if (!wincap.has_security () || !sec_acl (acl, true, true, sid1, sid2, ac=
cess2))
     return inherit ? &sec_none : &sec_none_nih;

   if (!InitializeSecurityDescriptor (psd, SECURITY_DESCRIPTOR_REVISION))
Index: pinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.84
diff -u -p -r1.84 pinfo.cc
--- pinfo.cc	13 Sep 2003 17:14:15 -0000	1.84
+++ pinfo.cc	13 Sep 2003 21:29:57 -0000
@@ -164,7 +164,11 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
 	}
       else
 	{
-	  h =3D CreateFileMapping (INVALID_HANDLE_VALUE, &sec_all_nih,
+	  char sa_buf[1024];
+	  PSECURITY_ATTRIBUTES sec_attribs =3D
+	    sec_user_nih (sa_buf, cygheap->user.sid(), well_known_world_sid,
+			  FILE_MAP_READ | FILE_MAP_WRITE); /* FIXME */
+	  h =3D CreateFileMapping (INVALID_HANDLE_VALUE, sec_attribs,
 				 PAGE_READWRITE, 0, mapsize, mapname);
 	  created =3D h && GetLastError () !=3D ERROR_ALREADY_EXISTS;
 	}
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.150
diff -u -p -r1.150 security.cc
--- security.cc	26 Jul 2003 04:53:59 -0000	1.150
+++ security.cc	13 Sep 2003 21:30:00 -0000
@@ -906,7 +906,7 @@ create_token (cygsid &usersid, user_grou
     goto out;

   /* Create default dacl. */
-  if (!sec_acl ((PACL) acl_buf, FALSE,
+  if (!sec_acl ((PACL) acl_buf, false, false,
 		tmp_gsids.contains (well_known_admins_sid) ?
 		well_known_admins_sid : usersid))
     goto out;
@@ -926,7 +926,7 @@ create_token (cygsid &usersid, user_grou
   else
     {
       /* Set security descriptor and primary group */
-      psa =3D __sec_user (sa_buf, usersid, TRUE);
+      psa =3D sec_user (sa_buf, usersid);
       if (psa->lpSecurityDescriptor &&
 	  !SetSecurityDescriptorGroup ((PSECURITY_DESCRIPTOR)
 				       psa->lpSecurityDescriptor,
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.288
diff -u -p -r1.288 syscalls.cc
--- syscalls.cc	13 Sep 2003 17:14:15 -0000	1.288
+++ syscalls.cc	13 Sep 2003 21:30:05 -0000
@@ -2076,7 +2076,6 @@ seteuid32 (__uid32_t uid)
   user_groups &groups =3D cygheap->user.groups;
   HANDLE ptok, new_token =3D INVALID_HANDLE_VALUE;
   struct passwd * pw_new;
-  cygpsid origpsid, psid2 (NO_SID);
   BOOL token_is_internal, issamesid;

   pw_new =3D internal_getpwuid (uid);
@@ -2121,9 +2120,7 @@ seteuid32 (__uid32_t uid)
   if (cygheap->user.current_token !=3D new_token)
     {
       char dacl_buf[MAX_DACL_LEN (5)];
-      if (usersid !=3D (origpsid =3D cygheap->user.orig_sid ()))
-	psid2 =3D usersid;
-      if (sec_acl ((PACL) dacl_buf, FALSE, origpsid, psid2))
+      if (sec_acl ((PACL) dacl_buf, true, false, usersid))
 	{
 	  TOKEN_DEFAULT_DACL tdacl;
 	  tdacl.DefaultDacl =3D (PACL) dacl_buf;
@@ -2171,7 +2168,7 @@ seteuid32 (__uid32_t uid)
     }

   CloseHandle (ptok);
-  issamesid =3D (usersid =3D=3D (psid2 =3D cygheap->user.sid ()));
+  issamesid =3D (usersid =3D=3D cygheap->user.sid ());
   cygheap->user.set_sid (usersid);
   cygheap->user.current_token =3D new_token =3D=3D ptok ? INVALID_HANDLE_V=
ALUE
                                                   : new_token;
Index: dcrt0.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.180
diff -u -p -r1.180 dcrt0.cc
--- dcrt0.cc	12 Sep 2003 06:41:53 -0000	1.180
+++ dcrt0.cc	13 Sep 2003 21:30:06 -0000
@@ -680,6 +680,9 @@ dll_crt0_1 ()
   }
 #endif

+  /* Init global well known SID objects */
+  cygsid::init ();
+
   /* Initialize our process table entry. */
   pinfo_init (envp, envc);

@@ -689,9 +692,6 @@ dll_crt0_1 ()
   /* Allocate cygheap->fdtab */
   dtable_init ();

-  /* Init global well known SID objects */
-  cygsid::init ();
-
   /* Initialize user info. */
   uinfo_init ();


--=====================_1063519977==_--
