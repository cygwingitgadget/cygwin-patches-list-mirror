Return-Path: <cygwin-patches-return-2401-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 923 invoked by alias); 13 Jun 2002 01:00:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 909 invoked from network); 13 Jun 2002 00:59:59 -0000
Message-Id: <3.0.5.32.20020612205711.007f7300@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 12 Jun 2002 18:00:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Reorganizing internal_getlogin()
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1023944231==_"
X-SW-Source: 2002-q2/txt/msg00384.txt.bz2

--=====================_1023944231==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2294

/* I just found the mail of Chris from last nite (spend a day
   on the road) but as all of the following was ready and tested, 
   I am sending it anyway. Pick what you want. */

As explained previously, the main purpose of the patches 
is to increase performances of servers that fork() and 
setuid() but do not exec(). In particular, the number of
accesses to logonservers (either directly, or through 
LookupAccountSid ) is greatly reduced. The performance
of programs that setuid() and exec() is improved as well, 
e.g. by not reading the passwd file in the child.

In addition the code (mostly uinfo.cc and seteuid) is greatly 
streamlined (IMHO). The changes are pretty self explanatory,
except perhaps the following.
dll_crt0_1() passes a flag to uinfo_init() to indicate if the
parent is a Cygwin process. The previous method (ppid != 1) 
is not reliable and causes the following bug: when a cygwin 
process with ppid == 1 exec()'s after setgid(), the new gid 
gets lost.
Another minor bug is fixed: LOGONSERVER is always set correctly.

Pierre

2002-06-12  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (seteuid32): Do not get or set the environment. Do not
	call LookupAccountSid nor internal_getlogin. Set cygheap->user name
	and sid from the passwd entry.
	* uinfo.cc (uinfo_init): Add an argument. Only call internal_getlogin
	when starting from a non Cygwin process and use the values returned
	in user.
	(internal_getlogin): Simplify to case where starting from a non
	Cygwin process. Store return values in user and return void. Do not set
	the Windows default environment.
	* dcrt0.cc (dll_crt0_1): Call uinfo_init only when needed, with an 
	argument. Do not set myself->uid nor reset user.sid.
	* environ.cc (addWinDefEnv): New.
	(inWinDefEnv): New.
	(writeWinDefEnv): New.
	* environ.h: Declare inWinDefEnv() and addWinDefEnv(), and 
	define WINDEFENVC.
	* spawn.cc (spawn_guts): Call functions above to set
	traditional Windows environment variables when copying the
	environment to the cygheap, before CreateProcessAsUser().
	Get the sid from cygheap->user. Always RevertToSelf().
	* cygheap.cc (cygheap_user::set_sid): Do not set orig_sig.
	(cygheap_user::set_sid): New.
	* cygheap.h: Declare cygheap_user::set_sid.
	* winsup.h: Add argument to uinfo_init().

--=====================_1023944231==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="spawn.cc.diff"
Content-length: 3304

--- spawn.cc.orig	2002-06-11 00:05:42.000000000 -0400
+++ spawn.cc	2002-06-12 19:24:50.000000000 -0400
@@ -567,13 +567,6 @@
   ciresrv.moreinfo->argv =3D newargv;

   ciresrv.moreinfo->envc =3D envsize (envp, 1);
