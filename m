Return-Path: <cygwin-patches-return-4236-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9478 invoked by alias); 26 Sep 2003 00:55:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9445 invoked from network); 26 Sep 2003 00:55:29 -0000
Message-Id: <3.0.5.32.20030925204653.008234f0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 26 Sep 2003 00:55:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Recent security improvements breaks proftpd 
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1064551613==_"
X-SW-Source: 2003-q3/txt/msg00252.txt.bz2

--=====================_1064551613==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1273

This fixes the bug recently reported by Jason Tishler, by making sure
that a user is always included in its default DACL.

It also puts cygsids in the cygheap_user structure, to simplify the code
and avoid the use of cmalloc.

During tests I noticed that empty space at the end of an acl is 
included in the token default DACL (at least on NT4) and can cause
"not enough space" failures.
To avoid potential problems I went back to sec_acl() to set the acl
size correctly there too.

Pierre


2003-09-25  Pierre Humblet <pierre.humblet@ieee.org>

	* uinfo.cc (cygheap_user::init): Make sure the current user appears
	in the default DACL. Rearrange to decrease the indentation levels. 
	Initialize the effec_cygsid directly.
	(internal_getlogin): Do not reinitialize myself->gid. Open the process
	token with the required access.
	* cygheap.h (class cygheap_user): Delete members pid and saved_psid.
	Create members effec_cygsid and saved_cygsid.
	(cygheap_user::set_sid): Define inline.
	(cygheap_user::set_saved_sid): Ditto.
	(cygheap_user::sid): Modify.
	(cygheap_user::saved_sid): Modify.
	* cygheap.cc (cygheap_user::set_sid): Delete.
	(cygheap_user::set_saved_sid): Ditto.
	* sec_helper.cc (sec_acl): Set the correct acl size.
	* autoload.cc (FindFirstFreeAce): Add.
	

