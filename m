From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH]: New method for implementing daemons which setuid
Date: Thu, 15 Jun 2000 06:49:00 -0000
Message-id: <3948DECA.D55BD113@vinschen.de>
X-SW-Source: 2000-q2/msg00103.html

Hi,

my new patch implements two new functions in cygwin:

- HANDLE logon_user(const struct passwd *pw, const char *password)

  Uses the given inforamtion to call LogonUser. The function
  takes all additional fields in pw->pw_gecos into account,
  the SID (S-...) as well as the U-domain\user info.
  The function returns the access token for the new user
  or INVALID_HANDLE_VALUE if it fails.

- void set_impersonation_token(const HANDLE token)

  This function sets the internal new token field to the
  value of the argument. The function itself doesn't
  impersonate the process, but that is now done by a
  later call to

	setuid(uid);

  Another call to

	setuid(previous_uid)

  resets the impersonation. This minimizes the porting effort
  for applications which care for different users, in my case
  ftpd, login, sshd.

  If it's absolute sure, that the impersonation isn't used
  anymore, the application should call

	set_impersonation_token(INVALID_HANDLE_VALUE);

Further benefits of that patch is that fork() and exec()
calls now care for a given impersonation by themselves:
A ported application doesn't need to call `sexec' anymore
to change the user context for a child process so this
additionally simplifies porting.

Without that patch:

   logon:
	~40 lines of logon code!!!

   preparations in new users context:

	if (winnt)
		ImpersonateLoggodOnUser(user_token);
	setuid(new_uid);
	...
	setuid(prev_uid);
	if (winnt)
		RevertToSelf();

   calls to exec:

	if (winnt)
		RevertToSelf();
		sexec(user_token, ...);
	else
		exec(...);

   parent cleanup:

	if (user_token != INVALID_HANDLE_VALUE)
		CloseHandle(user_token);

With that patch:

  logon:
	user_token = logon_user(pw, password);
	set_impersonation_token(user_token);

   preparations in new users context:

	setuid(new_uid);
	...
	setuid(prev_uid);

   calls to exec:

	exec(...);

   parent cleanup:

	set_impersonation_token(INVALID_HANDLE_VALUE);

I haven't yet checked in that patch because I want to get
a bit of opinions from you and (hopefully) somebody is
somewhat gutsy to try that patch!

Another problem is, that I don't know in which header file
the two new functions should be prototyped. Help!!!

Corinna

--
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.8
diff -u -p -r1.8 cygwin.din
--- cygwin.din	2000/06/08 00:55:27	1.8
+++ cygwin.din	2000/06/15 13:18:53
@@ -463,6 +463,8 @@ _logbf = logbf
 logf
 _logf = logf
 login
+logon_user
+_logon_user = logon_user
 logout
 longjmp
 _longjmp = longjmp
@@ -548,6 +550,8 @@ rand
 _rand = rand
 random
 initstate
