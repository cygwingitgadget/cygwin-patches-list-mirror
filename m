From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sources.redhat.com
Subject: Patch for the mount code.
Date: Mon, 18 Sep 2000 01:58:00 -0000
Message-id: <s1sitrugjsl.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00096.html

The following patch solves the following issues in the mount mechanism.
- All mount entries will be deleted if the cygdrive prefix is set to '/'.
- Mount() accepts an inappropriate mount point such as 'C:'.
- Mount() can't report the error `ENOPERM' if it fails to modify
  the system registry.
- Mount_info::add_item will incorrectly increment nmounts if it
  fails to modify the registry.

ChangeLog:
Mon Sep 18 17:15:37 2000  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* path.cc (mount_info::read_mounts): Don't delete mount entries of
 	which mount points have the cygdrive prefix.
	* (mount_info::add_reg_mount): Properly catch errors on registry
 	operations.
	* (mount_info::write_cygdrive_info_to_registry): Ditto.
	* (mount_info::del_reg_mount): Cosmetic changes to be consistent
	with other methods.
	* (mount_info::add_item): Check arguments more precisely.
	Increment nmounts only when registry operations succeed.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.57
diff -u -p -r1.57 path.cc
--- path.cc	2000/09/12 18:41:36	1.57
+++ path.cc	2000/09/18 05:46:34
@@ -1269,13 +1269,13 @@ mount_info::read_mounts (reg_key& r)
   char posix_path[MAX_PATH];
   HKEY key = r.get_key ();
   DWORD i, posix_path_size;
-  int found_cygdrive = FALSE;
+  int res;
 
   /* Loop through subkeys */
   /* FIXME: we would like to not check MAX_MOUNTS but the heap in the
      shared area is currently statically allocated so we can't have an
      arbitrarily large number of mounts. */
-  for (DWORD i = 0; ; i++)
+  for (i = 0; ; i++)
     {
       char native_path[MAX_PATH];
       int mount_flags;
@@ -1284,23 +1284,17 @@ mount_info::read_mounts (reg_key& r)
       /* FIXME: if maximum posix_path_size is 256, we're going to
 	 run into problems if we ever try to store a mount point that's
 	 over 256 but is under MAX_PATH! */
-      LONG err = RegEnumKeyEx (key, i, posix_path, &posix_path_size, NULL,
+      res = RegEnumKeyEx (key, i, posix_path, &posix_path_size, NULL,
 			  NULL, NULL, NULL);
 
-      if (err == ERROR_NO_MORE_ITEMS)
+      if (res == ERROR_NO_MORE_ITEMS)
 	break;
-      else if (err != ERROR_SUCCESS)
+      else if (res != ERROR_SUCCESS)
 	{
-	  debug_printf ("RegEnumKeyEx failed, error %d!\n", err);
+	  debug_printf ("RegEnumKeyEx failed, error %d!\n", res);
 	  break;
 	}
 
-      if (iscygdrive (posix_path))
-	{
-	  found_cygdrive = TRUE;
-	  continue;
-	}
-
       /* Get a reg_key based on i. */
       reg_key subkey = reg_key (key, KEY_READ, posix_path, NULL);
 
@@ -1309,31 +1303,10 @@ mount_info::read_mounts (reg_key& r)
       mount_flags = subkey.get_int ("flags", 0);
 
       /* Add mount_item corresponding to registry mount point. */
-      int res = cygwin_shared->mount.add_item (native_path, posix_path, mount_flags, FALSE);
+      res = cygwin_shared->mount.add_item (native_path, posix_path, mount_flags, FALSE);
       if (res && get_errno () == EMFILE)
 	break; /* The number of entries exceeds MAX_MOUNTS */
     }
-
-  if (!found_cygdrive)
-    return;
-
-loop:
-  for (i = 0; ;i++)
-    {
-      posix_path_size = MAX_PATH;
-      LONG err = RegEnumKeyEx (key, i, posix_path, &posix_path_size, NULL,
-			  NULL, NULL, NULL);
-
-      if (err != ERROR_SUCCESS)
-	break;
-
-      if (iscygdrive (posix_path))
-	{
-	  /* This shouldn't be in the mount table. */
-	  (void) r.kill (posix_path);
-	  goto loop;
-	}
-    }
 }
 
 /* from_registry: Build the entire mount table from the registry.  Also,
@@ -1376,6 +1349,8 @@ mount_info::from_registry ()
 int
 mount_info::add_reg_mount (const char * native_path, const char * posix_path, unsigned mountflags)
 {
+  int res = 0;
+
   /* Add the mount to the right registry location, depending on
      whether MOUNT_SYSTEM is set in the mount flags. */
   if (!(mountflags & MOUNT_SYSTEM)) /* current_user mount */
