Return-Path: <cygwin-patches-return-5130-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3867 invoked by alias); 16 Nov 2004 02:26:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3843 invoked from network); 16 Nov 2004 02:26:35 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.170.214)
  by sourceware.org with SMTP; 16 Nov 2004 02:26:35 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I792X6-001O0V-5A
	for cygwin-patches@cygwin.com; Mon, 15 Nov 2004 21:29:30 -0500
Message-Id: <3.0.5.32.20041115212136.00817700@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 16 Nov 2004 02:26:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Loading the registry hive on Win9x
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1100589696==_"
X-SW-Source: 2004-q4/txt/msg00131.txt.bz2

--=====================_1100589696==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 939

This patch is the first of two to also load the registry hive on
Win9x during seteuid, and to apply the method recommended in
MS KB 199190 to avoid using HKCU.
 
This will yield the correct user mounts under ssh, telnet, etc...

Using the new method cygheap_user::get_windows_id() also streamlines
some aspects of Cygwin, e.g. in shared.cc below and more tomorrow.

Pierre

2004-11-16  Pierre Humblet <pierre.humblet@ieee.org>

	* cygheap.h (cygheap_user::get_windows_id): New method.
	* registry.h (get_registry_hive_path): Change argument type.
	(load_registry_hive): Ditto.
	* registry.cc (get_registry_hive_path): Change argument type and take
	Win9x keys into account.
	(load_registry_hive): Ditto.
	* uinfo.cc (cygheap_user::env_userprofile): Use get_windows_id, even
	for SYSTEM.
	* shared.cc (user_shared_initialize): Use get_windows_id.
	* syscalls.cc (seteuid32): Load the registry hive and reload the user
	shared also on Win9x.
--=====================_1100589696==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hive2.diff"
Content-length: 7791

Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.91
diff -u -p -r1.91 cygheap.h
--- cygheap.h	28 Oct 2004 01:46:01 -0000	1.91
+++ cygheap.h	16 Nov 2004 01:42:18 -0000
@@ -206,6 +206,14 @@ public:
 	internal_token =3D NO_IMPERSONATION;
       }
   }
+  char * get_windows_id (char * buf)
+  {
+    if (wincap.is_winnt ())
+      return effec_cygsid.string (buf);
+    else
+      return strcpy (buf, name ());
+  }
+
   const char *cygheap_user::test_uid (char *&, const char *, size_t)
     __attribute__ ((regparm (3)));
 };
Index: registry.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/registry.h,v
retrieving revision 1.3
diff -u -p -r1.3 registry.h
--- registry.h	11 Sep 2001 20:01:00 -0000	1.3
+++ registry.h	16 Nov 2004 01:42:18 -0000
@@ -39,5 +39,5 @@ public:
 };

 /* Evaluates path to the directory of the local user registry hive */
-char *__stdcall get_registry_hive_path (const PSID psid, char *path);
-void __stdcall load_registry_hive (PSID psid);
+char *__stdcall get_registry_hive_path (const char *name, char *path);
+void __stdcall load_registry_hive (const char *name);
Index: registry.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/registry.cc,v
retrieving revision 1.20
diff -u -p -r1.20 registry.cc
--- registry.cc	26 Oct 2004 01:53:27 -0000	1.20
+++ registry.cc	16 Nov 2004 01:42:18 -0000
@@ -194,18 +194,16 @@ reg_key::~reg_key ()
 }

 char *
