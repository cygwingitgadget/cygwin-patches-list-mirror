Return-Path: <cygwin-patches-return-2404-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8424 invoked by alias); 13 Jun 2002 03:11:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8410 invoked from network); 13 Jun 2002 03:11:27 -0000
Message-Id: <3.0.5.32.20020612230833.0080d100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 12 Jun 2002 20:11:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Reorganizing internal_getlogin()
In-Reply-To: <20020613021230.GA26392@redhat.com>
References: <3.0.5.32.20020612205711.007f7300@mail.attbi.com>
 <3.0.5.32.20020612205711.007f7300@mail.attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1023952113==_"
X-SW-Source: 2002-q2/txt/msg00387.txt.bz2

--=====================_1023952113==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2113

At 10:12 PM 6/12/2002 -0400, you wrote:
>Yes, and as I explained previously, I didn't really like what you did to
>spawn_guts or your additions to environ.cc.  

You never really explained why, except the style of the names!

Currently seteuid unsets USERNAME and USERDOMAIN, which will
cause them to be set again, and HOMEPATH and HOMEDRIVE to be changed.
LOGONSERVER should be changed (or verified) as well, even if it is 
already set. So the environment is traversed at least 7 times.

Those 7 passes (not to mention contacting logonsevers to get the 
info) are only useful if there is an exec(), and that's why 
spawn_guts is the logical place to do it. 

The way I did it was for efficiency, only 1 pass through the whole 
environment. There is also the issue of variables such as HOMESHARE,
which become invalid (not a problem if SYSTEM does the setuid, but..).
It would have been much easier to write a routine doing explicit 
setenv and unsetenv, called from spawn_guts. Perhaps this is a way out.
What I did was probably overkill.

The other important change I did was not to call internal_login at
all from seteuid, and to avoid calling LookupAccountSid() [another
logonserver lookup, really] . Calling internal_getlogin
is useless (except for setting the environment) and it has the 
additional cost of traversing passwd.

>If you don't set the child's uid here then where is it going to be set?

It's already set! (as is myself->gid and the rest).
BTW spawn_info->moreinfo->uid has a misleading name (probably for
historical reasons). It's currently used as flag (when set to
INVALID_UID) to indicate CreateProcessAsUser.

>The correct way to find out if the parent is a cygwin process is to
>check for ppid_handle.  If it is zero, then the parent was not a cygwin
>process.  I've already made this change to uinfo.cc.

I just checked (printed myself->procinfo in gdb), same problem as ppid. 
If Windows starts a Cygwin process and this process exec()s.' then the 
exec'ed process has ppid_handle==0 even though the parent is a cygwin
process.

Pierre

P.S.: here is the missing uinfo.cc patch. Sorry.
--=====================_1023952113==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="uinfo.cc.diff"
Content-length: 10481

--- uinfo.cc.orig	2002-06-11 00:05:44.000000000 -0400
+++ uinfo.cc	2002-06-12 19:13:56.000000000 -0400
@@ -28,147 +28,35 @@
 #include "cygheap.h"
 #include "registry.h"

