From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Set default DACL in setup.exe
Date: Mon, 06 Aug 2001 15:16:00 -0000
Message-id: <20010807001602.N23782@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00064.html

Hi,

for reasons written about in cygwin-developers (see thread
"Silly ACL problems") I have patched setup.exe to create
all files with full access for everyone on NT/W2K as long
as the parent directory doesn't define propagated permissions.

This is done by changing the default DACL in the process token.

Ok to check in?

ChangeLog:
==========

2001-08-07  Corinna Vinschen  <corinna@vinschen.de>

	* autoload.c: Add dynamic load statements for NT/W2K
	advapi32 functions not available in 9x/ME.
	* main.cc (set_default_dacl): New function.
	(WinMain): Call `set_default_dacl' if running on NT/W2K.

Index: autoload.c
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/autoload.c,v
retrieving revision 2.1
diff -u -p -r2.1 autoload.c
--- autoload.c	2000/08/30 01:05:42	2.1
+++ autoload.c	2001/08/06 22:10:20
@@ -45,6 +45,15 @@ Auto (wininet, InternetQueryOptionA, 16)
 Auto (wininet, HttpQueryInfoA, 20);
 Auto (wininet, HttpSendRequestA, 20);
 
+DLL (advapi32);
+
+Auto (advapi32, AddAccessAllowedAce, 16);
+Auto (advapi32, AllocateAndInitializeSid, 44);
+Auto (advapi32, FreeSid, 4);
+Auto (advapi32, InitializeAcl, 12);
+Auto (advapi32, OpenProcessToken, 12);
+Auto (advapi32, SetTokenInformation, 16);
+
 typedef struct {
   DllInfo *dll;
   char name[100];
Index: main.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/main.cc,v
retrieving revision 2.5
diff -u -p -r2.5 main.cc
--- main.cc	2001/05/31 19:04:29	2.5
+++ main.cc	2001/08/06 22:10:20
@@ -48,6 +48,79 @@ int exit_msg = 0;
 
 HINSTANCE hinstance;
 
+/* Maximum size of a SID on NT/W2K. */
+#define MAX_SID_LEN	40
+
+/* Computes the size of an ACL in relation to the number of ACEs it
+   should contain. */
+#define TOKEN_ACL_SIZE(cnt) (sizeof(ACL) + \
+			     (cnt) * (sizeof(ACCESS_ALLOWED_ACE) + MAX_SID_LEN))
+
+#define iswinnt		(GetVersion() < 0x80000000)
+
+void
+set_default_dacl ()
+{
+  /* To assure that the created files have a useful ACL, the 
+  default DACL in the process token is set to full access to
+  everyone. This applies to files and subdirectories created
+  in directories which don't propagate permissions to child
+  objects. */
+
+  /* Create a buffer which has enough room to contain the TOKEN_DEFAULT_DACL
+     structure plus an ACL with one ACE. */
+  char buf[sizeof (TOKEN_DEFAULT_DACL) + TOKEN_ACL_SIZE (1)];
+
+  /* First initialize the TOKEN_DEFAULT_DACL structure. */
+  PTOKEN_DEFAULT_DACL dacl = (PTOKEN_DEFAULT_DACL) buf;
+  dacl->DefaultDacl = (PACL) (buf + sizeof *dacl);
+
+  /* Initialize the ACL for containing one ACE. */
+  if (!InitializeAcl (dacl->DefaultDacl, TOKEN_ACL_SIZE (1), ACL_REVISION))
+    {
+      log (LOG_TIMESTAMP, "InitializeAcl() failed: %lu", GetLastError ());
+      return;
+    }
+
+  /* Get the SID for "Everyone". */
+  PSID sid;
+  SID_IDENTIFIER_AUTHORITY sid_auth = SECURITY_WORLD_SID_AUTHORITY;
+  if (!AllocateAndInitializeSid(&sid_auth, 1, 0, 0, 0, 0, 0, 0, 0, 0, &sid))
+    {
+      log (LOG_TIMESTAMP, "AllocateAndInitializeSid() failed: %lu",
+	   GetLastError ());
+      return;
+    }
+
+  /* Create the ACE which grants full access to "Everyone" and store it
+     in dacl->DefaultDacl. */
+  if (!AddAccessAllowedAce (dacl->DefaultDacl, ACL_REVISION, GENERIC_ALL, sid))
+    {
+      log (LOG_TIMESTAMP, "AddAccessAllowedAce() failed: %lu", GetLastError ());
+      goto out;
+    }
+
+  /* Get the processes access token. */
+  HANDLE token;
+  if (!OpenProcessToken (GetCurrentProcess (),
+  			 TOKEN_READ | TOKEN_ADJUST_DEFAULT, &token))
+    {
+      log (LOG_TIMESTAMP, "OpenProcessToken() failed: %lu", GetLastError ());
+      goto out;
+    }
+
+  /* Set the default DACL to the above computed ACL. */
+  if (!SetTokenInformation (token, TokenDefaultDacl, dacl, sizeof buf))
+    log (LOG_TIMESTAMP, "OpenProcessToken() failed: %lu", GetLastError ());
+
+  /* Close token handle. */
+  CloseHandle (token);
+
+out:
+  /* Free memory occupied by the "Everyone" SID. */
+  FreeSid (sid);
+}
+
 int WINAPI
 WinMain (HINSTANCE h,
 	 HINSTANCE hPrevInstance,
@@ -64,6 +137,11 @@ WinMain (HINSTANCE h,
   GetCurrentDirectory (sizeof (cwd), cwd);
   local_dir = strdup (cwd);
   log (0, "Current Directory: %s", cwd);
+
+  /* Set the default DACL only on NT/W2K. 9x/ME has no idea of access
+     control lists and security at all. */
+  if (iswinnt)
+    set_default_dacl ();
 
   while (next_dialog)
     {

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