+set_impersonation_token
+_set_impersonation_token = set_impersonation_token
 setstate
 read
 _read = read
Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.21
diff -u -p -r1.21 dcrt0.cc
--- dcrt0.cc	2000/06/08 00:55:27	1.21
+++ dcrt0.cc	2000/06/15 13:18:54
@@ -1157,10 +1157,12 @@ LoadDLLfunc (GetSidSubAuthority, 8, adva
 LoadDLLfunc (GetSidSubAuthorityCount, 4, advapi32)
 LoadDLLfunc (GetTokenInformation, 20, advapi32)
 LoadDLLfunc (GetUserNameA, 8, advapi32)
+LoadDLLfunc (ImpersonateLoggedOnUser, 4, advapi32)
 LoadDLLfunc (InitializeAcl, 12, advapi32)
 LoadDLLfunc (InitializeSecurityDescriptor, 8, advapi32)
 LoadDLLfunc (InitializeSid, 12, advapi32)
 LoadDLLfunc (IsValidSid, 4, advapi32)
+LoadDLLfunc (LogonUserA, 24, advapi32)
 LoadDLLfunc (LookupAccountNameA, 28, advapi32)
 LoadDLLfunc (LookupAccountSidA, 28, advapi32)
 LoadDLLfunc (LookupPrivilegeValueA, 12, advapi32)
@@ -1175,6 +1177,7 @@ LoadDLLfunc (RegQueryValueExA, 24, advap
 LoadDLLfunc (RegSetValueExA, 24, advapi32)
 LoadDLLfunc (RegisterEventSourceA, 8, advapi32)
 LoadDLLfunc (ReportEventA, 36, advapi32)
+LoadDLLfunc (RevertToSelf, 0, advapi32)
 LoadDLLfunc (SetKernelObjectSecurity, 12, advapi32)
 LoadDLLfunc (SetSecurityDescriptorDacl, 16, advapi32)
 LoadDLLfunc (SetSecurityDescriptorGroup, 12, advapi32)
Index: fork.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.5
diff -u -p -r1.5 fork.cc
--- fork.cc	2000/04/08 04:13:12	1.5
+++ fork.cc	2000/06/15 13:18:57
@@ -363,10 +363,19 @@ fork ()
 	  goto cleanup;
 	}
 
+      /* Remove impersonation */
+      uid_t uid;
+      if (myself->impersonated && myself->token != INVALID_HANDLE_VALUE)
+        {
+          uid = myself->uid;
+          setuid (myself->orig_uid);
+        }
+
+      char sa_buf[1024];
       rc = CreateProcessA (myself->progname, /* image to run */
 			   myself->progname, /* what we send in arg0 */
-			   &sec_none_nih,  /* process security attrs */
-			   &sec_none_nih,  /* thread security attrs */
+                           allow_ntsec ? sec_user (sa_buf) : &sec_none_nih,
+                           allow_ntsec ? sec_user (sa_buf) : &sec_none_nih,
 			   TRUE,	  /* inherit handles from parent */
 			   c_flags,
 			   NULL,	  /* environment filled in later */
@@ -384,9 +393,16 @@ fork ()
 	  ForceCloseHandle(subproc_ready);
 	  ForceCloseHandle(forker_finished);
 	  subproc_ready = forker_finished = NULL;
+          /* Restore impersonation */
+          if (myself->impersonated && myself->token != INVALID_HANDLE_VALUE)
+            setuid (uid);
 	  return -1;
 	}
 
+      /* Restore impersonation */
+      if (myself->impersonated && myself->token != INVALID_HANDLE_VALUE)
+        setuid (uid);
+
       ProtectHandle (pi.hThread);
       /* Protect the handle but name it similarly to the way it will
 	 be called in subproc handling. */
@@ -410,6 +426,9 @@ fork ()
       memcpy (child->sidbuf, myself->sidbuf, 40);
       memcpy (child->logsrv, myself->logsrv, 256);
       memcpy (child->domain, myself->domain, MAX_COMPUTERNAME_LENGTH+1);
+      child->token = myself->token;
+      child->impersonated = myself->impersonated;
+      child->orig_uid = myself->orig_uid;
       set_child_mmap_ptr (child);
 
       /* Wait for subproc to initialize itself. */
@@ -493,6 +512,16 @@ fork ()
 
       debug_printf ("self %p, pid %d, ppid %d",
 		    myself, x, myself ? myself->ppid : -1);
+
+      /* Restore the inheritance state as in parent */
+      if (myself->impersonated)
+        {
+          debug_printf ("Impersonation of child, token: %d", myself->token);
+          if (myself->token == INVALID_HANDLE_VALUE)
+            RevertToSelf (); // probably not needed
+          else if (!ImpersonateLoggedOnUser (myself->token))
+            system_printf ("Impersonate for forked child failed: %E");
+        }
 
       sync_with_parent ("after longjmp.", TRUE);
       ProtectHandle (hParent);
Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.8
diff -u -p -r1.8 security.cc
--- security.cc	2000/05/24 20:09:43	1.8
+++ security.cc	2000/06/15 13:19:02
@@ -374,6 +374,73 @@ got_it:
   return TRUE;
 }
 
+extern "C"
+void
+set_impersonation_token (const HANDLE hToken)
+{
+  debug_printf ("set_impersonation_token (%d)", hToken);
+  if (myself->token != hToken)
+    {
+      if (myself->token != INVALID_HANDLE_VALUE)
+        CloseHandle (myself->token);
+      myself->token = hToken;
+      myself->impersonated = FALSE;
+    }
+}
+
+extern "C"
+HANDLE
+logon_user (const struct passwd *pw, const char *password)
+{
+  if (os_being_run != winNT)
+    {
+      set_errno (ENOSYS);
+      return INVALID_HANDLE_VALUE;
+    }
+  if (!pw)
+    {
+      set_errno (EINVAL);
+      return INVALID_HANDLE_VALUE;
+    }
+
+  char *c, *nt_user, *nt_domain = NULL;
+  char usernamebuf[256];
+  HANDLE hToken;
+
+  strcpy (usernamebuf, pw->pw_name);
+  if (pw->pw_gecos)
+    {
+      if ((c = strstr (pw->pw_gecos, "U-")) != NULL &&
+          (c == pw->pw_gecos || c[-1] == ','))
+        {
+          usernamebuf[0] = '\0';
+          strncat (usernamebuf, c + 2, 255);
+          if ((c = strchr (usernamebuf, ',')) != NULL)
+            *c = '\0';
+        }
+    }
+  nt_user = usernamebuf;
+  if ((c = strchr (nt_user, '\\')) != NULL)
+    {
+      nt_domain = nt_user;
+      *c = '\0';
+      nt_user = c + 1;
+    }
+  if (! LogonUserA (nt_user, nt_domain, (char *) password,
+                    LOGON32_LOGON_INTERACTIVE,
+                    LOGON32_PROVIDER_DEFAULT,
+                    &hToken)
+      || !SetHandleInformation (hToken,
+                                HANDLE_FLAG_INHERIT,
+                                HANDLE_FLAG_INHERIT))
+    {
+      __seterrno ();
+      return INVALID_HANDLE_VALUE;
+    }
+  debug_printf ("%d = logon_user(%s,...)", hToken, pw->pw_name);
+  return hToken;
+}
+
 /* read_sd reads a security descriptor from a file.
    In case of error, -1 is returned and errno is set.
    If sd_buf is too small, 0 is returned and sd_size
Index: shared.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shared.h,v
retrieving revision 1.9
diff -u -p -r1.9 shared.h
--- shared.h	2000/06/08 13:24:52	1.9
+++ shared.h	2000/06/15 13:19:03
@@ -93,6 +93,12 @@ class pinfo
   char logsrv[256]; /* Logon server, may be fully qualified DNS name */
   char domain[MAX_COMPUTERNAME_LENGTH+1]; /* Logon domain of the user */
 
