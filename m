Return-Path: <cygwin-patches-return-4192-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21097 invoked by alias); 10 Sep 2003 03:56:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21088 invoked from network); 10 Sep 2003 03:56:10 -0000
Message-Id: <3.0.5.32.20030909235426.008236c0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 10 Sep 2003 03:56:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Part 2 of Fixing a security hole in mount table.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1063180466==_"
X-SW-Source: 2003-q3/txt/msg00208.txt.bz2

--=====================_1063180466==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1055


This is the follow up on yesterday's patch.
There is no change in external behavior, just cleaning up.

The main innovation is the new function cygheap_user::init
that initializes the user name and sid just after the cygheap is
initialized. 
The information can then be used in user_shared_initialize and
need not be obtained again in internal_getlogin.

Pierre
 
2003-09-10  Pierre Humblet <pierre.humblet@ieee.org>

	* shared_info.h (shared_info::initialize): Remove argument.
	* cygheap.h (cygheap_user::init): New declaration.
	* uinfo.cc (cygheap_user::init): New.
	(internal_getlogin): Move functionality to cygheap_user::init.
	Open the process token to update the group sid.
	* shared.cc (user_shared_initialize): Get the user information
	from cygheap->user.
	(shared_info::initialize): Remove argument. Call cygheap->user.init
	instead of cygheap->user.set_name.
	(memory_init): Do not get the user name and do not pass it to
	shared_info::initialize.
	* registry.cc (get_registry_hive_path): Make csid a cygpsid.
	(load_registry_hive): Ditto.

--=====================_1063180466==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shared2.diff"
Content-length: 9003

Index: shared_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
retrieving revision 1.31
diff -u -p -r1.31 shared_info.h
--- shared_info.h	10 Sep 2003 02:12:25 -0000	1.31
+++ shared_info.h	10 Sep 2003 02:30:15 -0000
@@ -156,7 +156,7 @@ class shared_info

   tty_list tty;
   delqueue_list delqueue;
-  void initialize (const char *);
+  void initialize ();
   unsigned heap_chunk_size ();
 };

Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.63
diff -u -p -r1.63 cygheap.h
--- cygheap.h	5 Sep 2003 01:55:01 -0000	1.63
+++ cygheap.h	10 Sep 2003 02:30:16 -0000
@@ -134,6 +134,7 @@ public:

   ~cygheap_user ();

+  void init ();
   void set_name (const char *new_name);
   const char *name () const { return pname; }

Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.117
diff -u -p -r1.117 uinfo.cc
--- uinfo.cc	17 Aug 2003 17:50:40 -0000	1.117
+++ uinfo.cc	10 Sep 2003 02:30:17 -0000
@@ -30,44 +30,57 @@ details. */
 #include "environ.h"
 #include "pwdgrp.h"

+/* Initialize the part of cygheap_user that does not depend on files.
+   The information is used in shared.cc for the user shared.
+   Final initialization occurs in uinfo_init */
 void
-internal_getlogin (cygheap_user &user)
+cygheap_user::init()
 {
-  struct passwd *pw =3D NULL;
-  HANDLE ptok =3D INVALID_HANDLE_VALUE;
+  char user_name[UNLEN + 1];
+  DWORD user_name_len =3D UNLEN + 1;
+
+  set_name (GetUserName (user_name, &user_name_len) ? user_name : "unknown=
");

-  myself->gid =3D UNKNOWN_GID;
   if (wincap.has_security ())
     {
-      DWORD siz;
+      HANDLE ptok =3D NULL;
+      DWORD siz, ret;
       cygsid tu;
-      DWORD ret =3D 0;

-      /* Try to get the SID either from current process and
-	 store it in user.psid */
+      /* Get the SID from current process and store it in user.psid */
       if (!OpenProcessToken (hMainProc, TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
 			     &ptok))
 	system_printf ("OpenProcessToken(): %E");
-      else if (!GetTokenInformation (ptok, TokenUser, &tu, sizeof tu, &siz=
))
-	system_printf ("GetTokenInformation (TokenUser): %E");
-      else if (!(ret =3D user.set_sid (tu)))
-	system_printf ("Couldn't retrieve SID from access token!");
-      else if (!GetTokenInformation (ptok, TokenPrimaryGroup,
-				     &user.groups.pgsid, sizeof tu, &siz))
-	system_printf ("GetTokenInformation (TokenPrimaryGroup): %E");
-       /* We must set the user name, uid and gid.
-	 If we have a SID, try to get the corresponding Cygwin
-	 password entry. Set user name which can be different
-	 from the Windows user name */
-      if (ret)
+      else
 	{
-	  pw =3D internal_getpwsid (tu);
+	  if (!GetTokenInformation (ptok, TokenUser, &tu, sizeof tu, &siz))
+	    system_printf ("GetTokenInformation (TokenUser): %E");
+	  else if (!(ret =3D set_sid (tu)))
+	    system_printf ("Couldn't retrieve SID from access token!");
 	  /* Set token owner to the same value as token user */
-	  if (!SetTokenInformation (ptok, TokenOwner, &tu, sizeof tu))
+	  else if (!SetTokenInformation (ptok, TokenOwner, &tu, sizeof tu))
 	    debug_printf ("SetTokenInformation(TokenOwner): %E");
-	 }
+	  if (!GetTokenInformation (ptok, TokenPrimaryGroup,
+				    &groups.pgsid, sizeof tu, &siz))
+	    system_printf ("GetTokenInformation (TokenPrimaryGroup): %E");
+	  CloseHandle (ptok);
+	}
     }
+}

