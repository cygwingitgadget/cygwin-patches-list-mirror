Return-Path: <cygwin-patches-return-1962-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16644 invoked by alias); 10 Mar 2002 00:27:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16535 invoked from network); 10 Mar 2002 00:27:49 -0000
Message-Id: <3.0.5.32.20020309192813.007fcb70@pop.ne.mediaone.net>
X-Sender: phumblet@pop.ne.mediaone.net
X-Mailer: QUALCOMM Windows Eudora Pro Version 3.0.5 (32)
Date: Sat, 09 Mar 2002 16:48:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Security patches
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1015738093==_"
X-SW-Source: 2002-q1/txt/msg00319.txt.bz2

--=====================_1015738093==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2314

Hello Corinna,

Attached are 7 diff files, implementing changes discussed
last weekend, with two differences:

1) I kept spawn.cc almost intact. I had not considered
the possibility of an outside token (from old applications).
Also RevertToSelf() is and will remain needed.

2) When a call is made to cygheap->user.sid() in __sec_user(),
after seteuid() has been called, it returns the NEW sid,
which is the same as sid2. Thus the new sid is put twice 
in the acl, and the old user is NOT put it.
That's a problem when the old user is not in admins.
I have replaced the call to cygheap->user.sid() by a new func
sec_process_sid(), whick looks up the user sid from the process
token. This is a cumbersone method to get a simple thing. 
There are better ways. The process sid could be in cygheap 
(it changes rarely), or there could be a NOCOPY variable 
hMainToken (set in dcrt0.c) to make it easy to access the 
process token (it's opened and closed quite often in a number
of places). Either can be added later. I prefer the second 
method.

Changelog entries appear below, I hope the format is OK.
Does RedHat have my copyright assignment after all?
As usual, feel free to improve.

Pierre

2002-03-08  Pierre Humblet <pierre.humblet@ieee.org>
	
	* spawn.cc (spawn_guts): Move call to set_process_privilege()
	to load_registry_hive().
	* registry.cc (load_registry_hive): ditto.

	* fork.cc (fork_parent): Call sec_user_nih() only once.

	* shared.cc (sec_process_sid): Create.
	(sec_acl): Create from part of __sec_user(), except creator/owner.
	(__sec_user): Split into sec_acl(). Call sec_process_sid()
	instead of cygheap->user.sid().
	* security.h: Define new functions above and MAX_DACL_LEN.

	* syscalls.cc (setegid): Reverse change from 2002-01-21. Also
	call RevertToSelf and set primary group in impersonation token.

	* syscalls.cc (seteuid): Set default dacl in process token.
	Replace in-line code by call to verify_token().
	* security.cc (create_token): Store pgrpsid in security descriptor,
	except if it already appears in my_grps. Use sec_acl() in place
	of get_dacl()
	(verify_token): Create from code in seteuid(), with tighter checks.
	(get_dacl) Deleted.
	(get_group_sidlist): Add argument to indicate if pgrpsid is already
	in the groups.
	* autoload.cc: Load GetKernelObjectSecurity().


--=====================_1015738093==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="syscalls.cc.diff"
Content-length: 4001

--- syscalls.cc.org	Tue Feb 19 20:36:44 2002
+++ syscalls.cc	Fri Mar  8 20:22:18 2002
@@ -1929,7 +1929,7 @@
 	}
       else
 	{
-	  cygsid usersid, pgrpsid, tok_pgrpsid;
+	  cygsid usersid, pgrpsid, processsid;
 	  HANDLE sav_token =3D INVALID_HANDLE_VALUE;
 	  BOOL sav_impersonation;
 	  BOOL current_token_is_internal_token =3D FALSE;
@@ -1946,31 +1946,8 @@
 	     - if reasonable - new pgrp =3D=3D pgrp of impersonation token. */
 	  if (allow_ntsec && cygheap->user.token !=3D INVALID_HANDLE_VALUE)
 	    {
-	      if (!GetTokenInformation (cygheap->user.token, TokenUser,
-					&tok_usersid, sizeof tok_usersid, &siz))
-		{
-		  debug_printf ("GetTokenInformation(): %E");
-		  tok_usersid =3D NO_SID;
-		}
-	      if (!GetTokenInformation (cygheap->user.token, TokenPrimaryGroup,
-					&tok_pgrpsid, sizeof tok_pgrpsid, &siz))
-		{
-		  debug_printf ("GetTokenInformation(): %E");
-		  tok_pgrpsid =3D NO_SID;
-		}
-	      /* Check if the current user token was internally created. */
-	      TOKEN_SOURCE ts;
-	      if (!GetTokenInformation (cygheap->user.token, TokenSource,
-					&ts, sizeof ts, &siz))
-		debug_printf ("GetTokenInformation(): %E");
-	      else if (!memcmp (ts.SourceName, "Cygwin.1", 8))
-		current_token_is_internal_token =3D TRUE;
-	      if ((usersid && tok_usersid && usersid !=3D tok_usersid) ||
-		  /* Check for pgrp only if current token is an internal
-		     token. Otherwise the external provided token is
-		     very likely overwritten here. */
-		  (current_token_is_internal_token &&
-		   pgrpsid && tok_pgrpsid && pgrpsid !=3D tok_pgrpsid))
+	      if (!verify_token(cygheap->user.token, usersid, pgrpsid,
+				& current_token_is_internal_token))
 		{
 		  /* If not, RevertToSelf and close old token. */
 		  debug_printf ("tsid !=3D usersid");
@@ -2035,9 +2012,28 @@
 					    &pgrpsid, sizeof pgrpsid))
 		    debug_printf ("SetTokenInformation(user.token, "
 				  "TokenPrimaryGroup): %E");
-
 		}