-  ciresrv.moreinfo->envp =3D (char **) cmalloc (HEAP_1_ARGV, ciresrv.morei=
nfo->envc);
-  ciresrv.hexec_proc =3D hexec_proc;
-  char **c;
-  const char * const *e;
-  for (c =3D ciresrv.moreinfo->envp, e =3D envp; *e;)
-    *c++ =3D cstrdup1 (*e++);
-  *c =3D NULL;
   if (mode !=3D _P_OVERLAY ||
       !DuplicateHandle (hMainProc, myself.shared_handle (), hMainProc,
 			&ciresrv.moreinfo->myself_pinfo, 0,
@@ -604,25 +597,29 @@
   if (cygheap->fdtab.need_fixup_before ())
     flags |=3D CREATE_SUSPENDED;

-
-  /* Build windows style environment list */
-  char *envblock;
-  if (real_path.iscygexec ())
-    envblock =3D NULL;
-  else
-    envblock =3D winenv (envp, 0);
-
   const char *runpath =3D null_app_name ? NULL : (const char *) real_path;

   syscall_printf ("null_app_name %d (%s, %.132s)", null_app_name, runpath,=
 one_line.buf);

   void *newheap;
+  char *envblock;
   /* Preallocated buffer for `sec_user' call */
   char sa_buf[1024];

   cygbench ("spawn-guts");
   if (!cygheap->user.impersonated || cygheap->user.token =3D=3D INVALID_HA=
NDLE_VALUE)
     {
+      ciresrv.moreinfo->envp =3D (char **) cmalloc (HEAP_1_ARGV, ciresrv.m=
oreinfo->envc);
+      char **c;
+      const char * const *e;
+      for (c =3D ciresrv.moreinfo->envp, e =3D envp; *e;)
+	*c++ =3D cstrdup1 (*e++);
+      *c =3D NULL;
+      /* Build windows style environment list */
+      if (real_path.iscygexec ())
+	envblock =3D NULL;
+      else
+	envblock =3D winenv (envp, 0);
       PSECURITY_ATTRIBUTES sec_attribs =3D sec_user_nih (sa_buf);
       ciresrv.moreinfo->uid =3D getuid32 ();
       /* FIXME: This leaks a handle in the CreateProcessAsUser case since =
the
@@ -642,22 +639,26 @@
     }
   else
     {
-      cygsid sid;
-      DWORD ret_len;
-      if (!GetTokenInformation (cygheap->user.token, TokenUser, &sid,
-				sizeof sid, &ret_len))
-	{
-	  sid =3D NO_SID;
-	  system_printf ("GetTokenInformation: %E");
-	}
-      /* Retrieve security attributes before setting psid to NULL
-	 since it's value is needed by `sec_user'. */
+      PSID sid =3D cygheap->user.sid ();
+      /* Set security attributes with sid */
       PSECURITY_ATTRIBUTES sec_attribs =3D sec_user_nih (sa_buf, sid);
-
       /* Remove impersonation */
-      if (cygheap->user.impersonated
-	  && cygheap->user.token !=3D INVALID_HANDLE_VALUE)
-	RevertToSelf ();
+      RevertToSelf ();
+      /* Build environment with updated Windows variables */
+      ciresrv.moreinfo->envp =3D (char **) cmalloc (HEAP_1_ARGV,
+						  ciresrv.moreinfo->envc +
+						  WINDEFENVC);
+      char **c;
+      const char * const *e;
+      for (c =3D ciresrv.moreinfo->envp, e =3D envp; *e; e++)
+	if (!in_windef_env(*e)) *c++ =3D cstrdup1 (*e);
+      ciresrv.moreinfo->envc =3D (1 + build_windef_env((char **) c, sid) -
+				ciresrv.moreinfo->envp) * sizeof (char *);
+      /* Build windows style environment list */
+      if (real_path.iscygexec ())
+	envblock =3D NULL;
+      else
+	envblock =3D winenv (ciresrv.moreinfo->envp, 0);

       /* Load users registry hive. */
       load_registry_hive (sid);

--=====================_1023944231==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="cygheap.h.diff"
Content-length: 323

--- cygheap.h.orig	2002-06-11 00:05:40.000000000 -0400
+++ cygheap.h	2002-06-11 21:40:24.000000000 -0400
@@ -120,6 +120,7 @@
   const char *domain () const { return pdomain; }
 
   BOOL set_sid (PSID new_sid);
+  BOOL set_orig_sid ();
   PSID sid () const { return psid; }
   PSID orig_sid () const { return orig_psid; }
 

--=====================_1023944231==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="dcrt0.cc.diff"
Content-length: 985

--- dcrt0.cc.orig	2002-06-11 00:05:40.000000000 -0400
+++ dcrt0.cc	2002-06-12 19:53:06.000000000 -0400
@@ -608,7 +608,6 @@
 				  DUPLICATE_SAME_ACCESS | DUPLICATE_CLOSE_SOURCE))
 	      h = NULL;
 	    set_myself (mypid, h);
-	    myself->uid = spawn_info->moreinfo->uid;
 	    __argc = spawn_info->moreinfo->argc;
 	    __argv = spawn_info->moreinfo->argv;
 	    envp = spawn_info->moreinfo->envp;
@@ -623,8 +622,6 @@
 	      }
 	    if (child_proc_info->subproc_ready)
 	      ProtectHandle (child_proc_info->subproc_ready);
-	    if (myself->uid == ILLEGAL_UID)
-	      cygheap->user.set_sid (NULL);
 	    break;
 	}
     }
@@ -679,8 +676,10 @@
   /* Allocate cygheap->fdtab */
   dtable_init ();
 
-/* Initialize uid, gid. */
-  uinfo_init ();
+/* Initialize uid, gid if necessary. */
+  if (child_proc_info == NULL ||
+      spawn_info->moreinfo->uid == ILLEGAL_UID)
+    uinfo_init ((BOOL) child_proc_info);
 
   /* Initialize signal/subprocess handling. */
   sigproc_init ();

