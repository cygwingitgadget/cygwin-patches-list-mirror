Return-Path: <cygwin-patches-return-3927-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13486 invoked by alias); 8 Jun 2003 21:32:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13363 invoked from network); 8 Jun 2003 21:32:58 -0000
Message-Id: <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Sun, 08 Jun 2003 21:32:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: exec after seteuid
Cc: "Snively, John P (John)" <eeyore@lucent.com>
In-Reply-To: <20030607200438.GI18350@cygbert.vinschen.de>
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net>
 <3.0.5.32.20030607094044.00805970@mail.attbi.com>
 <3.0.5.32.20030607094044.00805970@mail.attbi.com>
 <3.0.5.32.20030607153456.008051b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1055122376==_"
X-SW-Source: 2003-q2/txt/msg00154.txt.bz2

--=====================_1055122376==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1399

At 10:04 PM 6/7/2003 +0200, Corinna Vinschen wrote:
>I just had a look into the current login.c implementation on NetBSD.
>It is using setuid/setgid.  Actually it's using setusercontext(3)
>but with all options set which implies setuid/setgid.  Yes, using
>only seteuid/setegid in login has to be considered an error which
>just didn't matter so far.

Corinna, 

here is the patch.

It seems to work fine but it requires login.exe changes. It's
not just a question of security. ash does not setuid, while bash 
setuid(getuid()), i.e. just the opposite of what we need.

While I was looking at the most recent login.c I saw that you have
added a seteuid (priv_uid). Ideally, shouldn't it still be effective 
while calling dolastlog()? It's weird that the Berkeley code didn't do
that. There is also the issue raised by Takashi Yano on the list.

I have thrown in the little exceptions.cc quoting patch.
 
2003-06-09  Pierre Humblet  <pierre.humblet@ieee.org>

	* spawn.cc (spawn_guts): Call CreateProcess while impersonated, 
	when the real {u,g}ids and the groups are original.
	Move RevertToSelf and ImpersonateLoggedOnUser to the main line.
	* uinfo.cc (uinfo_init): Reorganize. If CreateProcess was called 
	while impersonated, preserve the uids and gids and call
 	ImpersonateLoggedOnUser. Preserve the uids and gids on Win9X.

	* exceptions.cc (error_start_init): Quote the pgm in the command.

--=====================_1055122376==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="seteuid.diff"
Content-length: 4843

Index: spawn.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.122
diff -u -p -r1.122 spawn.cc
--- spawn.cc	3 Jun 2003 02:32:49 -0000	1.122
+++ spawn.cc	8 Jun 2003 15:59:10 -0000
@@ -622,7 +622,13 @@ spawn_guts (const char * prog_arg, const
   cygbench ("spawn-guts");

   cygheap->fdtab.set_file_pointers_for_exec ();
-  if (!cygheap->user.issetuid ())
+  RevertToSelf ();
+  /* FIXME. If ruid !=3D euid and ruid !=3D orig_uid we currently give
+     up on ruid. The new process will have ruid =3D euid */
+  if (!cygheap->user.issetuid ()
+      || (cygheap->user.orig_uid =3D=3D cygheap->user.real_uid
+	  && cygheap->user.orig_gid =3D=3D cygheap->user.real_gid
+	  && !cygheap->user.groups.issetgroups ()))
     {
       PSECURITY_ATTRIBUTES sec_attribs =3D sec_user_nih (sa_buf);
       ciresrv.moreinfo->envp =3D build_env (envp, envblock, ciresrv.morein=
fo->envc,
@@ -646,11 +652,8 @@ spawn_guts (const char * prog_arg, const
       /* Set security attributes with sid */
       PSECURITY_ATTRIBUTES sec_attribs =3D sec_user_nih (sa_buf, sid);

-      RevertToSelf ();
-
       /* Load users registry hive. */
       load_registry_hive (sid);
-
       /* allow the child to interact with our window station/desktop */
       HANDLE hwst, hdsk;
       SECURITY_INFORMATION dsi =3D DACL_SECURITY_INFORMATION;
@@ -682,11 +685,11 @@ spawn_guts (const char * prog_arg, const
 		       0,		/* use current drive/directory */
 		       &si,
 		       &pi);
-      /* Restore impersonation. In case of _P_OVERLAY this isn't
-	 allowed since it would overwrite child data. */
-      if (mode !=3D _P_OVERLAY)
-	ImpersonateLoggedOnUser (cygheap->user.token);
     }
+  /* Restore impersonation. In case of _P_OVERLAY this isn't
+     allowed since it would overwrite child data. */
+  if (mode !=3D _P_OVERLAY && cygheap->user.issetuid ())
+    ImpersonateLoggedOnUser (cygheap->user.token);

   MALLOC_CHECK;
   if (envblock)
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.112
diff -u -p -r1.112 uinfo.cc
--- uinfo.cc	27 Feb 2003 17:41:15 -0000	1.112
+++ uinfo.cc	8 Jun 2003 16:02:23 -0000
@@ -103,18 +103,33 @@ internal_getlogin (cygheap_user &user)
 void
 uinfo_init ()
 {
-  if (!child_proc_info || cygheap->user.token !=3D INVALID_HANDLE_VALUE)
+  if (child_proc_info && cygheap->user.token =3D=3D INVALID_HANDLE_VALUE)
+    return;
+
+  if (!child_proc_info)
+    internal_getlogin (cygheap->user); /* Set the cygheap->user. */
+  else if (!cygheap->user.issetuid ())
     {
-      if (!child_proc_info)
-	internal_getlogin (cygheap->user); /* Set the cygheap->user. */
-      else
-	CloseHandle (cygheap->user.token);
-      cygheap->user.set_orig_sid ();	/* Update the original sid */
-      cygheap->user.token =3D INVALID_HANDLE_VALUE; /* No token present */
+      CloseHandle (cygheap->user.token);
+      cygheap->user.token =3D INVALID_HANDLE_VALUE;
+      return;
     }
-  /* Real and effective uid/gid are identical on process start up. */
+  /* Conditions must match those in spawn */
+  else if (cygheap->user.orig_uid =3D=3D cygheap->user.real_uid
+	   && cygheap->user.orig_gid =3D=3D cygheap->user.real_gid
+	   && !cygheap->user.groups.issetgroups ())
+    {
+      if (!ImpersonateLoggedOnUser (cygheap->user.token))
+	system_printf ("ImpersonateLoggedOnUser: %E");
+      return;
+    }
+  else
+    CloseHandle (cygheap->user.token);
+
   cygheap->user.orig_uid =3D cygheap->user.real_uid =3D myself->uid;
   cygheap->user.orig_gid =3D cygheap->user.real_gid =3D myself->gid;
+  cygheap->user.set_orig_sid ();	/* Update the original sid */
+  cygheap->user.token =3D INVALID_HANDLE_VALUE; /* No token present */
 }

 extern "C" char *
Index: exceptions.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.147
diff -u -p -r1.147 exceptions.cc
--- exceptions.cc	30 May 2003 15:01:33 -0000	1.147
+++ exceptions.cc	8 Jun 2003 20:47:20 -0000
@@ -154,7 +154,7 @@ error_start_init (const char *buf)
   for (char *p =3D strchr (pgm, '\\'); p; p =3D strchr (p, '\\'))
     *p =3D '/';

-  __small_sprintf (debugger_command, "%s %s", buf, pgm);
+  __small_sprintf (debugger_command, "%s \"%s\"", buf, pgm);
 }

 static void

--=====================_1055122376==_--
