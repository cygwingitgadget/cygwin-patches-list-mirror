Return-Path: <cygwin-patches-return-5155-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24664 invoked by alias); 22 Nov 2004 03:00:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24557 invoked from network); 22 Nov 2004 03:00:35 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.190.188)
  by sourceware.org with SMTP; 22 Nov 2004 03:00:35 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I7K8IK-004TWH-I2
	for cygwin-patches@cygwin.com; Sun, 21 Nov 2004 22:03:56 -0500
Message-Id: <3.0.5.32.20041121215538.008217f0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Mon, 22 Nov 2004 03:00:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Loading the registry hive on Win9x (part 2)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1101110138==_"
X-SW-Source: 2004-q4/txt/msg00156.txt.bz2

--=====================_1101110138==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1765

This is the second part of the patch to also load the registry hive
on Win9x during seteuid, and to apply the method recommended in
MS KB 199190 to avoid using HKCU.

The main change is a new reg_key constructor that does not use
HKCU and that can also use HKLM.

There are collateral changes in path.cc, which is now 50 lines
shorter, as well as in environ.cc and shared.cc.

The two cygdrive bugs shown below are fixed. 

~: mount -p
Prefix              Type         Flags
~: umount -c
umount: remove_cygdrive_prefix: No error    <=== NOT RIGHT
~: ls -ld /cygdrive/c
drwxr-xr-x   14 pierre   all             0 Dec 31  1969 /cygdrive/c/
~: mount -c /xyz
~: mount -p
Prefix              Type         Flags
/xyz                system       binmode
~: ls -ld /xyz/c
ls: /xyz/c: No such file or directory       <==== NOT RIGHT

Pierre

2004-11-22  Pierre Humblet <pierre.humblet@ieee.org>

	* registry.h (reg_key::reg_key): Change arguments.
	* shared_info.h (class mount_info): Remove had_to_create_mount_areas.
	* registry.cc (reg_key::reg_key): Change constructors to always handle
	HKLM and to avoid relying on HKCU. 
	Do not set mount_table->had_to_create_mount_areas. 
	* path.cc (mount_info::conv_to_win32_path): Improve update of 
	sys_mount_table_counter.
	(mount_info::read_mounts): Use new reg_key constructor.	
	(mount_info::add_reg_mount): Ditto. 
	(mount_info::del_reg_mount): Ditto.
	(mount_info::read_cygdrive_info_from_registry): Ditto. 
	(mount_info::write_cygdrive_info_to_registry): Ditto.
	Update cygwin_shared->sys_mount_table_counter after registry update.
	(mount_info::get_cygdrive_info): Ditto.
	* shared.cc (shared_info::heap_chunk_size): Use new reg_key constructor.
	* environ.cc (regopt): Ditto.
	(environ_init): Optimize calls to regopt.
--=====================_1101110138==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hive3.diff"
Content-length: 21992

? debug.diff
? hive2.diff
? hive3.diff
? syscalls.cc.diff
Index: environ.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.102
diff -u -p -r1.102 environ.cc
--- environ.cc	7 Oct 2004 21:28:57 -0000	1.102
+++ environ.cc	21 Nov 2004 21:02:21 -0000
@@ -640,29 +640,22 @@ static bool __stdcall
 regopt (const char *name)
 {
   bool parsed_something =3D false;
-  /* FIXME: should not be under mount */
-  reg_key r (KEY_READ, CYGWIN_INFO_PROGRAM_OPTIONS_NAME, NULL);
   char buf[CYG_MAX_PATH];
   char lname[strlen (name) + 1];
   strlwr (strcpy (lname, name));

-  if (r.get_string (lname, buf, sizeof (buf) - 1, "") =3D=3D ERROR_SUCCESS)
+  for (int i =3D 0; i < 2; i++)
     {
-      parse_options (buf);
-      parsed_something =3D true;
-    }
-  else
-    {
-      reg_key r1 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
-		  CYGWIN_INFO_CYGNUS_REGISTRY_NAME,
-		  CYGWIN_INFO_CYGWIN_REGISTRY_NAME,
-		  CYGWIN_INFO_PROGRAM_OPTIONS_NAME, NULL);
-      if (r1.get_string (lname, buf, sizeof (buf) - 1, "") =3D=3D ERROR_SU=
CCESS)
+      reg_key r (i, KEY_READ, CYGWIN_INFO_PROGRAM_OPTIONS_NAME, NULL);
+
+      if (r.get_string (lname, buf, sizeof (buf) - 1, "") =3D=3D ERROR_SUC=
CESS)
 	{
 	  parse_options (buf);
 	  parsed_something =3D true;
+	  break;
 	}
     }
