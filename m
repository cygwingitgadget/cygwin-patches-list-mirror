Return-Path: <cygwin-patches-return-4303-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15555 invoked by alias); 16 Oct 2003 02:27:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15475 invoked from network); 16 Oct 2003 02:27:09 -0000
Message-Id: <3.0.5.32.20031015222235.00825920@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 16 Oct 2003 02:27:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] *** CreateFileMapping, Win32 error 5.  Terminating.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1066285355==_"
X-SW-Source: 2003-q4/txt/msg00022.txt.bz2

--=====================_1066285355==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 587

The background for this patch was just explained on the Cygwin
mailing list.

We must make sure that the user sid is present in the default 
DACL of impersonation tokens, internal as well as external.
Thus the place to do it is in seteuid32(), and it becomes useless
to create a default DACL in create_token.

Pierre
 

2003-10-15  Pierre Humblet  <pierre.humblet@ieee.org>

	* syscalls.cc (seteuid32): Always construct a default DACL including
	the new sid, Admins and SYSTEM and copy it to the new thread token.
	* security.cc (create_token): Use a NULL default DACL in NtCreateToken.

--=====================_1066285355==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dacl.diff"
Content-length: 3927

Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.153
diff -u -p -r1.153 security.cc
--- security.cc	25 Sep 2003 03:51:50 -0000	1.153
+++ security.cc	15 Oct 2003 22:14:49 -0000
@@ -815,8 +815,7 @@ create_token (cygsid &usersid, user_grou
   PTOKEN_PRIVILEGES privs =3D NULL;
   TOKEN_OWNER owner;
   TOKEN_PRIMARY_GROUP pgrp;
-  char acl_buf[MAX_DACL_LEN (5)];
-  TOKEN_DEFAULT_DACL dacl;
+  TOKEN_DEFAULT_DACL dacl =3D {};
   TOKEN_SOURCE source;
   TOKEN_STATISTICS stats;
   memcpy (source.SourceName, "Cygwin.1", 8);
@@ -904,13 +903,6 @@ create_token (cygsid &usersid, user_grou
   /* Retrieve list of privileges of that user. */
   if (!(privs =3D get_priv_list (lsa, usersid, tmp_gsids)))
     goto out;
-
-  /* Create default dacl. */
-  if (!sec_acl ((PACL) acl_buf, false, false,
-		tmp_gsids.contains (well_known_admins_sid) ?
-		well_known_admins_sid : usersid))
-    goto out;
-  dacl.DefaultDacl =3D (PACL) acl_buf;

   /* Let's be heroic... */
   ret =3D NtCreateToken (&token, TOKEN_ALL_ACCESS, &oa, TokenImpersonation,
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.296
diff -u -p -r1.296 syscalls.cc
--- syscalls.cc	8 Oct 2003 09:17:08 -0000	1.296
+++ syscalls.cc	15 Oct 2003 22:14:53 -0000
@@ -2121,6 +2121,8 @@ seteuid32 (__uid32_t uid)
   HANDLE ptok, new_token =3D INVALID_HANDLE_VALUE;
   struct passwd * pw_new;
   BOOL token_is_internal, issamesid;
+  char dacl_buf[MAX_DACL_LEN (5)];
+  TOKEN_DEFAULT_DACL tdacl =3D {};

   pw_new =3D internal_getpwuid (uid);
   if (!wincap.has_security () && pw_new)
@@ -2161,18 +2163,13 @@ seteuid32 (__uid32_t uid)
   debug_printf ("Found token %d", new_token);

   /* Set process def dacl to allow access to impersonated token */
-  if (cygheap->user.current_token !=3D new_token)
+  if (sec_acl ((PACL) dacl_buf, true, true, usersid))
     {
-      char dacl_buf[MAX_DACL_LEN (5)];
-      if (sec_acl ((PACL) dacl_buf, true, false, usersid))
-	{
-	  TOKEN_DEFAULT_DACL tdacl;
-	  tdacl.DefaultDacl =3D (PACL) dacl_buf;
-	  if (!SetTokenInformation (ptok, TokenDefaultDacl,
-				    &tdacl, sizeof dacl_buf))
-	    debug_printf ("SetTokenInformation"
-			  "(TokenDefaultDacl): %E");
-	}
+      tdacl.DefaultDacl =3D (PACL) dacl_buf;
+      if (!SetTokenInformation (ptok, TokenDefaultDacl,
+				&tdacl, sizeof dacl_buf))
+	debug_printf ("SetTokenInformation"
+		      "(TokenDefaultDacl): %E");
     }

   /* If no impersonation token is available, try to
@@ -2193,7 +2190,7 @@ seteuid32 (__uid32_t uid)
 	CloseHandle (cygheap->user.internal_token);
       cygheap->user.internal_token =3D new_token;
     }
-  else if (new_token !=3D ptok)
+  if (new_token !=3D ptok)
     {
       /* Avoid having HKCU use default user */
       load_registry_hive (usersid);
@@ -2204,11 +2201,15 @@ seteuid32 (__uid32_t uid)
 	debug_printf ("SetTokenInformation(user.token, "
 		      "TokenOwner): %E");
       /* Try setting primary group in token to current group */
-      if (!SetTokenInformation (new_token,
-				TokenPrimaryGroup,
+      if (!SetTokenInformation (new_token, TokenPrimaryGroup,
 				&groups.pgsid, sizeof (cygsid)))
 	debug_printf ("SetTokenInformation(user.token, "
 		      "TokenPrimaryGroup): %E");
+      /* Try setting default DACL */
+      if (tdacl.DefaultDacl
+	  && !SetTokenInformation (new_token, TokenDefaultDacl,
+				   &tdacl, sizeof (tdacl)))
+	debug_printf ("SetTokenInformation (TokenDefaultDacl): %E");
     }

   CloseHandle (ptok);

--=====================_1066285355==_--
