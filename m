From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Solve a problem triggered by duplicate names in /etc/passwd.
Date: Wed, 25 Apr 2001 05:41:00 -0000
Message-id: <s1ssnixnodp.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00158.html

The last patch of mine against `mkpasswd' can't solve another problem
triggered by the duplicate entries of Administrator in /etc/passwd.
The uid of processes executed by the local Administrator always
becomes the uid of the domain Administrator (10500).

The following patch can solve this problem.

2001-04-25  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* uinfo.cc (internal_getlogin): Return pointer to struct passwd.
	(uinfo_init): Accommodate the above change.
	* syscalls.cc (seteuid): Ditto.

Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.34
diff -u -p -r1.34 uinfo.cc
--- uinfo.cc	2001/04/25 09:43:25	1.34
+++ uinfo.cc	2001/04/25 12:25:30
@@ -26,11 +26,12 @@ details. */
 #include "registry.h"
 #include "security.h"
 
-const char *
+struct passwd *
 internal_getlogin (cygheap_user &user)
 {
   char username[MAX_USER_NAME];
   DWORD username_len = MAX_USER_NAME;
+  struct passwd *pw = NULL;
 
   if (!user.name ())
     if (!GetUserName (username, &username_len))
@@ -153,7 +154,6 @@ internal_getlogin (cygheap_user &user)
 	  cygsid gsid (NULL);
 	  if (ret)
 	    {
-	      struct passwd *pw;
 	      cygsid psid;
 
 	      if (!strcasematch (user.name (), "SYSTEM")
@@ -194,7 +194,7 @@ internal_getlogin (cygheap_user &user)
 	}
     }
   debug_printf ("Cygwins Username: %s", user.name ());
-  return user.name ();
+  return pw ?: getpwnam(user.name ());
 }
 
 void
@@ -212,7 +212,7 @@ uinfo_init ()
   /* If uid is USHRT_MAX, the process is started from a non cygwin
      process or the user context was changed in spawn.cc */
   if (myself->uid == USHRT_MAX)
-    if ((p = getpwnam (internal_getlogin (cygheap->user))) != NULL)
+    if ((p = internal_getlogin (cygheap->user)) != NULL)
       {
 	myself->uid = p->pw_uid;
 	/* Set primary group only if ntsec is off or the process has been
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.109
diff -u -p -r1.109 syscalls.cc
--- syscalls.cc	2001/04/25 09:43:25	1.109
+++ syscalls.cc	2001/04/25 12:25:30
@@ -1945,7 +1945,7 @@ setuid (uid_t uid)
   return ret;
 }
 
-extern const char *internal_getlogin (cygheap_user &user);
+extern struct passwd *internal_getlogin (cygheap_user &user);
 
 /* seteuid: standards? */
 extern "C" int
@@ -2015,7 +2015,7 @@ seteuid (uid_t uid)
 	     retrieving user's SID. */
 	  user.token = cygheap->user.impersonated ? cygheap->user.token
 						  : INVALID_HANDLE_VALUE;
-	  struct passwd *pw_cur = getpwnam (internal_getlogin (user));
+	  struct passwd *pw_cur = internal_getlogin (user);
 	  if (pw_cur != pw_new)
 	    {
 	      debug_printf ("Diffs!!! token: %d, cur: %d, new: %d, orig: %d",

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