-
+	      /* Set process def dacl to allow access to impersonated token */
+	      char dacl_buf[MAX_DACL_LEN(5)];
+	      sec_process_sid(processsid);
+	      if (usersid &&
+		  sec_acl((PACL) dacl_buf, FALSE, processsid, usersid))
+	        {
+		  HANDLE ptok;
+		  TOKEN_DEFAULT_DACL tdacl;
+		  tdacl.DefaultDacl =3D (PACL) dacl_buf;
+		  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_ADJUST_DEFAULT,
+					 &ptok))
+		    debug_printf ("OpenProcessToken(): %E\n");
+		  else
+		    {
+		      if (!SetTokenInformation (ptok, TokenDefaultDacl,
+						&tdacl, sizeof dacl_buf))
+			debug_printf ("SetTokenInformation"
+				      "(TokenDefaultDacl): %E");
+		      CloseHandle (ptok);
+		    }
+		}
 	      /* Now try to impersonate. */
 	      if (!LookupAccountSid (NULL, usersid, username, &ulen,
 				     domain, &dlen, &use))
@@ -2102,7 +2098,6 @@
 	      return -1;
 	    }
 	  myself->gid =3D gid;
-#if 0	  // Setting the primary group in token here isn't foolproof enough.
 	  if (allow_ntsec)
 	    {
 	      cygsid gsid;
@@ -2110,6 +2105,17 @@

 	      if (gsid.getfromgr (gr))
 		{
+		  /* Remove impersonation */
+		  if (cygheap->user.token !=3D INVALID_HANDLE_VALUE
+		      && cygheap->user.impersonated)
+		    {
+		      if (!SetTokenInformation (cygheap->user.token,
+						TokenPrimaryGroup,
+						&gsid, sizeof gsid))
+			debug_printf ("SetTokenInformation(primary, "
+				      "TokenPrimaryGroup): %E");
+		      RevertToSelf ();
+		    }
 		  if (!OpenProcessToken (GetCurrentProcess (),
 					 TOKEN_ADJUST_DEFAULT,
 					 &ptok))
@@ -2118,13 +2124,15 @@
 		    {
 		      if (!SetTokenInformation (ptok, TokenPrimaryGroup,
 						&gsid, sizeof gsid))
-			debug_printf ("SetTokenInformation(myself, "
+			debug_printf ("SetTokenInformation(process, "
 				      "TokenPrimaryGroup): %E");
 		      CloseHandle (ptok);
 		    }
+		  if (cygheap->user.token !=3D INVALID_HANDLE_VALUE
+		      && cygheap->user.impersonated)
+		    ImpersonateLoggedOnUser (cygheap->user.token);
 		}
 	    }
-#endif
 	}
     }
   else

--=====================_1015738093==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="fork.cc.diff"
Content-length: 801

--- fork.cc.org	Wed Feb 20 19:26:38 2002
+++ fork.cc	Thu Feb 21 10:55:34 2002
@@ -463,6 +463,7 @@
 #endif
 
   char sa_buf[1024];
+  PSECURITY_ATTRIBUTES sec_attribs = sec_user_nih (sa_buf);
   syscall_printf ("CreateProcess (%s, %s, 0, 0, 1, %x, 0, 0, %p, %p)",
 		  myself->progname, myself->progname, c_flags, &si, &pi);
   __malloc_lock (_reent_clib ());
