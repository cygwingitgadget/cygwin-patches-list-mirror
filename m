Return-Path: <cygwin-patches-return-2408-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10754 invoked by alias); 13 Jun 2002 04:43:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10740 invoked from network); 13 Jun 2002 04:43:39 -0000
Date: Wed, 12 Jun 2002 21:43:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020613044406.GA15352@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020612230833.0080d100@mail.attbi.com> <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612230833.0080d100@mail.attbi.com> <3.0.5.32.20020612233905.0080d100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020612233905.0080d100@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00391.txt.bz2


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1672

On Wed, Jun 12, 2002 at 11:39:05PM -0400, Pierre A. Humblet wrote:
>That's a good thing.  I am curious to see how.  I was hitting the fact
>that once you are impersonated LookupAccountSid won't work properly, so
>spawn_guts was the latest moment I could use it.

Btw, I don't claim to have solved any sid-related problems.  I probably
introduced some problems, in fact.  I was just trying to set up a
framework in which you or Corinna could work by introducing
(essentially) environment variable callbacks.  I was also trying to
avoid unnecessary multiple passes through the environment.

Reexamining what you did in spawn_guts, it looks like there may still be
a need to call the environment builder in two separate places.  One
before CreateProcess and one immediately before CreateProcessAsUser.
That's not happening now.

I have a first stab at a modified version of your patch below.  I tried
to keep to the letter of your patch except where I disagreed with
formatting or commenting.  The one thing missing is plugging some of the
missing environment variable info in for LOGONSERVER and USERDOMAIN.
It's too late for me to think about that.

Stupid question time: Do we *really* need to set these environment
variables?  What would break if we just didn't set them?  I can't
imagine any well-written software relying on these being set correctly.
How can you rely on something that a user could modify?  I know that
cygwin did/does in some cases, but it almost looks like it was doing it
just so that they could be passed on to subprocesses.

I wouldn't be adverse to just wiping them out in the setuid case unless
there was a really good reason not to do so.

cgf

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p
Content-length: 17736

? child_info.s
? cygcontrib
? hold1
? mount.cc
? smallprint.s
? times.cc.saf
? include/glob.h.saf
Index: cygheap.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/cygheap.cc,v
retrieving revision 1.53
diff -u -p -r1.53 cygheap.cc
--- cygheap.cc	12 Jun 2002 05:13:53 -0000	1.53
+++ cygheap.cc	13 Jun 2002 04:42:38 -0000
@@ -472,27 +472,24 @@ cygheap_user::set_domain (const char *ne
 BOOL
 cygheap_user::set_sid (PSID new_sid)
 {
-  if (!new_sid)
+  if (new_sid)
     {
+      if (!psid)
+        psid = cmalloc (HEAP_STR, MAX_SID_LEN);
       if (psid)
-	cfree (psid);
-      if (orig_psid)
-	cfree (orig_psid);
-      psid = NULL;
-      orig_psid = NULL;
-      return TRUE;
+	return CopySid (MAX_SID_LEN, psid, new_sid);
     }
-  else
+  return FALSE;
+}
+
+BOOL
+cygheap_user::set_orig_sid ()
+{
+  if (psid)
     {
-      if (!psid)
-	{
-	  if (!orig_psid)
-	    {
-	      orig_psid = cmalloc (HEAP_STR, MAX_SID_LEN);
-	      CopySid (MAX_SID_LEN, orig_psid, new_sid);
-	    }
-	  psid = cmalloc (HEAP_STR, MAX_SID_LEN);
-	}
-      return CopySid (MAX_SID_LEN, psid, new_sid);
+      if (!orig_psid) orig_psid = cmalloc (HEAP_STR, MAX_SID_LEN);
+      if (orig_psid)
+	  return CopySid (MAX_SID_LEN, orig_psid, psid);
     }
+  return FALSE;
 }
Index: cygheap.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/cygheap.h,v
retrieving revision 1.41
diff -u -p -r1.41 cygheap.h
--- cygheap.h	12 Jun 2002 05:13:54 -0000	1.41
+++ cygheap.h	13 Jun 2002 04:42:38 -0000
@@ -89,7 +89,9 @@ enum homebodies
 {
   CH_HOMEDRIVE,
   CH_HOMEPATH,
-  CH_HOME
+  CH_HOME,
+  CH_LOGSRV,
+  CH_DOMAIN
 };
 
 struct passwd;
@@ -135,6 +137,7 @@ public:
   const char *domain () const { return pdomain; }
 
   BOOL set_sid (PSID new_sid);
+  BOOL set_orig_sid ();
   PSID sid () const { return psid; }
   PSID orig_sid () const { return orig_psid; }
 
Index: dcrt0.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.129
diff -u -p -r1.129 dcrt0.cc
--- dcrt0.cc	10 Jun 2002 17:08:09 -0000	1.129
+++ dcrt0.cc	13 Jun 2002 04:42:39 -0000
@@ -608,7 +608,6 @@ dll_crt0_1 ()
 				  DUPLICATE_SAME_ACCESS | DUPLICATE_CLOSE_SOURCE))
 	      h = NULL;
 	    set_myself (mypid, h);
