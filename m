Return-Path: <cygwin-patches-return-2187-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28635 invoked by alias); 14 May 2002 03:44:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28615 invoked from network); 14 May 2002 03:44:55 -0000
Message-Id: <3.0.5.32.20020513232509.007f6350@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 13 May 2002 20:44:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Security patches
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1021361109==_"
X-SW-Source: 2002-q2/txt/msg00171.txt.bz2

--=====================_1021361109==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2321

Hello Corinna,

This is the third installment. It fixes:
1) non-cygwin child processes always get the correct primary group
2) tighter check of whether an existing token should be reused
3) impersonated tasks now have access to their own token

This brings us to the level of the patches I had sent in March.

There is another set of changes I'd like to make to address 
two issues:
1) Currently sequences such as setgid(newgid); setuid(originaluid);
or setgid(newgid); setuid(newuid); setuid(originaluid)
never create a token (newgid, originaluid) and thus the task 
isn't really in the newgid group (if newgid isn't a group that
originaluid naturally belongs to). 
2) Currently part of the seteuid() is executed on NT/2000/XP 
even when ntsec is off. This partially works, but only
for external tokens, and only when the passwd file contains 
the SIDs. Even then, the security descriptor may not give 
access to admins.

I don't know the history and motivation of this design, but
it doesn't seem that clean. I would propose instead one of 
the 3 following options:
1) when ntsec is off, setuid() succeeds while doing almost nothing.
The danger is that a privileged process will never give up
its privileges.
2) setuid() and setgid() return in error on NT if ntsec isn't set.
3) no matter ntsec, setuid() / setgid() behave basically as they do 
today when ntsec is set. They fail if the passwd file doesn't contain SIDs. 
I would vote for 3, not seeing the advantage of 2.
What's your opinion?

Pierre

2002-05-13  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (seteuid): Set default dacl in process token.
	Replace in-line code by call to verify_token().
	* security.cc (create_token): Store pgrpsid in token security
	descriptor, except if it already appears in my_grps. 
	Use sec_acl() in place of get_dacl().
	(verify_token): Create from code in seteuid(), with tighter checks.
	(get_dacl) Deleted.
	(get_group_sidlist): Add argument to indicate if pgrpsid is already
	in the groups.
	* security.h: Define verify_token().
	* autoload.cc: Load GetKernelObjectSecurity().


P.S.: it's late and I don't think straight.
seteuid() ends with
  else set_errno (ENOSYS);
  debug_printf ("real: %d, effective: %d", cygheap->user.real_uid,
myself->uid);
  return 0;
Why is ENOSYS set (on Win95) when 0 is returned?
--=====================_1021361109==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="autoload.cc.diff"
Content-length: 431

--- autoload.cc.orig	Mon May 13 18:18:16 2002
+++ autoload.cc	Mon May 13 18:24:56 2002
@@ -316,6 +316,7 @@
 LoadDLLfunc (EqualSid, 8, advapi32)
 LoadDLLfunc (GetAce, 12, advapi32)
 LoadDLLfunc (GetFileSecurityA, 20, advapi32)
+LoadDLLfunc (GetKernelObjectSecurity, 20, advapi32)
 LoadDLLfunc (GetLengthSid, 4, advapi32)
 LoadDLLfunc (GetSecurityDescriptorDacl, 16, advapi32)
 LoadDLLfunc (GetSecurityDescriptorGroup, 12, advapi32)

--=====================_1021361109==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.cc.diff"
Content-length: 6248

--- security.cc.orig	Sun May  5 10:49:32 2002
+++ security.cc	Sun May 12 10:37:40 2002
@@ -476,7 +476,8 @@
 static BOOL
 get_group_sidlist (const char *logonserver, cygsidlist &grp_list,
 		   cygsid &usersid, cygsid &pgrpsid,
-		   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos)
+		   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos,
+		   BOOL * special_pgrp)
 {
   WCHAR wserver[INTERNET_MAX_HOST_NAME_LENGTH + 1];
   char user[INTERNET_MAX_HOST_NAME_LENGTH + 1];
@@ -533,19 +534,25 @@
 	  auth_pos =3D grp_list.count - 1;
 	}
     }
+  /* special_pgrp true if pgrpsid is not null and not in normal groups */
   if (!pgrpsid)
-    get_user_primary_group (wserver, user, usersid, pgrpsid);
+    {
+      * special_pgrp =3D FALSE;
+      get_user_primary_group (wserver, user, usersid, pgrpsid);
+    }
+  else * special_pgrp =3D TRUE;
   if (!get_user_groups (wserver, grp_list, user) ||
       !get_user_local_groups (wserver, logonserver, grp_list, usersid))
     return FALSE;
-  if (!grp_list.contains (pgrpsid))
-    grp_list +=3D pgrpsid;
   if (get_supplementary_group_sidlist (user, sup_list))
     {
       for (int i =3D 0; i < sup_list.count; ++i)
 	if (!grp_list.contains (sup_list.sids[i]))
 	  grp_list +=3D sup_list.sids[i];
     }