-struct passwd *
+/* Only called when starting from a non Cygwin process */
+void
 internal_getlogin (cygheap_user &user)
 {
-  char buf[512];
-  char username[UNLEN + 1];
-  DWORD username_len =3D UNLEN + 1;
   struct passwd *pw =3D NULL;

-  if (!GetUserName (username, &username_len))
-    user.set_name ("unknown");
-  else
-    user.set_name (username);
-  debug_printf ("GetUserName() =3D %s", user.name ());
-
   if (wincap.has_security ())
     {
-      LPWKSTA_USER_INFO_1 wui;
-      NET_API_STATUS ret;
-      char *env;
-
-      user.set_logsrv (NULL);
-      /* First trying to get logon info from environment */
-      if ((env =3D getenv ("USERNAME")) !=3D NULL)
-	user.set_name (env);
-      if ((env =3D getenv ("USERDOMAIN")) !=3D NULL)
-	user.set_domain (env);
-      if ((env =3D getenv ("LOGONSERVER")) !=3D NULL)
-	user.set_logsrv (env + 2); /* filter leading double backslashes */
-      if (user.name () && user.domain ())
-	debug_printf ("User: %s, Domain: %s, Logon Server: %s",
-		      user.name (), user.domain (), user.logsrv ());
-      else if (!(ret =3D NetWkstaUserGetInfo (NULL, 1, (LPBYTE *) &wui)))
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
-      if (!user.logsrv () && user.domain() &&
-          get_logon_server(user.domain(), buf, NULL))
-	{
-	  user.set_logsrv (buf + 2);
-	  setenv ("LOGONSERVER", buf, 1);
-	}
-      debug_printf ("Domain: %s, Logon Server: %s, Windows Username: %s",
-		    user.domain (), user.logsrv (), user.name ());
-
-      /* NetUserGetInfo() can be slow in NT domain environment, thus we
-       * only obtain HOMEDRIVE and HOMEPATH if they are not already set
-       * in the environment. */
-      if (!getenv ("HOMEPATH") || !getenv ("HOMEDRIVE"))
-	{
-	  LPUSER_INFO_3 ui =3D NULL;
-	  WCHAR wuser[UNLEN + 1];
-
-	  sys_mbstowcs (wuser, user.name (), sizeof (wuser) / sizeof (*wuser));
-	  if ((ret =3D NetUserGetInfo (NULL, wuser, 3, (LPBYTE *)&ui)))
-	    {
-	      if (user.logsrv ())
-		{
-		  WCHAR wlogsrv[INTERNET_MAX_HOST_NAME_LENGTH + 3];
-		  strcat (strcpy (buf, "\\\\"), user.logsrv ());
-
-		  sys_mbstowcs (wlogsrv, buf,
-				sizeof (wlogsrv) / sizeof(*wlogsrv));
-		  ret =3D NetUserGetInfo (wlogsrv, wuser, 3,(LPBYTE *)&ui);
-		}
-	    }
-	  if (!ret)
-	    {
-	      sys_wcstombs (buf, ui->usri3_home_dir, MAX_PATH);
-	      if (!buf[0])
-		{
-		  sys_wcstombs (buf, ui->usri3_home_dir_drive, MAX_PATH);
-		  if (buf[0])
-		    strcat (buf, "\\");
-		  else
-		    {
-		      env =3D getenv ("SYSTEMDRIVE");
-		      if (env && *env)
-			strcat (strcpy (buf, env), "\\");
-		      else
-			GetSystemDirectoryA (buf, MAX_PATH);
-		    }
-		}
-	      setenv ("HOMEPATH", buf + 2, 1);
-	      buf[2] =3D '\0';
-	      setenv ("HOMEDRIVE", buf, 1);
-	    }
-	  if (ui)
-	    NetApiBufferFree (ui);
-	}
-
-      HANDLE ptok =3D user.token; /* Which is INVALID_HANDLE_VALUE if no
-				   impersonation took place. */
+      HANDLE ptok =3D INVALID_HANDLE_VALUE;
       DWORD siz;
       cygsid tu;
-      ret =3D 0;
+      DWORD ret =3D 0;

-      /* Try to get the SID either from already impersonated token
-	 or from current process first. To differ that two cases is
-	 important, because you can't rely on the user information
-	 in a process token of a currently impersonated process. */
-      if (ptok =3D=3D INVALID_HANDLE_VALUE
-	  && !OpenProcessToken (GetCurrentProcess (),
-				TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
-				&ptok))
-	debug_printf ("OpenProcessToken(): %E\n");
+      /* Try to get the SID from current process and store it in user.psid=
 */
+      if (!OpenProcessToken (GetCurrentProcess (),
+			     TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
+			     &ptok))
+        system_printf ("OpenProcessToken(): %E\n");
       else if (!GetTokenInformation (ptok, TokenUser, &tu, sizeof tu, &siz=
))
-	debug_printf ("GetTokenInformation(): %E");
+	system_printf ("GetTokenInformation(): %E");
       else if (!(ret =3D user.set_sid (tu)))
-	debug_printf ("Couldn't retrieve SID from access token!");
-      /* If that failes, try to get the SID from localhost. This can only
-	 be done if a domain is given because there's a chance that a local
-	 and a domain user may have the same name. */
-      if (!ret && user.domain ())
-	{
-	  char domain[DNLEN + 1];
-	  DWORD dlen =3D sizeof (domain);
-	  siz =3D sizeof (tu);
-	  SID_NAME_USE use =3D SidTypeInvalid;
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
+	system_printf ("Couldn't retrieve SID from access token!");
+      /* We must set the user name, uid and gid.
+	 If we have a SID, try to get the corresponding Cygwin
+	 password entry. Set user name which can be different
+	 from the Windows user name */
+      if ( ret )
+        {
+	  cygsid gsid (NO_SID);
 	  cygsid psid;

 	  for (int pidx =3D 0; (pw =3D internal_getpwent (pidx)); ++pidx)
@@ -181,95 +69,74 @@
 		      gsid =3D NO_SID;
 		break;
 	      }
-	  if (!strcasematch (user.name (), "SYSTEM")
-	      && user.domain () && user.logsrv ())
-	    {
-	      if (get_registry_hive_path (user.sid (), buf))
-		setenv ("USERPROFILE", buf, 1);
-	      else
-		unsetenv ("USERPROFILE");
-	    }
-	}
-
-      /* If this process is started from a non Cygwin process,
-	 set token owner to the same value as token user and
-	 primary group to the group which is set as primary group
-	 in /etc/passwd. */
-      if (ptok !=3D INVALID_HANDLE_VALUE && myself->ppid =3D=3D 1)
-	{
+	  /* When starting from a non CYGWIN process, set token owner
+	     to the same value as token user and primary group to the
+	     group which is set as primary group in /etc/passwd. */
 	  if (!SetTokenInformation (ptok, TokenOwner, &tu, sizeof tu))
 	    debug_printf ("SetTokenInformation(TokenOwner): %E");
 	  if (gsid && !SetTokenInformation (ptok, TokenPrimaryGroup,
 					    &gsid, sizeof gsid))
 	    debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
 	}
-
-      /* Close token only if it's a result from OpenProcessToken(). */
-      if (ptok !=3D INVALID_HANDLE_VALUE
-	  && user.token =3D=3D INVALID_HANDLE_VALUE)
+      /* Close token */
+      if (ptok !=3D INVALID_HANDLE_VALUE)
 	CloseHandle (ptok);
-    }
-
-  debug_printf ("Cygwins Username: %s", user.name ());
-
+    }
+  /* user.name was initialized in memory_init () or above */
+  debug_printf ("Cygwin Username: %s%s",
+		user.name (), (pw)?" from SID":"");
   if (!pw)
     pw =3D getpwnam(user.name ());