-get_registry_hive_path (const PSID psid, char *path)
+get_registry_hive_path (const char *name, char *path)
 {
-  char sid[256];
   char key[256];
   HKEY hkey;

-  if (!psid || !path)
+  if (!name || !path)
     return NULL;
-  cygpsid csid (psid);
-  csid.string (sid);
-  strcpy (key,"SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileLis=
t\\");
-  strcat (key, sid);
+  __small_sprintf (key, "SOFTWARE\\Microsoft\\Windows%s\\CurrentVersion\\P=
rofileList\\",
+		   wincap.is_winnt ()?" NT":"");
+  strcat (key, name);
   if (!RegOpenKeyExA (HKEY_LOCAL_MACHINE, key, 0, KEY_READ, &hkey))
     {
       char buf[256];
@@ -224,31 +222,31 @@ get_registry_hive_path (const PSID psid,
 }

 void
-load_registry_hive (PSID psid)
+load_registry_hive (const char * name)
 {
-  char sid[256];
   char path[CYG_MAX_PATH + 1];
   HKEY hkey;
   LONG ret;

-  if (!psid)
+  if (!name)
     return;
   /* Check if user hive is already loaded. */
-  cygpsid csid (psid);
-  csid.string (sid);
-  if (!RegOpenKeyExA (HKEY_USERS, sid, 0, KEY_READ, &hkey))
+  if (!RegOpenKeyExA (HKEY_USERS, name, 0, KEY_READ, &hkey))
     {
-      debug_printf ("User registry hive for %s already exists", sid);
+      debug_printf ("User registry hive for %s already exists", name);
       RegCloseKey (hkey);
       return;
     }
   /* This is only called while deimpersonated */
   set_process_privilege (SE_RESTORE_NAME);
-  if (get_registry_hive_path (psid, path))
+  if (get_registry_hive_path (name, path))
     {
-      strcat (path, "\\NTUSER.DAT");
-      if ((ret =3D RegLoadKeyA (HKEY_USERS, sid, path)) !=3D ERROR_SUCCESS)
-	debug_printf ("Loading user registry hive for %s failed: %d", sid, ret);
+      if (wincap.is_winnt ())
+	strcat (path, "\\NTUSER.DAT");
+      else
+	strcat (path, "\\USER.DAT");
+      if ((ret =3D RegLoadKeyA (HKEY_USERS, name, path)) !=3D ERROR_SUCCES=
S)
+	debug_printf ("Loading user registry hive for %s failed: %d", name, ret);
     }
 }

Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.132
diff -u -p -r1.132 uinfo.cc
--- uinfo.cc	28 Oct 2004 01:46:01 -0000	1.132
+++ uinfo.cc	16 Nov 2004 01:42:19 -0000
@@ -419,11 +419,10 @@ cygheap_user::env_userprofile (const cha
     return puserprof;

   char userprofile_env_buf[CYG_MAX_PATH + 1];
+  char win_id[UNLEN + 1]; /* Large enough for SID */
+
   cfree_and_set (puserprof, almost_null);
-  /* FIXME: Should this just be setting a puserprofile like everything els=
e? */
-  const char *myname =3D winname ();
-  if (myname && strcasematch (myname, "SYSTEM")
-      && get_registry_hive_path (sid (), userprofile_env_buf))
+  if (get_registry_hive_path (get_windows_id (win_id), userprofile_env_buf=
))
     puserprof =3D cstrdup (userprofile_env_buf);

   return puserprof;
Index: shared.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.82
diff -u -p -r1.82 shared.cc
--- shared.cc	28 May 2004 19:50:06 -0000	1.82
+++ shared.cc	16 Nov 2004 01:42:19 -0000
@@ -161,16 +161,8 @@ user_shared_initialize (bool reinit)
     }

   if (!cygwin_user_h)
-    {
-      if (wincap.has_security ())
-	{
-	  cygpsid tu (cygheap->user.sid ());
-	  tu.string (name);
-	}
-      else
-	strcpy (name, cygheap->user.name ());
-    }
+    cygheap->user.get_windows_id (name);

   user_shared =3D (user_info *) open_shared (name, USER_VERSION,
 					    cygwin_user_h, sizeof (user_info),
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.349
diff -u -p -r1.349 syscalls.cc
--- syscalls.cc	28 Oct 2004 01:46:01 -0000	1.349
+++ syscalls.cc	16 Nov 2004 01:42:23 -0000
@@ -2008,13 +2008,16 @@ seteuid32 (__uid32_t uid)
   user_groups &groups =3D cygheap->user.groups;
   HANDLE ptok, new_token =3D INVALID_HANDLE_VALUE;
   struct passwd * pw_new;
-  bool token_is_internal, issamesid;
+  bool token_is_internal, issamesid =3D false;
   char dacl_buf[MAX_DACL_LEN (5)];
   TOKEN_DEFAULT_DACL tdacl =3D {};

   pw_new =3D internal_getpwuid (uid);
   if (!wincap.has_security () && pw_new)
+    {
+      load_registry_hive (pw_new->pw_name);
     goto success_9x;
+    }
   if (!usersid.getfrompw (pw_new))
     {
       set_errno (EINVAL);
@@ -2082,7 +2085,8 @@ seteuid32 (__uid32_t uid)
   if (new_token !=3D ptok)
     {
       /* Avoid having HKCU use default user */
-      load_registry_hive (usersid);
+      char name[128];
+      load_registry_hive (usersid.string (name));

       /* Try setting owner to same value as user. */
       if (!SetTokenInformation (new_token, TokenOwner,
@@ -2106,16 +2110,17 @@ seteuid32 (__uid32_t uid)
   cygheap->user.set_sid (usersid);
   cygheap->user.current_token =3D new_token =3D=3D ptok ? NO_IMPERSONATION
 						  : new_token;
-  if (!issamesid) /* MS KB 199190 */
-    RegCloseKey (HKEY_CURRENT_USER);
   cygheap->user.reimpersonate ();
-  if (!issamesid)
-    user_shared_initialize (true);

 success_9x:
   cygheap->user.set_name (pw_new->pw_name);
   myself->uid =3D uid;
   groups.ischanged =3D FALSE;
+  if (!issamesid) /* MS KB 199190 */
+    {
+      RegCloseKey (HKEY_CURRENT_USER);
+      user_shared_initialize (true);
+    }
   return 0;

 failed:

--=====================_1100589696==_--
