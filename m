Return-Path: <cygwin-patches-return-4004-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5121 invoked by alias); 12 Jul 2003 00:03:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5108 invoked from network); 12 Jul 2003 00:03:11 -0000
Message-Id: <3.0.5.32.20030711200253.00807190@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Sat, 12 Jul 2003 00:03:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Problems on accessing Windows network resources
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1057982573==_"
X-SW-Source: 2003-q3/txt/msg00020.txt.bz2

--=====================_1057982573==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1251

Corinna,

here is the slight reimplementation of ntsec promised in 
<http://cygwin.com/ml/cygwin-patches/2003-q2/msg00182.html>
to avoid having cygwin_set_impersonation_token potentially 
wiping out the current token.
 
During testing I found some nits, e.g. when ftp does a ls of
a networked directory with 1.5, the owner is given as SYSTEM.
That comes from the way seteuid now propagates to child processes
and that's why get_file_attribute() is changed to report the 
effective ids.

Pierre

2003-07-12  Pierre Humblet  <pierre.humblet@ieee.org>

	* cygheap.h (enum impersonation): Delete.
	(cygheap_user::impersonation_state): Delete.
	(cygheap_user::current_token): New.
	(cygheap_user::issetuid): Modify to use current_token.
	(cygheap_user::token): Ditto.
	(cygheap_user::deimpersonate): Ditto.
	(cygheap_user::reimpersonate): Ditto.
	(cygheap_user::has_impersonation_tokens): Ditto.
	(cygheap_user::close_impersonation_tokens): Ditto.
	* security.cc (cygwin_set_impersonation_token): Always set the token.
	(verify_token): Change type of gsid to cygpsid.
	(get_file_attribute): Use the effective ids.
	* syscalls.cc (seteuid32): Modify to use cygheap_user::current_token.
	* uinfo.cc (uinfo_init) Do not set cygheap->user.impersonation_state.

--=====================_1057982573==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sec.diff"
Content-length: 11015

Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.58
diff -u -p -r1.58 cygheap.h
--- cygheap.h	30 Jun 2003 13:07:36 -0000	1.58
+++ cygheap.h	11 Jul 2003 23:51:03 -0000
@@ -92,14 +92,6 @@ enum homebodies
   CH_HOME
 };

