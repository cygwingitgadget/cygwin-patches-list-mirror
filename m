Return-Path: <cygwin-patches-return-5091-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17411 invoked by alias); 28 Oct 2004 00:37:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17383 invoked from network); 28 Oct 2004 00:37:34 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.203.248)
  by sourceware.org with SMTP; 28 Oct 2004 00:37:34 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I69R6J-000AHR-KV; Wed, 27 Oct 2004 20:39:55 -0400
Message-Id: <3.0.5.32.20041027203301.0081e7d0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 28 Oct 2004 00:37:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Deimpersonate while accessing HKLM
Cc: Jason Tishler <jason@tishler.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1098937981==_"
X-SW-Source: 2004-q4/txt/msg00092.txt.bz2

--=====================_1098937981==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 937

This patch should fix the chdir problem reported by Jason Tishler.
It deimpersonates while reading the mounts and cygdrive in HKLM.

For ease of initialization, the unused cygheap->user tokens are
now set to NO_IMPERSONATION (instead of INVALID_HANDLE_VALUE), 
which is #defined as NULL.
If the argument of cygwin_set_impersonation_token() is
INVALID_HANDLE_VALUE, it is changed to NO_IMPERSONATION.

Pierre

2004-10-28  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (mount_info::from_registry): Deimpersonate while
	accessing HKLM.
	(mount_info::read_cygdrive_info_from_registry): Ditto.
	* cygheap.h: Define NO_IMPERSONATION.
	(cygheap_user::issetuid): Replace INVALID_HANDLE_VALUE by 
	NO_IMPERSONATION.
	(cygheap_user::has_impersonation_tokens): Ditto.
	(cygheap_user::close_impersonation_tokens): Ditto.
	* uinfo.cc (uinfo_init): Ditto.
	* syscalls.cc (seteuid32): Ditto.
	* security.cc (set_impersonation_token): Ditto.

   
--=====================_1098937981==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="imperson.diff"
Content-length: 8105

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.324
diff -u -p -r1.324 path.cc
--- path.cc	6 Oct 2004 01:33:39 -0000	1.324
+++ path.cc	27 Oct 2004 23:43:26 -0000
@@ -1802,11 +1802,13 @@ mount_info::from_registry ()
   read_mounts (r);

   /* Then read mounts from system-wide mount table. */
+  cygheap->user.deimpersonate ();
   reg_key r1 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
 	      CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
 	      CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
 	      NULL);
   read_mounts (r1);
+  cygheap->user.reimpersonate ();
 }

 /* add_reg_mount: Add mount item to registry.  Return zero on success,
@@ -1922,16 +1924,16 @@ mount_info::read_cygdrive_info_from_regi
 {
   /* reg_key for user path prefix in HKEY_CURRENT_USER. */
   reg_key r;
-
+  /* First read cygdrive from user's registry. */
   if (r.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, cygdrive, sizeof (cygdriv=
e), "") !=3D 0)
     {
-      /* Didn't find the user path prefix so check the system path prefix.=
 */
-
-      /* reg_key for system path prefix in HKEY_LOCAL_MACHINE.  */
+      /* Then read cygdrive from system-wide registry. */
+      cygheap->user.deimpersonate ();
       reg_key r2 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
 		 CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
 		 CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
 		 NULL);
+      cygheap->user.reimpersonate ();

       if (r2.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, cygdrive,
 	  sizeof (cygdrive), ""))
Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.90
diff -b -u -p -r1.90 cygheap.h
--- cygheap.h	7 Oct 2004 21:28:57 -0000	1.90
+++ cygheap.h	28 Oct 2004 00:09:18 -0000
@@ -169,7 +169,8 @@ public:
   PSID sid () { return effec_cygsid; }
   PSID saved_sid () { return saved_cygsid; }
   const char *ontherange (homebodies what, struct passwd * =3D NULL);
-  bool issetuid () const { return current_token !=3D INVALID_HANDLE_VALUE;=
 }
+#define NO_IMPERSONATION NULL
+  bool issetuid () const { return current_token !=3D NO_IMPERSONATION; }
   HANDLE token () { return current_token; }
   void deimpersonate ()
   {
@@ -183,26 +184,26 @@ public:
       system_printf ("ImpersonateLoggedOnUser: %E");
   }
   bool has_impersonation_tokens ()
