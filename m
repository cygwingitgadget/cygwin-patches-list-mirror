Return-Path: <cygwin-patches-return-2210-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13296 invoked by alias); 23 May 2002 03:55:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13260 invoked from network); 23 May 2002 03:55:24 -0000
Message-Id: <3.0.5.32.20020522235216.00800c40@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 22 May 2002 20:55:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Patches to seteuid() etc...
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1022140336==_"
X-SW-Source: 2002-q2/txt/msg00194.txt.bz2

--=====================_1022140336==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 637

Hello Corinna,

Here are the patches to seteuid etc.. discussed recently.

Pierre

2002-05-22  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (seteuid): Do not take allow_ntsec into account. 
	Attempt to use an existing or new token even when the uid
	matches orig_uid, but the gid is not in the process token. 
	Major reorganization after several incremental changes.
	(setegid): Do not take allow_ntsec into account. Minor
	reorganization after several incremental changes.
	* security.cc (create_token): Call __sec_user() instead of
	sec_user() to remove dependence on allow_ntsec. Verify that
	the returned sd is non-null.

--=====================_1022140336==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="syscalls.cc.diff"
Content-length: 16744

--- syscalls.cc.orig	2002-05-16 05:30:48.000000000 -0400
+++ syscalls.cc	2002-05-21 20:30:22.000000000 -0400
@@ -1947,274 +1947,248 @@
 extern "C" int
 seteuid (__uid16_t uid)
 {
+  if (!wincap.has_security ()) return 0;
+
+  if (uid =3D=3D ILLEGAL_UID)
+    {
+      debug_printf ("new euid =3D=3D illegal euid, nothing happens");
+      return 0;
+    }
+
   sigframe thisframe (mainthread);
-  if (wincap.has_security ())
+  DWORD ulen =3D UNLEN + 1;
+  DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
+  char orig_username[UNLEN + 1];
+  char orig_domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
+  char username[UNLEN + 1];
+  char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
+  cygsid usersid, pgrpsid;
+  HANDLE ptok, sav_token;
+  BOOL sav_impersonated, sav_token_is_internal_token;
+  BOOL process_ok, explicitly_created_token =3D FALSE;
+  struct passwd * pw_new, * pw_cur;
+  cygheap_user user;
+  PSID origpsid, psid2 =3D NO_SID;
+
+  debug_printf ("uid: %d myself->gid: %d", uid, myself->gid);
+
+  pw_new =3D getpwuid (uid);
+  if (!usersid.getfrompw (pw_new) ||
+      (!pgrpsid.getfromgr (getgrgid (myself->gid))))
     {
-      char orig_username[UNLEN + 1];
-      char orig_domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-      char username[UNLEN + 1];
-      DWORD ulen =3D UNLEN + 1;
-      char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-      DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
-      SID_NAME_USE use;
-
-      if (uid =3D=3D ILLEGAL_UID || uid =3D=3D myself->uid)
-	{
-	  debug_printf ("new euid =3D=3D current euid, nothing happens");
-	  return 0;
-	}
-      struct passwd *pw_new =3D getpwuid (uid);
-      if (!pw_new)
-	{
-	  set_errno (EINVAL);
-	  return -1;
+      set_errno (EINVAL);
+      return -1;
+    }
+  /* Save current information */
+  sav_token =3D cygheap->user.token;
+  sav_impersonated =3D cygheap->user.impersonated;
+  char *env;
+  orig_username[0] =3D orig_domain[0] =3D '\0';
+  if ((env =3D getenv ("USERNAME")))
+    strlcpy (orig_username, env, sizeof(orig_username));
+  if ((env =3D getenv ("USERDOMAIN")))
+    strlcpy (orig_domain, env, sizeof(orig_domain));
+
+  RevertToSelf();
+  if (!OpenProcessToken (GetCurrentProcess (),
+			 TOKEN_QUERY | TOKEN_ADJUST_DEFAULT, &ptok))
+    {
+      __seterrno ();
+      goto failed;
+    }
+  /* Verify if the process token is suitable.
+     Currently we do not try to differentiate between
+	 internal tokens and others */
+  process_ok =3D verify_token(ptok, usersid, pgrpsid);
+  debug_printf("Process token %sverified", process_ok?"":"not ");
+  if (process_ok)
+    {
+      if (cygheap->user.token =3D=3D INVALID_HANDLE_VALUE ||
+	  ! cygheap->user.impersonated )
+        {
+	  CloseHandle (ptok);
+	  return 0; /* No change */
 	}
+      else cygheap->user.impersonated =3D FALSE;
+    }

-      cygsid tok_usersid;
-      DWORD siz;
-
-      char *env;
-      orig_username[0] =3D orig_domain[0] =3D '\0';
-      if ((env =3D getenv ("USERNAME")))
-	strncat (orig_username, env, UNLEN + 1);
-      if ((env =3D getenv ("USERDOMAIN")))
-	strncat (orig_domain, env, INTERNET_MAX_HOST_NAME_LENGTH + 1);
-      if (uid =3D=3D cygheap->user.orig_uid)
-	{
-
-	  debug_printf ("RevertToSelf () (uid =3D=3D orig_uid, token=3D%d)",
-			cygheap->user.token);
-	  RevertToSelf ();
-	  if (cygheap->user.token !=3D INVALID_HANDLE_VALUE)
-	    cygheap->user.impersonated =3D FALSE;
-
-	  HANDLE ptok =3D INVALID_HANDLE_VALUE;
-	  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_QUERY, &ptok))
-	    debug_printf ("OpenProcessToken(): %E\n");
-	  else if (!GetTokenInformation (ptok, TokenUser, &tok_usersid,
-					 sizeof tok_usersid, &siz))
-	    debug_printf ("GetTokenInformation(): %E");
-	  else if (!LookupAccountSid (NULL, tok_usersid, username, &ulen,
-				      domain, &dlen, &use))
-	    debug_printf ("LookupAccountSid(): %E");
-	  else
-	    {
-	      setenv ("USERNAME", username, 1);
-	      setenv ("USERDOMAIN", domain, 1);
-	    }
-	  if (ptok !=3D INVALID_HANDLE_VALUE)
+  if (!process_ok && cygheap->user.token !=3D INVALID_HANDLE_VALUE)
+    {
+      /* Verify if the current tokem is suitable */
+      BOOL token_ok =3D verify_token (cygheap->user.token, usersid, pgrpsi=
d,
+				    & sav_token_is_internal_token);
+      debug_printf("Thread token %d %sverified",
+		   cygheap->user.token, token_ok?"":"not ");
+      if (token_ok)
+        {
+	  /* Return if current token is valid */
+	  if (cygheap->user.impersonated)
+	  {
 	    CloseHandle (ptok);
+	    if (!ImpersonateLoggedOnUser (cygheap->user.token))
+	      system_printf ("Impersonating in seteuid failed: %E");
+	    return 0; /* No change */
+	  }
 	}
+      else cygheap->user.token =3D INVALID_HANDLE_VALUE;
+    }
+
+  /* Set process def dacl to allow access to impersonated token */
+  char dacl_buf[MAX_DACL_LEN(5)];
+  if (usersid !=3D (origpsid =3D  cygheap->user.orig_sid())) psid2 =3D use=
rsid;
+  if (sec_acl ((PACL) dacl_buf, FALSE, origpsid, psid2))
+    {
+      TOKEN_DEFAULT_DACL tdacl;
+      tdacl.DefaultDacl =3D (PACL) dacl_buf;
+      if (!SetTokenInformation (ptok, TokenDefaultDacl,
+				&tdacl, sizeof dacl_buf))
+	debug_printf ("SetTokenInformation"
+		      "(TokenDefaultDacl): %E");
+    }
+  CloseHandle (ptok);
+
+  if (!process_ok && cygheap->user.token =3D=3D INVALID_HANDLE_VALUE)
+    {
+      /* If no impersonation token is available, try to
+	 authenticate using NtCreateToken() or subauthentication. */
+      cygheap->user.token =3D create_token (usersid, pgrpsid);
+      if (cygheap->user.token !=3D INVALID_HANDLE_VALUE)
+	explicitly_created_token =3D TRUE;
       else
-	{
-	  cygsid usersid, pgrpsid, origsid;
-	  HANDLE sav_token =3D INVALID_HANDLE_VALUE;
-	  BOOL sav_impersonation;
-	  BOOL current_token_is_internal_token =3D FALSE;
-	  BOOL explicitely_created_token =3D FALSE;
-
-	  struct __group16 *gr =3D getgrgid (myself->gid);
-	  debug_printf ("myself->gid: %d, gr: %d", myself->gid, gr);
-
-	  usersid.getfrompw (pw_new);
-	  pgrpsid.getfromgr (gr);
-
-	  /* Only when ntsec is ON! */
-	  /* Check if new user =3D=3D user of impersonation token and
-	     - if reasonable - new pgrp =3D=3D pgrp of impersonation token. */
-	  if (allow_ntsec && cygheap->user.token !=3D INVALID_HANDLE_VALUE)
-	    {
-	      if (!verify_token(cygheap->user.token, usersid, pgrpsid,
-				& current_token_is_internal_token))
-		{
-		  /* If not, RevertToSelf and close old token. */
-		  debug_printf ("tsid !=3D usersid");
-		  RevertToSelf ();
-		  sav_token =3D cygheap->user.token;
-		  sav_impersonation =3D cygheap->user.impersonated;
-		  cygheap->user.token =3D INVALID_HANDLE_VALUE;
-		  cygheap->user.impersonated =3D FALSE;
-		}
-	    }
-
-	  /* Only when ntsec is ON! */
-	  /* If no impersonation token is available, try to
-	     authenticate using NtCreateToken() or subauthentication. */
-	  if (allow_ntsec && cygheap->user.token =3D=3D INVALID_HANDLE_VALUE)
-	    {
-	      HANDLE ptok =3D INVALID_HANDLE_VALUE;
-
-	      ptok =3D create_token (usersid, pgrpsid);
-	      if (ptok !=3D INVALID_HANDLE_VALUE)
-		explicitely_created_token =3D TRUE;
-	      else
-		{
-		  /* create_token failed. Try subauthentication. */
-		  debug_printf ("create token failed, try subauthentication.");
-		  ptok =3D subauth (pw_new);
-		}
-	      if (ptok !=3D INVALID_HANDLE_VALUE)
-		{
-		  cygwin_set_impersonation_token (ptok);
-		  /* If sav_token was internally created, destroy it. */
-		  if (sav_token !=3D INVALID_HANDLE_VALUE &&
-		      current_token_is_internal_token)
-		    CloseHandle (sav_token);
-		}
-	      else if (sav_token !=3D INVALID_HANDLE_VALUE)
-		cygheap->user.token =3D sav_token;
-	    }
-	  /* If no impersonation is active but an impersonation
-	     token is available, try to impersonate. */
-	  if (cygheap->user.token !=3D INVALID_HANDLE_VALUE &&
-	      !cygheap->user.impersonated)
-	    {
-	      debug_printf ("Impersonate (uid =3D=3D %d)", uid);
-	      RevertToSelf ();
-
-	      /* If the token was explicitely created, all information has
-		 already been set correctly. */
-	      if (!explicitely_created_token)
-		{
-		  /* Try setting owner to same value as user. */
-		  if (usersid &&
-		      !SetTokenInformation (cygheap->user.token, TokenOwner,
-					    &usersid, sizeof usersid))
-		    debug_printf ("SetTokenInformation(user.token, "
-				  "TokenOwner): %E");
-		  /* Try setting primary group in token to current group
-		     if token not explicitely created. */
-		  if (pgrpsid &&
-		      !SetTokenInformation (cygheap->user.token,
-					    TokenPrimaryGroup,
-					    &pgrpsid, sizeof pgrpsid))
-		    debug_printf ("SetTokenInformation(user.token, "
-				  "TokenPrimaryGroup): %E");
-		}
-	      /* Set process def dacl to allow access to impersonated token */
-	      char dacl_buf[MAX_DACL_LEN(5)];
-	      origsid =3D cygheap->user.orig_sid ();
-	      if (usersid && origsid &&
-		  sec_acl((PACL) dacl_buf, FALSE, origsid, usersid))
-	        {
-		  HANDLE ptok =3D INVALID_HANDLE_VALUE;
-		  TOKEN_DEFAULT_DACL tdacl;
-		  tdacl.DefaultDacl =3D (PACL) dacl_buf;
-		  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_ADJUST_DEFAULT,
-					 &ptok))
-		    debug_printf ("OpenProcessToken(): %E");
-		  else
-		    {
-		      if (!SetTokenInformation (ptok, TokenDefaultDacl,
-						&tdacl, sizeof dacl_buf))
-			debug_printf ("SetTokenInformation"
-				      "(TokenDefaultDacl): %E");
-		    }
-		  if (ptok !=3D INVALID_HANDLE_VALUE) CloseHandle (ptok);
-		}
-	      /* Now try to impersonate. */
-	      if (!LookupAccountSid (NULL, usersid, username, &ulen,
-				     domain, &dlen, &use))
-		debug_printf ("LookupAccountSid (): %E");
-	      else if (!ImpersonateLoggedOnUser (cygheap->user.token))
-		system_printf ("Impersonating (%d) in set(e)uid failed: %E",
-			       cygheap->user.token);
-	      else
-		{
-		  cygheap->user.impersonated =3D TRUE;
-		  setenv ("USERNAME", username, 1);
-		  setenv ("USERDOMAIN", domain, 1);
-		}
-	    }
+        {
+	  /* create_token failed. Try subauthentication. */
+	  debug_printf ("create token failed, try subauthentication.");
+	  cygheap->user.token =3D subauth (pw_new);
+	  if (cygheap->user.token =3D=3D INVALID_HANDLE_VALUE) goto failed;
 	}
+    }