--=====================_1023944231==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="environ.cc.diff"
Content-length: 4808

--- environ.cc.orig	2002-06-06 21:02:20.000000000 -0400
+++ environ.cc	2002-06-08 13:50:20.000000000 -0400
@@ -14,6 +14,9 @@
 #include <ctype.h>
 #include <sys/cygwin.h>
 #include <cygwin/version.h>
+#include <winnls.h>
+#include <wininet.h>
+#include <lm.h>
 #include "pinfo.h"
 #include "perprocess.h"
 #include "security.h"
@@ -867,3 +870,136 @@

   return __cygwin_environ;
 }
+
+/* The default Windows environment variables */
+static NO_COPY struct _WinDefEnv {
+    const char * name;
+    const size_t namelen;
+} WinDefEnv[] =3D {
+  { "HOMEDRIVE=3D", sizeof("HOMEDRIVE=3D") - 1},
+  { "HOMEPATH=3D", sizeof("HOMEPATH=3D") - 1},
+  { "HOMESHARE=3D", sizeof("HOMESHARE=3D") - 1},     /* Clear only */
+  { "LOGONSERVER=3D", sizeof("LOGONSERVER=3D") - 1},
+  { "USERDOMAIN=3D", sizeof("USERDOMAIN=3D") - 1},
+  { "USERNAME=3D", sizeof("USERNAME=3D") - 1},
+  { "USERPROFILE=3D", sizeof("USERPROFILE=3D") - 1}
+};
+/* Must be in same order as above */
+enum {HD, HP, HS, LS, UD, UN, UP };
+
+/* True if name matches one of the names above */
+BOOL
+inWinDefEnv(const char * name)
+{
+  struct _WinDefEnv * ptr =3D NULL;
+  if (name[0] =3D=3D 'H')
+    {
+      if (name[4] =3D=3D 'D') ptr =3D &WinDefEnv[HD];
+      else if (name[4] =3D=3D 'P') ptr =3D &WinDefEnv[HP];
+      else if (name[4] =3D=3D 'S') ptr =3D &WinDefEnv[HS];
+    }
+  else if (name[0] =3D=3D 'L') ptr =3D &WinDefEnv[LS];
+  else if (name[0] =3D=3D 'U')
+    {
+      if (name[4] =3D=3D 'D') ptr =3D &WinDefEnv[UD];
+      if (name[4] =3D=3D 'N') ptr =3D &WinDefEnv[UN];
+      if (name[4] =3D=3D 'P') ptr =3D &WinDefEnv[UP];
+    }
+  if (ptr)
+    return !strncmp(name, ptr->name, ptr->namelen);
+  else return FALSE;
+}
+
+static BOOL
+writeWinDefEnv(char *** pwhere, int offset, char * value)
+{
+  if (value[0])
+    {
+      **pwhere =3D (char *) cmalloc (HEAP_1_STR, strlen(value) +
+				   WinDefEnv[offset].namelen + 1);
+      if (!**pwhere) return FALSE;
+      strcpy(**pwhere, WinDefEnv[offset].name);
+      strcpy(**pwhere + WinDefEnv[offset].namelen, value);
+      (*pwhere)++;
+    }
+  return TRUE;
+}
+
+/* Build default Windows environment variables */
+char **
+buildWinDefEnv(char ** ptr, PSID pusersid)
+{
+  char username[UNLEN + 1] =3D {0};
+  DWORD ulen =3D sizeof (username);
+  char userdomain[DNLEN + 1] =3D {0};
+  DWORD dlen =3D sizeof (userdomain);
+  char userprofile[MAX_PATH +1] =3D {0};
+  char logsrv[INTERNET_MAX_HOST_NAME_LENGTH + 3] =3D {0}; /* With leading =
\\ */
+  WCHAR wlogsrv[INTERNET_MAX_HOST_NAME_LENGTH + 3]; /* With leading \\ */
+  char homepath[MAX_PATH + 1] =3D {0, 0}; /* Used for drive + path */
+  LPUSER_INFO_3 ui =3D NULL;
+
+  if (!pusersid)
+    goto out;
+  /*  Warning: the info is incorrect
+      if the pusersid is impersonated. */
+  SID_NAME_USE use;
+  if (!LookupAccountSid (NULL, pusersid, username, &ulen,
+                         userdomain, &dlen, &use))
+    {
+      __seterrno ();
+      goto out;
+    }
+  if (!writeWinDefEnv(&ptr, UD, userdomain) ||
+      !writeWinDefEnv(&ptr, UN, username))
+    goto out;
+  if (!strcasematch (username, "SYSTEM"))
+    {
+      if (get_logon_server (userdomain, logsrv, wlogsrv))
+        {
+          if (!writeWinDefEnv(&ptr, LS, logsrv))
+            goto out;
+
+          WCHAR wuser[UNLEN + 1];
+          NET_API_STATUS ret;
+          sys_mbstowcs (wuser, username, sizeof (wuser) / sizeof (*wuser));
+          if ((ret =3D NetUserGetInfo (wlogsrv, wuser, 3,(LPBYTE *)&ui)))
+            debug_printf("NetUserGetInfo: %d", ret);
+          else
+            {
+              sys_wcstombs (homepath, ui->usri3_home_dir, sizeof (homepath=
));
+              debug_printf("homepath(1) %s\n", homepath);
+              if (homepath[1] !=3D ':')
+                {
+                  sys_wcstombs (homepath, ui->usri3_home_dir_drive, sizeof=
 (homepath));
+                  debug_printf("homepath(2) %s", homepath);
+                  homepath[2] =3D '\\'; homepath[3] =3D 0;
+                }
+//            sys_wcstombs (userprofile, ui->usri3_profile, sizeof (userpr=
ofile));
+//            debug_printf("userprofile(1) %s\n", userprofile);
+              NetApiBufferFree (ui);
+            }
+        }
+      if (get_registry_hive_path (pusersid, userprofile))
+        {
+          debug_printf("userprofile(2) %s\n", userprofile);
+          if (!writeWinDefEnv(&ptr, UP, userprofile))
+            goto out;
+        }
+    }
+  if (homepath[1] !=3D ':')
+    {
+      GetSystemDirectoryA (homepath, sizeof (homepath));
+      homepath[3] =3D 0;
+    }
+  if (homepath[1] =3D=3D ':')
+    {
+      if (!writeWinDefEnv(&ptr, HP, &homepath[2]) ||
+          (homepath[2] =3D 0) ||
+          !writeWinDefEnv(&ptr, HD, homepath))
+        goto out;
+    }
+ out:
+  *ptr =3D NULL;
+  return ptr;
+}