-    { return external_token !=3D INVALID_HANDLE_VALUE
-	     || internal_token !=3D INVALID_HANDLE_VALUE
-	     || current_token !=3D INVALID_HANDLE_VALUE; }
+    { return external_token !=3D NO_IMPERSONATION
+	     || internal_token !=3D NO_IMPERSONATION
+	     || current_token !=3D NO_IMPERSONATION; }
   void close_impersonation_tokens ()
   {
-    if (current_token !=3D INVALID_HANDLE_VALUE)
+    if (current_token !=3D NO_IMPERSONATION)
       {
 	if( current_token !=3D external_token && current_token !=3D internal_toke=
n)
 	  CloseHandle (current_token);
-	current_token =3D INVALID_HANDLE_VALUE;
+	current_token =3D NO_IMPERSONATION;
       }
-    if (external_token !=3D INVALID_HANDLE_VALUE)
+    if (external_token !=3D NO_IMPERSONATION)
       {
 	CloseHandle (external_token);
-	external_token =3D INVALID_HANDLE_VALUE;
+	external_token =3D NO_IMPERSONATION;
       }
-    if (internal_token !=3D INVALID_HANDLE_VALUE)
+    if (internal_token !=3D NO_IMPERSONATION)
       {
 	CloseHandle (internal_token);
-	internal_token =3D INVALID_HANDLE_VALUE;
+	internal_token =3D NO_IMPERSONATION;
       }
   }
   const char *cygheap_user::test_uid (char *&, const char *, size_t)
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.131
diff -b -u -p -r1.131 uinfo.cc
--- uinfo.cc	7 Oct 2004 21:28:57 -0000	1.131
+++ uinfo.cc	28 Oct 2004 00:09:19 -0000
@@ -160,9 +160,9 @@ uinfo_init ()

   cygheap->user.saved_uid =3D cygheap->user.real_uid =3D myself->uid;
   cygheap->user.saved_gid =3D cygheap->user.real_gid =3D myself->gid;
-  cygheap->user.external_token =3D INVALID_HANDLE_VALUE;
-  cygheap->user.internal_token =3D INVALID_HANDLE_VALUE;
-  cygheap->user.current_token =3D INVALID_HANDLE_VALUE;
+  cygheap->user.external_token =3D NO_IMPERSONATION;
+  cygheap->user.internal_token =3D NO_IMPERSONATION;
+  cygheap->user.current_token =3D NO_IMPERSONATION;
   cygheap->user.set_saved_sid ();	/* Update the original sid */
 }

Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.348
diff -b -u -p -r1.348 syscalls.cc
--- syscalls.cc	17 Sep 2004 09:10:53 -0000	1.348
+++ syscalls.cc	28 Oct 2004 00:09:22 -0000
@@ -2032,17 +2032,17 @@ seteuid32 (__uid32_t uid)
   if (verify_token (ptok, usersid, groups))
     new_token =3D ptok;
   /* Verify if the external token is suitable */
-  else if (cygheap->user.external_token !=3D INVALID_HANDLE_VALUE
+  else if (cygheap->user.external_token !=3D NO_IMPERSONATION
 	   && verify_token (cygheap->user.external_token, usersid, groups))
     new_token =3D cygheap->user.external_token;
   /* Verify if the current token (internal or former external) is suitable=
 */
-  else if (cygheap->user.current_token !=3D INVALID_HANDLE_VALUE
+  else if (cygheap->user.current_token !=3D NO_IMPERSONATION
 	   && cygheap->user.current_token !=3D cygheap->user.external_token
 	   && verify_token (cygheap->user.current_token, usersid, groups,
 			    &token_is_internal))
     new_token =3D cygheap->user.current_token;
   /* Verify if the internal token is suitable */
-  else if (cygheap->user.internal_token !=3D INVALID_HANDLE_VALUE
+  else if (cygheap->user.internal_token !=3D NO_IMPERSONATION
 	   && cygheap->user.internal_token !=3D cygheap->user.current_token
 	   && verify_token (cygheap->user.internal_token, usersid, groups,
 			    &token_is_internal))
@@ -2074,10 +2074,11 @@ seteuid32 (__uid32_t uid)
 	    goto failed;
 	}
       /* Keep at most one internal token */
-      if (cygheap->user.internal_token !=3D INVALID_HANDLE_VALUE)
+      if (cygheap->user.internal_token !=3D NO_IMPERSONATION)
 	CloseHandle (cygheap->user.internal_token);
       cygheap->user.internal_token =3D new_token;
     }
+
   if (new_token !=3D ptok)
     {
       /* Avoid having HKCU use default user */
@@ -2103,7 +2104,7 @@ seteuid32 (__uid32_t uid)
   CloseHandle (ptok);
   issamesid =3D (usersid =3D=3D cygheap->user.sid ());
   cygheap->user.set_sid (usersid);
-  cygheap->user.current_token =3D new_token =3D=3D ptok ? INVALID_HANDLE_V=
ALUE
+  cygheap->user.current_token =3D new_token =3D=3D ptok ? NO_IMPERSONATION
 						  : new_token;
   if (!issamesid) /* MS KB 199190 */
     RegCloseKey (HKEY_CURRENT_USER);
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.177
diff -b -u -p -r1.177 security.cc
--- security.cc	6 Oct 2004 01:33:39 -0000	1.177
+++ security.cc	28 Oct 2004 00:09:26 -0000
@@ -69,7 +69,7 @@ extern "C" void
 cygwin_set_impersonation_token (const HANDLE hToken)
 {
   debug_printf ("set_impersonation_token (%d)", hToken);
-  cygheap->user.external_token =3D hToken;
+  cygheap->user.external_token =3D hToken =3D=3D INVALID_HANDLE_VALUE ? NO=
_IMPERSONATION : hToken;
   return;
 }


--=====================_1098937981==_--
