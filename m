Return-Path: <cygwin-patches-return-2163-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4459 invoked by alias); 8 May 2002 02:35:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4206 invoked from network); 8 May 2002 02:35:05 -0000
Message-Id: <3.0.5.32.20020507223050.007b2550@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Tue, 07 May 2002 19:35:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Security patches
In-Reply-To: <20020412095426.B20149@cygbert.vinschen.de>
References: <3CB58D37.52F084E@ieee.org>
 <3.0.5.32.20020309192813.007fcb70@pop.ne.mediaone.net>
 <20020314133309.Q29574@cygbert.vinschen.de>
 <3C90B0D7.EB06F222@ieee.org>
 <3CB58D37.52F084E@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1020839450==_"
X-SW-Source: 2002-q2/txt/msg00147.txt.bz2

--=====================_1020839450==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1104

At 09:54 AM 4/12/2002 +0200, Corinna Vinschen wrote:
>I hope you don't mind that I'm asking you to send the patch again
>to cygwin-patches, relative to the current CVS. 

Here is the second installment. The only substantial change is that
in __sec_user() sid1 is not obtained from cygheap->user.sid ()
but from a new function getting the sid of the process token user.
That is because we want the "old" sid, but cygheap->user.sid can
already be the "new" sid.
Instead of having this new function it would be more elegant to
keep this important sid as a NO_COPY variable (initialized in
dcrt0.cc), or perhaps in cygheap. It's largely a matter of taste.

The split of __sec_user() in two functions is for software modularity
and reuse. The function will be reused in installment #3.

Pierre

2002-05-07  Pierre Humblet <pierre.humblet@ieee.org>
	* shared.cc (sec_process_sid): Create.
	(sec_acl): Create from part of __sec_user(), except creator/owner.
	(__sec_user): Split into sec_acl(). Call sec_process_sid()
	instead of cygheap->user.sid().
	* security.h: Define new functions above and MAX_DACL_LEN.

--=====================_1020839450==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shared.cc.diff"
Content-length: 3509

--- shared.cc.orig	Sun May  5 10:49:32 2002
+++ shared.cc	Sun May  5 13:37:14 2002
@@ -236,6 +236,58 @@
   return null_sdp;
 }

+BOOL
+sec_acl (PACL acl, BOOL admins, PSID sid1, PSID sid2)
+{
+  size_t acl_len =3D MAX_DACL_LEN(5);
+
+  if (!InitializeAcl (acl, acl_len, ACL_REVISION))
+    {
+      debug_printf ("InitializeAcl %E");
+      return FALSE;
+    }
+  if (sid2)
+    if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			      GENERIC_ALL, sid2))
+      debug_printf ("AddAccessAllowedAce(sid2) %E");
+  if (sid1)
+    if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			      GENERIC_ALL, sid1))
+      debug_printf ("AddAccessAllowedAce(sid1) %E", sid1);
+  if (admins)
+    if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			      GENERIC_ALL, well_known_admins_sid))
+      debug_printf ("AddAccessAllowedAce(admin) %E");
+  if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			    GENERIC_ALL, well_known_system_sid))
+    debug_printf ("AddAccessAllowedAce(system) %E");
+#if 0
+  if (!AddAccessAllowedAce (acl, ACL_REVISION,
+			    GENERIC_ALL, well_known_creator_owner_sid))
+    debug_printf ("AddAccessAllowedAce(creator_owner) %E");
+#endif
+  return TRUE;
+}
+
+void
+sec_process_sid(cygsid &sid)
+{
+  HANDLE token;
+  DWORD size;
+  sid =3D NO_SID;
+  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_QUERY, &token))
+    debug_printf ("OpenProcessToken(token_query): %E\n");
+  else
+    {
+      if (!GetTokenInformation (token, TokenUser,
+				&sid, sizeof sid, &size))
+	debug_printf ("GetTokenInformation(TokenUser): %E");
+      CloseHandle (token);
+    }
+  return;
+}
+
+
 PSECURITY_ATTRIBUTES __stdcall
 __sec_user (PVOID sa_buf, PSID sid2, BOOL inherit)
 {
@@ -246,49 +298,9 @@

   cygsid sid;

-  if (cygheap->user.sid ())
-    sid =3D cygheap->user.sid ();
-  else if (!lookup_name (getlogin (), cygheap->user.logsrv (), sid))
+  sec_process_sid(sid);
+  if (!sec_acl (acl, TRUE, sid, sid2))
     return inherit ? &sec_none : &sec_none_nih;
-
-  size_t acl_len =3D sizeof (ACL)
-		   + 4 * (sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD))
-		   + GetLengthSid (sid)
-		   + GetLengthSid (well_known_admins_sid)
-		   + GetLengthSid (well_known_system_sid)
-		   + GetLengthSid (well_known_creator_owner_sid);
-  if (sid2)
-    acl_len +=3D sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD)
-	       + GetLengthSid (sid2);
-
-  if (!InitializeAcl (acl, acl_len, ACL_REVISION))
-    debug_printf ("InitializeAcl %E");
-
-  if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			    SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			    sid))
-    debug_printf ("AddAccessAllowedAce(%s) %E", getlogin ());
-
-  if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			    SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			    well_known_admins_sid))
-    debug_printf ("AddAccessAllowedAce(admin) %E");
-
-  if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			    SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			    well_known_system_sid))
-    debug_printf ("AddAccessAllowedAce(system) %E");
-
-  if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			    SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			    well_known_creator_owner_sid))
-    debug_printf ("AddAccessAllowedAce(creator_owner) %E");
-
-  if (sid2)
-    if (!AddAccessAllowedAce (acl, ACL_REVISION,
-			      SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL,
-			      sid2))
-      debug_printf ("AddAccessAllowedAce(sid2) %E");

   if (!InitializeSecurityDescriptor (psd, SECURITY_DESCRIPTOR_REVISION))
     debug_printf ("InitializeSecurityDescriptor %E");

--=====================_1020839450==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="security.h.diff"
Content-length: 853

--- security.h.orig	Sun May  5 14:47:00 2002
+++ security.h	Sun May  5 14:47:46 2002
@@ -16,6 +16,8 @@
 #define DEFAULT_GID DOMAIN_ALIAS_RID_ADMINS
 
 #define MAX_SID_LEN 40
+#define MAX_DACL_LEN(n) (sizeof (ACL) \
+		   + (n) * (sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD) + MAX_SID_LEN))
 
 #define NO_SID ((PSID)NULL)
 
@@ -201,6 +203,8 @@
 extern SECURITY_ATTRIBUTES sec_none, sec_none_nih, sec_all, sec_all_nih;
 extern SECURITY_ATTRIBUTES *__stdcall __sec_user (PVOID sa_buf, PSID sid2, BOOL inherit)
   __attribute__ ((regparm (3)));
+extern BOOL sec_acl (PACL acl, BOOL admins, PSID sid1 = NO_SID, PSID sid2 = NO_SID);
+extern void sec_process_sid(cygsid &sid);
 
 int __stdcall NTReadEA (const char *file, const char *attrname, char *buf, int len);
 BOOL __stdcall NTWriteEA (const char *file, const char *attrname, const char *buf, int len);

--=====================_1020839450==_--