+
   MALLOC_CHECK;
   return parsed_something;
 }
@@ -678,7 +671,7 @@ environ_init (char **envp, int envc)
   char *newp;
   int sawTERM =3D 0;
   bool envp_passed_in;
-  bool got_something_from_registry;
+  bool got_something_from_registry =3D false;
   static char NO_COPY cygterm[] =3D "TERM=3Dcygwin";

   static int initted;
@@ -692,9 +685,9 @@ environ_init (char **envp, int envc)
       initted =3D 1;
     }

-  got_something_from_registry =3D regopt ("default");
   if (myself->progname[0])
-    got_something_from_registry =3D regopt (myself->progname) || got_somet=
hing_from_registry;
+    got_something_from_registry =3D regopt (myself->progname);
+  got_something_from_registry =3D  got_something_from_registry || regopt (=
"default");

   /* Set ntsec explicit as default, if NT is running */
   if (wincap.has_security ())
Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.325
diff -u -p -r1.325 path.cc
--- path.cc	28 Oct 2004 01:46:01 -0000	1.325
+++ path.cc	21 Nov 2004 21:02:27 -0000
@@ -120,8 +120,6 @@ create_shortcut_header (void)
     }
 }

-#define CYGWIN_REGNAME (cygheap->cygwin_regname ?: CYGWIN_INFO_CYGWIN_REGI=
STRY_NAME)
-
 /* Determine if path prefix matches current cygdrive */
 #define iscygdrive(path) \
   (path_prefix_p (mount_table->cygdrive, (path), mount_table->cygdrive_len=
))
@@ -1400,8 +1398,9 @@ mount_info::conv_to_win32_path (const ch
   bool chroot_ok =3D !cygheap->root.exists ();
   while (sys_mount_table_counter < cygwin_shared->sys_mount_table_counter)
     {
+      int current =3D cygwin_shared->sys_mount_table_counter;
       init ();
-      sys_mount_table_counter++;
+      sys_mount_table_counter =3D current;
     }
   MALLOC_CHECK;

@@ -1753,7 +1752,7 @@ mount_info::read_mounts (reg_key& r)
       char native_path[CYG_MAX_PATH];
       int mount_flags;

-      posix_path_size =3D CYG_MAX_PATH;
+      posix_path_size =3D sizeof (posix_path);
       /* FIXME: if maximum posix_path_size is 256, we're going to
 	 run into problems if we ever try to store a mount point that's
 	 over 256 but is under CYG_MAX_PATH. */
@@ -1788,27 +1787,23 @@ mount_info::read_mounts (reg_key& r)
 void
 mount_info::from_registry ()
 {
-  /* Use current mount areas if either user or system mount areas
-     already exist.  Otherwise, import old mounts. */
-
-  reg_key r;

   /* Retrieve cygdrive-related information. */
   read_cygdrive_info_from_registry ();

   nmounts =3D 0;

-  /* First read mounts from user's table. */
-  read_mounts (r);
-
-  /* Then read mounts from system-wide mount table. */
-  cygheap->user.deimpersonate ();
-  reg_key r1 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
-	      CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
-	      CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
-	      NULL);
-  read_mounts (r1);
-  cygheap->user.reimpersonate ();
+  /* First read mounts from user's table.
+     Then read mounts from system-wide mount table while deimpersonated . =
*/
+  for (int i =3D 0; i < 2; i++)
+    {
+      if (i)
+	cygheap->user.deimpersonate ();
+      reg_key r (i, KEY_READ, CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NULL=
);
+      read_mounts (r);
+      if (i)
+	cygheap->user.reimpersonate ();
+    }
 }

 /* add_reg_mount: Add mount item to registry.  Return zero on success,
@@ -1818,66 +1813,37 @@ mount_info::from_registry ()
 int
 mount_info::add_reg_mount (const char *native_path, const char *posix_path=
, unsigned mountflags)
 {
-  int res =3D 0;
-
-  if (strchr (posix_path, '\\'))
-    {
-      set_errno (EINVAL);
-      goto err1;
-    }
+  int res;

   /* Add the mount to the right registry location, depending on
      whether MOUNT_SYSTEM is set in the mount flags. */
