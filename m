From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sourceware.cygnus.com
Subject: problems related to mount_info.
Date: Wed, 07 Jun 2000 13:06:00 -0000
Message-id: <s1su2f5qmsh.fsf@jaist.ac.jp>
X-SW-Source: 2000-q2/msg00092.html

The methods of the `mount_info' class operates mount entries in
the registry without regularizing paths. I was amazed by this
manner as the following.

   $ mount
   Device              Directory           Type         Flags
   ...
   C:\text             /text               user         textmode
   ...
   $ umount /text
   umount: No such file or directory

I failed to notice that I had created the mount entry as the
following by mistake.
   $ mount 'C:\text' /text/

When I read the source code for fixing this issue, I found some
more problems.

1. `strcmp' is used improperly for checking existing entries.
2. `memcmpy' is used improperly for moving a memory area to
   an overlapped area.
3. The loop through mount entries in read_mounts() can't stop
   even if nmounts reaches MAX_MOUNTS.
4. When nmounts == MAX_MOUNTS, it can't modify an existing entry.

The following patch can fix these problems. In this patch,
`add_item' method manages all things, that is, checking nmounts,
looking up existing entries, regularizing paths, feeding an
entry into the registry, and sorting the mount table.

By the way, I removed the mount_slash feature in the patch.
I believe it has become unnecessary by the cygdrive feature.

ChangeLog:
2000-06-07  Kazuhiro Fujieda <fujieda@jaist.ac.jp>
	path.cc (mount_info::init): Eliminate the mount_slash feature.
	(mount_slash): Eliminated.
	(mount_info::read_mounts): Eliminate looking up existing entries. The
	loop for deleting cygpath entries is done only when such entries exist.
	(mount_info::from_registry): Eliminate sorting.
	(mount_info::add_item): Call add_reg_mount if necessary. Check nmounts
	more precisely. Use strcasematch in looking up existing entries.
	(mount_info::del_item): Call del_reg_mount if necessary. Use
	strcasematch. Use memmove instead of memcpy.
	(mount_info::import_v1_registry): Everything is done in this method.
	(mount_info::to_registry): Eliminated.
	(mount_info::from_v1_registry): Eliminated.
	(cygwin_umount): Simply call del_item.
	shared.h: Modify the declaration of add_item and del_item. Remove the
	declaration of from_v1_registry.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.25
diff -u -p -r1.25 path.cc
--- path.cc	2000/05/30 21:24:50	1.25
+++ path.cc	2000/06/07 18:43:26
@@ -845,43 +845,14 @@ conv_path_list (const char *src, char *d
 void
 mount_info::init ()
 {
-  int found_slash = 0;
-
   nmounts = 0;
   had_to_create_mount_areas = 0;
 
   /* Fetch the mount table and cygdrive-related information from
      the registry.  */
   from_registry ();
-
-  /* If slash isn't already mounted, mount system directory as slash. */
-  if (nmounts != 0)
-    for (int i = 0; i < nmounts; i++)
-      {
-	if (strcmp (mount[i].posix_path, "/") == 0)
-	  {
-	    found_slash = 1;
-	    break;
-	  }
-      }
-
-  if (!found_slash)
-    mount_slash ();
 }
 
-/* mount_slash: mount the system partition as slash. */
-
-void
-mount_info::mount_slash ()
-{
-  char drivestring[MAX_PATH];
-  GetSystemDirectory (drivestring, MAX_PATH);
-  drivestring[2] = 0;   /* truncate path to "<drive>:" */
-
-  if (add_reg_mount (drivestring, "/", 0) == 0)
-    add_item (drivestring, "/", 0);
-}
-
 /* conv_to_win32_path: Ensure src_path is a pure Win32 path and store
    the result in win32_path.
 
@@ -1267,30 +1238,13 @@ mount_info::read_mounts (reg_key& r)
   char posix_path[MAX_PATH];
   HKEY key = r.get_key ();
   DWORD i, posix_path_size;
+  int found_cygdrive = FALSE;
 
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
-
   /* Loop through subkeys */
   /* FIXME: we would like to not check MAX_MOUNTS but the heap in the
      shared area is currently statically allocated so we can't have an
      arbitrarily large number of mounts. */
-  for (DWORD i = 0; i < MAX_MOUNTS; i++)
+  for (DWORD i = 0; ; i++)
     {
       char native_path[MAX_PATH];
       int mount_flags;
@@ -1312,27 +1266,42 @@ loop:
 
       if (iscygdrive (posix_path))
 	{
-	  /* This shouldn't be in the mount table. */
-	  // (void) r.kill (posix_path);
+	  found_cygdrive = TRUE;
 	  continue;
 	}
 
       /* Get a reg_key based on i. */
       reg_key subkey = reg_key (key, KEY_READ, posix_path, NULL);
 
-      /* Check the mount table for prefix matches. */
-      for (int j = 0; j < nmounts; j++)
-	if (strcasematch (mount[j].posix_path, posix_path))
-	  goto next;	/* Can't have more than one */
-
       /* Fetch info from the subkey. */
       subkey.get_string ("native", native_path, sizeof (native_path), "");
       mount_flags = subkey.get_int ("flags", 0);
 
       /* Add mount_item corresponding to registry mount point. */
-      cygwin_shared->mount.add_item (native_path, posix_path, mount_flags);
-    next:
-      continue;
+      int res = cygwin_shared->mount.add_item (native_path, posix_path, mount_flags, FALSE);
+      if (res && get_errno () == EMFILE)
+	break; /* The number of entries exceeds MAX_MOUNTS */
+    }
+
+  if (!found_cygdrive)
+    return;
+
+loop:
+  for (i = 0; ;i++)
+    {
+      posix_path_size = MAX_PATH;
+      LONG err = RegEnumKeyEx (key, i, posix_path, &posix_path_size, NULL,
+			  NULL, NULL, NULL);
+
+      if (err != ERROR_SUCCESS)
+	break;
+
+      if (iscygdrive (posix_path))
+	{
+	  /* This shouldn't be in the mount table. */
+	  (void) r.kill (posix_path);
+	  goto loop;
+	}
     }
 }
 
