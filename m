From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [RFA]: patch to setuid, setgid, seteuid, setegid
Date: Wed, 19 Apr 2000 02:01:00 -0000
Message-id: <38FD72A5.88C544BB@vinschen.de>
X-SW-Source: 2000-q2/msg00010.html

Hello,

I want to hear your opinion about the following patch.

While porting inetutils to our new net release I'm trying
to get ftpd to work with NT security. ftpd is one of
those apps that doesn't `exec' after changing the user
context but ftpd itself works in the changed context.
What can be done in this case?

In theory it's not that complicated: Instead of using
	crypt()/setuid()
one has to use
	LogonUser()/ImpersonateLoggedOnUser().

Unfortunately the cygwin1.dll does know nothing about
the new user context. Now I had the idea to use the
functions set(e)uid, set(e)gid for that purpose. With
the below patch, you can port U*X apps so that you
substitute the crypt call by LogonUser() and
after calling ImpersonateLoggedOnUser() you let
the setuid/setgid calls in the code. This results
in the context switch in the dll.

Caveats:
- You can't do without password as some suid apps
  like `cron' do.
- You need to have the permission to change the
  user context. Eg. processes started via service
  manager have that permission.
- With NT, the impersonation is restricted to the
  calling thread.

My setuid/seteuid implementation checks whether
the uid is the one of the logged on user. If this is
the case it replaces the user settings in `myself' by
that of the new user. All further security settings in the
dll are now done relating to the new user context.

The setgid/setegid implementation only checks if
the new gid can be found in /etc/group. I would like
to check if the gid is the primary or a supplementary
group of the new user but typically setgid is called
prior to setuid.

I would like to commit that change if nobody objects.

Corinna
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.14
diff -u -p -r1.14 syscalls.cc
--- syscalls.cc	2000/04/16 22:57:05	1.14
+++ syscalls.cc	2000/04/18 23:40:43
@@ -1690,38 +1694,78 @@ mknod ()
 /* FIXME: unimplemented! */
 extern "C"
 int
-setgid (gid_t)
+setgid (gid_t gid)
 {
-  set_errno (ENOSYS);
+  if (os_being_run == winNT)
+    {
+      if (gid != (gid_t) -1)
+        {
+          if (!getgrgid (gid))
+            {
+              set_errno (EINVAL);
+              return -1;
+            }
+          myself->gid = gid;
+        }
+    }
+  else
+    set_errno (ENOSYS);
   return 0;
 }
 
+extern char *internal_getlogin (struct pinfo *pi);
+
 /* setuid: POSIX 4.2.2.1 */
 /* FIXME: unimplemented! */
 extern "C"
 int
-setuid (uid_t)
+setuid (uid_t uid)
 {
-  set_errno (ENOSYS);
+  if (os_being_run == winNT)
+    {
+      if (uid != (uid_t) -1)
+        {
+          struct passwd *pw_new = getpwuid (uid);
+          if (!pw_new)
+            {
+              set_errno (EINVAL);
+              return -1;
+            }
+
+          struct pinfo pi;
+          pi.psid = (PSID) pi.sidbuf;
+          struct passwd *pw_cur = getpwnam (internal_getlogin (&pi));
+          if (pw_cur != pw_new)
+            {
+              set_errno (EPERM);
+              return -1;
+            }
+          myself->uid = uid;
+          strcpy (myself->username, pi.username);
+          CopySid (40, myself->psid, pi.psid);
+          strcpy (myself->logsrv, pi.logsrv);
+          strcpy (myself->domain, pi.domain);
+        }
+    }
+  else
+    set_errno (ENOSYS);
   return 0;
 }
 
 /* seteuid: standards? */
 extern "C"
 int
-seteuid (uid_t)
+seteuid (uid_t uid)
 {
-  set_errno (ENOSYS);
-  return 0;
+  return setuid (uid);
 }
 
 /* setegid: from System V.  */
 extern "C"
 int
-setegid (gid_t)
+setegid (gid_t gid)
 {
-  set_errno (ENOSYS);
-  return 0;
+  return setgid (gid);
 }
 
 /* chroot: privileged Unix system call.  */
