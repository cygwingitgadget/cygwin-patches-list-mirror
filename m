From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: rootdir
Date: Thu, 16 Mar 2000 05:43:00 -0000
Message-id: <38D0E4C2.5F8DA404@vinschen.de>
X-SW-Source: 2000-q1/msg00003.html

As mentioned in cygwin-developers, the patch increases speed of
file access by the following methods:

- Replace functions get_file_owner() and get_file_group()
  by a pumped get_file_attribute function.
- Calling set_process_privileges only once in dll_crt0_1()
  instead of calling on each [gs]et_nt_attribute().
- Calling num_entries() only on non remote drives.

And, last but not least:

There's an error in `rootdir()' function. Not in each case
it's called with a full path as parameter, a relative path is
possible, too. I have patched the function so that if the
incoming path is relative it's substituted by the result of
a call to getcwd_inner(win32_style).

This has a side effect: Now you can't rely on the fact that
a full path is always longer than it's rootdir path. So the
used buffer has to be initialized generally with size MAX_PATH.

BTW: The "no ntea on ntfs drives if ntsec is ON" patch is a part
of this patch. It was a bit easier so. If Jeremy answers, I will
be able to change it according to our results, of course.

Corinna
Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.30
diff -u -p -u -p -r1.30 ChangeLog
--- ChangeLog	2000/03/15 20:40:07	1.30
+++ ChangeLog	2000/03/16 13:39:37
@@ -1,3 +1,34 @@
+Thu Mar 16 14:15:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+        * security.cc (set_process_privileges): Removed `static'.
+        (get_nt_attribute): Returns uid and gid additionally. Removed call
+        to set_process_privileges().
+        (get_file_attribute): Returns uid and gid additionally. Don't
+        call ntea if ntsec is ON.
+        (set_nt_attribute): Removed call to set_process_privileges().
+        Don't call ntea if ntsec is ON.
+        (acl): Removed call to set_process_privileges().
+        * dcrt0.cc (dll_crt0_1): Calls set_process_privileges() now.
+        * winsup.h: New prototype for set_process_privileges(),
+        changed prototype for get_file_attribute().
+        * fhandler.cc (get_file_owner): Discarded.
+        (get_file_group): Ditto.
+        (rootdir): Copy cwd into full_path if full_path is a relativ path.
+        (fhandler_disk_file::fstat): Discard calls to get_file_owner() and
+        get_file_group().
+        * path.cc: Remove definition of getcwd_inner().
+        (path_conv::path_conv): Change size of `root' buffer.
+        Added debugging output for result of GetVolumeInformation().
+        (getcwd_inner): Removed `static'.
+        * path.h: New prototype for getcwd_inner().
+        * syscalls.cc (chown): Reformatted.
+        (chmod): Replace get_file_owner() and get_file_group() calls
+        by a call to get_file_attribute(). Discard local variable has_acls.
+        Slightly reformatted.
+        (stat_worker): Replaced idiot's (it's me) root dir check by call
+        to rootdir(). Don't call num_entries() on remote drives.
+        Discard local variable has_acls.
+
 Wed Mar 15 20:38:06 2000  Corinna Vinschen <corinna@vinschen.de>
 
         * errno.cc: Map ERROR_NOACCESS to EFAULT.
Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.3
diff -u -p -u -p -r1.3 dcrt0.cc
--- dcrt0.cc	2000/02/28 05:05:33	1.3
+++ dcrt0.cc	2000/03/16 13:39:39
@@ -638,6 +638,10 @@ dll_crt0_1 ()
   threadname_init ();
   debug_init ();
 
+  /* Allow backup semantics. It's better done only once on process start
+     instead of each time a file is opened. */
+  set_process_privileges ();
+  
   /* Initialize SIGSEGV handling, etc...  Because the exception handler
      references data in the shared area, this must be done after
      shared_init. */
Index: winsup.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.5
diff -u -p -u -p -r1.5 winsup.h
--- winsup.h	2000/03/09 21:04:05	1.5
+++ winsup.h	2000/03/16 13:39:40
@@ -414,7 +414,9 @@ const char * __stdcall find_exec (const 
 			int null_if_notfound = 0, const char **known_suffix = NULL);
 
 /* File manipulation */
-int __stdcall get_file_attribute (int, const char *, int *);
+int __stdcall set_process_privileges ();
+int __stdcall get_file_attribute (int, const char *, int *,
+                                  uid_t * = NULL, gid_t * = NULL);
 int __stdcall set_file_attribute (int, const char *, int);
 int __stdcall set_file_attribute (int, const char *, uid_t, gid_t, int, const char *);
 void __stdcall set_std_handle (int);
Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.9
diff -u -p -u -p -r1.9 fhandler.cc
--- fhandler.cc	2000/03/15 04:49:36	1.9
+++ fhandler.cc	2000/03/16 13:39:41
@@ -114,54 +114,6 @@ fhandler_base::get_readahead_into_buffer
   return copied_chars;
 }
 
-uid_t __stdcall
-get_file_owner (int use_ntsec, const char *filename)
-{
-  if (use_ntsec && allow_ntsec)
-    {
-      extern LONG ReadSD(const char *, PSECURITY_DESCRIPTOR, LPDWORD);
-      DWORD sd_size = 4096;
-      char psd_buffer[4096];
-      PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) psd_buffer;
-      PSID psid;
-      BOOL bOwnerDefaulted = TRUE;
-
-      if (ReadSD (filename, psd, &sd_size) <= 0)
-        return getuid();
-
-      if (!GetSecurityDescriptorOwner (psd, &psid, &bOwnerDefaulted))
-        return getuid ();
-
-      return psid ? get_uid_from_sid (psid) : getuid ();
-    }
-
-  return getuid();
-}
-
-gid_t __stdcall
-get_file_group (int use_ntsec, const char *filename)
-{
-  if (use_ntsec && allow_ntsec)
-    {
-      extern LONG ReadSD(const char *, PSECURITY_DESCRIPTOR, LPDWORD);
-      DWORD sd_size = 4096;
-      char psd_buffer[4096];
-      PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) psd_buffer;
-      PSID psid;
-      BOOL bGroupDefaulted = TRUE;
-
-      if (ReadSD (filename, psd, &sd_size) <= 0)
-        return getgid();
-
-      if (!GetSecurityDescriptorGroup (psd, &psid, &bGroupDefaulted))
-        return getgid ();
-
-      return psid ? get_gid_from_sid (psid) : getuid ();
-    }
-
-  return getgid ();
-}
-
 /**********************************************************************/
 /* fhandler_base */
 
@@ -850,6 +802,11 @@ rootdir(char *full_path)
    */
   char *root=full_path;
 
+  /* If the path is a relative path, copy the cwd into full_path */
+  if (full_path[1] != ':'
+      && (full_path[0] != '\\' || full_path[1] != '\\'))
+    root = getcwd_inner (full_path, MAX_PATH, 0);
+
   if (full_path[1] == ':')
     strcpy (full_path + 2, "\\");
   else if (full_path[0] == '\\' && full_path[1] == '\\')
@@ -934,7 +891,7 @@ fhandler_disk_file::fstat (struct stat *
   buf->st_size    = local.nFileSizeLow;
 
   /* Allocate some place to determine the root directory. */
-  char root[strlen (get_win32_name ()) + 1];
+  char root[MAX_PATH];
   strcpy (root, get_win32_name ());
 
   /* Assume that if a drive has ACL support it MAY have valid "inodes".
@@ -959,14 +916,16 @@ fhandler_disk_file::fstat (struct stat *
 
   buf->st_blksize = S_BLKSIZE;
   buf->st_blocks  = (buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
-  buf->st_uid     = get_file_owner (has_acls (), get_win32_name ());
-  buf->st_gid     = get_file_group (has_acls (), get_win32_name ());
 
   /* Using a side effect: get_file_attibutes checks for
      directory. This is used, to set S_ISVTX, if needed.  */
   if (local.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
     buf->st_mode |= S_IFDIR;
-  if (! get_file_attribute (has_acls (), get_win32_name (), &buf->st_mode))
+  if (! get_file_attribute (has_acls (),
+                            get_win32_name (),
+                            &buf->st_mode,
+                            &buf->st_uid,
+                            &buf->st_gid))
     {
       /* If read-only attribute is set, modify ntsec return value */
       if (local.dwFileAttributes & FILE_ATTRIBUTE_READONLY)
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.2
diff -u -p -u -p -r1.2 path.cc
--- path.cc	2000/02/21 05:20:37	1.2
+++ path.cc	2000/03/16 13:39:43
@@ -92,7 +92,6 @@ static int symlink_check_one (const char
 			      const suffix_info *suffixes,
 			      char *&found_suffix);
 static int normalize_win32_path (const char *cwd, const char *src, char *dst);
-static char *getcwd_inner (char *buf, size_t ulen, int posix_p);
 static void slashify (const char *src, char *dst, int trailing_slash_p);
 static void backslashify (const char *src, char *dst, int trailing_slash_p);
 static int path_prefix_p_ (const char *path1, const char *path2, int len1);
@@ -376,13 +375,21 @@ path_conv::path_conv (const char *src, s
 out:
   DWORD serial, volflags;
 
-  char root[strlen(full_path) + 10];
+  char root[MAX_PATH];
   strcpy (root, full_path);
   if (!rootdir (root) ||
       !GetVolumeInformation (root, NULL, 0, &serial, NULL, &volflags, NULL, 0))
-    set_has_acls (FALSE);
+    {
+      debug_printf ("GetVolumeInformation(%s) = ERR %d, set_has_acls(FALSE)",
+                    root, GetLastError ());
+      set_has_acls (FALSE);
+    }
   else
-    set_has_acls (volflags & FS_PERSISTENT_ACLS);
+    {
+      debug_printf ("GetVolumeInformation(%s) = OK, set_has_acls(%d)",
+                    root, volflags & FS_PERSISTENT_ACLS);
+      set_has_acls (volflags & FS_PERSISTENT_ACLS);
+    }
 }
 
 #define deveq(s) (strcasematch (name, (s)))
@@ -2370,7 +2377,7 @@ get_current_directory_name ()
 
 /* getcwd */
 
-static char *
+char *
 getcwd_inner (char *buf, size_t ulen, int posix_p)
 {
   char *resbuf = NULL;
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.2
diff -u -p -u -p -r1.2 path.h
--- path.h	2000/02/21 05:20:37	1.2
+++ path.h	2000/03/16 13:39:43
@@ -86,6 +86,8 @@ extern suffix_info std_suffixes[];
 int __stdcall get_device_number (const char *name, int &unit, BOOL from_conv = FALSE);
 int __stdcall slash_unc_prefix_p (const char *path);
 
+char *__stdcall getcwd_inner (char *buf, size_t ulen, int posix_p);
+
 /* Common macros for checking for invalid path names */
 #define check_null_empty_path(src) \
   (!(src) ? EFAULT : *(src) ? 0 : ENOENT)
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.6
diff -u -p -u -p -r1.6 syscalls.cc
--- syscalls.cc	2000/03/09 21:04:05	1.6
+++ syscalls.cc	2000/03/16 13:39:45
@@ -659,7 +659,9 @@ chown (const char * name, uid_t uid, gid
         attrib |= S_IFDIR;
       int has_acls;
       has_acls = allow_ntsec && win32_path.has_acls ();
-      res = get_file_attribute (has_acls, win32_path.get_win32 (), (int *) &attrib);
+      res = get_file_attribute (has_acls,
+                                win32_path.get_win32 (),
+                                (int *) &attrib);
       if (!res)
 	res = set_file_attribute (win32_path.has_acls (),
                                   win32_path.get_win32 (),
@@ -723,14 +725,15 @@ chmod (const char *path, mode_t mode)
       SetFileAttributesA (win32_path.get_win32 (),
 			  attr & ~FILE_ATTRIBUTE_READONLY);
 
-      int has_acls = allow_ntsec && win32_path.has_acls ();
-      uid_t uid = get_file_owner (has_acls, win32_path.get_win32 ());
-      if (! set_file_attribute (has_acls, win32_path.get_win32 (),
-				uid,
-				get_file_group (has_acls,
-                                                win32_path.get_win32 ()),
-				mode,
-                                myself->logsrv)
+      uid_t uid;
+      gid_t gid;
+      get_file_attribute (win32_path.has_acls (),
+                          win32_path.get_win32 (),
+                          NULL, &uid, &gid);
+      if (! set_file_attribute (win32_path.has_acls (),
+                                win32_path.get_win32 (),
+				uid, gid,
+				mode, myself->logsrv)
 	  && allow_ntsec)
 	res = 0;
 
@@ -903,7 +906,8 @@ stat_worker (const char *caller, const c
   int res = -1;
   int atts;
   char *win32_name;
-  char drive[4] = "X:\\";
+  char root[MAX_PATH];
+  UINT dtype;
   MALLOC_CHECK;
 
   debug_printf ("%s (%s, %p)", caller, name, buf);
@@ -945,14 +949,13 @@ stat_worker (const char *caller, const c
 
   debug_printf ("%d = GetFileAttributesA (%s)", atts, win32_name);
 
-  drive[0] = win32_name[0];
-  UINT dtype;
+  strcpy (root, win32_name);
+  dtype = GetDriveType (rootdir (root));
 
   if (atts == -1 || !(atts & FILE_ATTRIBUTE_DIRECTORY) ||
       (os_being_run == winNT
-       && (((dtype = GetDriveType (drive)) != DRIVE_NO_ROOT_DIR
-	     //&& dtype != DRIVE_REMOTE
-	     && dtype != DRIVE_UNKNOWN))))
+       && dtype != DRIVE_NO_ROOT_DIR
+       && dtype != DRIVE_UNKNOWN))
     {
       fhandler_disk_file fh (NULL);
 
@@ -961,28 +964,30 @@ stat_worker (const char *caller, const c
 	{
 	  res = fh.fstat (buf);
 	  fh.close ();
+          /* See the comment 10 lines below */
 	  if (atts != -1 && (atts & FILE_ATTRIBUTE_DIRECTORY))
-	    buf->st_nlink = num_entries (win32_name);
+            buf->st_nlink =
+                (dtype == DRIVE_REMOTE ? 2 : num_entries (win32_name));
 	}
     }
   else
     {
       WIN32_FIND_DATA wfd;
       HANDLE handle;
-      /* hmm, the number of links to a directory includes the
-	 number of entries in the directory, since all the things
-	 in the directory point to it */
-      buf->st_nlink += num_entries (win32_name);
+      /* The number of links to a directory includes the
+	 number of subdirectories in the directory, since all
+         those subdirectories point to it.
+         This is too slow on remote drives, so we do without it and
+         set the number of links to 2. */
+      buf->st_nlink = (dtype == DRIVE_REMOTE ? 2 : num_entries (win32_name));
       buf->st_dev = FHDEVN(FH_DISK) << 8;
       buf->st_ino = hash_path_name (0, real_path.get_win32 ());
       buf->st_mode = S_IFDIR | STD_RBITS | STD_XBITS;
       if ((atts & FILE_ATTRIBUTE_READONLY) == 0)
 	buf->st_mode |= STD_WBITS;
-
-      int has_acls = allow_ntsec && real_path.has_acls ();
 
-      buf->st_uid = get_file_owner (has_acls, real_path.get_win32 ());
-      buf->st_gid = get_file_group (has_acls, real_path.get_win32 ());
+      get_file_attribute (real_path.has_acls (), real_path.get_win32 (),
+                          NULL, &buf->st_uid, &buf->st_gid);
 
       if ((handle = FindFirstFile (real_path.get_win32(), &wfd)) != INVALID_HANDLE_VALUE)
 	{
Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.2
diff -u -p -u -p -r1.2 security.cc
--- security.cc	2000/02/21 05:20:37	1.2
+++ security.cc	2000/03/16 13:39:46
@@ -532,7 +532,7 @@ WriteSD(const char *file, PSECURITY_DESC
   return 0;
 }
 
-static int
+int
 set_process_privileges ()
 {
   HANDLE hProcess = NULL;
@@ -597,16 +597,14 @@ out:
 }
 
 static int
-get_nt_attribute (const char *file, int *attribute)
+get_nt_attribute (const char *file, int *attribute,
+                  uid_t *uidret, gid_t *gidret)
 {
   if (os_being_run != winNT)
     return 0;
 
   syscall_printf ("file: %s", file);
 
-  if (set_process_privileges () < 0)
-    return -1;
-
   /* Yeah, sounds too much, but I've seen SDs of 2100 bytes! */
   DWORD sd_size = 4096;
   char sd_buf[4096];
@@ -638,16 +636,29 @@ get_nt_attribute (const char *file, int 
       return -1;
     }
 
+  uid_t uid = get_uid_from_sid (owner_sid);
+  gid_t gid = get_gid_from_sid (group_sid);
+  if (uidret)
+    *uidret = uid;
+  if (gidret)
+    *gidret = gid;
+
+  if (! attribute)
+    {
+      syscall_printf ("file: %s uid %d, gid %d", uid, gid);
+      return 0;
+    }
+
+  BOOL grp_member = is_grp_member (uid, gid);
+
   if (! acl_exists || ! acl)
     {
       *attribute |= S_IRWXU | S_IRWXG | S_IRWXO;
-      syscall_printf ("file: %s No ACL = %x", file, *attribute);
+      syscall_printf ("file: %s No ACL = %x, uid %d, gid %d",
+                      file, *attribute, uid, gid);
       return 0;
     }
 
-  BOOL grp_member = is_grp_member (get_uid_from_sid (owner_sid),
-                                   get_gid_from_sid (group_sid));
-
   ACCESS_ALLOWED_ACE *ace;
   int allow = 0;
   int deny = 0;
@@ -722,38 +733,35 @@ get_nt_attribute (const char *file, int 
   *attribute &= ~(S_IRWXU|S_IRWXG|S_IRWXO|S_ISVTX);
   *attribute |= allow;
   *attribute &= ~deny;
-  syscall_printf ("file: %s %x", file, *attribute);
+  syscall_printf ("file: %s %x, uid %d, gid %d", file, *attribute, uid, gid);
   return 0;
 }
 
 int
-get_file_attribute (int use_ntsec, const char *file, int *attribute)
+get_file_attribute (int use_ntsec, const char *file, int *attribute,
+                    uid_t *uidret, gid_t *gidret)
 {
-  if (!attribute)
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
+  if (use_ntsec && allow_ntsec)
+    return get_nt_attribute (file, attribute, uidret, gidret);
 
-  int res;
+  if (uidret)
+    *uidret = getuid ();
+  if (gidret)
+    *gidret = getgid ();
 
-  if (use_ntsec && allow_ntsec)
-    {
-      res = get_nt_attribute (file, attribute);
-      if (!res)
-        return 0;
-    }
+  if (! attribute)
+    return 0;
 
-  res = NTReadEA (file, ".UNIXATTR", (char *) attribute, sizeof (*attribute));
+  int res = NTReadEA (file, ".UNIXATTR",
+                      (char *) attribute, sizeof (*attribute));
 
   // symlinks are anything for everyone!
   if ((*attribute & S_IFLNK) == S_IFLNK)
     *attribute |= S_IRWXU | S_IRWXG | S_IRWXO;
 
-  if (res > 0)
-    return 0;
-  set_errno (ENOSYS);
-  return -1;
+  if (res <= 0)
+    set_errno (ENOSYS);
+  return res > 0 ? 0 : -1;
 }
 
 BOOL add_access_allowed_ace (PACL acl, int offset, DWORD attributes,
@@ -1020,9 +1028,6 @@ set_nt_attribute (const char *file, uid_
   if (os_being_run != winNT)
     return 0;
 
-  if (set_process_privileges () < 0)
-    return -1;
-
   DWORD sd_size = 4096;
   char sd_buf[4096];
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
@@ -1050,11 +1055,10 @@ set_file_attribute (int use_ntsec, const
   if ((attribute & S_IFLNK) == S_IFLNK)
     attribute |= S_IRWXU | S_IRWXG | S_IRWXO;
 
-  BOOL ret = NTWriteEA (file, ".UNIXATTR",
-			(char *) &attribute, sizeof (attribute));
   if (!use_ntsec || !allow_ntsec)
     {
-      if (! ret)
+      if (! NTWriteEA (file, ".UNIXATTR",
+                       (char *) &attribute, sizeof (attribute)))
 	{
 	  __seterrno ();
 	  return -1;
@@ -1062,10 +1066,10 @@ set_file_attribute (int use_ntsec, const
       return 0;
     }
 
-  int ret2 = set_nt_attribute (file, uid, gid, logsrv, attribute);
+  int ret = set_nt_attribute (file, uid, gid, logsrv, attribute);
   syscall_printf ("%d = set_file_attribute (%s, %d, %d, %p)",
-		  ret2, file, uid, gid, attribute);
-  return ret2;
+		  ret, file, uid, gid, attribute);
+  return ret;
 }
 
 int
@@ -1518,9 +1522,6 @@ extern "C"
 int
 acl (const char *path, int cmd, int nentries, aclent_t *aclbufp)
 {
-  if (set_process_privileges () < 0)
-    return -1;
-
   path_conv real_path (path);
   if (real_path.error)
     {