-  if (!(mountflags & MOUNT_SYSTEM)) /* current_user mount */
+
+  reg_key reg (mountflags & MOUNT_SYSTEM,  KEY_ALL_ACCESS,
+	       CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NULL);
+
+  /* Start by deleting existing mount if one exists. */
+  res =3D reg.kill (posix_path);
+  if (res !=3D ERROR_SUCCESS && res !=3D ERROR_FILE_NOT_FOUND)
     {
-      /* reg_key for user mounts in HKEY_CURRENT_USER. */
-      reg_key reg_user;
+ err:
+      __seterrno_from_win_error (res);
+      return -1;
+    }

-      /* Start by deleting existing mount if one exists. */
-      res =3D reg_user.kill (posix_path);
-      if (res !=3D ERROR_SUCCESS && res !=3D ERROR_FILE_NOT_FOUND)
-	goto err;
-
-      /* Create the new mount. */
-      reg_key subkey =3D reg_key (reg_user.get_key (),
-				KEY_ALL_ACCESS,
-				posix_path, NULL);
-      res =3D subkey.set_string ("native", native_path);
-      if (res !=3D ERROR_SUCCESS)
-	goto err;
-      res =3D subkey.set_int ("flags", mountflags);
-    }
-  else /* local_machine mount */
-    {
-      /* reg_key for system mounts in HKEY_LOCAL_MACHINE. */
-      reg_key reg_sys (HKEY_LOCAL_MACHINE, KEY_ALL_ACCESS, "SOFTWARE",
-		       CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
-		       CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
-		       NULL);
-
-      /* Start by deleting existing mount if one exists. */
-      res =3D reg_sys.kill (posix_path);
-      if (res !=3D ERROR_SUCCESS && res !=3D ERROR_FILE_NOT_FOUND)
-	goto err;
-
-      /* Create the new mount. */
-      reg_key subkey =3D reg_key (reg_sys.get_key (),
-				KEY_ALL_ACCESS,
-				posix_path, NULL);
-      res =3D subkey.set_string ("native", native_path);
-      if (res !=3D ERROR_SUCCESS)
-	goto err;
-      res =3D subkey.set_int ("flags", mountflags);
+  /* Create the new mount. */
+  reg_key subkey (reg.get_key (), KEY_ALL_ACCESS, posix_path, NULL);

+  res =3D subkey.set_string ("native", native_path);
+  if (res !=3D ERROR_SUCCESS)
+    goto err;
+  res =3D subkey.set_int ("flags", mountflags);
+
+  if (mountflags & MOUNT_SYSTEM)
+    {
       sys_mount_table_counter++;
       cygwin_shared->sys_mount_table_counter++;
-    }
-
+    }
   return 0; /* Success */
- err:
-  __seterrno_from_win_error (res);
- err1:
-  return -1;
 }

 /* del_reg_mount: delete mount item from registry indicated in flags.
@@ -1889,22 +1855,9 @@ mount_info::del_reg_mount (const char *
 {
   int res;

-  if (!(flags & MOUNT_SYSTEM))	/* Delete from user registry */
-    {
-      reg_key reg_user (KEY_ALL_ACCESS,
-			CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NULL);
-      res =3D reg_user.kill (posix_path);
-    }
-  else					/* Delete from system registry */
-    {
-      sys_mount_table_counter++;
-      cygwin_shared->sys_mount_table_counter++;
-      reg_key reg_sys (HKEY_LOCAL_MACHINE, KEY_ALL_ACCESS, "SOFTWARE",
-		       CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
-		       CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
-		       NULL);
-      res =3D reg_sys.kill (posix_path);
-    }
+  reg_key reg (flags & MOUNT_SYSTEM, KEY_ALL_ACCESS,
+	       CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NULL);
+  res =3D reg.kill (posix_path);

   if (res !=3D ERROR_SUCCESS)
     {
@@ -1912,6 +1865,12 @@ mount_info::del_reg_mount (const char *
       return -1;
     }

+  if (flags & MOUNT_SYSTEM)
+    {
+      sys_mount_table_counter++;
+      cygwin_shared->sys_mount_table_counter++;
+    }
+
   return 0; /* Success */
 }

