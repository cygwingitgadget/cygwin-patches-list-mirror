From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: [PATCH] Fix .exe searching in stat_worker, add preliminary mount/symlink stuff
Date: Sat, 25 Mar 2000 17:54:00 -0000
Message-id: <20000325205429.A13373@cygnus.com>
X-SW-Source: 2000-q1/msg00013.html

I've committed the patch below.  It fixes a problem that I just noticed while trying to
build a toolchain with the latest snapshot.  A check in stat_worker was assuming that
GetLastError() related to the last open of a file being checked.  This was rarely the
case.  It caused make to fail with an "ar" not found.

I've also been playing with allowing symlinks to be controlled via the mount mechanism.
That means that by setting a flag in the mount table, a file can be made to look like
a symlink.  I don't know if this is a good idea or not yet and it requires manual
intervention in order to even do this but I thought we could use something like this
to allow symlinks on SMB shares.

cgf

Sat Mar 25 20:46:39 2000  Christopher Faylor <cgf@cygnus.com>

        * path.cc (symlink_check_one): Recognize symlink settings from the 
        mount table.
        * path.h: Make PATH_SYMLINK an alias for MOUNT_SYMLINK.
        * syscalls.cc (stat_worker): Use extension search mechanism in 
        path_conv to look for .exe rather than trying to special case it here.
        * mount.h: Make MOUNT_SYMLINK a real option.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.3
diff -u -p -r1.3 path.cc
--- path.cc	2000/03/16 19:35:18	1.3
+++ path.cc	2000/03/26 01:46:06
@@ -2156,7 +2156,7 @@ symlink_check_one (const char *in_path, 
 
       /* A symlink will have the `system' file attribute. */
       /* Only files can be symlinks (which can be symlinks to directories). */
-      if (!SYMLINKATTR (fileattr))
+      if (!(*pflags & PATH_SYMLINK) && !SYMLINKATTR (fileattr))
 	goto file_not_symlink;
 
       /* Check the file's extended attributes, if it has any.  */
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.3
diff -u -p -r1.3 path.h
--- path.h	2000/03/18 06:26:14	1.3
+++ path.h	2000/03/26 01:46:06
@@ -28,7 +28,7 @@ enum symlink_follow
 enum
 {
   PATH_NOTHING = 0,
-  PATH_SYMLINK = 1,
+  PATH_SYMLINK = MOUNT_SYMLINK,
   PATH_BINARY = MOUNT_BINARY,
   PATH_EXEC = MOUNT_EXEC,
   PATH_SOCKET =  0x40000000,
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.9
diff -u -p -r1.9 syscalls.cc
--- syscalls.cc	2000/03/19 11:05:14	1.9
+++ syscalls.cc	2000/03/26 01:46:07
@@ -917,6 +917,12 @@ stat_dev (DWORD devn, int unit, unsigned
   return 0;
 }
 
+static suffix_info stat_suffixes[] = 
+{
+  suffix_info ("", 1),
+  suffix_info (".exe", 1)
+};
+
 /* Cygwin internal */
 static int
 stat_worker (const char *caller, const char *name, struct stat *buf,
@@ -930,8 +936,10 @@ stat_worker (const char *caller, const c
   MALLOC_CHECK;
 
   debug_printf ("%s (%s, %p)", caller, name, buf);
+
+  path_conv real_path (name, nofollow ? SYMLINK_NOFOLLOW : SYMLINK_FOLLOW, 1,
+		       stat_suffixes);
 
-  path_conv real_path (name, nofollow ? SYMLINK_NOFOLLOW : SYMLINK_FOLLOW, 1);
   if (real_path.error)
     {
       set_errno (real_path.error);
@@ -946,25 +954,6 @@ stat_worker (const char *caller, const c
 		     hash_path_name (0, win32_name), buf);
 
   atts = real_path.file_attributes ();
-
-/* FIXME: this is of dubious merit and is fundamentally flawed.
-   E.g., what if the .exe file is a symlink?  This is not accounted
-   for here.  Also, what about all of the other special extensions?
-
-   This could be "fixed" by passing the appropriate extension list
-   to path_conv but I'm not sure that this is really justified.  */
-
-  /* If we can't find the name, try again with a .exe suffix
-     [but only if not already present].  */
-  if (atts == -1 && GetLastError () == ERROR_FILE_NOT_FOUND &&
-      !(strrchr (win32_name, '.') > strrchr (win32_name, '\\')))
-    {
-      debug_printf ("trying with .exe suffix");
-      strcat (win32_name, ".exe");
-      atts = (int) GetFileAttributesA (win32_name);
-      if (atts == -1)
-	strchr (win32_name, '\0')[4] = '\0';
-    }
 
   debug_printf ("%d = GetFileAttributesA (%s)", atts, win32_name);
 
Index: include/sys/mount.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/mount.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 mount.h
--- mount.h	2000/02/17 19:38:31	1.1.1.1
+++ mount.h	2000/03/26 01:46:07
@@ -7,7 +7,7 @@ extern "C" {
 
 enum
   {
-    /* MOUNT_SYMLINK = 1, place holder.  Do not use it. */
+    MOUNT_SYMLINK = 1,	/* "mount point" is a symlink */
     MOUNT_BINARY =  2,	/* "binary" format read/writes */
     MOUNT_SYSTEM =  8,	/* mount point came from system table */
     MOUNT_EXEC   = 16,	/* Any file in the mounted directory gets 'x' bit */
