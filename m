From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: speed(?) changes
Date: Tue, 25 Apr 2000 08:40:00 -0000
Message-id: <3905BC0A.1A1E1C57@vinschen.de>
X-SW-Source: 2000-q2/msg00033.html

Hello,

I had to change nearly everything in my speed patch. The speed up
will be not so noticable anymore but now I'm sure that the below
patch is really functional. All patches are in some way related to
ntsec. What important is happened now:

- The call to get_file_attribute() in symlink::check() is removed
  as before.

- In contrast to Linux, any user which has write permissions to
  a file had the right to chmod the file. Now only the owner or
  admin has that right.

- A user couldn't stat a file if he has no read permission. This
  was due to the fact that stat_worker() tries to open a file to
  be able to call fh.fstat(). Now stat_worker() tries to get file
  stat informations regardless of being able to open the file.

- Corresponding to this, the usage of BackupRead() had the same
  problem. I had to use GetFileSecurity() again as it was used in
  earlier versions of the dll. That time I had some problems with
  samba so I had removed the call in favor of BackupRead() but
  I have found no problems anymore.


Corinna
 
ChangeLog:
==========

Thu Apr 25 16:37:00 2000  Corinna Vinschen <corinna@vinschen.de>

    * fhandler.cc (fhandler_disk_file::open): Check for allow_ntsec
    when determining exec flag.
    * path.cc (symlink_info::check): Remove call to