@@ -1922,31 +1881,29 @@ mount_info::del_reg_mount (const char *
 void
 mount_info::read_cygdrive_info_from_registry ()
 {
-  /* reg_key for user path prefix in HKEY_CURRENT_USER. */
-  reg_key r;
-  /* First read cygdrive from user's registry. */
-  if (r.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, cygdrive, sizeof (cygdriv=
e), "") !=3D 0)
-    {
-      /* Then read cygdrive from system-wide registry. */
-      cygheap->user.deimpersonate ();
-      reg_key r2 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
-		 CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
-		 CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
-		 NULL);
-      cygheap->user.reimpersonate ();
-
-      if (r2.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, cygdrive,
-	  sizeof (cygdrive), ""))
-	strcpy (cygdrive, CYGWIN_INFO_CYGDRIVE_DEFAULT_PREFIX);
-      cygdrive_flags =3D r2.get_int (CYGWIN_INFO_CYGDRIVE_FLAGS, MOUNT_CYG=
DRIVE | MOUNT_BINARY);
-      slashify (cygdrive, cygdrive, 1);
-      cygdrive_len =3D strlen (cygdrive);
-    }
-  else
-    {
-      /* Fetch user cygdrive_flags from registry; returns MOUNT_CYGDRIVE on
-	 error. */
-      cygdrive_flags =3D r.get_int (CYGWIN_INFO_CYGDRIVE_FLAGS, MOUNT_CYGD=
RIVE | MOUNT_BINARY);
+  /* First read cygdrive from user's registry.
+     If failed, then read cygdrive from system-wide registry
+     while deimpersonated. */
+  for (int i =3D 0; i < 2; i++)
+    {
+      if (i)
+	cygheap->user.deimpersonate ();
+      reg_key r (i, KEY_READ, CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NULL=
);
+      if (i)
+	cygheap->user.reimpersonate ();
+
+      if (r.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, cygdrive, sizeof (cyg=
drive),
+			CYGWIN_INFO_CYGDRIVE_DEFAULT_PREFIX) !=3D ERROR_SUCCESS && i =3D=3D 0)
+	continue;
+
+      /* Fetch user cygdrive_flags from registry; returns MOUNT_CYGDRIVE o=
n error. */
+      cygdrive_flags =3D r.get_int (CYGWIN_INFO_CYGDRIVE_FLAGS,
+				  MOUNT_CYGDRIVE | MOUNT_BINARY);
+      /* Sanitize */
+      if (i =3D=3D 0)
+        cygdrive_flags &=3D ~MOUNT_SYSTEM;
+      else
+        cygdrive_flags |=3D MOUNT_SYSTEM;
       slashify (cygdrive, cygdrive, 1);
       cygdrive_len =3D strlen (cygdrive);
     }