+  if (!grp_list.contains (pgrpsid))
+    grp_list +=3D pgrpsid;
+  else * special_pgrp =3D FALSE;
   return TRUE;
 }

@@ -663,38 +670,56 @@
   return privs;
 }

-#define token_acl_size (sizeof (ACL) + \
-			2 * (sizeof (ACCESS_ALLOWED_ACE) + MAX_SID_LEN))
-
-static BOOL
-get_dacl (PACL acl, cygsid usersid, cygsidlist &grp_list)
+BOOL
+verify_token (HANDLE token, cygsid &usersid, cygsid &pgrpsid, BOOL * pinte=
rn)
 {
-  if (!InitializeAcl(acl, token_acl_size, ACL_REVISION))
-    {
-      __seterrno ();
-      return FALSE;
-    }
-  if (grp_list.contains (well_known_admins_sid))
-    {
-      if (!AddAccessAllowedAce(acl, ACL_REVISION, GENERIC_ALL,
-			       well_known_admins_sid))
-	{
-	  __seterrno ();
-	  return FALSE;
-	}
-    }
-  else if (!AddAccessAllowedAce(acl, ACL_REVISION, GENERIC_ALL, usersid))
-    {
-      __seterrno ();
-      return FALSE;
-    }
-  if (!AddAccessAllowedAce(acl, ACL_REVISION, GENERIC_ALL,
-			   well_known_system_sid))
+  DWORD size;
+  BOOL intern =3D FALSE;
+
+  if (pintern)
     {
-      __seterrno ();
-      return FALSE;
+      TOKEN_SOURCE ts;
+      if (!GetTokenInformation (cygheap->user.token, TokenSource,
+				&ts, sizeof ts, &size))
+	debug_printf ("GetTokenInformation(): %E");
+      else *pintern =3D intern =3D !memcmp (ts.SourceName, "Cygwin.1", 8);
+    }
+  /* Verify usersid */
+  cygsid tok_usersid =3D NO_SID;
+  if (!GetTokenInformation (token, TokenUser,
+			    &tok_usersid, sizeof tok_usersid, &size))
+      debug_printf ("GetTokenInformation(): %E");
+  if (usersid !=3D tok_usersid) return FALSE;
+
+  /* In an internal token, if the sd group is not well_known_null_sid,
+     it must match pgrpsid */
+  if (intern)
+    {
+       char sd_buf[MAX_SID_LEN + sizeof (SECURITY_DESCRIPTOR)];
+       PSID gsid =3D NO_SID;
+       if (!GetKernelObjectSecurity(token, GROUP_SECURITY_INFORMATION,
+				    (PSECURITY_DESCRIPTOR) sd_buf,
+				    sizeof sd_buf, &size))
+	   debug_printf ("GetKernelObjectSecurity(): %E");
+       else if (!GetSecurityDescriptorGroup((PSECURITY_DESCRIPTOR) sd_buf,
+					    &gsid, (BOOL *) &size))
+	   debug_printf ("GetSecurityDescriptorGroup(): %E");
+       if (well_known_null_sid !=3D gsid) return pgrpsid =3D=3D gsid;
     }
-  return TRUE;
+  /* See if the pgrpsid is in the token groups */
+  PTOKEN_GROUPS my_grps =3D NULL;
+  BOOL ret =3D FALSE;
+
+  if (!GetTokenInformation (token, TokenGroups, NULL, 0, &size) &&
+	  GetLastError () !=3D ERROR_INSUFFICIENT_BUFFER)
+	debug_printf ("GetTokenInformation(token, TokenGroups): %E\n");
+  else if (!(my_grps =3D (PTOKEN_GROUPS) malloc (size)))
+	debug_printf ("malloc (my_grps) failed.");
+  else if (!GetTokenInformation (token, TokenGroups, my_grps, size, &size))
+	debug_printf ("GetTokenInformation(my_token, TokenGroups): %E\n");
+  else 	ret =3D sid_in_token_groups (my_grps, pgrpsid);
+  if (my_grps) free (my_grps);
+  return ret;
 }

 HANDLE
@@ -711,6 +736,8 @@
     { sizeof sqos, SecurityImpersonation, SECURITY_STATIC_TRACKING, FALSE =
};
   OBJECT_ATTRIBUTES oa =3D
     { sizeof oa, 0, 0, 0, 0, &sqos };
+  PSECURITY_ATTRIBUTES psa;
+  BOOL special_pgrp;
   char sa_buf[1024];
   LUID auth_luid =3D SYSTEM_LUID;
   LARGE_INTEGER exp =3D { QuadPart:0x7fffffffffffffffLL  };
@@ -720,7 +747,7 @@
   PTOKEN_PRIVILEGES privs =3D NULL;
   TOKEN_OWNER owner;
   TOKEN_PRIMARY_GROUP pgrp;
-  char acl_buf[token_acl_size];
+  char acl_buf[MAX_DACL_LEN(5)];
   TOKEN_DEFAULT_DACL dacl;
   TOKEN_SOURCE source;
   TOKEN_STATISTICS stats;