@@ -470,8 +471,8 @@
   newheap = cygheap_setup_for_child (&ch,cygheap->fdtab.need_fixup_before ());
   rc = CreateProcess (myself->progname, /* image to run */
 		      myself->progname, /* what we send in arg0 */
-		      sec_user_nih (sa_buf),
-		      sec_user_nih (sa_buf),
+		      sec_attribs,
+		      sec_attribs,
 		      TRUE,	  /* inherit handles from parent */
 		      c_flags,
 		      NULL,	  /* environment filled in later */

--=====================_1015738093==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.cc.diff"
Content-length: 4366

477c477,478
< 		   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos)
---
> 		   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos,
> 		   BOOL * special_pgrp)
533a535
>   /* special_pgrp true if pgrpsid is not null and not in normal groups */
535c537,541
<     get_user_primary_group (wserver, user, usersid, pgrpsid);
---
>     {
>       * special_pgrp =3D FALSE;
>       get_user_primary_group (wserver, user, usersid, pgrpsid);
>     }
>   else * special_pgrp =3D TRUE;
539,540d544
<   if (!grp_list.contains (pgrpsid))
<     grp_list +=3D pgrpsid;
546a551,553
>   if (!grp_list.contains (pgrpsid))
>     grp_list +=3D pgrpsid;
>   else * special_pgrp =3D FALSE;
664,668c671,672
< #define token_acl_size (sizeof (ACL) + \
< 			2 * (sizeof (ACCESS_ALLOWED_ACE) + MAX_SID_LEN))
<
< static BOOL
< get_dacl (PACL acl, cygsid usersid, cygsidlist &grp_list)
---
> BOOL
> verify_token (HANDLE token, cygsid &usersid, cygsid &pgrpsid, BOOL * pint)
670,695c674,718
<   if (!InitializeAcl(acl, token_acl_size, ACL_REVISION))
<     {
<       __seterrno ();
<       return FALSE;
<     }
<   if (grp_list.contains (well_known_admins_sid))
<     {
<       if (!AddAccessAllowedAce(acl, ACL_REVISION, GENERIC_ALL,
< 			       well_known_admins_sid))
< 	{
< 	  __seterrno ();
< 	  return FALSE;
< 	}
<     }
<   else if (!AddAccessAllowedAce(acl, ACL_REVISION, GENERIC_ALL, usersid))
<     {
<       __seterrno ();
<       return FALSE;
<     }
<   if (!AddAccessAllowedAce(acl, ACL_REVISION, GENERIC_ALL,
< 			   well_known_system_sid))
<     {
<       __seterrno ();
<       return FALSE;
<     }
<   return TRUE;
---
>   BOOL ret =3D FALSE;
>   DWORD size;
>   cygsid tok_usersid =3D NO_SID;
>   * pint =3D FALSE;
>   /* Verify usersid */
>   if (!GetTokenInformation (token, TokenUser,
> 			    &tok_usersid, sizeof tok_usersid, &size))
>       debug_printf ("GetTokenInformation(): %E");
>   if (usersid !=3D tok_usersid) return FALSE;
>
>   /* If token is internal and the sd group is not well_known_null_sid,
> 	 it must match pgrpsid */
>   TOKEN_SOURCE ts;
>   if (!GetTokenInformation (cygheap->user.token, TokenSource,
> 			    &ts, sizeof ts, &size))
>     debug_printf ("GetTokenInformation(): %E");
>   else if (!memcmp (ts.SourceName, "Cygwin.1", 8)) {
>     char sd_buf[MAX_SID_LEN + sizeof (SECURITY_DESCRIPTOR)];
>     PSID gsid =3D NO_SID;
> 	* pint =3D TRUE;
>     if (!GetKernelObjectSecurity(token,
> 				 GROUP_SECURITY_INFORMATION,
> 				 (PSECURITY_DESCRIPTOR) sd_buf,
> 				 sizeof sd_buf,
> 				 &size))
>       debug_printf ("GetKernelObjectSecurity(): %E");
>     else if (!GetSecurityDescriptorGroup((PSECURITY_DESCRIPTOR) sd_buf,
> 					 &gsid, (BOOL *) &size))
>       debug_printf ("GetSecurityDescriptorGroup(): %E");
>     if (well_known_null_sid !=3D gsid) return pgrpsid =3D=3D gsid;
>   }
>
>   /* See if the pgrpsid is in the token groups */
>   PTOKEN_GROUPS my_grps =3D NULL;
>   if (!GetTokenInformation (token, TokenGroups, NULL, 0, &size) &&
> 	  GetLastError () !=3D ERROR_INSUFFICIENT_BUFFER)
> 	debug_printf ("GetTokenInformation(token, TokenGroups): %E\n");
>   else if (!(my_grps =3D (PTOKEN_GROUPS) malloc (size)))
> 	debug_printf ("malloc (my_grps) failed.");
>   else if (!GetTokenInformation (token, TokenGroups, my_grps,
> 								 size, &size))
> 	debug_printf ("GetTokenInformation(my_token, TokenGroups): %E\n");
>   else 	ret =3D sid_in_token_groups (my_grps, pgrpsid);
>   if (my_grps) free (my_grps);
>   return ret;
711a735,736
>   PSECURITY_ATTRIBUTES psa;
>   BOOL special_pgrp;
721c746
<   char acl_buf[token_acl_size];
---
>   char acl_buf[MAX_DACL_LEN(5)];
787c812
< 			  my_grps, auth_luid, auth_pos))
---
> 			  my_grps, auth_luid, auth_pos, &special_pgrp))
812c837,838
<   if (!get_dacl ((PACL) acl_buf, usersid, grpsids))
---
>   if (!sec_acl((PACL) acl_buf, FALSE,
> 		grpsids.contains (well_known_admins_sid)?well_known_admins_sid:usersid))
827a854,860
>   /* Set sd and primary group */
>   psa =3D sec_user (sa_buf, usersid);
>   if (!SetSecurityDescriptorGroup (
>                    (PSECURITY_DESCRIPTOR) psa->lpSecurityDescriptor,
> 		   special_pgrp?pgrpsid:well_known_null_sid, FALSE))
>     debug_printf ("SetSecurityDescriptorGroup %E");
>
829c862
<   if (!DuplicateTokenEx (token, MAXIMUM_ALLOWED, sec_user (sa_buf, usersi=
d),
---
>   if (!DuplicateTokenEx (token, MAXIMUM_ALLOWED, psa,

--=====================_1015738093==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.h.diff"
Content-length: 1267

--- security.h.org	Thu Feb 21 19:37:46 2002
+++ security.h	Fri Mar  8 12:59:46 2002
@@ -16,6 +16,8 @@
 #define DEFAULT_GID DOMAIN_ALIAS_RID_ADMINS

 #define MAX_SID_LEN 40
+#define MAX_DACL_LEN(n) (sizeof (ACL) \
+		   + (n) * (sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD) + MAX_SID_LEN))

 #define NO_SID ((PSID)NULL)

@@ -179,6 +181,8 @@
 HANDLE subauth (struct passwd *pw);
 /* Try creating a token directly. */
 HANDLE create_token (cygsid &usersid, cygsid &pgrpsid);
+/* Verify an existing token */
+BOOL verify_token (HANDLE token, cygsid &usersid, cygsid &pgrpsid, BOOL * =
pintern);

 /* Extract U-domain\user field from passwd entry. */
 void extract_nt_dom_user (const struct passwd *pw, char *domain, char *use=
r);
@@ -201,6 +205,8 @@
 extern SECURITY_ATTRIBUTES sec_none, sec_none_nih, sec_all, sec_all_nih;
 extern SECURITY_ATTRIBUTES *__stdcall __sec_user (PVOID sa_buf, PSID sid2,=
 BOOL inherit)
   __attribute__ ((regparm (3)));
+extern BOOL sec_acl (PACL acl, BOOL admins, PSID sid1 =3D NO_SID, PSID sid=
2 =3D NO_SID);
+extern void sec_process_sid(cygsid &sid);

 int __stdcall NTReadEA (const char *file, const char *attrname, char *buf,=
 int len);
 BOOL __stdcall NTWriteEA (const char *file, const char *attrname, const ch=
ar *buf, int len);

--=====================_1015738093==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shared.cc.diff"
Content-length: 3508

--- shared.cc.org	Tue Feb 19 20:36:42 2002
+++ shared.cc	Fri Mar  8 19:57:56 2002
@@ -236,6 +236,58 @@
   return null_sdp;
 }

+BOOL
+sec_acl (PACL acl, BOOL admins, PSID sid1, PSID sid2)
+{
+  size_t acl_len =3D MAX_DACL_LEN(5);
+
+  if (!InitializeAcl (acl, acl_len, ACL_REVISION))
+    {
+      debug_printf ("InitializeAcl %E");
+      return FALSE;
+    }
+  if (sid2)
+    if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			      GENERIC_ALL, sid2))
+      debug_printf ("AddAccessAllowedAce(sid2) %E");
+  if (sid1)
+    if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			      GENERIC_ALL, sid1))
+      debug_printf ("AddAccessAllowedAce(sid1) %E", sid1);
+  if (admins)
+    if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			      GENERIC_ALL, well_known_admins_sid))
+      debug_printf ("AddAccessAllowedAce(admin) %E");
+  if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			    GENERIC_ALL, well_known_system_sid))
+    debug_printf ("AddAccessAllowedAce(system) %E");
+#if 0
+  if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			    GENERIC_ALL, well_known_creator_owner_sid))
+    debug_printf ("AddAccessAllowedAce(creator_owner) %E");
+#endif
+  return TRUE;
+}
+
+void
+sec_process_sid(cygsid &sid)
+{
+  HANDLE token;
+  DWORD size;
+  sid =3D NO_SID;
+  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_QUERY, &token))
+    debug_printf ("OpenProcessToken(token_query): %E\n");
+  else
+    {
+      if (!GetTokenInformation (token, TokenUser,
+				&sid, sizeof sid, &size))
+	debug_printf ("GetTokenInformation(TokenUser): %E");
+      CloseHandle (token);
+    }
+  return;
+}
+
+
 PSECURITY_ATTRIBUTES __stdcall
 __sec_user (PVOID sa_buf, PSID sid2, BOOL inherit)
 {
@@ -246,49 +298,9 @@

   cygsid sid;

-  if (cygheap->user.sid ())
-    sid =3D cygheap->user.sid ();
-  else if (!lookup_name (getlogin (), cygheap->user.logsrv (), sid))
+  sec_process_sid(sid);
+  if (!sec_acl (acl, TRUE, sid, sid2))
     return inherit ? &sec_none : &sec_none_nih;
-
-  size_t acl_len =3D sizeof (ACL)
-		   + 4 * (sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD))
-		   + GetLengthSid (sid)
-		   + GetLengthSid (well_known_admins_sid)
-		   + GetLengthSid (well_known_system_sid)
-		   + GetLengthSid (well_known_creator_owner_sid);
-  if (sid2)
-    acl_len +=3D sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD)
-	       + GetLengthSid (sid2);
-
-  if (!InitializeAcl (acl, acl_len, ACL_REVISION))
-    debug_printf ("InitializeAcl %E");
-
-  if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			    SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			    sid))
-    debug_printf ("AddAccessAllowedAce(%s) %E", getlogin ());
-
-  if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			    SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			    well_known_admins_sid))
-    debug_printf ("AddAccessAllowedAce(admin) %E");
-
-  if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			    SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			    well_known_system_sid))
-    debug_printf ("AddAccessAllowedAce(system) %E");
-
-  if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			    SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			    well_known_creator_owner_sid))
-    debug_printf ("AddAccessAllowedAce(creator_owner) %E");
-
-  if (sid2)
-    if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			      SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			      sid2))
-      debug_printf ("AddAccessAllowedAce(sid2) %E");

   if (!InitializeSecurityDescriptor (psd, SECURITY_DESCRIPTOR_REVISION))
     debug_printf ("InitializeSecurityDescriptor %E");

