Return-Path: <cygwin-patches-return-2374-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31579 invoked by alias); 10 Jun 2002 03:15:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31532 invoked from network); 10 Jun 2002 03:15:41 -0000
Message-Id: <3.0.5.32.20020609231253.008044d0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 09 Jun 2002 20:15:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Reorganizing internal_getlogin()
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1023693173==_"
X-SW-Source: 2002-q2/txt/msg00357.txt.bz2

--=====================_1023693173==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2232

Corinna,

internal_getlogin() has evolved over time. Currently it has two 
purposes:
1) set Cygwin variables (e.g. cygheap->user, HOME, prgpsid,...)
2) set traditional Windows environment entries (e.g. HOMEPATH)

It is called in 3 cases:
a) Entry from Windows
b) From seteuid()
c) After CreateProcessAsUser()

The purpose in cases a) and c) is 1 above.
The purpose in case  b) is mainly 2. 

I propose to reorganize the code by breaking 
internal_getlogin() in two functions, one that does 1) and 
another that does 2). The main purpose is to increase the efficiency,
as explained below, as well as fixing some nits, e.g. 
LOGONSERVER is never updated.

The first function would be called in cases a) and c), although
it would do very little in case c).
The second one would be called in spawn_guts(), just before
the CreateProcessAsUser() [when the environment is copied to
the cygheap]. 
There would be no call to internal_getlogin() from seteuid(). 
The few Cygwin fields that need updating in seteuid() 
[e.g.user.name] would be handled in seteuid() itself, where
the info is readily available.
These changes would improve the performances of servers [such as 
mail servers] that setuid() repeatedly but exec() only rarely,
in particular avoiding lookups over the network. 

As a first step in this process, the attached patches contain the 
modifications that add function 2). They can already be applied
although internal_getlogin() is not touched. It will be simplified
in a second phase. This will allow you to more easily check what's
going on.  

I worry (because I can't test) that this might break applications 
using sexecXX calls, although I don't see how it would. Are there 
any still around? It would be easy to bypass the new code for sexecXX 
calls, if needed.

2002-06-09  Pierre Humblet <pierre.humblet@ieee.org>

	* environ.cc (addWinDefEnv): New.
	(inWinDefEnv): New.
	(writeWinDefEnv): New.
	* spawn.cc (spawn_guts): Call functions above to set
	traditional Windows environment variables when copying the
	environment to the cygheap, before CreateProcessAsUser().
	Define sec_attribs and call sec_user_nih() only once.
	* environ.h: Declare inWinDefEnv() and addWinDefEnv(), and 
	define WINDEFENVC.

Pierre

--=====================_1023693173==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="spawn.cc.diff"
Content-length: 3361

--- spawn.cc.orig	2002-06-06 21:02:22.000000000 -0400
+++ spawn.cc	2002-06-08 15:00:32.000000000 -0400
@@ -567,13 +567,7 @@
   ciresrv.moreinfo->argv =3D newargv;

   ciresrv.moreinfo->envc =3D envsize (envp, 1);
-  ciresrv.moreinfo->envp =3D (char **) cmalloc (HEAP_1_ARGV, ciresrv.morei=
nfo->envc);
   ciresrv.hexec_proc =3D hexec_proc;
-  char **c;
-  const char * const *e;
-  for (c =3D ciresrv.moreinfo->envp, e =3D envp; *e;)
-    *c++ =3D cstrdup1 (*e++);
-  *c =3D NULL;
   if (mode !=3D _P_OVERLAY ||
       !DuplicateHandle (hMainProc, myself.shared_handle (), hMainProc,
 			&ciresrv.moreinfo->myself_pinfo, 0,
@@ -604,14 +598,6 @@
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
   /* Preallocated buffer for `sec_user' call */
   char sa_buf[1024];

@@ -624,9 +610,22 @@
   syscall_printf ("spawn_guts null_app_name %d (%s, %.132s)", null_app_nam=
e, runpath, one_line.buf);

   void *newheap;
+  char *envblock;
   cygbench ("spawn-guts");
   if (!hToken)
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
+      PSECURITY_ATTRIBUTES sec_attribs =3D sec_user_nih (sa_buf);
       ciresrv.moreinfo->uid =3D getuid32 ();
       /* FIXME: This leaks a handle in the CreateProcessAsUser case since =
the
 	 child process doesn't know about cygwin_mount_h. */
@@ -634,10 +633,8 @@
       newheap =3D cygheap_setup_for_child (&ciresrv, cygheap->fdtab.need_f=
ixup_before ());
       rc =3D CreateProcess (runpath,	/* image name - with full path */
 			  one_line.buf,	/* what was passed to exec */
-					  /* process security attrs */
-			  sec_user_nih (sa_buf),
-					  /* thread security attrs */
-			  sec_user_nih (sa_buf),
+			  sec_attribs,  /* process security attrs */
+			  sec_attribs,  /* thread security attrs */
 			  TRUE,	/* inherit handles from parent */
 			  flags,
 			  envblock,/* environment */
@@ -659,10 +656,25 @@
       PSECURITY_ATTRIBUTES sec_attribs =3D sec_user_nih (sa_buf, sid);

       /* Remove impersonation */
-      if (cygheap->user.impersonated
-	  && cygheap->user.token !=3D INVALID_HANDLE_VALUE)
+      if (cygheap->user.impersonated &&
+	  cygheap->user.token !=3D INVALID_HANDLE_VALUE)
 	RevertToSelf ();

+      ciresrv.moreinfo->envp =3D (char **) cmalloc (HEAP_1_ARGV,
+						  ciresrv.moreinfo->envc +
+						  WINDEFENVC);
+      char **c;
+      const char * const *e;
+      for (c =3D ciresrv.moreinfo->envp, e =3D envp; *e; e++)
+	if (!inWinDefEnv(*e)) *c++ =3D cstrdup1 (*e);
+      ciresrv.moreinfo->envc =3D (1 + buildWinDefEnv((char **) c, sid) -
+				ciresrv.moreinfo->envp) * sizeof (char *);
+      /* Build windows style environment list */
+      if (real_path.iscygexec ())
+	envblock =3D NULL;
+      else
+	envblock =3D winenv (ciresrv.moreinfo->envp, 0);
+
       /* Load users registry hive. */
       load_registry_hive (sid);


--=====================_1023693173==_
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

--=====================_1023693173==_
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

--=====================_1023693173==_--