--=====================_1023944231==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="environ.h.diff"
Content-length: 640

--- environ.h.orig	2001-10-30 19:55:32.000000000 -0500
+++ environ.h	2002-06-08 13:31:02.000000000 -0400
@@ -8,6 +8,9 @@
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
+/* Space for Windows default variables (HOMEPATH, ..) */
+#define WINDEFENVC (6 * sizeof (char *))
+
 /* Initialize the environment */
 void environ_init (char **, int);
 
@@ -39,3 +42,5 @@
 extern char **__cygwin_environ, ***main_environ;
 extern "C" char __stdcall **cur_environ ();
 int __stdcall envsize (const char * const *, int debug_print = 0);
+extern char ** buildWinDefEnv(char **, PSID);
+extern BOOL inWinDefEnv(const char *);

--=====================_1023944231==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="cygheap.cc.diff"
Content-length: 1034

--- cygheap.cc.orig	2002-06-11 00:05:40.000000000 -0400
+++ cygheap.cc	2002-06-11 21:40:12.000000000 -0400
@@ -464,27 +464,24 @@
 BOOL
 cygheap_user::set_sid (PSID new_sid)
 {
-  if (!new_sid)
+  if (new_sid)
     {
-      if (psid)
-	cfree (psid);
-      if (orig_psid)
-	cfree (orig_psid);
-      psid =3D NULL;
-      orig_psid =3D NULL;
-      return TRUE;
+      if (!psid)
+        psid =3D cmalloc (HEAP_STR, MAX_SID_LEN);
+      if (psid)
+	return CopySid (MAX_SID_LEN, psid, new_sid);
     }
-  else
-    {
-      if (!psid)
-	{
-	  if (!orig_psid)
-	    {
-	      orig_psid =3D cmalloc (HEAP_STR, MAX_SID_LEN);
-	      CopySid (MAX_SID_LEN, orig_psid, new_sid);
-	    }
-	  psid =3D cmalloc (HEAP_STR, MAX_SID_LEN);
-	}
-      return CopySid (MAX_SID_LEN, psid, new_sid);
+  return FALSE;
+}
+
+BOOL
+cygheap_user::set_orig_sid ()
+{
+  if (psid)
+    {
+      if (!orig_psid) orig_psid =3D cmalloc (HEAP_STR, MAX_SID_LEN);
+      if (orig_psid)
+	  return CopySid (MAX_SID_LEN, orig_psid, psid);
     }
+  return FALSE;
 }

--=====================_1023944231==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="syscalls.cc.diff"
Content-length: 3612

--- syscalls.cc.orig	2002-06-11 00:05:42.000000000 -0400
+++ syscalls.cc	2002-06-11 19:06:10.000000000 -0400
@@ -1943,8 +1943,6 @@
   return -1;
 }