-enum impersonation
-{
-  IMP_BAD =3D -1,
-  IMP_NONE =3D 0,
-  IMP_EXTERNAL,
-  IMP_INTERNAL
-};
-
 class cygheap_user
 {
   /* Extendend user information.
@@ -125,7 +117,7 @@ public:
      to `set_impersonation_token()'. */
   HANDLE external_token;
   HANDLE internal_token;
-  enum impersonation impersonation_state;
+  HANDLE current_token;

   /* CGF 2002-06-27.  I removed the initializaton from this constructor
      since this class is always allocated statically.  That means that eve=
rything
@@ -170,32 +162,28 @@ public:
   PSID sid () const { return psid; }
   PSID orig_sid () const { return orig_psid; }
   const char *ontherange (homebodies what, struct passwd * =3D NULL);
-  bool issetuid () const
-  {
-    return impersonation_state > IMP_NONE;
-  }
-  HANDLE token ()
-  {
-    if (impersonation_state =3D=3D IMP_EXTERNAL)
-      return external_token;
-    if (impersonation_state =3D=3D IMP_INTERNAL)
-      return internal_token;
-    return INVALID_HANDLE_VALUE;
-  }
+  bool issetuid () const { return current_token !=3D 0; }
+  HANDLE token () { return current_token; }
   void deimpersonate ()
   {
-    if (impersonation_state > IMP_NONE)
+    if (issetuid ())
       RevertToSelf ();
   }
-  void reimpersonate ()
+  void reimpersonate ()
   {
-    if (impersonation_state > IMP_NONE
+    if (issetuid ()
 	&& !ImpersonateLoggedOnUser (token ()))
       system_printf ("ImpersonateLoggedOnUser: %E");
   }
-  bool has_impersonation_tokens () { return external_token || internal_tok=
en; }
+  bool has_impersonation_tokens () { return external_token || internal_tok=
en || current_token; }
   void close_impersonation_tokens ()
   {
+    if (current_token)
+      {
+	if( current_token !=3D external_token && current_token !=3D internal_toke=
n)
+	  CloseHandle (current_token);
+	current_token =3D 0;
+      }
     if (external_token)
       {
 	CloseHandle (external_token);
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.147
diff -u -p -r1.147 security.cc
--- security.cc	2 Jul 2003 03:16:00 -0000	1.147
+++ security.cc	11 Jul 2003 23:51:04 -0000
@@ -69,17 +69,8 @@ extern "C" void
 cygwin_set_impersonation_token (const HANDLE hToken)
 {
   debug_printf ("set_impersonation_token (%d)", hToken);
-  if (cygheap->user.impersonation_state =3D=3D IMP_EXTERNAL
-      && cygheap->user.external_token !=3D hToken)
-    {
-      set_errno (EPERM);
-      return;
-    }
-  else
-    {
-      cygheap->user.external_token =3D hToken;
-      return;
-    }
+  cygheap->user.external_token =3D hToken;
+  return;
 }

 void
@@ -741,13 +732,13 @@ verify_token (HANDLE token, cygsid &user
   if (intern && !groups.issetgroups ())
     {
       char sd_buf[MAX_SID_LEN + sizeof (SECURITY_DESCRIPTOR)];
-      PSID gsid =3D NO_SID;
+      cygpsid gsid (NO_SID);
       if (!GetKernelObjectSecurity (token, GROUP_SECURITY_INFORMATION,
 				    (PSECURITY_DESCRIPTOR) sd_buf,
 				    sizeof sd_buf, &size))
 	debug_printf ("GetKernelObjectSecurity(): %E");
       else if (!GetSecurityDescriptorGroup ((PSECURITY_DESCRIPTOR) sd_buf,
-					    &gsid, (BOOL *) &size))
+					    (PSID *) &gsid, (BOOL *) &size))
 	debug_printf ("GetSecurityDescriptorGroup(): %E");
       if (well_known_null_sid !=3D gsid)
 	return gsid =3D=3D groups.pgsid;
@@ -1414,9 +1405,9 @@ get_file_attribute (int use_ntsec, const
     }

   if (uidret)
-    *uidret =3D getuid32 ();
+    *uidret =3D myself->uid;
   if (gidret)
-    *gidret =3D getgid32 ();
+    *gidret =3D myself->gid;

   if (!attribute)
     return 0;
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.276
diff -u -p -r1.276 syscalls.cc
--- syscalls.cc	6 Jul 2003 20:13:48 -0000	1.276
+++ syscalls.cc	11 Jul 2003 23:51:05 -0000
@@ -2058,7 +2058,6 @@ seteuid32 (__uid32_t uid)
   HANDLE ptok, new_token =3D INVALID_HANDLE_VALUE;
   struct passwd * pw_new;
   PSID origpsid, psid2 =3D NO_SID;
-  enum impersonation new_state =3D IMP_BAD;
   BOOL token_is_internal;

   pw_new =3D internal_getpwuid (uid);
@@ -2079,48 +2078,47 @@ seteuid32 (__uid32_t uid)

   /* Verify if the process token is suitable. */
   if (verify_token (ptok, usersid, groups))
-    new_state =3D IMP_NONE;
-  /* Verify if a current token is suitable */
+    new_token =3D 0;
+  /* Verify if the external token is suitable */
   else if (cygheap->user.external_token
 	   && verify_token (cygheap->user.external_token, usersid, groups))
-    {
-      new_token =3D cygheap->user.external_token;
-      new_state =3D IMP_EXTERNAL;
-    }
-  else if (cygheap->user.internal_token
+    new_token =3D cygheap->user.external_token;
+  /* Verify if the current token (internal or former external) is suitable=
 */
+  else if (cygheap->user.current_token
+	   && cygheap->user.current_token !=3D cygheap->user.external_token
+	   && verify_token (cygheap->user.current_token, usersid, groups,
+			    &token_is_internal))
+    new_token =3D cygheap->user.current_token;
+  /* Verify if the internal token is suitable */
+  else if (cygheap->user.internal_token
+	   && cygheap->user.internal_token !=3D cygheap->user.current_token
 	   && verify_token (cygheap->user.internal_token, usersid, groups,
 			    &token_is_internal))
-    {
-      new_token =3D cygheap->user.internal_token;
-      new_state =3D IMP_INTERNAL;
-    }
-
-  debug_printf ("New token %d, state %d", new_token, new_state);
-  /* Return if current token is valid */
-  if (cygheap->user.impersonation_state =3D=3D new_state)
-    {
-      cygheap->user.reimpersonate ();
-      goto success; /* No change */
-    }
+    new_token =3D cygheap->user.internal_token;

+  debug_printf ("Found token %d", new_token);
+
   /* Set process def dacl to allow access to impersonated token */
-  char dacl_buf[MAX_DACL_LEN (5)];
-  if (usersid !=3D (origpsid =3D cygheap->user.orig_sid ()))
-    psid2 =3D usersid;
-  if (sec_acl ((PACL) dacl_buf, FALSE, origpsid, psid2))
+  if (cygheap->user.current_token !=3D new_token)
     {
-      TOKEN_DEFAULT_DACL tdacl;
-      tdacl.DefaultDacl =3D (PACL) dacl_buf;
-      if (!SetTokenInformation (ptok, TokenDefaultDacl,
-				&tdacl, sizeof dacl_buf))
-	debug_printf ("SetTokenInformation"
-		      "(TokenDefaultDacl): %E");
+      char dacl_buf[MAX_DACL_LEN (5)];
+      if (usersid !=3D (origpsid =3D cygheap->user.orig_sid ()))
+	psid2 =3D usersid;
+      if (sec_acl ((PACL) dacl_buf, FALSE, origpsid, psid2))
+        {
+	  TOKEN_DEFAULT_DACL tdacl;
+	  tdacl.DefaultDacl =3D (PACL) dacl_buf;
+	  if (!SetTokenInformation (ptok, TokenDefaultDacl,
+				    &tdacl, sizeof dacl_buf))
+	    debug_printf ("SetTokenInformation"
+			  "(TokenDefaultDacl): %E");
+	}
     }
-
-  if (new_state =3D=3D IMP_BAD)
+
+  /* If no impersonation token is available, try to
+     authenticate using NtCreateToken () or subauthentication. */
+  if (new_token =3D=3D INVALID_HANDLE_VALUE)
     {
-      /* If no impersonation token is available, try to
-	 authenticate using NtCreateToken () or subauthentication. */
       new_token =3D create_token (usersid, groups, pw_new);
       if (new_token =3D=3D INVALID_HANDLE_VALUE)
 	{
@@ -2130,48 +2128,30 @@ seteuid32 (__uid32_t uid)
 	  if (new_token =3D=3D INVALID_HANDLE_VALUE)
 	    goto failed;
 	}
-      new_state =3D IMP_INTERNAL;
-    }
-
-  /* If using the token, set info and impersonate */
-  if (new_state !=3D IMP_NONE)
-    {
-      /* If the token was explicitly created, all information has
-	 already been set correctly. */
-      if (new_state =3D=3D IMP_EXTERNAL)
-	{
-	  /* Try setting owner to same value as user. */
-	  if (!SetTokenInformation (new_token, TokenOwner,
-				    &usersid, sizeof usersid))
-	    debug_printf ("SetTokenInformation(user.token, "
-			  "TokenOwner): %E");
-	  /* Try setting primary group in token to current group */
-	  if (!SetTokenInformation (new_token,
-				    TokenPrimaryGroup,
-				    &groups.pgsid, sizeof (cygsid)))
-	    debug_printf ("SetTokenInformation(user.token, "
-			  "TokenPrimaryGroup): %E");
-	}
-      /* Try to impersonate. */
-      if (!ImpersonateLoggedOnUser (new_token))
-	{
-	  debug_printf ("ImpersonateLoggedOnUser %E");
-	  __seterrno ();
-	  goto failed;
-	}
       /* Keep at most one internal token */
-      if (new_state =3D=3D IMP_INTERNAL)
-        {
-	  if (cygheap->user.internal_token)
-	    CloseHandle (cygheap->user.internal_token);
-	  cygheap->user.internal_token =3D new_token;
-	}
+      if (cygheap->user.internal_token)
+	CloseHandle (cygheap->user.internal_token);
+      cygheap->user.internal_token =3D new_token;
+    }
+  else if (new_token !=3D 0)
+    {
+      /* Try setting owner to same value as user. */
+      if (!SetTokenInformation (new_token, TokenOwner,
+				&usersid, sizeof usersid))
+	debug_printf ("SetTokenInformation(user.token, "
+		      "TokenOwner): %E");
+      /* Try setting primary group in token to current group */
+      if (!SetTokenInformation (new_token,
+				TokenPrimaryGroup,
+				&groups.pgsid, sizeof (cygsid)))
+	debug_printf ("SetTokenInformation(user.token, "
+		      "TokenPrimaryGroup): %E");
     }
-  cygheap->user.set_sid (usersid);

-success:
   CloseHandle (ptok);
-  cygheap->user.impersonation_state =3D new_state;
+  cygheap->user.set_sid (usersid);
+  cygheap->user.current_token =3D new_token;
+  cygheap->user.reimpersonate ();
 success_9x:
   cygheap->user.set_name (pw_new->pw_name);
   myself->uid =3D uid;
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.115
diff -u -p -r1.115 uinfo.cc
--- uinfo.cc	30 Jun 2003 13:07:36 -0000	1.115
+++ uinfo.cc	11 Jul 2003 23:51:05 -0000
@@ -122,7 +122,6 @@ uinfo_init ()

   cygheap->user.orig_uid =3D cygheap->user.real_uid =3D myself->uid;
   cygheap->user.orig_gid =3D cygheap->user.real_gid =3D myself->gid;
-  cygheap->user.impersonation_state =3D IMP_NONE;
   cygheap->user.set_orig_sid ();	/* Update the original sid */
 }


--=====================_1057982573==_--
