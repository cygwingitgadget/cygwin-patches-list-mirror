Return-Path: <cygwin-patches-return-3947-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25924 invoked by alias); 12 Jun 2003 03:17:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25788 invoked from network); 12 Jun 2003 03:17:53 -0000
Message-Id: <3.0.5.32.20030611230336.00807a30@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Thu, 12 Jun 2003 03:17:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Problems on accessing Windows network resources
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1055401416==_"
X-SW-Source: 2003-q2/txt/msg00174.txt.bz2

--=====================_1055401416==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2010

Corinna, 

Here is the patch to preserve the external token.

After mulling over the issue, I settled on a solution
close to what I had initially in mind, i.e. separate
external and internal tokens. It always behaves as
expected, we don't have to assume anything about what
the application expects in the cases where the orig_uid 
matches the impersonated uid and only the group(s) 
differ(s).

It also handles a case that had bothered me: daemon
starts, setgroups(0, NULL), and setuid, thus possibly
creating an internal token [ exim does this ]. 
User logs in, daemon calls cygwin_set_impersonation_token() 
and wipes out its own token... [ exim doesn't do that :) ]

You will see that cygwin_set_impersonation_token() should
now return a success/failure indication, instead of void.
That's not done yet, waiting for your opinion.

Pierre

2003-06-12  Pierre Humblet  <pierre.humblet@ieee.org>

	* cygheap.h (enum impersonation): New enum.
	(cygheap_user::token): Delete.
	(cygheap_user::impersonated): Delete.
	(cygheap_user::external_token): New member.
	(cygheap_user::internal_token): New member.
	(cygheap_user::impersonation_state): New member.
	(cygheap_user::issetuid): Modify.
	(cygheap_user::token): New method.
	(cygheap_user::deimpersonate): New method.
	(cygheap_user::reimpersonate): New method.
	(cygheap_user::has_impersonation_tokens): New method.
	(cygheap_user::close_impersonation_tokens): New method.
	* dtable.cc (dtable::vfork_child_dup): Use new cygheap_user methods.
	* fhandler_socket.cc (fhandler_socket::dup): Ditto.
	* fork.cc (fork_child): Ditto.
	(fork_parent): Ditto.
	* grp.cc (internal_getgroups): Ditto.
	* security.cc (verify_token): Ditto.
	(check_file_access): Ditto.
	(cygwin_set_impersonation_token): Detect conflicts. Set 
	user.external_token. 
	* spawn.cc (spawn_guts): Use new cygheap_user methods. 
	* syscalls.cc (seteuid32): Rearrange to use the two tokens
	in cygheap_user.
	(setegid32): Use new cygheap_user methods.
	* uinfo.cc: (internal_getlogin): Ditto. 

--=====================_1055401416==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.diff"
Content-length: 20225

Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.57
diff -u -p -r1.57 cygheap.h
--- cygheap.h	17 Jan 2003 05:18:29 -0000	1.57
+++ cygheap.h	12 Jun 2003 02:44:33 -0000
@@ -92,7 +92,13 @@ enum homebodies
   CH_HOME
 };