-      cygheap_user user;
-      /* user.token is used in internal_getlogin () to determine if
-	 impersonation is active. If so, the token is used for
-	 retrieving user's SID. */
-      user.token =3D cygheap->user.impersonated ? cygheap->user.token
-					      : INVALID_HANDLE_VALUE;
-      /* Unsetting these both env vars is necessary to get NetUserGetInfo()
-	 called in internal_getlogin ().  Otherwise the wrong path is used
-	 after a user switch, probably. */
-      unsetenv ("HOMEDRIVE");
-      unsetenv ("HOMEPATH");
-      struct passwd *pw_cur =3D internal_getlogin (user);
-      if (pw_cur !=3D pw_new)
-	{
-	  debug_printf ("Diffs!!! token: %d, cur: %d, new: %d, orig: %d",
-			cygheap->user.token, pw_cur->pw_uid,
-			pw_new->pw_uid, cygheap->user.orig_uid);
-	  setenv ("USERNAME", orig_username, 1);
-	  setenv ("USERDOMAIN", orig_domain, 1);
-	  set_errno (EPERM);
-	  return -1;
+  /* Lookup username and domain before impersonating,
+     LookupAccountSid() returns a different answer afterwards. */
+  SID_NAME_USE use;
+  if (!LookupAccountSid (NULL, usersid, username, &ulen,
+			 domain, &dlen, &use))
+    {
+      debug_printf ("LookupAccountSid (): %E");
+      __seterrno ();
+      goto failed;
+    }
+  /* If using the token, set info and impersonate */
+  if (! process_ok )
+    {
+      /* If the token was explicitly created, all information has
+	 already been set correctly. */
+      if (!explicitly_created_token)
+        {
+	  /* Try setting owner to same value as user. */
+	  if (!SetTokenInformation (cygheap->user.token, TokenOwner,
+				    &usersid, sizeof usersid))
+	    debug_printf ("SetTokenInformation(user.token, "
+			  "TokenOwner): %E");
+	  /* Try setting primary group in token to current group */
+	  if (!SetTokenInformation (cygheap->user.token,
+				    TokenPrimaryGroup,
+				    &pgrpsid, sizeof pgrpsid))
+	    debug_printf ("SetTokenInformation(user.token, "
+			  "TokenPrimaryGroup): %E");
+	}
+      /* Now try to impersonate. */
+      if (!ImpersonateLoggedOnUser (cygheap->user.token))
+        {
+	  debug_printf ("ImpersonateLoggedOnUser %E");
+	  __seterrno ();
+	  goto failed;
 	}
+      cygheap->user.impersonated =3D TRUE;
+    }
+
+  /* user.token is used in internal_getlogin () to determine if
+     impersonation is active. If so, the token is used for
+     retrieving user's SID. */
+  user.token =3D cygheap->user.impersonated ? cygheap->user.token
+                                          : INVALID_HANDLE_VALUE;
+  /* Unsetting these two env vars is necessary to get NetUserGetInfo()
+     called in internal_getlogin ().  Otherwise the wrong path is used
+     after a user switch, probably. */
+  unsetenv ("HOMEDRIVE");
+  unsetenv ("HOMEPATH");
+  setenv ("USERDOMAIN", domain, 1);
+  setenv ("USERNAME", username, 1);
+  pw_cur =3D internal_getlogin (user);
+  if (pw_cur =3D=3D pw_new)
+    {
+      /* If sav_token was internally created and is replaced, destroy it. =
*/
+      if (sav_token !=3D INVALID_HANDLE_VALUE &&
+	  sav_token !=3D cygheap->user.token &&
+	  sav_token_is_internal_token)
+	CloseHandle (sav_token);
       myself->uid =3D uid;
       cygheap->user =3D user;
+      return 0;
     }
-  else
-    set_errno (ENOSYS);
-  debug_printf ("real: %d, effective: %d", cygheap->user.real_uid, myself-=
>uid);
-  return 0;
+  debug_printf ("Diffs!!! token: %d, cur: %d, new: %d, orig: %d",
+		cygheap->user.token, pw_cur->pw_uid,
+		pw_new->pw_uid, cygheap->user.orig_uid);
+  set_errno (EPERM);
+
+ failed:
+  setenv ("USERNAME", orig_username, 1);
+  setenv ("USERDOMAIN", orig_domain, 1);
+  cygheap->user.token =3D sav_token;
+  cygheap->user.impersonated =3D sav_impersonated;
+  if ( cygheap->user.token !=3D INVALID_HANDLE_VALUE &&
+       cygheap->user.impersonated &&
+       !ImpersonateLoggedOnUser (cygheap->user.token))
+    system_printf ("Impersonating in seteuid failed: %E");
+  return -1;
 }

 /* setegid: from System V.  */
 extern "C" int
 setegid (__gid16_t gid)
 {
+  if ((!wincap.has_security ()) ||
+      (gid =3D=3D ILLEGAL_GID))
+    return 0;
+
   sigframe thisframe (mainthread);
-  if (wincap.has_security ())
-    {
-      if (gid !=3D ILLEGAL_GID)
-	{
-	  struct __group16 *gr;
+  cygsid gsid;
+  HANDLE ptok;

-	  if (!(gr =3D getgrgid (gid)))
-	    {
-	      set_errno (EINVAL);
-	      return -1;
-	    }
-	  myself->gid =3D gid;
-	  if (allow_ntsec)
-	    {
-	      cygsid gsid;
-	      HANDLE ptok;
-
-	      if (gsid.getfromgr (gr))
-		{
-		  /* Remove impersonation */
-		  if (cygheap->user.token !=3D INVALID_HANDLE_VALUE
-		      && cygheap->user.impersonated)
-		    {
-		      if (!SetTokenInformation (cygheap->user.token,
-						TokenPrimaryGroup,
-						&gsid, sizeof gsid))
-			debug_printf ("SetTokenInformation(primary, "
-				      "TokenPrimaryGroup): %E");
-		      RevertToSelf ();
-		    }
-		  if (!OpenProcessToken (GetCurrentProcess (),
-					 TOKEN_ADJUST_DEFAULT,
-					 &ptok))
-		    debug_printf ("OpenProcessToken(): %E\n");
-		  else
-		    {
-		      if (!SetTokenInformation (ptok, TokenPrimaryGroup,
-						&gsid, sizeof gsid))
-			debug_printf ("SetTokenInformation(process, "
-				      "TokenPrimaryGroup): %E");
-		      CloseHandle (ptok);
-		    }
-		  if (cygheap->user.token !=3D INVALID_HANDLE_VALUE
-		      && cygheap->user.impersonated)
-		    ImpersonateLoggedOnUser (cygheap->user.token);
-		}
-	    }
-	}
+  if (!(gsid.getfromgr (getgrgid (gid))))
+    {
+      set_errno (EINVAL);
+      return -1;
     }
+  myself->gid =3D gid;
+
+  /* If impersonated, update primary group and revert */
+  if (cygheap->user.token !=3D INVALID_HANDLE_VALUE
+      && cygheap->user.impersonated)
+    {
+      if (!SetTokenInformation (cygheap->user.token,
+				TokenPrimaryGroup,
+				&gsid, sizeof gsid))
+	debug_printf ("SetTokenInformation(thread, "
+		      "TokenPrimaryGroup): %E");
+      RevertToSelf ();
+    }
+  if (!OpenProcessToken (GetCurrentProcess (),
+			 TOKEN_ADJUST_DEFAULT,
+			 &ptok))
+    debug_printf ("OpenProcessToken(): %E\n");
   else
-    set_errno (ENOSYS);
+    {
+      if (!SetTokenInformation (ptok, TokenPrimaryGroup,
+				&gsid, sizeof gsid))
+	debug_printf ("SetTokenInformation(process, "
+		      "TokenPrimaryGroup): %E");
+      CloseHandle (ptok);
+    }
+  if (cygheap->user.token !=3D INVALID_HANDLE_VALUE
+      && cygheap->user.impersonated
+      && !ImpersonateLoggedOnUser (cygheap->user.token))
+    system_printf ("Impersonating in setegid failed: %E");
   return 0;
 }


--=====================_1022140336==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="security.cc.diff"
Content-length: 820

--- security.cc.orig	2002-05-21 19:34:44.000000000 -0400
+++ security.cc	2002-05-21 19:39:12.000000000 -0400
@@ -854,10 +854,11 @@
   else
     {
       /* Set security descriptor and primary group */
-      psa = sec_user (sa_buf, usersid);
-      if (!SetSecurityDescriptorGroup (
-                   (PSECURITY_DESCRIPTOR) psa->lpSecurityDescriptor,
-                   special_pgrp?pgrpsid:well_known_null_sid, FALSE))
+      psa = __sec_user (sa_buf, usersid, TRUE);
+      if (psa->lpSecurityDescriptor && 
+	  !SetSecurityDescriptorGroup (
+	      (PSECURITY_DESCRIPTOR) psa->lpSecurityDescriptor,
+	      special_pgrp?pgrpsid:well_known_null_sid, FALSE))
           debug_printf ("SetSecurityDescriptorGroup %E");
       /* Convert to primary token. */
       if (!DuplicateTokenEx (token, MAXIMUM_ALLOWED, psa,

--=====================_1022140336==_--