@@ -786,7 +813,7 @@
   /* Create list of groups, the user is member in. */
   int auth_pos;
   if (!get_group_sidlist (logonserver, grpsids, usersid, pgrpsid,
-			  my_grps, auth_luid, auth_pos))
+			  my_grps, auth_luid, auth_pos, &special_pgrp))
     goto out;

   /* Primary group. */
@@ -811,7 +838,8 @@
     goto out;

   /* Create default dacl. */
-  if (!get_dacl ((PACL) acl_buf, usersid, grpsids))
+  if (!sec_acl((PACL) acl_buf, FALSE,
+		grpsids.contains (well_known_admins_sid)?well_known_admins_sid:usersid))
     goto out;
   dacl.DefaultDacl =3D (PACL) acl_buf;

@@ -826,11 +854,20 @@
       __seterrno ();
       debug_printf ("Loading NtCreateToken failed.");
     }
-
-  /* Convert to primary token. */
-  if (!DuplicateTokenEx (token, MAXIMUM_ALLOWED, sec_user (sa_buf, usersid=
),
-			 SecurityImpersonation, TokenPrimary, &primary_token))
-    __seterrno ();
+  else
+    {
+      /* Set security descriptor and primary group */
+      psa =3D sec_user (sa_buf, usersid);
+      if (!SetSecurityDescriptorGroup (
+                   (PSECURITY_DESCRIPTOR) psa->lpSecurityDescriptor,
+		   special_pgrp?pgrpsid:well_known_null_sid, FALSE))
+	  debug_printf ("SetSecurityDescriptorGroup %E");
+      /* Convert to primary token. */
+      if (!DuplicateTokenEx (token, MAXIMUM_ALLOWED, psa,
+			     SecurityImpersonation, TokenPrimary, &primary_token))
+	  __seterrno ();
+	  debug_printf ("DuplicateTokenEx %E");
+    }

 out:
   if (old_priv_state >=3D 0)

--=====================_1021361109==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="security.h.diff"
Content-length: 496

--- security.h.orig	Mon May 13 18:04:56 2002
+++ security.h	Fri May 10 22:01:26 2002
@@ -181,6 +181,8 @@
 HANDLE subauth (struct passwd *pw);
 /* Try creating a token directly. */
 HANDLE create_token (cygsid &usersid, cygsid &pgrpsid);
+/* Verify an existing token */
+BOOL verify_token (HANDLE token, cygsid &usersid, cygsid &pgrpsid, BOOL * pintern = NULL);
 
 /* Extract U-domain\user field from passwd entry. */
 void extract_nt_dom_user (const struct passwd *pw, char *domain, char *user);

--=====================_1021361109==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="syscalls.cc.diff"
Content-length: 4072

--- syscalls.cc.orig	Mon May 13 18:09:42 2002
+++ syscalls.cc	Mon May 13 19:30:22 2002
@@ -2007,7 +2007,7 @@
 	}
       else
 	{
-	  cygsid usersid, pgrpsid, tok_pgrpsid;
+	  cygsid usersid, pgrpsid, origsid;
 	  HANDLE sav_token =3D INVALID_HANDLE_VALUE;
 	  BOOL sav_impersonation;
 	  BOOL current_token_is_internal_token =3D FALSE;
@@ -2024,31 +2024,8 @@
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
@@ -2113,9 +2090,28 @@
 					    &pgrpsid, sizeof pgrpsid))
 		    debug_printf ("SetTokenInformation(user.token, "
 				  "TokenPrimaryGroup): %E");
-
 		}
-
+	      /* Set process def dacl to allow access to impersonated token */
+	      char dacl_buf[MAX_DACL_LEN(5)];
+	      origsid =3D cygheap->user.orig_sid ();
+	      if (usersid && origsid &&
+		  sec_acl((PACL) dacl_buf, FALSE, origsid, usersid))
+	        {
+		  HANDLE ptok =3D INVALID_HANDLE_VALUE;
+		  TOKEN_DEFAULT_DACL tdacl;
+		  tdacl.DefaultDacl =3D (PACL) dacl_buf;
+		  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_ADJUST_DEFAULT,
+					 &ptok))
+		    debug_printf ("OpenProcessToken(): %E");
+		  else
+		    {
+		      if (!SetTokenInformation (ptok, TokenDefaultDacl,
+						&tdacl, sizeof dacl_buf))
+			debug_printf ("SetTokenInformation"
+				      "(TokenDefaultDacl): %E");
+		    }
+		  if (ptok !=3D INVALID_HANDLE_VALUE) CloseHandle (ptok);
+		}
 	      /* Now try to impersonate. */
 	      if (!LookupAccountSid (NULL, usersid, username, &ulen,
 				     domain, &dlen, &use))
@@ -2180,7 +2176,6 @@
 	      return -1;
 	    }
 	  myself->gid =3D gid;
-#if 0	  // Setting the primary group in token here isn't foolproof enough.
 	  if (allow_ntsec)
 	    {
 	      cygsid gsid;
@@ -2188,6 +2183,17 @@

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
@@ -2196,13 +2202,15 @@
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

--=====================_1021361109==_--