@@ -1367,8 +1336,6 @@ mount_info::from_registry ()
      old mounts. */
   if (had_to_create_mount_areas == 2)
     import_v1_mounts ();
-
-  sort ();
 }
 
 /* add_reg_mount: Add mount item to registry.  Return zero on success,
@@ -1619,22 +1586,15 @@ mount_info::sort ()
   qsort (native_sorted, nmounts, sizeof (native_sorted[0]), sort_by_native_name);
 }
 
-/* Add an entry to the in-memory mount table.
+/* Add an entry to the mount table.
    Returns 0 on success, -1 on failure and errno is set.
 
    This is where all argument validation is done.  It may not make sense to
    do this when called internally, but it's cleaner to keep it all here.  */
 
 int
-mount_info::add_item (const char *native, const char *posix, unsigned mountflags)
+mount_info::add_item (const char *native, const char *posix, unsigned mountflags, int reg_p)
 {
-  /* Can't add more than MAX_MOUNTS. */
-  if (nmounts == MAX_MOUNTS)
-    {
-      set_errno (EMFILE);
-      return -1;
-    }
-
   /* Something's wrong if either path is NULL or empty, or if it's
      not a UNC or absolute path. */
 
@@ -1676,20 +1636,27 @@ mount_info::add_item (const char *native
 
   /* Write over an existing mount item with the same POSIX path if
      it exists and is from the same registry area. */
-  for (int i = 0; i < nmounts; i++)
+  int i;
+  for (i = 0; i < nmounts; i++)
     {
-      if ((strcmp (mount[i].posix_path, posixtmp) == 0) &&
-	  ((mount[i].flags & MOUNT_SYSTEM) == (mountflags & MOUNT_SYSTEM)))
-	{
-	  /* replace existing mount item */
-	  mount[i].init (nativetmp, posixtmp, mountflags);
-	  goto sortit;
-	}
+      if (strcasematch (mount[i].posix_path, posixtmp) &&
+	  (mount[i].flags & MOUNT_SYSTEM) == (mountflags & MOUNT_SYSTEM))
+	break;
+    }
+
+  /* Can't add more than MAX_MOUNTS. */
+  if (i == nmounts && nmounts < MAX_MOUNTS)
+    i = nmounts++;
+  else
+    {
+      set_errno (EMFILE);
+      return -1;
     }
 
-  mount[nmounts++].init (nativetmp, posixtmp, mountflags);
+  if (reg_p && add_reg_mount (nativetmp, posixtmp, mountflags))
+    return -1;
 
-sortit:
+  mount[i].init (nativetmp, posixtmp, mountflags);
   sort ();
 
   return 0;
@@ -1704,12 +1671,12 @@ sortit:
 */
 
 int
-mount_info::del_item (const char *path, unsigned flags)
+mount_info::del_item (const char *path, unsigned flags, int reg_p)
 {
   char pathtmp[MAX_PATH];
 
   /* Something's wrong if path is NULL or empty. */
-  if ((path == NULL) || (*path == 0))
+  if (path == NULL || *path == 0)
     {
       set_errno (EINVAL);
       return -1;
@@ -1720,18 +1687,22 @@ mount_info::del_item (const char *path, 
 
   debug_printf ("%s[%s]", path, pathtmp);
 
+  if (reg_p && del_reg_mount (pathtmp, flags)
+      && del_reg_mount (path, flags)) /* for old irregular entries */
+    return -1;
+
   for (int i = 0; i < nmounts; i++)
     {
       /* Delete if paths and mount locations match. */
-      if (((strcmp (mount[i].posix_path, pathtmp) == 0
-	    || strcmp (mount[i].native_path, pathtmp) == 0)) &&
-	  ((mount[i].flags & MOUNT_SYSTEM) == (flags & MOUNT_SYSTEM)))
+      if ((strcasematch (mount[i].posix_path, pathtmp)
+	   || strcasematch (mount[i].native_path, pathtmp)) &&
+	  (mount[i].flags & MOUNT_SYSTEM) == (flags & MOUNT_SYSTEM))
 	{
 	  nmounts--;		/* One less mount table entry */
 	  /* Fill in the hole if not at the end of the table */
 	  if (i < nmounts)
-	    memcpy (mount + i, mount + i + 1,
-		    sizeof (mount[i]) * (nmounts - i));
+	    memmove (mount + i, mount + i + 1,
+		     sizeof (mount[i]) * (nmounts - i));
 	  sort ();		/* Resort the table */
 	  return 0;
 	}
@@ -1778,16 +1749,18 @@ mount_info::read_v1_mounts (reg_key r, u
 	     we're reading. */
 	  mountflags |= which;
 
-	  cygwin_shared->mount.add_item (win32path, unixpath, mountflags);
+	  int res = cygwin_shared->mount.add_item (win32path, unixpath, mountflags, TRUE);
+	  if (res && get_errno () == EMFILE)
+	    break; /* The number of entries exceeds MAX_MOUNTS */
 	}
     }
 }
 
-/* from_v1_registry: Build the entire mount table from the old v1 registry
-   mount area.  */
+/* import_v1_mounts: If v1 mounts are present, load them and write
+   the new entries to the new registry area. */
 
 void
-mount_info::from_v1_registry ()
+mount_info::import_v1_mounts ()
 {
   reg_key r (HKEY_CURRENT_USER, KEY_ALL_ACCESS,
 	     "SOFTWARE",
@@ -1811,43 +1784,6 @@ mount_info::from_v1_registry ()
 	      "mounts",
 	      NULL);
   read_v1_mounts (r1, MOUNT_SYSTEM);
-
-  /* Note: we don't need to sort internal table here since it is
-     done in main from_registry call after this function would be
-     run. */
-}
-
-/* import_v1_mounts: If v1 mounts are present, load them and write
-   the new entries to the new registry area. */
-
-void
-mount_info::import_v1_mounts ()
-{
-  /* Read in old mounts into memory. */
-  from_v1_registry ();
-
-  /* Write all mounts to the new registry. */
-  to_registry ();
-}
-
-/* to_registry: For every mount point in memory, add a corresponding
-   registry mount point. */
-
-void
-mount_info::to_registry ()
-{
-  for (int i = 0; i < MAX_MOUNTS; i++)
-    {
-      if (i < nmounts)
-	{
-	  mount_item *p = mount + i;
-
-	  add_reg_mount (p->native_path, p->posix_path, p->flags);
-
-	  debug_printf ("%02x: %s, %s, %d",
-			i, p->native_path, p->posix_path, p->flags);
-	}
-    }
 }
 
 /************************* mount_item class ****************************/
@@ -1948,10 +1884,7 @@ mount (const char *win32_path, const cha
 	  return res;	/* Don't try to add cygdrive prefix. */
 	}
 
-      res = cygwin_shared->mount.add_reg_mount (win32_path, posix_path, flags);
-
-      if (res == 0)
-	cygwin_shared->mount.add_item (win32_path, posix_path, flags);
+      res = cygwin_shared->mount.add_item (win32_path, posix_path, flags, TRUE);
     }
 
   syscall_printf ("%d = mount (%s, %s, %p)", res, win32_path, posix_path, flags);
@@ -1978,10 +1911,7 @@ extern "C"
 int
 cygwin_umount (const char *path, unsigned flags)
 {
-  int res = cygwin_shared->mount.del_reg_mount (path, flags);
-
-  if (res == 0)
-    cygwin_shared->mount.del_item (path, flags);
+  int res = cygwin_shared->mount.del_item (path, flags, TRUE);
 
   syscall_printf ("%d = cygwin_umount (%s, %d)", res,  path, flags);
   return res;
Index: shared.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shared.h,v
retrieving revision 1.8
diff -u -p -r1.8 shared.h
--- shared.h	2000/05/23 14:08:52	1.8
+++ shared.h	2000/06/07 18:43:27
@@ -301,11 +301,10 @@ public:
   int had_to_create_mount_areas;
 
   void init ();
-  int add_item (const char *dev, const char *path, unsigned flags);
-  int del_item (const char *path, unsigned flags);
+  int add_item (const char *dev, const char *path, unsigned flags, int reg_p);
+  int del_item (const char *path, unsigned flags, int reg_p);
 
   void from_registry ();
-  void from_v1_registry ();
   int add_reg_mount (const char * native_path, const char * posix_path,
 		      unsigned mountflags);
   int del_reg_mount (const char * posix_path, unsigned mountflags);

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