+  /* token is needed if sexec should be called. It can be set by a call
+     to `set_impersonation_token()'. */
+  HANDLE token;
+  BOOL impersonated;
+  uid_t orig_uid;
+
   /* Non-zero if process was stopped by a signal. */
   char stopsig;
 
Index: spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.6
diff -u -p -r1.6 spawn.cc
--- spawn.cc	2000/05/30 00:38:51	1.6
+++ spawn.cc	2000/06/15 13:19:04
@@ -503,6 +503,9 @@ skip_arg_parsing:
   /* Preallocated buffer for `sec_user' call */
   char sa_buf[1024];
 
+  if (!hToken && myself->token != INVALID_HANDLE_VALUE)
+    hToken = myself->token;
+
   if (hToken)
     {
       /* allow the child to interact with our window station/desktop */
@@ -535,6 +538,14 @@ skip_arg_parsing:
       else
         system_printf ("GetTokenInformation: %E");
 
+      /* Remove impersonation */
+      uid_t uid;
+      if (myself->impersonated && myself->token != INVALID_HANDLE_VALUE)
+        {
+          uid = myself->uid;
+          setuid (myself->orig_uid);
+        }
+
       rc = CreateProcessAsUser (hToken,
 		       real_path,	/* image name - with full path */
 		       one_line.buf,	/* what was passed to exec */
@@ -550,6 +561,9 @@ skip_arg_parsing:
 		       0,	/* use current drive/directory */
 		       &si,
 		       &pi);
+      /* Restore impersonation */
+      if (myself->impersonated && myself->token != INVALID_HANDLE_VALUE)
+        setuid (uid);
     }
   else
     rc = CreateProcessA (real_path,	/* image name - with full path */
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.28
diff -u -p -r1.28 syscalls.cc
--- syscalls.cc	2000/05/24 20:09:43	1.28
+++ syscalls.cc	2000/06/15 13:19:06
@@ -1832,11 +1832,34 @@ setuid (uid_t uid)
               return -1;
             }
 
+          if (uid != myself->uid)
+            if (uid == myself->orig_uid)
+              {
+                debug_printf ("RevertToSelf() (uid == orig_uid, token=%d)",
+                              myself->token);
+                RevertToSelf();
+                if (myself->token != INVALID_HANDLE_VALUE)
+                  myself->impersonated = FALSE;
+              }
+            else if (!myself->impersonated)
+              {
+                debug_printf ("Impersonate(uid == %d)", uid);
+                RevertToSelf();
+                if (myself->token != INVALID_HANDLE_VALUE)
+                  if (!ImpersonateLoggedOnUser (myself->token))
+                    system_printf ("Impersonate(%d) in set(e)uid failed: %E", myself->token);
+                  else
+                    myself->impersonated = TRUE;
+              }
+
           struct pinfo pi;
           pi.psid = (PSID) pi.sidbuf;
           struct passwd *pw_cur = getpwnam (internal_getlogin (&pi));
           if (pw_cur != pw_new)
             {
+              debug_printf ("Diffs!!! token: %d, cur: %d, new: %d, orig: %d",
+                            myself->token, pw_cur->pw_uid,
+                            pw_new->pw_uid, myself->orig_uid);
               set_errno (EPERM);
               return -1;
             }
Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.5
diff -u -p -r1.5 uinfo.cc
--- uinfo.cc	2000/06/01 05:57:54	1.5
+++ uinfo.cc	2000/06/15 13:19:06
@@ -126,6 +126,11 @@ uinfo_init ()
       myself->uid = DEFAULT_UID;
       myself->gid = DEFAULT_GID;
     }
+  myself->orig_uid = myself->uid;
+  /* Set to non impersonated value. */
+  myself->token = INVALID_HANDLE_VALUE;
+  myself->impersonated = TRUE;
+
 }
 
 extern "C" char *
