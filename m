Return-Path: <cygwin-patches-return-3801-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17594 invoked by alias); 10 Apr 2003 03:32:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17583 invoked from network); 10 Apr 2003 03:32:23 -0000
Message-Id: <3.0.5.32.20030409232437.007fa540@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Thu, 10 Apr 2003 03:32:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: security.cc 
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1049959477==_"
X-SW-Source: 2003-q2/txt/msg00028.txt.bz2

--=====================_1049959477==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1180

Corinna,

this patch originated when fixing the sd error handling in 
get_nt_object_attribute. In the end I simplified the structure
by moving common code in a new function, get_info_from_sd,
and setting the symlink attributes in fhandler_disk_file.
Security.cc is now 30 lines shorter.

Please double check the removal of "else if (pc->issocket ())"
from fstat_helper. I think that case has already been handled before.

Pierre

2003-04-10  Pierre Humblet  <pierre.humblet@ieee.org>

	* security.cc (get_info_from_sd): New function.
	(get_nt_attribute): Only call read_sd and get_info_from_sd.
	Return void.
	(get_file_attribute): Move sd error handling to get_info_from_sd.
	and symlink handling to fhandler_disk_file::fstat_helper.
	(get_nt_object_attribute): Only call read_sd and get_info_from_sd.
	Return void.
	(get_object_attribute): Remove symlink handling and simply return -1
	when ntsec is off.
	* fhandler_disk_file.cc (fhandler_disk_file::fstat_helper): For symlinks
	set the attribute, call get_file_attribute to get the ids and return. 
	In the normal case call get_file_attribute with the addresses of the buffer
	ids and do not recheck if the file is a socket.
	
--=====================_1049959477==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.diff"
Content-length: 11553

Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.143
diff -u -p -r1.143 security.cc
--- security.cc	1 Apr 2003 17:17:46 -0000	1.143
+++ security.cc	9 Apr 2003 23:43:00 -0000
@@ -1318,22 +1318,21 @@ get_attribute_from_acl (mode_t *attribut
   return;
 }