@@ -1384,14 +1359,18 @@ mount_info::add_reg_mount (const char * 
       reg_key reg_user;
 
       /* Start by deleting existing mount if one exists. */
-      reg_user.kill (posix_path);
+      res = reg_user.kill (posix_path);
+      if (res != ERROR_SUCCESS && res != ERROR_FILE_NOT_FOUND)
+	goto err;
 
       /* Create the new mount. */
       reg_key subkey = reg_key (reg_user.get_key (),
 				KEY_ALL_ACCESS,
 				posix_path, NULL);
-      subkey.set_string ("native", native_path);
-      subkey.set_int ("flags", mountflags);
+      res = subkey.set_string ("native", native_path);
+      if (res != ERROR_SUCCESS)
+	goto err;
+      res = subkey.set_int ("flags", mountflags);
     }
   else /* local_machine mount */
     {
@@ -1402,24 +1381,25 @@ mount_info::add_reg_mount (const char * 
 		       CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
 		       NULL);
 
-      if (reg_sys.get_key () == INVALID_HANDLE_VALUE)
-	{
-	  set_errno (EACCES);
-	  return -1;
-	}
-
       /* Start by deleting existing mount if one exists. */
-      reg_sys.kill (posix_path);
+      res = reg_sys.kill (posix_path);
+      if (res != ERROR_SUCCESS && res != ERROR_FILE_NOT_FOUND)
+	goto err;
 
       /* Create the new mount. */
       reg_key subkey = reg_key (reg_sys.get_key (),
 				KEY_ALL_ACCESS,
 				posix_path, NULL);
-      subkey.set_string ("native", native_path);
-      subkey.set_int ("flags", mountflags);
+      res = subkey.set_string ("native", native_path);
+      if (res != ERROR_SUCCESS)
+	goto err;
+      res = subkey.set_int ("flags", mountflags);
     }
 
   return 0; /* Success! */
+ err:
+  __seterrno_from_win_error (res);
+  return -1;
 }
 
 /* del_reg_mount: delete mount item from registry indicated in flags.
@@ -1429,13 +1409,13 @@ mount_info::add_reg_mount (const char * 
 int
 mount_info::del_reg_mount (const char * posix_path, unsigned flags)
 {
-  int killres;
+  int res;
 
   if ((flags & MOUNT_SYSTEM) == 0)	/* Delete from user registry */
     {
       reg_key reg_user (KEY_ALL_ACCESS,
 			CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NULL);
-      killres = reg_user.kill (posix_path);
+      res = reg_user.kill (posix_path);
     }
   else					/* Delete from system registry */
     {
@@ -1444,19 +1424,12 @@ mount_info::del_reg_mount (const char * 
 		       CYGWIN_INFO_CYGWIN_REGISTRY_NAME,
 		       CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
 		       NULL);
-
-      if (reg_sys.get_key () == INVALID_HANDLE_VALUE)
-	{
-	  set_errno (EACCES);
-	  return -1;
-	}
-
-      killres = reg_sys.kill (posix_path);
+      res = reg_sys.kill (posix_path);
     }
 
-  if (killres != ERROR_SUCCESS)
+  if (res != ERROR_SUCCESS)
     {
-      __seterrno_from_win_error (killres);
+      __seterrno_from_win_error (res);
       return -1;
     }
 
@@ -1541,7 +1514,13 @@ mount_info::write_cygdrive_info_to_regis
   /* Ensure that there is never a final slash */
   nofinalslash (cygdrive_prefix, hold_cygdrive_prefix);
 
-  r.set_string ("cygdrive prefix", hold_cygdrive_prefix);
+  int res;
+  res = r.set_string ("cygdrive prefix", hold_cygdrive_prefix);
+  if (res != ERROR_SUCCESS)
+    {
+      __seterrno_from_win_error (res);
+      return -1;
+    }
   r.set_int ("cygdrive flags", flags);
 
   /* This also needs to go in the in-memory copy of "cygdrive", but only if
@@ -1711,7 +1690,8 @@ mount_info::add_item (const char *native
 
   if ((native == NULL) || (*native == 0) ||
       (posix == NULL) || (*posix == 0) ||
-      (!slash_unc_prefix_p (native) && !isabspath (native)))
+      !isabspath (native) || !isabspath (posix) ||
+      slash_unc_prefix_p (posix) || isdrive (posix))
     {
       set_errno (EINVAL);
       return -1;
@@ -1753,20 +1733,17 @@ mount_info::add_item (const char *native
 	break;
     }
 
-  if (i == nmounts)
+  if (i == nmounts && nmounts == MAX_MOUNTS)
     {
-      if (nmounts < MAX_MOUNTS)
-	i = nmounts++;
-      else
-	{
-	  set_errno (EMFILE);
-	  return -1;
-	}
+      set_errno (EMFILE);
+      return -1;
     }
 
   if (reg_p && add_reg_mount (nativetmp, posixtmp, mountflags))
     return -1;
 
+  if (i == nmounts)
+    nmounts++;
   mount[i].init (nativetmp, posixtmp, mountflags);
   sort ();
 
@@ -2001,15 +1978,7 @@ mount (const char *win32_path, const cha
       win32_path = NULL;
     }
   else
-    {
-      if (iscygdrive (posix_path))
-	{
-	  set_errno (EINVAL);
-	  return res;	/* Don't try to add cygdrive prefix. */
-	}
-
-      res = cygwin_shared->mount.add_item (win32_path, posix_path, flags, TRUE);
-    }
+    res = cygwin_shared->mount.add_item (win32_path, posix_path, flags, TRUE);
 
   syscall_printf ("%d = mount (%s, %s, %p)", res, win32_path, posix_path, flags);
   return res;

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