+  if (pw)
+    {
+      user.real_uid =3D pw->pw_uid;
+      user.real_gid =3D pw->pw_gid;
+    }
+  else
+    {
+      user.real_uid =3D DEFAULT_UID;
+      user.real_gid =3D DEFAULT_GID;
+    }
+
+  /* Set HOME if needed when starting from a non CYGWIN process. */
   if (!getenv ("HOME"))
     {
       const char *homedrive, *homepath;
+      char buf[MAX_PATH + 1], home[MAX_PATH+1] =3D "/";
       if (pw && pw->pw_dir && *pw->pw_dir)
-	{
+        {
 	  setenv ("HOME", pw->pw_dir, 1);
 	  debug_printf ("Set HOME (from /etc/passwd) to %s", pw->pw_dir);
 	}
-      else if ((homedrive =3D getenv ("HOMEDRIVE"))
+      else
+        {
+	  if ((homedrive =3D getenv ("HOMEDRIVE"))
 	       && (homepath =3D getenv ("HOMEPATH")))
-	{
-	  char home[MAX_PATH];
-	  strcpy (buf, homedrive);
-	  strcat (buf, homepath);
-	  cygwin_conv_to_full_posix_path (buf, home);
+	    {
+	      strcpy (buf, homedrive);
+	      strcat (buf, homepath);
+	      cygwin_conv_to_full_posix_path (buf, home);
+	      debug_printf ("Set HOME (from HOMEDRIVE/HOMEPATH) to %s", home);
+	    }
 	  setenv ("HOME", home, 1);
-	  debug_printf ("Set HOME (from HOMEDRIVE/HOMEPATH) to %s", home);
 	}
     }
-  return pw;
 }

+/* Called when the process is started from a non Cygwin process or
+   the user context was changed in spawn.cc. */
 void
-uinfo_init ()
+uinfo_init (BOOL from_cygwin)
 {
-  struct passwd *p;
-
-  /* Initialize to non impersonated values.
-     Setting `impersonated' to TRUE seems to be wrong but it
-     isn't. Impersonated is thought as "Current User and `token'
-     are coincident". See seteuid() for the mechanism behind that. */
-  if (cygheap->user.token !=3D INVALID_HANDLE_VALUE && cygheap->user.token=
 !=3D NULL)
-    CloseHandle (cygheap->user.token);
+  if (!from_cygwin)
+    internal_getlogin (cygheap->user); /* Set the cygheap->user. */
+  /* Real and effective uid/gid are identical on process start up. */
+  myself->uid =3D cygheap->user.orig_uid =3D cygheap->user.real_uid;
+  myself->gid =3D cygheap->user.orig_gid =3D cygheap->user.real_gid;
+  cygheap->user.set_orig_sid();      /* Update the original sid */
+  /* No token present */
   cygheap->user.token =3D INVALID_HANDLE_VALUE;
-  cygheap->user.impersonated =3D TRUE;
-
-  /* If uid is ILLEGAL_UID, the process is started from a non cygwin
-     process or the user context was changed in spawn.cc */
-  if (myself->uid =3D=3D ILLEGAL_UID)
-    if ((p =3D internal_getlogin (cygheap->user)) !=3D NULL)
-      {
-	myself->uid =3D p->pw_uid;
-	/* Set primary group only if process has been started from a
-	   non cygwin process. */
-	if (!myself->ppid_handle)
-	  myself->gid =3D p->pw_gid;
-      }
-    else
-      {
-	myself->uid =3D DEFAULT_UID;
-	myself->gid =3D DEFAULT_GID;
-      }
-  /* Real and effective uid/gid are always identical on process start up.
-     This is at least true for NT/W2K. */
-  cygheap->user.orig_uid =3D cygheap->user.real_uid =3D myself->uid;
-  cygheap->user.orig_gid =3D cygheap->user.real_gid =3D myself->gid;
+  /* cygheap->user.impersonated =3D TRUE;  Don't care */
 }

 extern "C" char *

--=====================_1023952113==_--