-static int
-get_nt_attribute (const char *file, mode_t *attribute,
+static void
+get_info_from_sd (PSECURITY_DESCRIPTOR psd, mode_t *attribute,
 		  __uid32_t *uidret, __gid32_t *gidret)
 {
-  syscall_printf ("file: %s", file);
-
-  /* Yeah, sounds too much, but I've seen SDs of 2100 bytes! */
-  DWORD sd_size =3D 4096;
-  char sd_buf[4096];
-  PSECURITY_DESCRIPTOR psd =3D (PSECURITY_DESCRIPTOR) sd_buf;
-
-  int ret;
-  if ((ret =3D read_sd (file, psd, &sd_size)) <=3D 0)
+  if (!psd)
     {
-      debug_printf ("read_sd %E");
-      return -1;
+      /* If reading the security descriptor failed, treat the object
+	 as unreadable. */
+      if (attribute)
+	*attribute &=3D ~(S_IRWXU | S_IRWXG | S_IRWXO);
+      if (uidret)
+	*uidret =3D ILLEGAL_UID;
+      if (gidret)
+	*gidret =3D ILLEGAL_GID;
+      return;
     }

   cygpsid owner_sid;
@@ -1345,16 +1344,6 @@ get_nt_attribute (const char *file, mode
   if (!GetSecurityDescriptorGroup (psd, (PSID *) &group_sid, &dummy))
     debug_printf ("GetSecurityDescriptorGroup %E");

-  PACL acl;
-  BOOL acl_exists;
-
-  if (!GetSecurityDescriptorDacl (psd, &acl_exists, &acl, &dummy))
-    {
-      __seterrno ();
-      debug_printf ("GetSecurityDescriptorDacl %E");
-      return -1;
-    }
-
   __uid32_t uid;
   __gid32_t gid;
   BOOL grp_member =3D get_sids_info (owner_sid, group_sid, &uid, &gid);
@@ -1365,21 +1354,46 @@ get_nt_attribute (const char *file, mode

   if (!attribute)
     {
-      syscall_printf ("file: %s uid %d, gid %d", file, uid, gid);
-      return 0;
+      syscall_printf ("uid %d, gid %d", uid, gid);
+      return;
     }

-  if (!acl_exists || !acl)
+  PACL acl;
+  BOOL acl_exists;
+
+  if (!GetSecurityDescriptorDacl (psd, &acl_exists, &acl, &dummy))
     {
-      *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;
-      syscall_printf ("file: %s No ACL =3D %x, uid %d, gid %d",
-		      file, *attribute, uid, gid);
-      return 0;
+      __seterrno ();
+      debug_printf ("GetSecurityDescriptorDacl %E");
+      *attribute &=3D ~(S_IRWXU | S_IRWXG | S_IRWXO);
     }
-  get_attribute_from_acl (attribute, acl, owner_sid, group_sid, grp_member=
);
+  else if (!acl_exists || !acl)
+    *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;
+  else
+    get_attribute_from_acl (attribute, acl, owner_sid, group_sid, grp_memb=
er);

-  syscall_printf ("file: %s %x, uid %d, gid %d", file, *attribute, uid, gi=
d);
-  return 0;
+  syscall_printf ("%sACL =3D %x, uid %d, gid %d",
+		  (!acl_exists || !acl)?"NO ":"", *attribute, uid, gid);
+  return;
+}
+
+static void
+get_nt_attribute (const char *file, mode_t *attribute,
+		  __uid32_t *uidret, __gid32_t *gidret)
+{
+  /* Yeah, sounds too much, but I've seen SDs of 2100 bytes! */
+  DWORD sd_size =3D 4096;
+  char sd_buf[4096];
+  PSECURITY_DESCRIPTOR psd =3D (PSECURITY_DESCRIPTOR) sd_buf;
+
+  if (read_sd (file, psd, &sd_size) <=3D 0)
+    {
+      debug_printf ("read_sd %E");
+      psd =3D NULL;
+    }
+
+  get_info_from_sd (psd, attribute, uidret, gidret);
+  return;
 }

 int
@@ -1387,22 +1401,11 @@ get_file_attribute (int use_ntsec, const
 		    mode_t *attribute, __uid32_t *uidret, __gid32_t *gidret)
 {
   int res;
+  syscall_printf ("file: %s", file);

   if (use_ntsec && allow_ntsec && wincap.has_security ())
     {
-      res =3D get_nt_attribute (file, attribute, uidret, gidret);
-      if (res)
-	{
-	  /* If reading the security descriptor failed, treat the file
-	     as unreadable. */
-	  *attribute &=3D ~(S_IRWXU | S_IRWXG | S_IRWXO);
-	  if (uidret)
-	    *uidret =3D ILLEGAL_UID;
-	  if (gidret)
-	    *gidret =3D ILLEGAL_GID;
-	}
-      else if (attribute && S_ISLNK (*attribute))
-	*attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;
+      get_nt_attribute (file, attribute, uidret, gidret);
       return 0;
     }

@@ -1423,119 +1426,51 @@ get_file_attribute (int use_ntsec, const
   else
     res =3D 0;

-  /* symlinks are everything for everyone! */
-  if (S_ISLNK (*attribute))
-    *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;
-
   return res > 0 ? 0 : -1;
 }

-static int
+static void
 get_nt_object_attribute (HANDLE handle, SE_OBJECT_TYPE object_type,
 			 mode_t *attribute, __uid32_t *uidret, __gid32_t *gidret)
 {
-  PSECURITY_DESCRIPTOR psd =3D NULL;
-  cygpsid owner_sid;
-  cygpsid group_sid;
-  PACL acl =3D NULL;
+  PSECURITY_DESCRIPTOR psd;
+  char sd_buf[4096];

   if (object_type =3D=3D SE_REGISTRY_KEY)
     {
-      // use different code for registry handles, for performance reasons
-      char sd_buf[4096];
-      PSECURITY_DESCRIPTOR psd2 =3D (PSECURITY_DESCRIPTOR) & sd_buf[0];
+      /* use different code for registry handles, for performance reasons =
*/
+      psd =3D (PSECURITY_DESCRIPTOR) & sd_buf[0];
       DWORD len =3D sizeof (sd_buf);
       if (ERROR_SUCCESS !=3D RegGetKeySecurity ((HKEY) handle,
                                               DACL_SECURITY_INFORMATION |
                                               GROUP_SECURITY_INFORMATION |
                                               OWNER_SECURITY_INFORMATION,
-                                              psd2, &len))
+                                              psd, &len))
         {
           __seterrno ();
           debug_printf ("RegGetKeySecurity %E");
-          return -1;
+          psd =3D NULL;
         }
-
-      BOOL bDaclPresent;
-      BOOL bDaclDefaulted;
-      if (!GetSecurityDescriptorDacl (psd2,
-                                      &bDaclPresent, &acl, &bDaclDefaulted=
))
-        {
-          __seterrno ();
-          debug_printf ("GetSecurityDescriptorDacl %E");
-          return -1;
-        }
-      if (!bDaclPresent)
-        {
-          acl =3D NULL;
-        }
-
-      BOOL bGroupDefaulted;
-      if (!GetSecurityDescriptorGroup (psd2,
-                                       (PSID *) & group_sid,
-                                       &bGroupDefaulted))
-        {
-          __seterrno ();
-          debug_printf ("GetSecurityDescriptorGroup %E");
-          return -1;
-        }
-
-      BOOL bOwnerDefaulted;
-      if (!GetSecurityDescriptorOwner (psd2,
-                                       (PSID *) & owner_sid,
-                                       &bOwnerDefaulted))
-        {
-          __seterrno ();
-          debug_printf ("GetSecurityDescriptorOwner %E");
-          return -1;
-        }
-    }
+      }
   else
     {
       if (ERROR_SUCCESS !=3D GetSecurityInfo (handle, object_type,
-                                            DACL_SECURITY_INFORMATION |
-                                            GROUP_SECURITY_INFORMATION |
-                                            OWNER_SECURITY_INFORMATION,
-                                            (PSID *) & owner_sid,
-                                            (PSID *) & group_sid,
-                                            &acl, NULL, &psd))
-        {
-          __seterrno ();
-          debug_printf ("GetSecurityInfo %E");
-          return -1;
-        }
-    }
-
-  __uid32_t uid;
-  __gid32_t gid;
-  BOOL grp_member =3D get_sids_info (owner_sid, group_sid, &uid, &gid);
-
-  if (uidret)
-    *uidret =3D uid;
-  if (gidret)
-    *gidret =3D gid;
-
-  if (!attribute)
-    {
-      syscall_printf ("uid %d, gid %d", uid, gid);
-      LocalFree (psd);
-      return 0;
-    }
-
-  if (!acl)
-    {
-      *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;
-      syscall_printf ("No ACL =3D %x, uid %d, gid %d", *attribute, uid, gi=
d);
-      LocalFree (psd);
-      return 0;
+					    DACL_SECURITY_INFORMATION |
+					    GROUP_SECURITY_INFORMATION |
+					    OWNER_SECURITY_INFORMATION,
+					    NULL, NULL, NULL, NULL, &psd))
+        {
+	  __seterrno ();
+	  debug_printf ("GetSecurityInfo %E");
+	  psd =3D NULL;
+	}
     }