-struct passwd;
+enum impersonation
+{
+  IMP_BAD =3D -1,
+  IMP_NONE =3D 0,
+  IMP_EXTERNAL,
+  IMP_INTERNAL
+};

 class cygheap_user
 {
@@ -117,8 +123,9 @@ public:

   /* token is needed if set(e)uid should be called. It can be set by a call
      to `set_impersonation_token()'. */
-  HANDLE token;
-  BOOL   impersonated;
+  HANDLE external_token;
+  HANDLE internal_token;
+  enum impersonation impersonation_state;

   /* CGF 2002-06-27.  I removed the initializaton from this constructor
      since this class is always allocated statically.  That means that eve=
rything
@@ -165,7 +172,40 @@ public:
   const char *ontherange (homebodies what, struct passwd * =3D NULL);
   bool issetuid () const
   {
-    return impersonated && token !=3D INVALID_HANDLE_VALUE;
+    return impersonation_state > IMP_NONE;
+  }
+  HANDLE token ()
+  {
+    if (impersonation_state =3D=3D IMP_EXTERNAL)
+      return external_token;
+    if (impersonation_state =3D=3D IMP_INTERNAL)
+      return internal_token;
+    return INVALID_HANDLE_VALUE;
+  }
+  void deimpersonate ()
+  {
+    if (impersonation_state > IMP_NONE)
+      RevertToSelf ();
+  }
+  void reimpersonate ()
+  {
+    if (impersonation_state > IMP_NONE
+	&& !ImpersonateLoggedOnUser (token ()))
+      system_printf ("ImpersonateLoggedOnUser: %E");
+  }
+  bool has_impersonation_tokens () { return external_token || internal_tok=
en; }
+  void close_impersonation_tokens ()
+  {
+    if (external_token)
+      {
+	CloseHandle (external_token);
+	external_token =3D 0;
+      }
+    if (internal_token)
+      {
+	CloseHandle (internal_token);
+	internal_token =3D 0;
+      }
   }
   const char *cygheap_user::test_uid (char *&, const char *, size_t)
     __attribute__ ((regparm (3)));
Index: dtable.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.111
diff -u -p -r1.111 dtable.cc
--- dtable.cc	2 Mar 2003 18:37:17 -0000	1.111
+++ dtable.cc	12 Jun 2003 02:44:35 -0000
@@ -635,8 +635,7 @@ dtable::vfork_child_dup ()
   int res =3D 1;

   /* Remove impersonation */
-  if (cygheap->user.issetuid ())
-    RevertToSelf ();
+  cygheap->user.deimpersonate ();

   for (size_t i =3D 0; i < size; i++)
     if (not_open (i))
@@ -655,8 +654,7 @@ dtable::vfork_child_dup ()

 out:
   /* Restore impersonation */
-  if (cygheap->user.issetuid ())
-    ImpersonateLoggedOnUser (cygheap->user.token);
+  cygheap->user.reimpersonate ();

   ReleaseResourceLock (LOCK_FD_LIST, WRITE_LOCK | READ_LOCK, "dup");
   return 1;
Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.104
diff -u -p -r1.104 fhandler_socket.cc
--- fhandler_socket.cc	7 Jun 2003 11:05:35 -0000	1.104
+++ fhandler_socket.cc	12 Jun 2003 02:44:37 -0000
@@ -331,12 +331,10 @@ fhandler_socket::dup (fhandler_base *chi
 	 If WSADuplicateSocket() still fails for some reason, we fall back
 	 to DuplicateHandle(). */
       WSASetLastError (0);
-      if (cygheap->user.issetuid ())
-	RevertToSelf ();
+      cygheap->user.deimpersonate ();
       fhs->set_io_handle (get_io_handle ());
       fhs->fixup_before_fork_exec (GetCurrentProcessId ());
-      if (cygheap->user.issetuid ())
-	ImpersonateLoggedOnUser (cygheap->user.token);
+      cygheap->user.reimpersonate ();
       if (!WSAGetLastError ())
 	{
 	  fhs->fixup_after_fork (hMainProc);
Index: fork.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.107
diff -u -p -r1.107 fork.cc
--- fork.cc	24 Apr 2003 01:57:07 -0000	1.107
+++ fork.cc	12 Jun 2003 02:44:38 -0000
@@ -237,14 +237,7 @@ fork_child (HANDLE& hParent, dll *&first

   /* Restore the inheritance state as in parent
      Don't call setuid here! The flags are already set. */
-  if (cygheap->user.impersonated)
-    {
-      debug_printf ("Impersonation of child, token: %d", cygheap->user.tok=
en);
-      if (cygheap->user.token =3D=3D INVALID_HANDLE_VALUE)
-	RevertToSelf (); // probably not needed
-      else if (!ImpersonateLoggedOnUser (cygheap->user.token))
-	system_printf ("Impersonate for forked child failed: %E");
-    }
+  cygheap->user.reimpersonate ();

   sync_with_parent ("after longjmp.", TRUE);
   sigproc_printf ("hParent %p, child 1 first_dll %p, load_dlls %d", hParen=
t,
@@ -437,8 +430,7 @@ fork_parent (HANDLE& hParent, dll *&firs
   si.cbReserved2 =3D sizeof (ch);

   /* Remove impersonation */
-  if (cygheap->user.issetuid ())
-    RevertToSelf ();
+  cygheap->user.deimpersonate ();

   ch.parent =3D hParent;
 #ifdef DEBUGGING
@@ -486,8 +478,7 @@ fork_parent (HANDLE& hParent, dll *&firs
       ForceCloseHandle (subproc_ready);
       ForceCloseHandle (forker_finished);
       /* Restore impersonation */
-      if (cygheap->user.issetuid ())
-	ImpersonateLoggedOnUser (cygheap->user.token);
+      cygheap->user.reimpersonate ();
       cygheap_setup_for_child_cleanup (newheap, &ch, 0);
       return -1;
     }
@@ -514,8 +505,7 @@ fork_parent (HANDLE& hParent, dll *&firs
   strcpy (forked->progname, myself->progname);

   /* Restore impersonation */
-  if (cygheap->user.issetuid ())
-    ImpersonateLoggedOnUser (cygheap->user.token);
+  cygheap->user.reimpersonate ();

   ProtectHandle (pi.hThread);
   /* Protect the handle but name it similarly to the way it will
Index: grp.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.79
diff -u -p -r1.79 grp.cc
--- grp.cc	17 Apr 2003 20:05:15 -0000	1.79
+++ grp.cc	12 Jun 2003 02:44:39 -0000
@@ -262,7 +262,7 @@ internal_getgroups (int gidsetsize, __gi
     {
       /* If impersonated, use impersonation token. */
       if (cygheap->user.issetuid ())
-	hToken =3D cygheap->user.token;
+	hToken =3D cygheap->user.token ();
       else if (!OpenProcessToken (hMainProc, TOKEN_QUERY, &hToken))
 	hToken =3D NULL;
     }
@@ -296,7 +296,7 @@ internal_getgroups (int gidsetsize, __gi
 			  ++cnt;
 			  if (gidsetsize && cnt > gidsetsize)
 			    {
-			      if (hToken !=3D cygheap->user.token)
+			      if (!cygheap->user.issetuid ())
 				CloseHandle (hToken);
 			      goto error;
 			    }
@@ -306,7 +306,7 @@ internal_getgroups (int gidsetsize, __gi
 	}
       else
 	debug_printf ("%d =3D GetTokenInformation(NULL) %E", size);
-      if (hToken !=3D cygheap->user.token)
+      if (!cygheap->user.issetuid ())
 	CloseHandle (hToken);
       return cnt;
     }
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.144
diff -u -p -r1.144 security.cc
--- security.cc	11 Apr 2003 09:38:07 -0000	1.144
+++ security.cc	12 Jun 2003 02:44:46 -0000
@@ -71,10 +71,16 @@ extern "C" void
 cygwin_set_impersonation_token (const HANDLE hToken)
 {
   debug_printf ("set_impersonation_token (%d)", hToken);
-  if (cygheap->user.token !=3D hToken)
+  if (cygheap->user.impersonation_state =3D=3D IMP_EXTERNAL
+      && cygheap->user.external_token !=3D hToken)
     {
-      cygheap->user.token =3D hToken;
-      cygheap->user.impersonated =3D FALSE;
+      set_errno (EPERM);
+      return;
+    }
+  else
+    {
+      cygheap->user.external_token =3D hToken;
+      return;
     }
 }

@@ -718,7 +724,7 @@ verify_token (HANDLE token, cygsid &user
   if (pintern)
     {
       TOKEN_SOURCE ts;
-      if (!GetTokenInformation (cygheap->user.token, TokenSource,
+      if (!GetTokenInformation (token, TokenSource,
 				&ts, sizeof ts, &size))
 	debug_printf ("GetTokenInformation(): %E");
       else
@@ -1907,7 +1913,7 @@ check_file_access (const char *fn, int f
     goto done;

   if (cygheap->user.issetuid ())
-    hToken =3D cygheap->user.token;
+    hToken =3D cygheap->user.token ();
   else if (!OpenProcessToken (hMainProc, TOKEN_DUPLICATE, &hToken))
     {
       __seterrno ();
@@ -1915,7 +1921,7 @@ check_file_access (const char *fn, int f
     }
   if (!(status =3D DuplicateToken (hToken, SecurityIdentification, &hIToke=
n)))
     __seterrno ();
-  if (hToken !=3D cygheap->user.token)
+  if (!cygheap->user.issetuid ())
     CloseHandle (hToken);
   if (!status)
     goto done;
Index: spawn.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.123
diff -u -p -r1.123 spawn.cc
--- spawn.cc	9 Jun 2003 13:29:12 -0000	1.123
+++ spawn.cc	12 Jun 2003 02:44:48 -0000
@@ -622,8 +622,7 @@ spawn_guts (const char * prog_arg, const
   cygbench ("spawn-guts");

   cygheap->fdtab.set_file_pointers_for_exec ();
-  if (cygheap->user.issetuid ())
-    RevertToSelf ();
+  cygheap->user.deimpersonate ();
   /* When ruid !=3D euid we create the new process under the current origi=
nal
      account and impersonate in child, this way maintaining the different
      effective vs. real ids.
@@ -679,7 +678,7 @@ spawn_guts (const char * prog_arg, const
       ciresrv.moreinfo->envp =3D build_env (envp, envblock, ciresrv.morein=
fo->envc,
 					  real_path.iscygexec ());
       newheap =3D cygheap_setup_for_child (&ciresrv, cygheap->fdtab.need_f=
ixup_before ());
-      rc =3D CreateProcessAsUser (cygheap->user.token,
+      rc =3D CreateProcessAsUser (cygheap->user.token (),
 		       runpath,		/* image name - with full path */
 		       one_line.buf,	/* what was passed to exec */
 		       sec_attribs,     /* process security attrs */
@@ -693,8 +692,8 @@ spawn_guts (const char * prog_arg, const
     }
   /* Restore impersonation. In case of _P_OVERLAY this isn't
      allowed since it would overwrite child data. */
-  if (mode !=3D _P_OVERLAY && cygheap->user.issetuid ())
-    ImpersonateLoggedOnUser (cygheap->user.token);
+  if (mode !=3D _P_OVERLAY)
+      cygheap->user.reimpersonate ();

   MALLOC_CHECK;
   if (envblock)
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.271
diff -u -p -r1.271 syscalls.cc
--- syscalls.cc	26 May 2003 16:52:58 -0000	1.271
+++ syscalls.cc	12 Jun 2003 02:44:52 -0000
@@ -2058,66 +2058,52 @@ seteuid32 (__uid32_t uid)
   sigframe thisframe (mainthread);
   cygsid usersid;
   user_groups &groups =3D cygheap->user.groups;
-  HANDLE ptok, sav_token;
-  BOOL sav_impersonated, sav_token_is_internal_token;
-  BOOL process_ok, explicitly_created_token =3D FALSE;
+  HANDLE ptok, new_token =3D INVALID_HANDLE_VALUE;
   struct passwd * pw_new;
   PSID origpsid, psid2 =3D NO_SID;
+  enum impersonation new_state =3D IMP_BAD;
+  BOOL token_is_internal;

   pw_new =3D internal_getpwuid (uid);
   if (!wincap.has_security () && pw_new)
-    goto success;
+    goto success_9x;
   if (!usersid.getfrompw (pw_new))
     {
       set_errno (EINVAL);
       return -1;
     }
-  /* Save current information */
-  sav_token =3D cygheap->user.token;
-  sav_impersonated =3D cygheap->user.impersonated;

   RevertToSelf ();
   if (!OpenProcessToken (hMainProc, TOKEN_QUERY | TOKEN_ADJUST_DEFAULT, &p=
tok))
     {
       __seterrno ();
-      goto failed;
-    }
-  /* Verify if the process token is suitable.
-     Currently we do not try to differentiate between
-	 internal tokens and others */
-  process_ok =3D verify_token (ptok, usersid, groups);
-  debug_printf ("Process token %sverified", process_ok ? "" : "not ");
-  if (process_ok)
-    {
-      if (cygheap->user.issetuid ())
-	cygheap->user.impersonated =3D FALSE;
-      else
-	{
-	  CloseHandle (ptok);
-	  goto success; /* No change */
-	}
+      goto failed_ptok;;
     }

-  if (!process_ok && cygheap->user.token !=3D INVALID_HANDLE_VALUE)
+  /* Verify if the process token is suitable. */
+  if (verify_token (ptok, usersid, groups))
+    new_state =3D IMP_NONE;
+  /* Verify if a current token is suitable */
+  else if (cygheap->user.external_token
+	   && verify_token (cygheap->user.external_token, usersid, groups))
     {
-      /* Verify if the current tokem is suitable */
-      BOOL token_ok =3D verify_token (cygheap->user.token, usersid, groups,
-				    &sav_token_is_internal_token);
-      debug_printf ("Thread token %d %sverified",
-		   cygheap->user.token, token_ok?"":"not ");
-      if (!token_ok)
-	cygheap->user.token =3D INVALID_HANDLE_VALUE;
-      else
-	{
-	  /* Return if current token is valid */
-	  if (cygheap->user.impersonated)
-	    {
-	      CloseHandle (ptok);
-	      if (!ImpersonateLoggedOnUser (cygheap->user.token))
-		system_printf ("Impersonating in seteuid failed: %E");
-	      goto success; /* No change */
-	    }
-	}
+      new_token =3D cygheap->user.external_token;
+      new_state =3D IMP_EXTERNAL;
+    }
+  else if (cygheap->user.internal_token
+	   && verify_token (cygheap->user.internal_token, usersid, groups,
+			    &token_is_internal))
+    {
+      new_token =3D cygheap->user.internal_token;
+      new_state =3D IMP_INTERNAL;
+    }
+
+  debug_printf ("New token %d, state %d", new_token, new_state);
+  /* Return if current token is valid */
+  if (cygheap->user.impersonation_state =3D=3D new_state)
+    {
+      cygheap->user.reimpersonate ();
+      goto success; /* No change */
     }

   /* Set process def dacl to allow access to impersonated token */
@@ -2133,72 +2119,72 @@ seteuid32 (__uid32_t uid)
 	debug_printf ("SetTokenInformation"
 		      "(TokenDefaultDacl): %E");
     }
-  CloseHandle (ptok);

-  if (!process_ok && cygheap->user.token =3D=3D INVALID_HANDLE_VALUE)
+  if (new_state =3D=3D IMP_BAD)
     {
       /* If no impersonation token is available, try to
 	 authenticate using NtCreateToken () or subauthentication. */
-      cygheap->user.token =3D create_token (usersid, groups, pw_new);
-      if (cygheap->user.token !=3D INVALID_HANDLE_VALUE)
-	explicitly_created_token =3D TRUE;
-      else
+      new_token =3D create_token (usersid, groups, pw_new);
+      if (new_token =3D=3D INVALID_HANDLE_VALUE)
 	{
 	  /* create_token failed. Try subauthentication. */
 	  debug_printf ("create token failed, try subauthentication.");
-	  cygheap->user.token =3D subauth (pw_new);
-	  if (cygheap->user.token =3D=3D INVALID_HANDLE_VALUE)
+	  new_token =3D subauth (pw_new);
+	  if (new_token =3D=3D INVALID_HANDLE_VALUE)
 	    goto failed;
 	}
+      new_state =3D IMP_INTERNAL;
     }

   /* If using the token, set info and impersonate */
-  if (!process_ok)
+  if (new_state !=3D IMP_NONE)
     {
       /* If the token was explicitly created, all information has
 	 already been set correctly. */
-      if (!explicitly_created_token)
+      if (new_state =3D=3D IMP_EXTERNAL)
 	{
 	  /* Try setting owner to same value as user. */
-	  if (!SetTokenInformation (cygheap->user.token, TokenOwner,
+	  if (!SetTokenInformation (new_token, TokenOwner,
 				    &usersid, sizeof usersid))
 	    debug_printf ("SetTokenInformation(user.token, "
 			  "TokenOwner): %E");
 	  /* Try setting primary group in token to current group */
-	  if (!SetTokenInformation (cygheap->user.token,
+	  if (!SetTokenInformation (new_token,
 				    TokenPrimaryGroup,
 				    &groups.pgsid, sizeof (cygsid)))
 	    debug_printf ("SetTokenInformation(user.token, "
 			  "TokenPrimaryGroup): %E");
 	}
-      /* Now try to impersonate. */
-      if (!ImpersonateLoggedOnUser (cygheap->user.token))
+      /* Try to impersonate. */
+      if (!ImpersonateLoggedOnUser (new_token))
 	{
 	  debug_printf ("ImpersonateLoggedOnUser %E");
 	  __seterrno ();
 	  goto failed;
 	}
-      cygheap->user.impersonated =3D TRUE;
+      /* Keep at most one internal token */
+      if (new_state =3D=3D IMP_INTERNAL)
+        {
+	  if (cygheap->user.internal_token)
+	    CloseHandle (cygheap->user.internal_token);
+	  cygheap->user.internal_token =3D new_token;
+	}
     }
-
-  /* If sav_token was internally created and is replaced, destroy it. */
-  if (sav_token !=3D INVALID_HANDLE_VALUE &&
-      sav_token !=3D cygheap->user.token &&
-      sav_token_is_internal_token)
-      CloseHandle (sav_token);
   cygheap->user.set_sid (usersid);
+
 success:
+  CloseHandle (ptok);
+  cygheap->user.impersonation_state =3D new_state;
+success_9x:
   cygheap->user.set_name (pw_new->pw_name);
   myself->uid =3D uid;
   groups.ischanged =3D FALSE;
   return 0;

 failed:
-  cygheap->user.token =3D sav_token;
-  cygheap->user.impersonated =3D sav_impersonated;
-  if (cygheap->user.issetuid ()
-      && !ImpersonateLoggedOnUser (cygheap->user.token))
-    system_printf ("Impersonating in seteuid failed: %E");
+  CloseHandle (ptok);
+failed_ptok:
+  cygheap->user.reimpersonate ();
   return -1;
 }

@@ -2279,7 +2265,7 @@ setegid32 (__gid32_t gid)
   /* If impersonated, update primary group and revert */
   if (cygheap->user.issetuid ())
     {
-      if (!SetTokenInformation (cygheap->user.token,
+      if (!SetTokenInformation (cygheap->user.token (),
 				TokenPrimaryGroup,
 				&gsid, sizeof gsid))
 	debug_printf ("SetTokenInformation(thread, "
@@ -2297,7 +2283,7 @@ setegid32 (__gid32_t gid)
       CloseHandle (ptok);
     }
   if (cygheap->user.issetuid ()
-      && !ImpersonateLoggedOnUser (cygheap->user.token))
+      && !ImpersonateLoggedOnUser (cygheap->user.token ()))
     system_printf ("Impersonating in setegid failed: %E");
   return 0;
 }
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.113
diff -u -p -r1.113 uinfo.cc
--- uinfo.cc	9 Jun 2003 13:29:12 -0000	1.113
+++ uinfo.cc	12 Jun 2003 02:44:54 -0000
@@ -103,7 +103,7 @@ internal_getlogin (cygheap_user &user)
 void
 uinfo_init ()
 {
-  if (child_proc_info && cygheap->user.token =3D=3D INVALID_HANDLE_VALUE)
+  if (child_proc_info && !cygheap->user.has_impersonation_tokens ())
     return;

   if (!child_proc_info)
@@ -115,17 +115,16 @@ uinfo_init ()
 	   && cygheap->user.orig_gid =3D=3D cygheap->user.real_gid
 	   && !cygheap->user.groups.issetgroups ())
     {
-      if (!ImpersonateLoggedOnUser (cygheap->user.token))
-	system_printf ("ImpersonateLoggedOnUser: %E");
+      cygheap->user.reimpersonate ();
       return;
     }
   else
-    CloseHandle (cygheap->user.token);
+    cygheap->user.close_impersonation_tokens ();

   cygheap->user.orig_uid =3D cygheap->user.real_uid =3D myself->uid;
   cygheap->user.orig_gid =3D cygheap->user.real_gid =3D myself->gid;
+  cygheap->user.impersonation_state =3D IMP_NONE;
   cygheap->user.set_orig_sid ();	/* Update the original sid */
-  cygheap->user.token =3D INVALID_HANDLE_VALUE; /* No token present */
 }

 extern "C" char *

--=====================_1055401416==_--