@@ -1959,22 +1916,6 @@ mount_info::read_cygdrive_info_from_regi
 int
 mount_info::write_cygdrive_info_to_registry (const char *cygdrive_prefix, =
unsigned flags)
 {
-  /* Determine whether to modify user or system cygdrive path prefix. */
-  HKEY top =3D (flags & MOUNT_SYSTEM) ? HKEY_LOCAL_MACHINE : HKEY_CURRENT_=
USER;
-
-  if (flags & MOUNT_SYSTEM)
-    {
-      sys_mount_table_counter++;
-      cygwin_shared->sys_mount_table_counter++;
-    }
-
-  /* reg_key for user path prefix in HKEY_CURRENT_USER or system path pref=
ix in
-     HKEY_LOCAL_MACHINE.  */
-  reg_key r (top, KEY_ALL_ACCESS, "SOFTWARE",
-	     CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
-	     CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
-	     NULL);
-
   /* Verify cygdrive prefix starts with a forward slash and if there's
      another character, it's not a slash. */
   if ((cygdrive_prefix =3D=3D NULL) || (*cygdrive_prefix =3D=3D 0) ||
@@ -1989,6 +1930,8 @@ mount_info::write_cygdrive_info_to_regis
   /* Ensure that there is never a final slash */
   nofinalslash (cygdrive_prefix, hold_cygdrive_prefix);

+  reg_key r (flags & MOUNT_SYSTEM, KEY_ALL_ACCESS,
+	     CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NULL);
   int res;
   res =3D r.set_string (CYGWIN_INFO_CYGDRIVE_PREFIX, hold_cygdrive_prefix);
   if (res !=3D ERROR_SUCCESS)
@@ -1998,15 +1941,18 @@ mount_info::write_cygdrive_info_to_regis
     }
   r.set_int (CYGWIN_INFO_CYGDRIVE_FLAGS, flags);

+  if (flags & MOUNT_SYSTEM)
+    sys_mount_table_counter =3D ++cygwin_shared->sys_mount_table_counter;
+
   /* This also needs to go in the in-memory copy of "cygdrive", but only if
      appropriate:
        1. setting user path prefix, or
        2. overwriting (a previous) system path prefix */
   if (!(flags & MOUNT_SYSTEM) || (mount_table->cygdrive_flags & MOUNT_SYST=
EM))
     {
-      slashify (cygdrive_prefix, mount_table->cygdrive, 1);
-      mount_table->cygdrive_flags =3D flags;
-      mount_table->cygdrive_len =3D strlen (mount_table->cygdrive);
+      slashify (cygdrive_prefix, cygdrive, 1);
+      cygdrive_flags =3D flags;
+      cygdrive_len =3D strlen (cygdrive);
     }

   return 0;
@@ -2015,19 +1961,7 @@ mount_info::write_cygdrive_info_to_regis
 int
 mount_info::remove_cygdrive_info_from_registry (const char *cygdrive_prefi=
x, unsigned flags)
 {
-  /* Determine whether to modify user or system cygdrive path prefix. */
-  HKEY top =3D (flags & MOUNT_SYSTEM) ? HKEY_LOCAL_MACHINE : HKEY_CURRENT_=
USER;
-
-  if (flags & MOUNT_SYSTEM)
-    {
-      sys_mount_table_counter++;
-      cygwin_shared->sys_mount_table_counter++;
-    }
-
-  /* reg_key for user path prefix in HKEY_CURRENT_USER or system path pref=
ix in
-     HKEY_LOCAL_MACHINE.  */
-  reg_key r (top, KEY_ALL_ACCESS, "SOFTWARE",
-	     CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
+  reg_key r (flags & MOUNT_SYSTEM, KEY_ALL_ACCESS,
 	     CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
 	     NULL);

@@ -2035,11 +1969,20 @@ mount_info::remove_cygdrive_info_from_re
   int res =3D r.killvalue (CYGWIN_INFO_CYGDRIVE_PREFIX);
   int res2 =3D r.killvalue (CYGWIN_INFO_CYGDRIVE_FLAGS);

+  if (flags & MOUNT_SYSTEM)
+    sys_mount_table_counter =3D ++cygwin_shared->sys_mount_table_counter;
+
   /* Reinitialize the cygdrive path prefix to reflect to removal from the
      registry. */
   read_cygdrive_info_from_registry ();

-  return (res !=3D ERROR_SUCCESS) ? res : res2;
+  if (res =3D=3D ERROR_SUCCESS)
+    res =3D res2;
+  if (res =3D=3D ERROR_SUCCESS)
+    return 0;
+
+  __seterrno_from_win_error (res);
+  return -1;
 }

 int
@@ -2047,7 +1990,7 @@ mount_info::get_cygdrive_info (char *use
 			       char* system_flags)
 {
   /* Get the user path prefix from HKEY_CURRENT_USER. */
-  reg_key r;
+  reg_key r (false,  KEY_READ, CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NUL=
L);
   int res =3D r.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, user, CYG_MAX_PAT=
H, "");

   /* Get the user flags, if appropriate */
@@ -2058,10 +2001,7 @@ mount_info::get_cygdrive_info (char *use
     }

   /* Get the system path prefix from HKEY_LOCAL_MACHINE. */
-  reg_key r2 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
-	      CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
-	      CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
-	      NULL);
+  reg_key r2 (true,  KEY_READ, CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NUL=
L);
   int res2 =3D r2.get_string (CYGWIN_INFO_CYGDRIVE_PREFIX, system, CYG_MAX=
_PATH, "");

   /* Get the system flags, if appropriate */
Index: registry.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/registry.cc,v
retrieving revision 1.21
diff -u -p -r1.21 registry.cc
--- registry.cc	20 Nov 2004 19:09:18 -0000	1.21
+++ registry.cc	21 Nov 2004 21:02:28 -0000
@@ -13,8 +13,12 @@ details. */
 #include "registry.h"
 #include "security.h"
 #include <cygwin/version.h>
-
-static char NO_COPY cygnus_class[] =3D "cygnus";
+#include "path.h"
+#include "fhandler.h"
+#include "dtable.h"
+#include "cygerrno.h"
+#include "cygheap.h"
+static const char cygnus_class[] =3D "cygnus";

 reg_key::reg_key (HKEY top, REGSAM access, ...)
 {
@@ -24,30 +28,44 @@ reg_key::reg_key (HKEY top, REGSAM acces
   va_end (av);
 }

-reg_key::reg_key (REGSAM access, ...)
+/* Opens a key under the appropriate Cygwin key */
+reg_key::reg_key (bool isHKLM, REGSAM access, ...)
 {
   va_list av;
+  HKEY top;

-  new (this) reg_key (HKEY_CURRENT_USER, access, "SOFTWARE",
-		 CYGWIN_INFO_CYGNUS_REGISTRY_NAME,
-		 CYGWIN_INFO_CYGWIN_REGISTRY_NAME, NULL);
-
-  HKEY top =3D key;
+  if (isHKLM)
+    top =3D HKEY_LOCAL_MACHINE;
+  else
+    {
+      char name[128];
+      const char *names[2] =3D {cygheap->user.get_windows_id (name), ".DEF=
AULT"};
+      for (int i =3D 0; i < 2; i++)
+	{
+	  key_is_invalid =3D RegOpenKeyEx (HKEY_USERS, names[i], 0, access, &top);
+	  if (key_is_invalid =3D=3D ERROR_SUCCESS)
+	    goto OK;
+	  debug_printf ("HKU\\%s failed, Win32 error %ld", names[i], key_is_inval=
id);
+	}
+      return;
+    }
+OK:
+  new (this) reg_key (top, access, "SOFTWARE",
+		      CYGWIN_INFO_CYGNUS_REGISTRY_NAME,
+		      CYGWIN_INFO_CYGWIN_REGISTRY_NAME, NULL);
+  if (top !=3D HKEY_LOCAL_MACHINE)
+    RegCloseKey (top);
+  if (key_is_invalid)
+    return;
+
+  top =3D key;
   va_start (av, access);
-  build_reg (top, KEY_READ, av);
+  build_reg (top, access, av);
   va_end (av);
   if (top !=3D key)
     RegCloseKey (top);
 }

-reg_key::reg_key (REGSAM access)
-{
-  new (this) reg_key (HKEY_CURRENT_USER, access, "SOFTWARE",
-		 CYGWIN_INFO_CYGNUS_REGISTRY_NAME,
-		 CYGWIN_INFO_CYGWIN_REGISTRY_NAME,
-		 CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME, NULL);
-}
-
 void
 reg_key::build_reg (HKEY top, REGSAM access, va_list av)
 {
@@ -62,16 +80,15 @@ reg_key::build_reg (HKEY top, REGSAM acc

   while ((name =3D va_arg (av, char *)) !=3D NULL)
     {
-      DWORD disp;
       int res =3D RegCreateKeyExA (r,
 				 name,
 				 0,
-				 cygnus_class,
+				 (char *) cygnus_class,
 				 REG_OPTION_NON_VOLATILE,
 				 access,
 				 &sec_none_nih,
 				 &key,
-				 &disp);
+				 NULL);
       if (r !=3D top)
 	RegCloseKey (r);
       r =3D key;
@@ -81,12 +98,6 @@ reg_key::build_reg (HKEY top, REGSAM acc
 	  debug_printf ("failed to create key %s in the registry", name);
 	  break;
 	}
-
-      /* If we're considering the mounts key, check if it had to
-	 be created and set had_to_create appropriately. */
-      if (strcmp (name, CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME) =3D=3D 0)
-	if (disp =3D=3D REG_CREATED_NEW_KEY)
-	  mount_table->had_to_create_mount_areas++;
     }
 }

Index: registry.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/registry.h,v
retrieving revision 1.4
diff -u -p -r1.4 registry.h
--- registry.h	20 Nov 2004 19:09:18 -0000	1.4
+++ registry.h	21 Nov 2004 21:02:28 -0000
@@ -18,8 +18,7 @@ private:
 public:

   reg_key (HKEY toplev, REGSAM access, ...);
-  reg_key (REGSAM access, ...);
-  reg_key (REGSAM access =3D KEY_ALL_ACCESS);
+  reg_key (bool isHKLM, REGSAM access, ...);

   void *operator new (size_t, void *p) {return p;}
   void build_reg (HKEY key, REGSAM access, va_list av);
Index: shared.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.83
diff -u -p -r1.83 shared.cc
--- shared.cc	20 Nov 2004 19:09:18 -0000	1.83
+++ shared.cc	21 Nov 2004 21:02:28 -0000
@@ -250,22 +250,20 @@ shared_info::heap_chunk_size ()
 {
   if (!heap_chunk)
     {
-      /* Fetch misc. registry entries.  */
+      /* Fetch from registry, first user then local machine.  */
+      for (int i =3D 0; i < 2; i++)
+	{
+	  reg_key reg (i, KEY_READ, NULL);

-      reg_key reg (KEY_READ, NULL);
+	  /* Note that reserving a huge amount of heap space does not result in
+	     the use of swap since we are not committing it. */
+	  /* FIXME: We should not be restricted to a fixed size heap no matter
+	     what the fixed size is. */

-      /* Note that reserving a huge amount of heap space does not result in
-      the use of swap since we are not committing it. */
-      /* FIXME: We should not be restricted to a fixed size heap no matter
-      what the fixed size is. */
-
-      heap_chunk =3D reg.get_int ("heap_chunk_in_mb", 0);
-      if (!heap_chunk) {
-	reg_key r1 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
-		    CYGWIN_INFO_CYGNUS_REGISTRY_NAME,
-		    CYGWIN_INFO_CYGWIN_REGISTRY_NAME, NULL);
-	heap_chunk =3D r1.get_int ("heap_chunk_in_mb", 384);
-      }
+	  if ((heap_chunk =3D reg.get_int ("heap_chunk_in_mb", 0)))
+	    break;
+	  heap_chunk =3D 384; /* Default */
+	}

       if (heap_chunk < 4)
 	heap_chunk =3D 4 * 1024 * 1024;
Index: shared_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
retrieving revision 1.42
diff -u -p -r1.42 shared_info.h
--- shared_info.h	10 Apr 2004 00:50:16 -0000	1.42
+++ shared_info.h	21 Nov 2004 21:02:32 -0000
@@ -70,10 +70,6 @@ class mount_info
   int native_sorted[MAX_MOUNTS];

  public:
-  /* Increment when setting up a reg_key if mounts area had to be
-     created so we know when we need to import old mount tables. */
-  int had_to_create_mount_areas;
-
   void init ();
   int add_item (const char *dev, const char *path, unsigned flags, int reg=
_p);
   int del_item (const char *path, unsigned flags, int reg_p);

--=====================_1101110138==_--