+
+  get_info_from_sd (psd, attribute, uidret, gidret);
+  if (psd !=3D (PSECURITY_DESCRIPTOR) & sd_buf[0])
+    LocalFree (psd);

-  get_attribute_from_acl (attribute, acl, owner_sid, group_sid, grp_member=
);
-
-  LocalFree (psd);
-
-  syscall_printf ("%x, uid %d, gid %d", *attribute, uid, gid);
-  return 0;
+  return;
 }

 int
@@ -1544,26 +1479,11 @@ get_object_attribute (HANDLE handle, SE_
 {
   if (allow_ntsec && wincap.has_security ())
     {
-      int res =3D get_nt_object_attribute (handle, object_type, attribute,
-					 uidret, gidret);
-      if (attribute && S_ISLNK (*attribute))
-	*attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;
-      return res;
+      get_nt_object_attribute (handle, object_type, attribute, uidret, gid=
ret);
+      return 0;
     }
-
-  if (uidret)
-    *uidret =3D getuid32 ();
-  if (gidret)
-    *gidret =3D getgid32 ();
-
-  if (!attribute)
-    return 0;
-
-  /* symlinks are everything for everyone! */
-  if (S_ISLNK (*attribute))
-    *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;
-
-  return 0;
+  /* The entries are already set to default values */
+  return -1;
 }

 BOOL
Index: fhandler_disk_file.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.47
diff -u -p -r1.47 fhandler_disk_file.cc
--- fhandler_disk_file.cc	1 Apr 2003 16:11:41 -0000	1.47
+++ fhandler_disk_file.cc	9 Apr 2003 23:43:26 -0000
@@ -281,14 +281,18 @@ fhandler_disk_file::fstat_helper (struct
   if (pc->isdir ())
     buf->st_mode =3D S_IFDIR;
   else if (pc->issymlink ())
-    buf->st_mode =3D S_IFLNK;
+    {
+      /* symlinks are everything for everyone! */
+      buf->st_mode =3D S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO;
+      get_file_attribute (pc->has_acls (), get_win32_name (), NULL,
+			  &buf->st_uid, &buf->st_gid);
+      goto done;
+    }
   else if (pc->issocket ())
     buf->st_mode =3D S_IFSOCK;

-  __uid32_t uid;
-  __gid32_t gid;
   if (get_file_attribute (pc->has_acls (), get_win32_name (), &buf->st_mod=
e,
-			  &uid, &gid) =3D=3D 0)
+			  &buf->st_uid, &buf->st_gid) =3D=3D 0)
     {
       /* If read-only attribute is set, modify ntsec return value */
       if (pc->has_attribute (FILE_ATTRIBUTE_READONLY) && !get_symlink_p ())
@@ -309,8 +313,6 @@ fhandler_disk_file::fstat_helper (struct
 	buf->st_mode |=3D S_IFDIR | STD_XBITS;
       else if (buf->st_mode & S_IFMT)
 	/* nothing */;
-      else if (pc->issocket ())
-	buf->st_mode |=3D S_IFSOCK;
       else
 	{
 	  buf->st_mode |=3D S_IFREG;
@@ -344,15 +346,12 @@ fhandler_disk_file::fstat_helper (struct
 	buf->st_mode |=3D STD_XBITS;
     }

-  buf->st_uid =3D uid;
-  buf->st_gid =3D gid;
-
   /* The number of links to a directory includes the
      number of subdirectories in the directory, since all
      those subdirectories point to it.
      This is too slow on remote drives, so we do without it and
      set the number of links to 2. */
-
+ done:
   syscall_printf ("0 =3D fstat (, %p) st_atime=3D%x st_size=3D%D, st_mode=
=3D%p, st_ino=3D%d, sizeof=3D%d",
 		  buf, buf->st_atime, buf->st_size, buf->st_mode,
 		  (int) buf->st_ino, sizeof (*buf));

--=====================_1049959477==_--