-extern struct passwd *internal_getlogin (cygheap_user &user);
-
 /* seteuid: standards? */
 extern "C" int
 seteuid32 (__uid32_t uid)
@@ -1958,17 +1956,11 @@
     }

   sigframe thisframe (mainthread);
-  DWORD ulen =3D UNLEN + 1;
-  DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
-  char orig_username[UNLEN + 1];
-  char orig_domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-  char username[UNLEN + 1];
-  char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
   cygsid usersid, pgrpsid;
   HANDLE ptok, sav_token;
   BOOL sav_impersonated, sav_token_is_internal_token;
   BOOL process_ok, explicitly_created_token =3D FALSE;
-  struct passwd * pw_new, * pw_cur;
+  struct passwd * pw_new;
   cygheap_user user;
   PSID origpsid, psid2 =3D NO_SID;

@@ -1984,12 +1976,6 @@
   /* Save current information */
   sav_token =3D cygheap->user.token;
   sav_impersonated =3D cygheap->user.impersonated;
-  char *env;
-  orig_username[0] =3D orig_domain[0] =3D '\0';
-  if ((env =3D getenv ("USERNAME")))
-    strlcpy (orig_username, env, sizeof(orig_username));
-  if ((env =3D getenv ("USERDOMAIN")))
-    strlcpy (orig_domain, env, sizeof(orig_domain));

   RevertToSelf();
   if (!OpenProcessToken (GetCurrentProcess (),
@@ -2065,16 +2051,6 @@
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
   if (! process_ok )
     {
@@ -2104,38 +2080,17 @@
       cygheap->user.impersonated =3D TRUE;
     }

-  /* user.token is used in internal_getlogin () to determine if
-     impersonation is active. If so, the token is used for
-     retrieving user's SID. */
-  user.token =3D cygheap->user.impersonated ? cygheap->user.token
-					  : INVALID_HANDLE_VALUE;
-  /* Unsetting these two env vars is necessary to get NetUserGetInfo()
-     called in internal_getlogin ().  Otherwise the wrong path is used
-     after a user switch, probably. */
-  unsetenv ("HOMEDRIVE");
-  unsetenv ("HOMEPATH");
-  setenv ("USERDOMAIN", domain, 1);
-  setenv ("USERNAME", username, 1);
-  pw_cur =3D internal_getlogin (user);
-  if (pw_cur =3D=3D pw_new)
-    {
-      /* If sav_token was internally created and is replaced, destroy it. =
*/
-      if (sav_token !=3D INVALID_HANDLE_VALUE &&
-	  sav_token !=3D cygheap->user.token &&
-	  sav_token_is_internal_token)
-	CloseHandle (sav_token);
-      myself->uid =3D uid;
-      cygheap->user =3D user;
-      return 0;
-    }
-  debug_printf ("Diffs!!! token: %d, cur: %d, new: %d, orig: %d",
-		cygheap->user.token, pw_cur->pw_uid,
-		pw_new->pw_uid, cygheap->user.orig_uid);
-  set_errno (EPERM);
+  /* If sav_token was internally created and is replaced, destroy it. */
+  if (sav_token !=3D INVALID_HANDLE_VALUE &&
+      sav_token !=3D cygheap->user.token &&
+      sav_token_is_internal_token)
+      CloseHandle (sav_token);
+  cygheap->user.set_name (pw_new->pw_name);
+  cygheap->user.set_sid (usersid);
+  myself->uid =3D uid;
+  return 0;

  failed:
-  setenv ("USERNAME", orig_username, 1);
-  setenv ("USERDOMAIN", orig_domain, 1);
   cygheap->user.token =3D sav_token;
   cygheap->user.impersonated =3D sav_impersonated;
   if ( cygheap->user.token !=3D INVALID_HANDLE_VALUE &&

--=====================_1023944231==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="winsup.h.diff"
Content-length: 337

--- winsup.h.orig	2002-06-06 21:02:24.000000000 -0400
+++ winsup.h	2002-06-11 20:58:48.000000000 -0400
@@ -145,7 +145,7 @@
 extern "C" void __stdcall do_exit (int) __attribute__ ((noreturn));
 
 /* UID/GID */
-void uinfo_init (void);
+void uinfo_init (BOOL);
 
 #define ILLEGAL_UID16 ((__uid16_t)-1)
 #define ILLEGAL_UID ((__uid32_t)-1)

--=====================_1023944231==_--
