From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>, Chris Faylor <cgf@cygnus.com>
Subject: [RFA]: some speed up changes
Date: Sun, 23 Apr 2000 03:00:00 -0000
Message-id: <3902C84A.C0ED2C59@vinschen.de>
X-SW-Source: 2000-q2/msg00026.html

I have tested a patch to speed up file access mostly when using
ntsec. The patch consists of three major changes.

- get/set_file_attribute and subordinated ntsec functions got
  file handle as additional parameter which allows to get/set
  security descriptors on an already opened file.

- Only files that are opened with FILE_FLAG_BACKUP_SEMANTICS
  are able to profit of the first change. So, if using WinNT,
  now all files are opened using that flag. It doesn't affect
  normal file access but allows additional access to SD's and
  EA's (ntea isn't adapted yet but it's no problem to do that
  later).

- In symlink::check() a request for nt attributes is eliminated.
  The check for exec bit isn't used later but is very time
  consuming.

Additionally I have changed some names in security.cc to reflect
the naming scheme better.

Corinna
Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 dir.cc
--- dir.cc	2000/02/17 19:38:31	1.1.1.1
+++ dir.cc	2000/04/23 08:12:45
@@ -292,7 +292,7 @@ mkdir (const char *dir, mode_t mode)
 
   if (CreateDirectoryA (real_dir.get_win32 (), 0))
     {
-      set_file_attribute (real_dir.has_acls (), real_dir.get_win32 (),
+      set_file_attribute (real_dir.has_acls (), real_dir.get_win32 (), NULL,
                           (mode & 0777) & ~myself->umask);
       res = 0;
     }
Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.13
diff -u -p -r1.13 fhandler.cc
--- fhandler.cc	2000/04/20 04:38:10	1.13
+++ fhandler.cc	2000/04/23 08:12:47
@@ -316,7 +316,11 @@ fhandler_base::open (int flags, mode_t m
 
   file_attributes = FILE_ATTRIBUTE_NORMAL;
   if (flags & O_DIROPEN)
-    file_attributes |= FILE_FLAG_BACKUP_SEMANTICS;
+    {
+      if (os_being_run == winNT)
+        access_ |= READ_CONTROL | WRITE_DAC | WRITE_OWNER;
+      file_attributes |= FILE_FLAG_BACKUP_SEMANTICS;
+    }
   if (get_device () == FH_SERIAL)
     file_attributes |= FILE_FLAG_OVERLAPPED;
 
@@ -343,7 +347,8 @@ fhandler_base::open (int flags, mode_t m
   // Attributes may be set only if a file is _really_ created.
   if (flags & O_CREAT && get_device () == FH_DISK
       && GetLastError () != ERROR_ALREADY_EXISTS)
-    set_file_attribute (has_acls (), get_win32_name (), mode);
+    set_file_attribute (has_acls (), get_win32_name (),
+                        (flags & O_DIROPEN) ? x : NULL, mode);
 
   namehash_ = hash_path_name (0, get_win32_name ());
   set_io_handle (x);
@@ -921,6 +926,7 @@ fhandler_disk_file::fstat (struct stat *
     buf->st_mode |= S_IFDIR;
   if (! get_file_attribute (has_acls (),
                             get_win32_name (),
+                            (get_flags () & O_DIROPEN) ? get_handle () : NULL,
                             &buf->st_mode,
                             &buf->st_uid,
                             &buf->st_gid))
@@ -1181,14 +1187,18 @@ fhandler_disk_file::open (path_conv& rea
 
   set_has_acls (real_path.has_acls ());
 
+  if (os_being_run == winNT)
+    flags |= O_DIROPEN;
+
   int res = this->fhandler_base::open (flags, mode);
 
   if (!res)
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
+++ path.cc	2000/04/23 08:12:49
@@ -2075,6 +2075,7 @@ symlink (const char *topath, const char 
 	  CloseHandle (h);
           set_file_attribute (win32_path.has_acls (),
                               win32_path.get_win32 (),
+                              NULL,
                               S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO);
           SetFileAttributesA (win32_path.get_win32 (), FILE_ATTRIBUTE_SYSTEM);
 	  res = 0;
@@ -2185,17 +2186,6 @@ symlink_info::check (const char *in_path
       /* Only files can be symlinks (which can be symlinks to directories). */
       if (!(pflags & PATH_SYMLINK) && !SYMLINKATTR (fileattr))
 	goto file_not_symlink;
-
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
 
       /* Open the file.  */
 
Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.4
diff -u -p -r1.4 security.cc
--- security.cc	2000/04/13 06:53:23	1.4
+++ security.cc	2000/04/23 08:12:51
@@ -374,7 +374,7 @@ got_it:
   return TRUE;
 }
 
-/* ReadSD reads a security descriptor from a file.
+/* read_sd reads a security descriptor from a file.
    In case of error, -1 is returned and errno is set.
    If the file doesn't have a SD, 0 is returned.
    Otherwise, the size of the SD is returned and
@@ -386,7 +386,8 @@ got_it:
 */
 
 LONG
-ReadSD(const char *file, PSECURITY_DESCRIPTOR sdBuf, LPDWORD sdBufSize)
+read_sd(const char *file, HANDLE fh_in, PSECURITY_DESCRIPTOR sdBuf,
+         LPDWORD sdBufSize)
 {
   /* Check parameters */
   if (! sdBufSize)
@@ -395,19 +396,28 @@ ReadSD(const char *file, PSECURITY_DESCR
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
+  /* Open file for read  if fh isn't given */
+
+  HANDLE fh;
+  if (!fh_in)
     {
-      __seterrno ();
-      return -1;
+      fh = CreateFile (file, GENERIC_READ,
+			         FILE_SHARE_READ | FILE_SHARE_WRITE,
+			         &sec_none_nih, OPEN_EXISTING,
+			         FILE_ATTRIBUTE_NORMAL
+                                 | FILE_FLAG_BACKUP_SEMANTICS,
+			         NULL);
+
+      if (fh == INVALID_HANDLE_VALUE)
+        {
+          __seterrno ();
+          return -1;
+        }
     }
+  else
+    fh = fh_in;
 
   /* step through the backup streams and search for the security data */
   WIN32_STREAM_ID header;
@@ -417,7 +427,7 @@ ReadSD(const char *file, PSECURITY_DESCR
   DWORD datasize;
   LONG ret = 0;
 
-  while (BackupRead (hFile, (LPBYTE) &header,
+  while (BackupRead (fh, (LPBYTE) &header,
 		     3 * sizeof (DWORD) + sizeof (LARGE_INTEGER),
 		     &bytes_read, FALSE, TRUE, &context))
     {
@@ -428,7 +438,7 @@ ReadSD(const char *file, PSECURITY_DESCR
       datasize = header.Size.LowPart + header.dwStreamNameSize;
       char b[datasize];
 
-      if (! BackupRead (hFile, (LPBYTE) b, datasize, &bytes_read,
+      if (! BackupRead (fh, (LPBYTE) b, datasize, &bytes_read,
 			FALSE, TRUE, &context))
 	{
 	  __seterrno ();
@@ -460,13 +470,15 @@ ReadSD(const char *file, PSECURITY_DESCR
       break;
 
     }
-  BackupRead (hFile, NULL, 0, &bytes_read, TRUE, TRUE, &context);
-  CloseHandle (hFile);
+  BackupRead (fh, NULL, 0, &bytes_read, TRUE, TRUE, &context);
+  if (!fh_in)
+    CloseHandle (fh);
   return ret;
 }
 
 LONG
-WriteSD(const char *file, PSECURITY_DESCRIPTOR sdBuf, DWORD sdBufSize)
+write_sd(const char *file, HANDLE fh_in, PSECURITY_DESCRIPTOR sdBuf,
+         DWORD sdBufSize)
 {
   /* Check parameters */
   if (! sdBuf || ! sdBufSize)
@@ -475,19 +487,25 @@ WriteSD(const char *file, PSECURITY_DESC
       return -1;
     }
 
-  HANDLE hFile = CreateFile (file,
-			     WRITE_OWNER | WRITE_DAC,
-                             FILE_SHARE_READ | FILE_SHARE_WRITE,
-                             &sec_none_nih,
-                             OPEN_EXISTING,
-                             FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,
-                             NULL);
-
-  if (hFile == INVALID_HANDLE_VALUE)
+  HANDLE fh;
+  if (!fh_in)
     {
-      __seterrno ();
-      return -1;
+      fh = CreateFile (file,
+		       WRITE_OWNER | WRITE_DAC,
+                       FILE_SHARE_READ | FILE_SHARE_WRITE,
+                       &sec_none_nih,
+                       OPEN_EXISTING,
+                       FILE_ATTRIBUTE_NORMAL | FILE_FLAG_BACKUP_SEMANTICS,
+                       NULL);
+
+      if (fh == INVALID_HANDLE_VALUE)
+        {
+          __seterrno ();
+          return -1;
+        }
     }
+  else
+    fh = fh_in;
 
   LPVOID context = NULL;
   DWORD bytes_written = 0;
@@ -500,17 +518,17 @@ WriteSD(const char *file, PSECURITY_DESC
   header.Size.HighPart = 0;
   header.Size.LowPart = sdBufSize;
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
+  if (!BackupWrite (fh, (LPBYTE) sdBuf,
 		    header.Size.LowPart + header.dwStreamNameSize,
 		    &bytes_written, FALSE, TRUE, &context))
     {
@@ -521,15 +539,16 @@ WriteSD(const char *file, PSECURITY_DESC
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
+  if (!fh_in)
+    CloseHandle (fh);
   return 0;
 }
 
@@ -598,7 +617,7 @@ out:
 }
 
 static int
-get_nt_attribute (const char *file, int *attribute,
+get_nt_attribute (const char *file, HANDLE fh, int *attribute,
                   uid_t *uidret, gid_t *gidret)
 {
   if (os_being_run != winNT)
@@ -612,9 +631,9 @@ get_nt_attribute (const char *file, int 
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
 
   int ret;
-  if ((ret = ReadSD (file, psd, &sd_size)) <= 0)
+  if ((ret = read_sd (file, fh, psd, &sd_size)) <= 0)
     {
-      debug_printf ("ReadSD %E");
+      debug_printf ("read_sd %E");
       return ret;
     }
 
@@ -739,11 +758,11 @@ get_nt_attribute (const char *file, int 
 }
 
 int
-get_file_attribute (int use_ntsec, const char *file, int *attribute,
-                    uid_t *uidret, gid_t *gidret)
+get_file_attribute (int use_ntsec, const char *file, HANDLE fh,
+                    int *attribute, uid_t *uidret, gid_t *gidret)
 {
   if (use_ntsec && allow_ntsec)
-    return get_nt_attribute (file, attribute, uidret, gidret);
+    return get_nt_attribute (file, fh, attribute, uidret, gidret);
 
   if (uidret)
     *uidret = getuid ();
@@ -1023,7 +1042,7 @@ alloc_sd (uid_t uid, gid_t gid, const ch
 }
 
 static int
-set_nt_attribute (const char *file, uid_t uid, gid_t gid,
+set_nt_attribute (const char *file, HANDLE fh, uid_t uid, gid_t gid,
                   const char *logsrv, int attribute)
 {
   if (os_being_run != winNT)
@@ -1034,9 +1053,9 @@ set_nt_attribute (const char *file, uid_
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
 
   int ret;
-  if ((ret = ReadSD (file, psd, &sd_size)) <= 0)
+  if ((ret = read_sd (file, NULL, psd, &sd_size)) <= 0)
     {
-      debug_printf ("ReadSD %E");
+      debug_printf ("read_sd %E");
       return ret;
     }
 
@@ -1044,11 +1063,12 @@ set_nt_attribute (const char *file, uid_
   if (! (psd = alloc_sd (uid, gid, logsrv, attribute, psd, &sd_size)))
     return -1;
 
-  return WriteSD (file, psd, sd_size);
+  return write_sd (file, fh, psd, sd_size);
 }
 
 int
 set_file_attribute (int use_ntsec, const char *file,
+                    HANDLE fh,
                     uid_t uid, gid_t gid,
                     int attribute, const char *logsrv)
 {
@@ -1067,16 +1087,16 @@ set_file_attribute (int use_ntsec, const
       return 0;
     }
 
-  int ret = set_nt_attribute (file, uid, gid, logsrv, attribute);
+  int ret = set_nt_attribute (file, fh, uid, gid, logsrv, attribute);
   syscall_printf ("%d = set_file_attribute (%s, %d, %d, %p)",
 		  ret, file, uid, gid, attribute);
   return ret;
 }
 
 int
-set_file_attribute (int use_ntsec, const char *file, int attribute)
+set_file_attribute (int use_ntsec, const char *file, HANDLE fh, int attribute)
 {
-  return set_file_attribute (use_ntsec, file,
+  return set_file_attribute (use_ntsec, file, fh,
                              myself->uid, myself->gid,
                              attribute, myself->logsrv);
 }
@@ -1100,9 +1120,9 @@ setacl (const char *file, int nentries, 
   char sd_buf[4096];
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
 
-  if (ReadSD (file, psd, &sd_size) <= 0)
+  if (read_sd (file, NULL, psd, &sd_size) <= 0)
     {
-      debug_printf ("ReadSD %E");
+      debug_printf ("read_sd %E");
       return -1;
     }
 
@@ -1265,7 +1285,7 @@ setacl (const char *file, int nentries, 
       return -1;
     }
   debug_printf ("Created SD-Size: %d", sd_size);
-  return WriteSD (file, psd, sd_size);
+  return write_sd (file, NULL, psd, sd_size);
 }
 
 static void
@@ -1301,9 +1321,9 @@ getacl (const char *file, DWORD attr, in
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
 
   int ret;
-  if ((ret = ReadSD (file, psd, &sd_size)) <= 0)
+  if ((ret = read_sd (file, NULL, psd, &sd_size)) <= 0)
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
+++ syscalls.cc	2000/04/23 08:12:53
@@ -681,6 +681,7 @@ chown_worker (const char *name, symlink_
         attrib |= S_IFDIR;
       res = get_file_attribute (win32_path.has_acls (),
                                 win32_path.get_win32 (),
+                                NULL,
                                 (int *) &attrib,
                                 &old_uid,
                                 &old_gid);
@@ -692,6 +693,7 @@ chown_worker (const char *name, symlink_
             gid = old_gid;
 	  res = set_file_attribute (win32_path.has_acls (),
                                     win32_path.get_win32 (),
+                                    NULL,
 				    uid, gid, attrib,
                                     myself->logsrv);
         }
@@ -796,9 +798,10 @@ chmod (const char *path, mode_t mode)
       gid_t gid;
       get_file_attribute (win32_path.has_acls (),
                           win32_path.get_win32 (),
-                          NULL, &uid, &gid);
+                          NULL, NULL, &uid, &gid);
       if (! set_file_attribute (win32_path.has_acls (),
                                 win32_path.get_win32 (),
+                                NULL,
 				uid, gid,
 				mode, myself->logsrv)
 	  && allow_ntsec)
@@ -1046,7 +1049,7 @@ stat_worker (const char *caller, const c
 	buf->st_mode |= STD_WBITS;
 
       get_file_attribute (real_path.has_acls (), real_path.get_win32 (),
-                          NULL, &buf->st_uid, &buf->st_gid);
+                          NULL, NULL, &buf->st_uid, &buf->st_gid);
 
       if ((handle = FindFirstFile (real_path.get_win32(), &wfd)) != INVALID_HANDLE_VALUE)
 	{
Index: winsup.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.7
diff -u -p -r1.7 winsup.h
--- winsup.h	2000/04/08 04:13:12	1.7
+++ winsup.h	2000/04/23 08:12:53
@@ -416,10 +416,10 @@ const char * __stdcall find_exec (const 
 
 /* File manipulation */
 int __stdcall set_process_privileges ();
-int __stdcall get_file_attribute (int, const char *, int *,
+int __stdcall get_file_attribute (int, const char *, HANDLE, int *,
                                   uid_t * = NULL, gid_t * = NULL);
-int __stdcall set_file_attribute (int, const char *, int);
-int __stdcall set_file_attribute (int, const char *, uid_t, gid_t, int, const char *);
+int __stdcall set_file_attribute (int, const char *, HANDLE, int);
+int __stdcall set_file_attribute (int, const char *, HANDLE, uid_t, gid_t, int, const char *);
 void __stdcall set_std_handle (int);
 int __stdcall writable_directory (const char *file);
 int __stdcall stat_dev (DWORD, int, unsigned long, struct stat *);