--=====================_1064551613==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="jason.diff"
Content-length: 8746

Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.120
diff -u -p -r1.120 uinfo.cc
--- uinfo.cc	25 Sep 2003 00:37:17 -0000	1.120
+++ uinfo.cc	26 Sep 2003 00:11:35 -0000
@@ -41,31 +41,63 @@ cygheap_user::init()

   set_name (GetUserName (user_name, &user_name_len) ? user_name : "unknown=
");

-  if (wincap.has_security ())
+  if (!wincap.has_security ())
+    return;
+
+  HANDLE ptok;
+  DWORD siz;
+  char buf [1024];
+
+  PTOKEN_DEFAULT_DACL pdacl =3D (PTOKEN_DEFAULT_DACL) buf;
+
+  if (!OpenProcessToken (hMainProc, TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
+			 &ptok))
     {
-      HANDLE ptok =3D NULL;
-      DWORD siz, ret;
-      cygsid tu;
-
-      /* Get the SID from current process and store it in user.psid */
-      if (!OpenProcessToken (hMainProc, TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
-			     &ptok))
-	system_printf ("OpenProcessToken(): %E");
-      else
-	{
-	  if (!GetTokenInformation (ptok, TokenUser, &tu, sizeof tu, &siz))
-	    system_printf ("GetTokenInformation (TokenUser): %E");
-	  else if (!(ret =3D set_sid (tu)))
-	    system_printf ("Couldn't retrieve SID from access token!");
-	  /* Set token owner to the same value as token user */
-	  else if (!SetTokenInformation (ptok, TokenOwner, &tu, sizeof tu))
-	    debug_printf ("SetTokenInformation(TokenOwner): %E");
-	  if (!GetTokenInformation (ptok, TokenPrimaryGroup,
-				    &groups.pgsid, sizeof tu, &siz))
-	    system_printf ("GetTokenInformation (TokenPrimaryGroup): %E");
-	  CloseHandle (ptok);
+      system_printf ("OpenProcessToken(): %E");
+      return;
+    }
+  if (!GetTokenInformation (ptok, TokenPrimaryGroup,
+			    &groups.pgsid, sizeof (cygsid), &siz))
+    system_printf ("GetTokenInformation (TokenPrimaryGroup): %E");
+
+  /* Get the SID from current process and store it in effec_cygsid */
+  if (!GetTokenInformation (ptok, TokenUser, &effec_cygsid, sizeof (cygsid=
), &siz))
+    {
+      system_printf ("GetTokenInformation (TokenUser): %E");
+      goto out;
+    }
+
+  /* Set token owner to the same value as token user */
+  if (!SetTokenInformation (ptok, TokenOwner, &effec_cygsid, sizeof (cygsi=
d)))
+    debug_printf ("SetTokenInformation(TokenOwner): %E");
+
+  /* Add the user in the default DACL if needed */
+  if (!GetTokenInformation (ptok, TokenDefaultDacl, buf, sizeof (buf), &si=
z))
+    system_printf ("GetTokenInformation (TokenDefaultDacl): %E");
+  else if (pdacl->DefaultDacl) /* Running with security */
+    {
+      PACL pAcl =3D pdacl->DefaultDacl;
+      PACCESS_ALLOWED_ACE pAce;
+
+      for (int i =3D 0; i < pAcl->AceCount; i++)
+        {
+	  if (!GetAce(pAcl, i, (LPVOID *) &pAce))
+	    system_printf ("GetAce: %E");
+	  else if (pAce->Header.AceType =3D=3D ACCESS_ALLOWED_ACE_TYPE
+		   && effec_cygsid =3D=3D &pAce->SidStart)
+	    goto out;
 	}
+      pAcl->AclSize =3D &buf[sizeof (buf)] - (char *) pAcl;
+      if (!AddAccessAllowedAce (pAcl, ACL_REVISION, GENERIC_ALL, effec_cyg=
sid))
+	system_printf ("AddAccessAllowedAce: %E");
+      else if (FindFirstFreeAce (pAcl, (LPVOID *) &pAce), !(pAce))
+	debug_printf ("FindFirstFreeAce %E");
+      else if (pAcl->AclSize =3D (char *) pAce - (char *) pAcl,
+	       !SetTokenInformation (ptok, TokenDefaultDacl, pdacl, sizeof (buf)))
+	system_printf ("SetTokenInformation (TokenDefaultDacl): %E");
     }
+ out:
+  CloseHandle (ptok);
 }

 void
@@ -73,8 +105,6 @@ internal_getlogin (cygheap_user &user)
 {
   struct passwd *pw =3D NULL;

-  myself->gid =3D UNKNOWN_GID;
-
   if (wincap.has_security ())
     {
       cygpsid psid =3D user.sid ();
@@ -96,8 +126,7 @@ internal_getlogin (cygheap_user &user)
 	    {
 	      HANDLE ptok;
 	      if (gsid !=3D user.groups.pgsid
-		  && OpenProcessToken (hMainProc, TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
-				     &ptok))
+		  && OpenProcessToken (hMainProc, TOKEN_ADJUST_DEFAULT, &ptok))
 	        {
 		  /* Set primary group to the group in /etc/passwd. */
 		  if (!SetTokenInformation (ptok, TokenPrimaryGroup,
Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.66
diff -u -p -r1.66 cygheap.h
--- cygheap.h	25 Sep 2003 00:37:16 -0000	1.66
+++ cygheap.h	26 Sep 2003 00:11:36 -0000
@@ -106,8 +106,8 @@ class cygheap_user
   char  *homepath;	/* User's home path */
   char  *pwinname;	/* User's name as far as Windows knows it */
   char  *puserprof;	/* User profile */
-  PSID   psid;          /* buffer for user's SID */
-  PSID   saved_psid;    /* Remains intact even after impersonation */
+  cygsid effec_cygsid;  /* buffer for user's SID */
+  cygsid saved_cygsid;  /* Remains intact even after impersonation */
 public:
   __uid32_t saved_uid;     /* Remains intact even after impersonation */
   __gid32_t saved_gid;     /* Ditto */
@@ -160,10 +160,10 @@ public:
     const char *p =3D env_domain ("USERDOMAIN=3D", sizeof ("USERDOMAIN=3D"=
) - 1);
     return (p =3D=3D almost_null) ? NULL : p;
   }
-  BOOL set_sid (PSID new_sid);
-  BOOL set_saved_sid ();
-  PSID sid () const { return psid; }
-  PSID saved_sid () const { return saved_psid; }
+  BOOL set_sid (PSID new_sid) {return (BOOL) (effec_cygsid =3D new_sid);}
+  BOOL set_saved_sid () { return (BOOL) (saved_cygsid =3D effec_cygsid); }
+  PSID sid () { return effec_cygsid; }
+  PSID saved_sid () { return saved_cygsid; }
   const char *ontherange (homebodies what, struct passwd * =3D NULL);
   bool issetuid () const { return current_token !=3D INVALID_HANDLE_VALUE;=
 }
   HANDLE token () { return current_token; }
Index: cygheap.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.cc,v
retrieving revision 1.85
diff -u -p -r1.85 cygheap.cc
--- cygheap.cc	25 Sep 2003 00:37:16 -0000	1.85
+++ cygheap.cc	26 Sep 2003 00:11:37 -0000
@@ -444,28 +444,3 @@ cygheap_user::set_name (const char *new_
   cfree_and_set (pwinname);
 }

-BOOL
-cygheap_user::set_sid (PSID new_sid)
-{
-  if (new_sid)
-    {
-      if (!psid)
-	psid =3D cmalloc (HEAP_STR, MAX_SID_LEN);
-      if (psid)
-	return CopySid (MAX_SID_LEN, psid, new_sid);
-    }
-  return FALSE;
-}
-
-BOOL
-cygheap_user::set_saved_sid ()
-{
-  if (psid)
-    {
-      if (!saved_psid)
-        saved_psid =3D cmalloc (HEAP_STR, MAX_SID_LEN);
-      if (saved_psid)
-	return CopySid (MAX_SID_LEN, saved_psid, psid);
-    }
-  return FALSE;
-}
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.43
diff -u -p -r1.43 sec_helper.cc
--- sec_helper.cc	25 Sep 2003 03:51:50 -0000	1.43
+++ sec_helper.cc	26 Sep 2003 00:11:37 -0000
@@ -375,6 +375,7 @@ BOOL
 sec_acl (PACL acl, bool original, bool admins, PSID sid1, PSID sid2, DWORD=
 access2)
 {
   size_t acl_len =3D MAX_DACL_LEN(5);
+  LPVOID pAce;
   cygpsid psid;

   if (!InitializeAcl (acl, acl_len, ACL_REVISION))
@@ -402,6 +403,12 @@ sec_acl (PACL acl, bool original, bool a
   if (!AddAccessAllowedAce (acl, ACL_REVISION,
 			    GENERIC_ALL, well_known_system_sid))
     debug_printf ("AddAccessAllowedAce(system) %E");
+  FindFirstFreeAce (acl, &pAce);
+  if (pAce)
+    acl->AclSize =3D (char *) pAce - (char *) acl;
+  else
+    debug_printf ("FindFirstFreeAce %E");
+
   return TRUE;
 }

Index: autoload.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.73
diff -u -p -r1.73 autoload.cc
--- autoload.cc	10 Sep 2003 15:51:58 -0000	1.73
+++ autoload.cc	26 Sep 2003 00:11:38 -0000
@@ -320,6 +320,7 @@ LoadDLLfunc (DeregisterEventSource, 4, a
 LoadDLLfunc (DuplicateToken, 12, advapi32)
 LoadDLLfuncEx (DuplicateTokenEx, 24, advapi32, 1)
 LoadDLLfunc (EqualSid, 8, advapi32)
+LoadDLLfunc (FindFirstFreeAce, 8, advapi32)
 LoadDLLfunc (GetAce, 12, advapi32)
 LoadDLLfunc (GetFileSecurityA, 20, advapi32)
 LoadDLLfunc (GetKernelObjectSecurity, 20, advapi32)

--=====================_1064551613==_--