get_file_attribute().
    * security.cc (read_sd): Rename, ditto for variables to conform
    to common naming convention. Use GetFileSecurity() instead of
    BackupRead() to avoid permission problems when reading ACLs.
    (write_sd): Same renaming as for read_sd().
    (alloc_sd): Change default permissions according to Linux
    permissions for group and world when write permission is set.
    * syscalls.cc (stat_worker): Avoid different permission problems 
    when requesting file informations.
Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.13
diff -u -p -r1.13 fhandler.cc
--- fhandler.cc	2000/04/20 04:38:10	1.13
+++ fhandler.cc	2000/04/25 14:37:40
@@ -1187,8 +1187,9 @@ fhandler_disk_file::open (path_conv& rea
     goto out;
 
   extern BOOL allow_ntea;
+  extern BOOL allow_ntsec;
 
-  if (!real_path.isexec () && !allow_ntea &&
+  if (!real_path.isexec () && !allow_ntea && !allow_ntsec &&
       GetFileType (get_handle ()) == FILE_TYPE_DISK)
     {
       DWORD done;
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.14
diff -u -p -r1.14 path.cc
--- path.cc	2000/04/21 14:37:48	1.14
+++ path.cc	2000/04/25 14:37:43
@@ -2186,17 +2186,6 @@ symlink_info::check (const char *in_path
       if (!(pflags & PATH_SYMLINK) && !SYMLINKATTR (fileattr))
 	goto file_not_symlink;
 
-      /* Check the file's extended attributes, if it has any.  */
-      int unixattr = 0;
-      if (fileattr & FILE_ATTRIBUTE_DIRECTORY)
-        unixattr |= S_IFDIR;
-
-      if (!get_file_attribute (TRUE, path, &unixattr))
-	{
-	  if (unixattr & STD_XBITS)
-	    pflags |= PATH_EXEC;
-	}
-
       /* Open the file.  */
 
       h = CreateFileA (path, GENERIC_READ, FILE_SHARE_READ, &sec_none_nih, OPEN_EXISTING,
Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.4
diff -u -p -r1.4 security.cc
--- security.cc	2000/04/13 06:53:23	1.4
+++ security.cc	2000/04/25 14:37:44
@@ -374,116 +374,67 @@ got_it:
   return TRUE;
 }
 
-/* ReadSD reads a security descriptor from a file.
+/* read_sd reads a security descriptor from a file.
    In case of error, -1 is returned and errno is set.
    If the file doesn't have a SD, 0 is returned.
    Otherwise, the size of the SD is returned and
-   the SD is copied to the buffer, pointed to by sdBuf.
-   sdBufSize contains the size of the buffer. If
+   the SD is copied to the buffer, pointed to by sd_buf.
+   sd_size contains the size of the buffer. If
    it's too small, to contain the complete SD, 0 is
-   returned and sdBufSize is set to the needed size
+   returned and sd_size is set to the needed size
    of the buffer.
 */
 
 LONG
-ReadSD(const char *file, PSECURITY_DESCRIPTOR sdBuf, LPDWORD sdBufSize)
+read_sd(const char *file, PSECURITY_DESCRIPTOR sd_buf, LPDWORD sd_size)
 {
   /* Check parameters */
-  if (! sdBufSize)
+  if (! sd_size)
     {
       set_errno (EINVAL);
       return -1;
     }
 
-  /* Open file for read */
   debug_printf("file = %s", file);
-  HANDLE hFile = CreateFile (file, GENERIC_READ,
-			     FILE_SHARE_READ | FILE_SHARE_WRITE,
-			     &sec_none_nih, OPEN_EXISTING,
-			     FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,
-			     NULL);
 
-  if (hFile == INVALID_HANDLE_VALUE)
+  DWORD len = 0;
+  if (! GetFileSecurity (file,
+                         OWNER_SECURITY_INFORMATION
+                         | GROUP_SECURITY_INFORMATION
+                         | DACL_SECURITY_INFORMATION,
+                         sd_buf, *sd_size, &len))
     {
       __seterrno ();
       return -1;
     }
-
-  /* step through the backup streams and search for the security data */
-  WIN32_STREAM_ID header;
-  DWORD bytes_read = 0;
-  LPVOID context = NULL;
-  PSECURITY_DESCRIPTOR psd = NULL;
-  DWORD datasize;
-  LONG ret = 0;
-
-  while (BackupRead (hFile, (LPBYTE) &header,
-		     3 * sizeof (DWORD) + sizeof (LARGE_INTEGER),
-		     &bytes_read, FALSE, TRUE, &context))
-    {
-      if (header.dwStreamId != BACKUP_SECURITY_DATA)
-	continue;
-
-      /* security data found */
-      datasize = header.Size.LowPart + header.dwStreamNameSize;
-      char b[datasize];
-
-      if (! BackupRead (hFile, (LPBYTE) b, datasize, &bytes_read,
-			FALSE, TRUE, &context))
-	{
-	  __seterrno ();
-	  ret = -1;
-	  break;
-	}
-
-      /* Check validity of the SD */
-      psd = (PSECURITY_DESCRIPTOR) &b[header.dwStreamNameSize];
-      if (! IsValidSecurityDescriptor (psd))
-	continue;
-
-      /* It's a valid SD */
-      datasize -= header.dwStreamNameSize;
-      debug_printf ("SD-Size: %d", datasize);
-
-      /* buffer to small? */
-      if (*sdBufSize < datasize)
-	{
-	  *sdBufSize = datasize;
-	  ret = 0;
-	  break;
-	}
-
-      if (sdBuf)
-	memcpy (sdBuf, psd, datasize);
-
-      ret = *sdBufSize = datasize;
-      break;
-
+  if (len > *sd_size)
+    {
+      *sd_size = len;
+      return 0;
     }
-  BackupRead (hFile, NULL, 0, &bytes_read, TRUE, TRUE, &context);
-  CloseHandle (hFile);
-  return ret;
+  return len;
 }
 
 LONG
-WriteSD(const char *file, PSECURITY_DESCRIPTOR sdBuf, DWORD sdBufSize)
+write_sd(const char *file, PSECURITY_DESCRIPTOR sd_buf, DWORD sd_size)
 {
   /* Check parameters */
-  if (! sdBuf || ! sdBufSize)
+  if (! sd_buf || ! sd_size)
     {
       set_errno (EINVAL);
       return -1;
     }
 
-  HANDLE hFile = CreateFile (file,
-			     WRITE_OWNER | WRITE_DAC,
-                             FILE_SHARE_READ | FILE_SHARE_WRITE,
-                             &sec_none_nih,
-                             OPEN_EXISTING,
-                             FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,
-                             NULL);
+  HANDLE fh;
+  fh = CreateFile (file,
+                   WRITE_OWNER | WRITE_DAC,
+                   FILE_SHARE_READ | FILE_SHARE_WRITE,
+                   &sec_none_nih,
+                   OPEN_EXISTING,
+                   FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,
+                   NULL);
 
-  if (hFile == INVALID_HANDLE_VALUE)
+  if (fh == INVALID_HANDLE_VALUE)
     {
       __seterrno ();
       return -1;
@@ -498,19 +449,19 @@ WriteSD(const char *file, PSECURITY_DESC
   header.dwStreamId = BACKUP_SECURITY_DATA;
   header.dwStreamAttributes = STREAM_CONTAINS_SECURITY;
   header.Size.HighPart = 0;
-  header.Size.LowPart = sdBufSize;
+  header.Size.LowPart = sd_size;
   header.dwStreamNameSize = 0;
-  if (!BackupWrite (hFile, (LPBYTE) &header,
+  if (!BackupWrite (fh, (LPBYTE) &header,
 		    3 * sizeof (DWORD) + sizeof (LARGE_INTEGER),
 		    &bytes_written, FALSE, TRUE, &context))
     {
       __seterrno ();
-      CloseHandle (hFile);
+      CloseHandle (fh);
       return -1;
     }
 
   /* write new security descriptor */
-  if (!BackupWrite (hFile, (LPBYTE) sdBuf,
+  if (!BackupWrite (fh, (LPBYTE) sd_buf,
 		    header.Size.LowPart + header.dwStreamNameSize,
 		    &bytes_written, FALSE, TRUE, &context))
     {
@@ -521,15 +472,15 @@ WriteSD(const char *file, PSECURITY_DESC
       if (ret != ERROR_NOT_SUPPORTED && ret != ERROR_INVALID_SECURITY_DESCR)
 	{
 	  __seterrno ();
-	  BackupWrite (hFile, NULL, 0, &bytes_written, TRUE, TRUE, &context);
-	  CloseHandle (hFile);
+	  BackupWrite (fh, NULL, 0, &bytes_written, TRUE, TRUE, &context);
+	  CloseHandle (fh);
 	  return -1;
 	}
     }
 
   /* terminate the restore process */
-  BackupWrite (hFile, NULL, 0, &bytes_written, TRUE, TRUE, &context);
-  CloseHandle (hFile);
+  BackupWrite (fh, NULL, 0, &bytes_written, TRUE, TRUE, &context);
+  CloseHandle (fh);
   return 0;
 }
 
@@ -612,9 +563,9 @@ get_nt_attribute (const char *file, int 
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
 
   int ret;
-  if ((ret = ReadSD (file, psd, &sd_size)) <= 0)
+  if ((ret = read_sd (file, psd, &sd_size)) <= 0)
     {
-      debug_printf ("ReadSD %E");
+      debug_printf ("read_sd %E");
       return ret;
     }
 
@@ -739,8 +690,8 @@ get_nt_attribute (const char *file, int 
 }
 
 int
-get_file_attribute (int use_ntsec, const char *file, int *attribute,
-                    uid_t *uidret, gid_t *gidret)
+get_file_attribute (int use_ntsec, const char *file,
+                    int *attribute, uid_t *uidret, gid_t *gidret)
 {
   if (use_ntsec && allow_ntsec)
     return get_nt_attribute (file, attribute, uidret, gidret);
@@ -898,7 +849,7 @@ alloc_sd (uid_t uid, gid_t gid, const ch
   if (attribute & S_IRGRP)
     group_allow |= FILE_GENERIC_READ;
   if (attribute & S_IWGRP)
-    group_allow |= STANDARD_RIGHTS_ALL | FILE_GENERIC_WRITE | DELETE;
+    group_allow |= STANDARD_RIGHTS_WRITE | FILE_GENERIC_WRITE | DELETE;
   if (attribute & S_IXGRP)
     group_allow |= FILE_GENERIC_EXECUTE;
   if (! (attribute & S_ISVTX))
@@ -910,7 +861,7 @@ alloc_sd (uid_t uid, gid_t gid, const ch
   if (attribute & S_IROTH)
     other_allow |= FILE_GENERIC_READ;
   if (attribute & S_IWOTH)
-    other_allow |= STANDARD_RIGHTS_ALL | FILE_GENERIC_WRITE | DELETE;
+    other_allow |= STANDARD_RIGHTS_WRITE | FILE_GENERIC_WRITE | DELETE;
   if (attribute & S_IXOTH)
     other_allow |= FILE_GENERIC_EXECUTE;
   if (! (attribute & S_ISVTX))
@@ -1034,9 +985,9 @@ set_nt_attribute (const char *file, uid_
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
 
   int ret;
-  if ((ret = ReadSD (file, psd, &sd_size)) <= 0)
+  if ((ret = read_sd (file, psd, &sd_size)) <= 0)
     {
-      debug_printf ("ReadSD %E");
+      debug_printf ("read_sd %E");
       return ret;
     }
 
@@ -1044,7 +995,7 @@ set_nt_attribute (const char *file, uid_
   if (! (psd = alloc_sd (uid, gid, logsrv, attribute, psd, &sd_size)))
     return -1;
 
-  return WriteSD (file, psd, sd_size);
+  return write_sd (file, psd, sd_size);
 }
 
 int
@@ -1100,9 +1051,9 @@ setacl (const char *file, int nentries, 
   char sd_buf[4096];
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
 
-  if (ReadSD (file, psd, &sd_size) <= 0)
+  if (read_sd (file, psd, &sd_size) <= 0)
     {
-      debug_printf ("ReadSD %E");
+      debug_printf ("read_sd %E");
       return -1;
     }
 
@@ -1265,7 +1216,7 @@ setacl (const char *file, int nentries, 
       return -1;
     }
   debug_printf ("Created SD-Size: %d", sd_size);
-  return WriteSD (file, psd, sd_size);
+  return write_sd (file, psd, sd_size);
 }
 
 static void
@@ -1301,9 +1252,9 @@ getacl (const char *file, DWORD attr, in
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
 
   int ret;
-  if ((ret = ReadSD (file, psd, &sd_size)) <= 0)
+  if ((ret = read_sd (file, psd, &sd_size)) <= 0)
     {
-      debug_printf ("ReadSD %E");
+      debug_printf ("read_sd %E");
       return ret;
     }
 
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.17
diff -u -p -r1.17 syscalls.cc
--- syscalls.cc	2000/04/20 13:52:41	1.17
+++ syscalls.cc	2000/04/25 14:37:47
@@ -982,6 +982,8 @@ stat_worker (const char *caller, const c
   char *win32_name;
   char root[MAX_PATH];
   UINT dtype;
+  fhandler_disk_file fh (NULL);
+
   MALLOC_CHECK;
 
   debug_printf ("%s (%s, %p)", caller, name, buf);
@@ -1009,28 +1011,15 @@ stat_worker (const char *caller, const c
   strcpy (root, win32_name);
   dtype = GetDriveType (rootdir (root));
 
-  if (atts == -1 || !(atts & FILE_ATTRIBUTE_DIRECTORY) ||
-      (os_being_run == winNT
-       && dtype != DRIVE_NO_ROOT_DIR
-       && dtype != DRIVE_UNKNOWN))
+  if ((atts == -1 || !(atts & FILE_ATTRIBUTE_DIRECTORY) ||
+       (os_being_run == winNT
+        && dtype != DRIVE_NO_ROOT_DIR
+        && dtype != DRIVE_UNKNOWN))
+      && fh.open (real_path, O_RDONLY | O_BINARY | O_DIROPEN |
+			     (nofollow ? O_NOSYMLINK : 0), 0))
     {
-      fhandler_disk_file fh (NULL);
-
-      if (fh.open (real_path, O_RDONLY | O_BINARY | O_DIROPEN |
-			      (nofollow ? O_NOSYMLINK : 0), 0))
-	{
-	  res = fh.fstat (buf);
-	  fh.close ();
-          /* See the comment 10 lines below */
-	  if (atts != -1 && (atts & FILE_ATTRIBUTE_DIRECTORY))
-            buf->st_nlink =
-                (dtype == DRIVE_REMOTE ? 1 : num_entries (win32_name));
-	}
-    }
-  else
-    {
-      WIN32_FIND_DATA wfd;
-      HANDLE handle;
+      res = fh.fstat (buf);
+      fh.close ();
       /* The number of links to a directory includes the
 	 number of subdirectories in the directory, since all
          those subdirectories point to it.
@@ -1038,26 +1027,54 @@ stat_worker (const char *caller, const c
          set the number of links to 2. */
       /* Unfortunately the count of 2 confuses `find(1)' command. So
          let's try it with `1' as link count. */
-      buf->st_nlink = (dtype == DRIVE_REMOTE ? 1 : num_entries (win32_name));
+      if (atts != -1 && (atts & FILE_ATTRIBUTE_DIRECTORY))
+        buf->st_nlink =
+            (dtype == DRIVE_REMOTE ? 1 : num_entries (win32_name));
+    }
+  else if (atts != -1 || GetLastError () != ERROR_FILE_NOT_FOUND)
+    {
+      /* Unfortunately, the above open may fail. So we have
+         to care for this case here, too. */
+      WIN32_FIND_DATA wfd;
+      HANDLE handle;
+      buf->st_nlink = 1;
+      if (atts != -1
+          && (atts & FILE_ATTRIBUTE_DIRECTORY)
+          && dtype != DRIVE_REMOTE)
+        buf->st_nlink = num_entries (win32_name);
       buf->st_dev = FHDEVN(FH_DISK) << 8;
       buf->st_ino = hash_path_name (0, real_path.get_win32 ());
-      buf->st_mode = S_IFDIR | STD_RBITS | STD_XBITS;
-      if ((atts & FILE_ATTRIBUTE_READONLY) == 0)
-	buf->st_mode |= STD_WBITS;
-
-      get_file_attribute (real_path.has_acls (), real_path.get_win32 (),
-                          NULL, &buf->st_uid, &buf->st_gid);
-
-      if ((handle = FindFirstFile (real_path.get_win32(), &wfd)) != INVALID_HANDLE_VALUE)
-	{
-	  buf->st_atime   = to_time_t (&wfd.ftLastAccessTime);
-	  buf->st_mtime   = to_time_t (&wfd.ftLastWriteTime);
-	  buf->st_ctime   = to_time_t (&wfd.ftCreationTime);
-	  buf->st_size    = wfd.nFileSizeLow;
-	  buf->st_blksize = S_BLKSIZE;
-	  buf->st_blocks  = (buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
-	  FindClose (handle);
-	}
+      if (atts != -1 && (atts & FILE_ATTRIBUTE_DIRECTORY))
+        buf->st_mode = S_IFDIR;
+      else if (real_path.issymlink ())
+        buf->st_mode = S_IFLNK;
+      else if (real_path.issocket ())
+        buf->st_mode = S_IFSOCK;
+      else
+        buf->st_mode = S_IFREG;
+      if (!real_path.has_acls ()
+          || get_file_attribute (real_path.has_acls (), real_path.get_win32 (),
+                                 &buf->st_mode, &buf->st_uid, &buf->st_gid))
+        {
+          buf->st_mode |= STD_RBITS | STD_XBITS;
+          if ((atts & FILE_ATTRIBUTE_READONLY) == 0)
+            buf->st_mode |= STD_WBITS;
+          get_file_attribute (FALSE, real_path.get_win32 (),
+                              NULL, &buf->st_uid, &buf->st_gid);
+        }
+      if ((handle = FindFirstFile (real_path.get_win32(), &wfd))
+          == INVALID_HANDLE_VALUE)
+        {
+          __seterrno ();
+          goto done;
+        }
+      buf->st_atime   = to_time_t (&wfd.ftLastAccessTime);
+      buf->st_mtime   = to_time_t (&wfd.ftLastWriteTime);
+      buf->st_ctime   = to_time_t (&wfd.ftCreationTime);
+      buf->st_size    = wfd.nFileSizeLow;
+      buf->st_blksize = S_BLKSIZE;
+      buf->st_blocks  = (buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
+      FindClose (handle);
       res = 0;
     }
 
