From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: umount falls into an infinite loop.
Date: Wed, 07 Jun 2000 13:55:00 -0000
Message-id: <s1sr9a9qkin.fsf@jaist.ac.jp>
References: <s1swvk1r5sr.fsf@jaist.ac.jp> <20000607154918.I16163@cygnus.com>
X-SW-Source: 2000-q2/msg00093.html

>>> On Wed, 7 Jun 2000 15:49:18 -0400
>>> Chris Faylor <cgf@cygnus.com> said:

> These look like good changes, but could I impose upon you to improve
> the umount (and probably mount) error message handling facility
> slightly?

No problem. It took only three seconds with my toes.

ChangeLog:
2000-06-07  Kazuhiro Fujieda <fujieda@jaist.ac.jp>
	mount.cc (error): New function to report an error and exit.
	umount.cc (error): Ditto.
	(remove_all_automounts): Check return status of cygwin_umount.
	(remove_all_user_mounts): Ditto.
	(remove_all_system_mounts): Ditto.

Index: mount.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/mount.cc,v
retrieving revision 1.4
diff -u -p -r1.4 mount.cc
--- mount.cc	2000/06/05 18:43:54	1.4
+++ mount.cc	2000/06/07 20:36:35
@@ -30,6 +30,14 @@ static short force = FALSE;
 
 static const char *progname;
 
+static void
+error (const char *path)
+{
+  fprintf (stderr, "%s: %s: %s\n", progname, path,
+	   (errno == EMFILE) ? "Too many mount entries" : strerror (errno));
+  exit (1);
+}
+
 /* FIXME: do_mount should also print a warning message if the dev arg
    is a non-existent Win32 path. */
 
@@ -59,10 +67,7 @@ do_mount (const char *dev, const char *w
 #endif
 
   if (mount (dev, where, flags))
-    {
-      perror ("mount failed");
-      exit (1);
-    }
+    error (where);
 
   if (statres == -1)
     {
@@ -159,8 +164,7 @@ main (int argc, const char **argv)
   if ((force == FALSE) && (mount_already_exists (argv[i + 1], flags)))
     {
       errno = EBUSY;
-      perror ("mount failed");
-      exit (1);
+      error (argv[i + 1]);
     }
   else
     do_mount (argv[i], argv[i + 1], flags);
@@ -232,10 +236,7 @@ change_cygdrive_prefix (const char *new_
   flags |= MOUNT_AUTO;
 
   if (mount (NULL, new_prefix, flags))
-    {
-      perror ("mount failed");
-      exit (1);
-    }
+    error (new_prefix);
   
   exit (0);
 }
Index: umount.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/umount.cc,v
retrieving revision 1.2
diff -u -p -r1.2 umount.cc
--- umount.cc	2000/06/05 18:43:54	1.2
+++ umount.cc	2000/06/07 20:36:35
@@ -13,6 +13,7 @@ details. */
 #include <sys/mount.h>
 #include <mntent.h>
 #include <stdlib.h>
+#include <errno.h>
 
 static void remove_all_mounts ();
 static void remove_all_automounts ();
@@ -34,6 +35,13 @@ usage (void)
   exit (1);
 }
 
+static void
+error (char *path)
+{
+  fprintf (stderr, "%s: %s: %s\n", progname, path, strerror (errno));
+  exit (1);
+}
+
 int
 main (int argc, char **argv)
 {
@@ -81,10 +89,7 @@ main (int argc, char **argv)
     usage ();
 
   if (cygwin_umount (argv[i], flags) != 0)
-    {
-      perror ("umount");
-      exit (1);
-    }
+    error (argv[i]);
 
   return 0;
 }
@@ -109,14 +114,18 @@ remove_all_automounts ()
       /* Remove the mount if it's an automount. */
       if (strcmp (p->mnt_type, "user,auto") == 0)
 	{
-	  cygwin_umount (p->mnt_dir, 0);
+	  if (cygwin_umount (p->mnt_dir, 0))
+	    error (p->mnt_dir);
+
 	  /* We've modified the table so we need to start over. */
 	  endmntent (m);
 	  m = setmntent ("/-not-used-", "r");
 	}
       else if (strcmp (p->mnt_type, "system,auto") == 0)
 	{
-	  cygwin_umount (p->mnt_dir, MOUNT_SYSTEM);
+	  if (cygwin_umount (p->mnt_dir, MOUNT_SYSTEM))
+	    error (p->mnt_dir);
+
 	  /* We've modified the table so we need to start over. */
 	  endmntent (m);
 	  m = setmntent ("/-not-used-", "r");
@@ -132,14 +141,14 @@ remove_all_user_mounts ()
 {
   FILE *m = setmntent ("/-not-used-", "r");
   struct mntent *p;
-  int err;
 
   while ((p = getmntent (m)) != NULL)
     {
       /* Remove the mount if it's a user mount. */
       if (strncmp (p->mnt_type, "user", 4) == 0)
 	{
-	  err = cygwin_umount (p->mnt_dir, 0);
+	  if (cygwin_umount (p->mnt_dir, 0))
+	    error (p->mnt_dir);
 
 	  /* We've modified the table so we need to start over. */
 	  endmntent (m);
@@ -162,7 +171,8 @@ remove_all_system_mounts ()
       /* Remove the mount if it's a system mount. */
       if (strncmp (p->mnt_type, "system", 6) == 0)
 	{
-	  cygwin_umount (p->mnt_dir, MOUNT_SYSTEM);
+	  if (cygwin_umount (p->mnt_dir, MOUNT_SYSTEM))
+	    error (p->mnt_dir);
 
 	  /* We've modified the table so we need to start over. */
 	  endmntent (m);

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