+void
+internal_getlogin (cygheap_user &user)
+{
+  struct passwd *pw =3D NULL;
+
+  myself->gid =3D UNKNOWN_GID;
+
+  if (wincap.has_security ())
+    {
+      cygpsid psid =3D user.sid ();
+      pw =3D internal_getpwsid (psid);
+    }
+
   if (!pw && !(pw =3D internal_getpwnam (user.name ()))
       && !(pw =3D internal_getpwuid (DEFAULT_UID)))
     debug_printf("user not found in augmented /etc/passwd");
@@ -81,19 +94,24 @@ internal_getlogin (cygheap_user &user)
 	  cygsid gsid;
 	  if (gsid.getfromgr (internal_getgrgid (pw->pw_gid)))
 	    {
-	      /* Set primary group to the group in /etc/passwd. */
-	      if (!SetTokenInformation (ptok, TokenPrimaryGroup,
-					&gsid, sizeof gsid))
-		debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
-	      else
-		user.groups.pgsid =3D gsid;
+	      HANDLE ptok;
+	      if (gsid !=3D user.groups.pgsid
+		  && OpenProcessToken (hMainProc, TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
+				     &ptok))
+	        {
+		  /* Set primary group to the group in /etc/passwd. */
+		  if (!SetTokenInformation (ptok, TokenPrimaryGroup,
+					    &gsid, sizeof gsid))
+		    debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
+		  else
+		    user.groups.pgsid =3D gsid;
+		  CloseHandle (ptok);
+		}
 	    }
 	  else
 	    debug_printf ("gsid not found in augmented /etc/group");
 	}
     }
-  if (ptok !=3D INVALID_HANDLE_VALUE)
-    CloseHandle (ptok);
   (void) cygheap->user.ontherange (CH_HOME, pw);

   return;
Index: shared.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.71
diff -u -p -r1.71 shared.cc
--- shared.cc	10 Sep 2003 02:12:26 -0000	1.71
+++ shared.cc	10 Sep 2003 02:30:17 -0000
@@ -148,35 +148,17 @@ open_shared (const char *name, int n, HA
 void
 user_shared_initialize ()
 {
-  char name[UNLEN + 1] =3D "";
+  char name[UNLEN > 127 ? UNLEN + 1 : 128] =3D "";

-  /* Temporary code. Will be cleaned up later */
   if (wincap.has_security ())
     {
-      HANDLE ptok =3D NULL;
-      DWORD siz;
-      cygsid tu;
-
-      if (cygwin_mount_h) /* Reinit */
-	tu =3D cygheap->user.sid ();
-      else
-        {
-	  if (!OpenProcessToken (hMainProc, TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
-				 &ptok))
-	    system_printf ("OpenProcessToken(): %E");
-	  else if (!GetTokenInformation (ptok, TokenUser, &tu, sizeof tu, &siz))
-	    system_printf ("GetTokenInformation (TokenUser): %E");
-	  else
-	    tu.string (name);
-	  if (ptok)
-	    CloseHandle (ptok);
-	}
+      cygsid tu (cygheap->user.sid ());
       tu.string (name);
     }
   else
     strcpy (name, cygheap->user.name ());

-  if (cygwin_mount_h)
+  if (cygwin_mount_h) /* Reinit */
     {
       if (!UnmapViewOfFile (mount_table))
 	debug_printf("UnmapViewOfFile %E");
@@ -211,7 +193,7 @@ user_shared_initialize ()
 }

 void
-shared_info::initialize (const char *user_name)
+shared_info::initialize ()
 {
   DWORD sversion =3D (DWORD) InterlockedExchange ((LONG *) &version, SHARE=
D_VERSION_MAGIC);
   if (!sversion)
@@ -237,7 +219,7 @@ shared_info::initialize (const char *use
   if (!cygheap)
     {
       cygheap_init ();
-      cygheap->user.set_name (user_name);
+      cygheap->user.init ();
     }

   heap_init ();
@@ -255,12 +237,6 @@ memory_init ()
 {
   getpagesize ();

-  char user_name[UNLEN + 1];
-  DWORD user_name_len =3D UNLEN + 1;
-
-  if (!GetUserName (user_name, &user_name_len))
-    strcpy (user_name, "unknown");
-
   /* Initialize general shared memory */
   HANDLE shared_h =3D cygheap ? cygheap->shared_h : NULL;
   cygwin_shared =3D (shared_info *) open_shared ("shared",
@@ -269,8 +245,7 @@ memory_init ()
 					       sizeof (*cygwin_shared),
 					       SH_CYGWIN_SHARED);

-  cygwin_shared->initialize (user_name);
-
+  cygwin_shared->initialize ();
   cygheap->shared_h =3D shared_h;
   ProtectHandleINH (cygheap->shared_h);

Index: registry.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/registry.cc,v
retrieving revision 1.16
diff -u -p -r1.16 registry.cc
--- registry.cc	5 Jun 2002 04:01:42 -0000	1.16
+++ registry.cc	10 Sep 2003 02:30:18 -0000
@@ -202,7 +202,7 @@ get_registry_hive_path (const PSID psid,

   if (!psid || !path)
     return NULL;
-  cygsid csid (psid);
+  cygpsid csid (psid);
   csid.string (sid);
   strcpy (key,"SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileLis=
t\\");
   strcat (key, sid);
@@ -233,7 +233,7 @@ load_registry_hive (PSID psid)
   if (!psid)
     return;
   /* Check if user hive is already loaded. */
-  cygsid csid (psid);
+  cygpsid csid (psid);
   csid.string (sid);
   if (!RegOpenKeyExA (HKEY_USERS, sid, 0, KEY_READ, &hkey))
     {

--=====================_1063180466==_--
