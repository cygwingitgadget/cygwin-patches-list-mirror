Return-Path: <cygwin-patches-return-4438-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5752 invoked by alias); 26 Nov 2003 01:56:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5742 invoked from network); 26 Nov 2003 01:56:32 -0000
Message-Id: <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 26 Nov 2003 01:56:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Create Global Privilege
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1069829733==_"
X-SW-Source: 2003-q4/txt/msg00157.txt.bz2

--=====================_1069829733==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1429

This patch will stop the "CreateFileMapping, Win32 error 5. Terminating."
complaints.

It changes shared_name() to avoid setting the Global\ prefix on file mappings
when the Create Global Object privilege may be required but the user doesn't
have it. 

Note that when running from the console or as a service, the names are
looked up
in the global name space by default (with or without privilege), thus it
doesn't
matter if the prefix is Global\ or "". 
In other words, there is no need to determine if the user is running from 
Terminal Services.

As a side effect, the cygheap must be initialized earlier in the startup
sequence because it is needed for CloseHandle when debugging is enabled
(thus the changes in memory_init and shared_info::initialize).

I don't have access to Terminal Services to test the patch, but Fabrice
Larribe
reports that it works fine on a system where he needed, but couldn't get, the
privilege. 

Pierre

2003-11-25  Pierre Humblet <pierre.humblet@ieee.org>

	* shared.cc (shared_name): Take into account the SE_CREATE_GLOBAL_NAME
	privilege when building the name string.
	(open_shared): Remove the call to OpenFileMapping.
	(shared_info::initialize): Move cygheap initialization to ...	
	(memory_init): ... here. Suppress now useless shared_h variable.
	(user_shared_initialize): Make tu a cygpsid.
	* sec_helper.cc (set_process_privilege): Call LookupPrivilegeValue
	before opening the token.

--=====================_1069829733==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shared.diff"
Content-length: 4001

Index: shared.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.78
diff -u -p -r1.78 shared.cc
--- shared.cc	14 Nov 2003 23:40:05 -0000	1.78
+++ shared.cc	26 Nov 2003 01:37:57 -0000
@@ -35,9 +35,14 @@ char * __stdcall
 shared_name (char *ret_buf, const char *str, int num)
 {
   extern bool _cygwin_testing;
+  static const char * prefix =3D NULL;

-  __small_sprintf (ret_buf, "%s%s.%s.%d",
-  		   wincap.has_terminal_services () ?  "Global\\" : "",
+  if (!prefix)
+    prefix =3D wincap.has_terminal_services ()
+             && ( set_process_privilege (SE_CREATE_GLOBAL_NAME, true) >=3D=
 0
+		  || GetLastError () =3D=3D ERROR_NO_SUCH_PRIVILEGE) ? "Global\\" : "";
+
+  __small_sprintf (ret_buf, "%s%s.%s.%d", prefix,
 		   cygwin_version.shared_id, str, num);
   if (_cygwin_testing)
     strcat (ret_buf, cygwin_version.dll_build_date);
@@ -91,15 +96,10 @@ open_shared (const char *name, int n, HA
       if (!name)
 	mapname =3D NULL;
       else
-	{
-	  mapname =3D shared_name (map_buf, name, n);
-	  shared_h =3D OpenFileMappingA (FILE_MAP_READ | FILE_MAP_WRITE,
-				       TRUE, mapname);
-	}
-      if (!shared_h &&
-	  !(shared_h =3D CreateFileMapping (INVALID_HANDLE_VALUE, psa,
+        mapname =3D shared_name (map_buf, name, n);
+      if (!(shared_h =3D CreateFileMapping (INVALID_HANDLE_VALUE, psa,
 					  PAGE_READWRITE, 0, size, mapname)))
-	api_fatal ("CreateFileMapping, %E.  Terminating.");
+	api_fatal ("CreateFileMapping %s, %E.  Terminating.", mapname);
     }

   shared =3D (shared_info *)
@@ -163,7 +163,7 @@ user_shared_initialize (bool reinit)
     {
       if (wincap.has_security ())
         {
-	  cygsid tu (cygheap->user.sid ());
+	  cygpsid tu (cygheap->user.sid ());
 	  tu.string (name);
 	}
       else
@@ -216,13 +216,6 @@ shared_info::initialize ()
 	low_priority_sleep (0);	// Should be hit only very very rarely
     }

-  /* Initialize the Cygwin heap, if necessary */
-  if (!cygheap)
-    {
-      cygheap_init ();
-      cygheap->user.init ();
-    }
-
   heap_init ();

   if (!sversion)
@@ -238,16 +231,21 @@ memory_init ()
 {
   getpagesize ();

+  /* Initialize the Cygwin heap, if necessary */
+  if (!cygheap)
+    {
+      cygheap_init ();
+      cygheap->user.init ();
+    }
+
   /* Initialize general shared memory */
-  HANDLE shared_h =3D cygheap ? cygheap->shared_h : NULL;
   cygwin_shared =3D (shared_info *) open_shared ("shared",
 					       CYGWIN_VERSION_SHARED_DATA,
-					       shared_h,
+					       cygheap->shared_h,
 					       sizeof (*cygwin_shared),
 					       SH_CYGWIN_SHARED);

   cygwin_shared->initialize ();
-  cygheap->shared_h =3D shared_h;
   ProtectHandleINH (cygheap->shared_h);

   user_shared_initialize (false);
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.45
diff -u -p -r1.45 sec_helper.cc
--- sec_helper.cc	4 Nov 2003 15:48:18 -0000	1.45
+++ sec_helper.cc	26 Nov 2003 01:38:17 -0000
@@ -305,18 +305,18 @@ set_process_privilege (const char *privi
   int ret =3D -1;
   DWORD size;

+  if (!LookupPrivilegeValue (NULL, privilege, &restore_priv))
+    {
+      __seterrno ();
+      goto out;
+    }
+
   if ((use_thread
        && !OpenThreadToken (GetCurrentThread (), TOKEN_QUERY | TOKEN_ADJUS=
T_PRIVILEGES,
 			    0, &hToken))
       ||(!use_thread
 	 && !OpenProcessToken (hMainProc, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES,
 			     &hToken)))
-    {
-      __seterrno ();
-      goto out;
-    }
-
-  if (!LookupPrivilegeValue (NULL, privilege, &restore_priv))
     {
       __seterrno ();
       goto out;

--=====================_1069829733==_--