--=====================_1015738093==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="spawn.cc.diff"
Content-length: 388

--- spawn.cc.org	Wed Feb 20 19:26:40 2002
+++ spawn.cc	Fri Mar  8 13:28:22 2002
@@ -663,13 +663,6 @@
 	  && cygheap->user.token != INVALID_HANDLE_VALUE)
 	RevertToSelf ();
 
-      static BOOL first_time = TRUE;
-      if (first_time)
-	{
-	  set_process_privilege (SE_RESTORE_NAME);
-	  first_time = FALSE;
-	}
-
       /* Load users registry hive. */
       load_registry_hive (sid);
 

--=====================_1015738093==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="autoload.cc.diff"
Content-length: 448

--- autoload.cc.in	Tue Feb 19 20:36:30 2002
+++ autoload.cc	Fri Mar  1 16:30:50 2002
@@ -317,6 +317,7 @@
 LoadDLLfunc (GetAce, 12, advapi32)
 LoadDLLfunc (GetFileSecurityA, 20, advapi32)
 LoadDLLfunc (GetLengthSid, 4, advapi32)
+LoadDLLfunc (GetKernelObjectSecurity, 20, advapi32)
 LoadDLLfunc (GetSecurityDescriptorDacl, 16, advapi32)
 LoadDLLfunc (GetSecurityDescriptorGroup, 12, advapi32)
 LoadDLLfunc (GetSecurityDescriptorOwner, 12, advapi32)

--=====================_1015738093==_--