-	    myself->uid = spawn_info->moreinfo->uid;
 	    __argc = spawn_info->moreinfo->argc;
 	    __argv = spawn_info->moreinfo->argv;
 	    envp = spawn_info->moreinfo->envp;
@@ -623,8 +622,6 @@ dll_crt0_1 ()
 	      }
 	    if (child_proc_info->subproc_ready)
 	      ProtectHandle (child_proc_info->subproc_ready);
-	    if (myself->uid == ILLEGAL_UID)
-	      cygheap->user.set_sid (NULL);
 	    break;
 	}
     }
@@ -679,8 +676,9 @@ dll_crt0_1 ()
   /* Allocate cygheap->fdtab */
   dtable_init ();
 
-/* Initialize uid, gid. */
-  uinfo_init ();
+  /* Initialize uid, gid if necessary. */
+  if (child_proc_info == NULL || spawn_info->moreinfo->uid == ILLEGAL_UID)
+    uinfo_init ();
 
   /* Initialize signal/subprocess handling. */
   sigproc_init ();
Index: spawn.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/spawn.cc,v
retrieving revision 1.106
diff -u -p -r1.106 spawn.cc
--- spawn.cc	12 Jun 2002 05:13:54 -0000	1.106
+++ spawn.cc	13 Jun 2002 04:42:40 -0000
@@ -567,8 +567,6 @@ spawn_guts (const char * prog_arg, const
   ciresrv.moreinfo->argc = newargv.argc;
   ciresrv.moreinfo->argv = newargv;
   ciresrv.hexec_proc = hexec_proc;
-  ciresrv.moreinfo->envp = build_env (envp, envblock, ciresrv.moreinfo->envc,
-				      real_path.iscygexec ());
 
   if (mode != _P_OVERLAY ||
       !DuplicateHandle (hMainProc, myself.shared_handle (), hMainProc,
@@ -610,14 +608,14 @@ spawn_guts (const char * prog_arg, const
   char sa_buf[1024];
 
   cygbench ("spawn-guts");
+  ciresrv.mount_h = cygwin_mount_h;
+
   if (!cygheap->user.impersonated || cygheap->user.token == INVALID_HANDLE_VALUE)
     {
       PSECURITY_ATTRIBUTES sec_attribs = sec_user_nih (sa_buf);
-      ciresrv.moreinfo->uid = getuid32 ();
-      /* FIXME: This leaks a handle in the CreateProcessAsUser case since the
-	 child process doesn't know about cygwin_mount_h. */
-      ciresrv.mount_h = cygwin_mount_h;
       newheap = cygheap_setup_for_child (&ciresrv, cygheap->fdtab.need_fixup_before ());
+      ciresrv.moreinfo->envp = build_env (envp, envblock, ciresrv.moreinfo->envc,
+					  real_path.iscygexec ());
       rc = CreateProcess (runpath,	/* image name - with full path */
 			  one_line.buf,	/* what was passed to exec */
 			  sec_attribs,	/* process security attrs */
@@ -631,16 +629,9 @@ spawn_guts (const char * prog_arg, const
     }
   else
     {
-      cygsid sid;
-      DWORD ret_len;
-      if (!GetTokenInformation (cygheap->user.token, TokenUser, &sid,
-				sizeof sid, &ret_len))
-	{
-	  sid = NO_SID;
-	  system_printf ("GetTokenInformation: %E");
-	}
-      /* Retrieve security attributes before setting psid to NULL
-	 since it's value is needed by `sec_user'. */
+      PSID sid = cygheap->user.sid ();
+
+      /* Set security attributes with sid */
       PSECURITY_ATTRIBUTES sec_attribs = sec_user_nih (sa_buf, sid);
 
       RevertToSelf ();
@@ -655,7 +646,6 @@ spawn_guts (const char * prog_arg, const
       char wstname[1024];
       char dskname[1024];
 
-      ciresrv.moreinfo->uid = ILLEGAL_UID;
       hwst = GetProcessWindowStation ();
       SetUserObjectSecurity (hwst, &dsi, get_null_sd ());
       GetUserObjectInformation (hwst, UOI_NAME, wstname, 1024, &n);
@@ -667,6 +657,8 @@ spawn_guts (const char * prog_arg, const
       si.lpDesktop = wstname;
 
       newheap = cygheap_setup_for_child (&ciresrv, cygheap->fdtab.need_fixup_before ());
+      ciresrv.moreinfo->envp = build_env (envp, envblock, ciresrv.moreinfo->envc,
+					  real_path.iscygexec ());
       rc = CreateProcessAsUser (cygheap->user.token,
 		       runpath,		/* image name - with full path */
 		       one_line.buf,	/* what was passed to exec */
Index: syscalls.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/syscalls.cc,v
retrieving revision 1.202
diff -u -p -r1.202 syscalls.cc
--- syscalls.cc	11 Jun 2002 16:06:15 -0000	1.202
+++ syscalls.cc	13 Jun 2002 04:42:42 -0000
@@ -1943,8 +1943,6 @@ mkfifo (const char *_path, mode_t mode)
   return -1;
 }
 
-extern struct passwd *internal_getlogin (cygheap_user &user);
-
 /* seteuid: standards? */
 extern "C" int
 seteuid32 (__uid32_t uid)
@@ -1958,17 +1956,11 @@ seteuid32 (__uid32_t uid)
     }
 
   sigframe thisframe (mainthread);
-  DWORD ulen = UNLEN + 1;
-  DWORD dlen = INTERNET_MAX_HOST_NAME_LENGTH + 1;
-  char orig_username[UNLEN + 1];
-  char orig_domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-  char username[UNLEN + 1];
-  char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
   cygsid usersid, pgrpsid;
   HANDLE ptok, sav_token;
   BOOL sav_impersonated, sav_token_is_internal_token;
   BOOL process_ok, explicitly_created_token = FALSE;
-  struct passwd * pw_new, * pw_cur;
+  struct passwd * pw_new;
   cygheap_user user;
   PSID origpsid, psid2 = NO_SID;
 
@@ -1984,12 +1976,6 @@ seteuid32 (__uid32_t uid)
   /* Save current information */
   sav_token = cygheap->user.token;
   sav_impersonated = cygheap->user.impersonated;
-  char *env;
-  orig_username[0] = orig_domain[0] = '\0';
-  if ((env = getenv ("USERNAME")))
-    strlcpy (orig_username, env, sizeof(orig_username));
-  if ((env = getenv ("USERDOMAIN")))
-    strlcpy (orig_domain, env, sizeof(orig_domain));
 
   RevertToSelf();
   if (!OpenProcessToken (GetCurrentProcess (),
@@ -2065,16 +2051,6 @@ seteuid32 (__uid32_t uid)
 	}
     }
 
-  /* Lookup username and domain before impersonating,
-     LookupAccountSid() returns a different answer afterwards. */
-  SID_NAME_USE use;
-  if (!LookupAccountSid (NULL, usersid, username, &ulen,
-			 domain, &dlen, &use))
-    {
-      debug_printf ("LookupAccountSid (): %E");
-      __seterrno ();
-      goto failed;
-    }
   /* If using the token, set info and impersonate */
   if (!process_ok)
     {
@@ -2104,38 +2080,17 @@ seteuid32 (__uid32_t uid)
       cygheap->user.impersonated = TRUE;
     }
 
-  /* user.token is used in internal_getlogin () to determine if
-     impersonation is active. If so, the token is used for
-     retrieving user's SID. */
-  user.token = cygheap->user.impersonated ? cygheap->user.token
-					  : INVALID_HANDLE_VALUE;
-  /* Unsetting these two env vars is necessary to get NetUserGetInfo()
-     called in internal_getlogin ().  Otherwise the wrong path is used
-     after a user switch, probably. */
-  unsetenv ("HOMEDRIVE");
-  unsetenv ("HOMEPATH");
-  setenv ("USERDOMAIN", domain, 1);
-  setenv ("USERNAME", username, 1);
-  pw_cur = internal_getlogin (user);
-  if (pw_cur == pw_new)
-    {
-      /* If sav_token was internally created and is replaced, destroy it. */
-      if (sav_token != INVALID_HANDLE_VALUE &&
-	  sav_token != cygheap->user.token &&
-	  sav_token_is_internal_token)
-	CloseHandle (sav_token);
-      myself->uid = uid;
-      cygheap->user = user;
-      return 0;
-    }
-  debug_printf ("Diffs!!! token: %d, cur: %d, new: %d, orig: %d",
-		cygheap->user.token, pw_cur->pw_uid,
-		pw_new->pw_uid, cygheap->user.orig_uid);
-  set_errno (EPERM);
+  /* If sav_token was internally created and is replaced, destroy it. */
+  if (sav_token != INVALID_HANDLE_VALUE &&
+      sav_token != cygheap->user.token &&
+      sav_token_is_internal_token)
+      CloseHandle (sav_token);
+  cygheap->user.set_name (pw_new->pw_name);
+  cygheap->user.set_sid (usersid);
+  myself->uid = uid;
+  return 0;
 
  failed:
-  setenv ("USERNAME", orig_username, 1);
-  setenv ("USERDOMAIN", orig_domain, 1);
   cygheap->user.token = sav_token;
   cygheap->user.impersonated = sav_impersonated;
   if ( cygheap->user.token != INVALID_HANDLE_VALUE &&
Index: uinfo.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/uinfo.cc,v
retrieving revision 1.71
diff -u -p -r1.71 uinfo.cc
--- uinfo.cc	13 Jun 2002 03:04:50 -0000	1.71
+++ uinfo.cc	13 Jun 2002 04:42:42 -0000
@@ -27,100 +27,37 @@ details. */
 #include "cygerrno.h"
 #include "cygheap.h"
 #include "registry.h"
+#include "child_info.h"
 
-struct passwd *
+void
 internal_getlogin (cygheap_user &user)
 {
-  char buf[512];
-  char username[UNLEN + 1];
-  DWORD username_len = UNLEN + 1;
   struct passwd *pw = NULL;
 
-  if (!GetUserName (username, &username_len))
-    user.set_name (NULL);
-  else
-    user.set_name (username);
-  debug_printf ("GetUserName() = %s", user.name ());
-
   if (wincap.has_security ())
     {
-      LPWKSTA_USER_INFO_1 wui;
-      NET_API_STATUS ret;
-      char *env;
-
-      user.set_logsrv (NULL);
-      /* First trying to get logon info from environment */
-      if (!*user.name () && (env = getenv ("USERNAME")) != NULL)
-	user.set_name (env);
-      if ((env = getenv ("USERDOMAIN")) != NULL)
-	user.set_domain (env);
-      if ((env = getenv ("LOGONSERVER")) != NULL)
-	user.set_logsrv (env + 2); /* filter leading double backslashes */
-      if (user.name () && user.domain ())
-	debug_printf ("User: %s, Domain: %s, Logon Server: %s",
-		      user.name (), user.domain (), user.logsrv ());
-      else if (!(ret = NetWkstaUserGetInfo (NULL, 1, (LPBYTE *) &wui)))
-	{
-	  sys_wcstombs (buf, wui->wkui1_username, UNLEN + 1);
-	  user.set_name (buf);
-	  sys_wcstombs (buf, wui->wkui1_logon_server,
-			INTERNET_MAX_HOST_NAME_LENGTH + 1);
-	  user.set_logsrv (buf);
-	  sys_wcstombs (buf, wui->wkui1_logon_domain,
-			INTERNET_MAX_HOST_NAME_LENGTH + 1);
-	  user.set_domain (buf);
-	  NetApiBufferFree (wui);
-	}
-      if (!user.logsrv () && user.domain () &&
-          get_logon_server (user.domain (), buf, NULL))
-	user.set_logsrv (buf + 2);
-      debug_printf ("Domain: %s, Logon Server: %s, Windows Username: %s",
-		    user.domain (), user.logsrv (), user.name ());
-
-
-      HANDLE ptok = user.token; /* Which is INVALID_HANDLE_VALUE if no
-				   impersonation took place. */
+      HANDLE ptok = INVALID_HANDLE_VALUE;
       DWORD siz;
       cygsid tu;
-      ret = 0;
+      DWORD ret = 0;
 
-      /* Try to get the SID either from already impersonated token
-	 or from current process first. To differ that two cases is
-	 important, because you can't rely on the user information
-	 in a process token of a currently impersonated process. */
-      if (ptok == INVALID_HANDLE_VALUE
-	  && !OpenProcessToken (GetCurrentProcess (),
-				TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
-				&ptok))
-	debug_printf ("OpenProcessToken(): %E\n");
+      /* Try to get the SID either from current process and
+	 store it in user.psid */
+      if (!OpenProcessToken (GetCurrentProcess (),
+			     TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
+			     &ptok))
+	system_printf ("OpenProcessToken(): %E\n");
       else if (!GetTokenInformation (ptok, TokenUser, &tu, sizeof tu, &siz))
-	debug_printf ("GetTokenInformation(): %E");
+	system_printf ("GetTokenInformation(): %E");
       else if (!(ret = user.set_sid (tu)))
-	debug_printf ("Couldn't retrieve SID from access token!");
-      /* If that failes, try to get the SID from localhost. This can only
-	 be done if a domain is given because there's a chance that a local
-	 and a domain user may have the same name. */
-      if (!ret && user.domain ())
-	{
-	  char domain[DNLEN + 1];
-	  DWORD dlen = sizeof (domain);
-	  siz = sizeof (tu);
-	  SID_NAME_USE use = SidTypeInvalid;
-	  /* Concat DOMAIN\USERNAME for the next lookup */
-	  strcat (strcat (strcpy (buf, user.domain ()), "\\"), user.name ());
-          if (!LookupAccountName (NULL, buf, tu, &siz,
-	                          domain, &dlen, &use) ||
-               !legal_sid_type (use))
-	        debug_printf ("Couldn't retrieve SID locally!");
-	  else user.set_sid (tu);
-
-	}
-
-      /* If we have a SID, try to get the corresponding Cygwin user name
-	 which can be different from the Windows user name. */
-      cygsid gsid (NO_SID);
-      if (ret)
-	{
+        system_printf ("Couldn't retrieve SID from access token!");
+       /* We must set the user name, uid and gid.
+	 If we have a SID, try to get the corresponding Cygwin
+	 password entry. Set user name which can be different
+	 from the Windows user name */
+       if (ret)
+	 {
+	  cygsid gsid (NO_SID);
 	  cygsid psid;
 
 	  for (int pidx = 0; (pw = internal_getpwent (pidx)); ++pidx)
@@ -133,72 +70,51 @@ internal_getlogin (cygheap_user &user)
 		      gsid = NO_SID;
 		break;
 	      }
-	}
 
-      /* If this process is started from a non Cygwin process,
-	 set token owner to the same value as token user and
-	 primary group to the group which is set as primary group
-	 in /etc/passwd. */
-      if (ptok != INVALID_HANDLE_VALUE && !myself->ppid_handle)
-	{
+	  /* Set token owner to the same value as token user and
+	     primary group to the group in /etc/passwd. */
 	  if (!SetTokenInformation (ptok, TokenOwner, &tu, sizeof tu))
 	    debug_printf ("SetTokenInformation(TokenOwner): %E");
 	  if (gsid && !SetTokenInformation (ptok, TokenPrimaryGroup,
 					    &gsid, sizeof gsid))
 	    debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
-	}
+	 }
 
-      /* Close token only if it's a result from OpenProcessToken(). */
-      if (ptok != INVALID_HANDLE_VALUE
-	  && user.token == INVALID_HANDLE_VALUE)
+      if (ptok != INVALID_HANDLE_VALUE)
 	CloseHandle (ptok);
     }
 
-  debug_printf ("Cygwins Username: %s", user.name ());
-
   if (!pw)
     pw = getpwnam (user.name ());
 
-  if (!myself->ppid_handle)
-    (void) cygheap->user.ontherange (CH_HOME, pw);
+  if (pw)
+    {
+      user.real_uid = pw->pw_uid;
+      user.real_gid = pw->pw_gid;
+    }
+  else
+    {
+      user.real_uid = DEFAULT_UID;
+      user.real_gid = DEFAULT_GID;
+    }
+
+  (void) cygheap->user.ontherange (CH_HOME, pw);
 
-  return pw;
+  return;
 }
 
 void
 uinfo_init ()
 {
-  struct passwd *p;
+  if (!child_proc_info)
+    internal_getlogin (cygheap->user); /* Set the cygheap->user. */
+
+  /* Real and effective uid/gid are identical on process start up. */
+  myself->uid = cygheap->user.orig_uid = cygheap->user.real_uid;
+  myself->gid = cygheap->user.orig_gid = cygheap->user.real_gid;
+  cygheap->user.set_orig_sid();      /* Update the original sid */
 
-  /* Initialize to non impersonated values.
-     Setting `impersonated' to TRUE seems to be wrong but it
-     isn't. Impersonated is thought as "Current User and `token'
-     are coincident". See seteuid() for the mechanism behind that. */
-  if (cygheap->user.token != INVALID_HANDLE_VALUE && cygheap->user.token != NULL)
-    CloseHandle (cygheap->user.token);
-  cygheap->user.token = INVALID_HANDLE_VALUE;
-  cygheap->user.impersonated = TRUE;
-
-  /* If uid is ILLEGAL_UID, the process is started from a non cygwin
-     process or the user context was changed in spawn.cc */
-  if (myself->uid == ILLEGAL_UID)
-    if ((p = internal_getlogin (cygheap->user)) != NULL)
-      {
-	myself->uid = p->pw_uid;
-	/* Set primary group only if process has been started from a
-	   non cygwin process. */
-	if (!myself->ppid_handle)
-	  myself->gid = p->pw_gid;
-      }
-    else
-      {
-	myself->uid = DEFAULT_UID;
-	myself->gid = DEFAULT_GID;
-      }
-  /* Real and effective uid/gid are always identical on process start up.
-     This is at least true for NT/W2K. */
-  cygheap->user.orig_uid = cygheap->user.real_uid = myself->uid;
-  cygheap->user.orig_gid = cygheap->user.real_gid = myself->gid;
+  cygheap->user.token = INVALID_HANDLE_VALUE; /* No token present */
 }
 
 extern "C" char *

--ZPt4rx8FFjLCG7dd--
