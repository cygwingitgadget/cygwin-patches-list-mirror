Return-Path: <cygwin-patches-return-3178-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16429 invoked by alias); 15 Nov 2002 03:06:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16419 invoked from network); 15 Nov 2002 03:06:29 -0000
Message-Id: <3.0.5.32.20021114220454.0082ca20@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 14 Nov 2002 19:06:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
In-Reply-To: <20021114205715.O10395@cygbert.vinschen.de>
References: <20021114202105.N10395@cygbert.vinschen.de>
 <3DD159F7.45001468@ieee.org>
 <20021113135916.Q10395@cygbert.vinschen.de>
 <3DD27B59.3FA8990@ieee.org>
 <3.0.5.32.20021113223509.0082c960@mail.attbi.com>
 <20021114110340.G10395@cygbert.vinschen.de>
 <3DD3B369.A530D7EE@ieee.org>
 <20021114173630.A20639@cygbert.vinschen.de>
 <3DD3D75C.99C07A78@ieee.org>
 <20021114182323.L10395@cygbert.vinschen.de>
 <20021114202105.N10395@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1037347494==_"
X-SW-Source: 2002-q4/txt/msg00129.txt.bz2

--=====================_1037347494==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1346

At 08:57 PM 11/14/2002 +0100, Corinna Vinschen wrote:
>On Thu, Nov 14, 2002 at 08:21:05PM +0100, Corinna Vinschen wrote:
>> is_grp_member() calls getgroups32() only for the current user and
>> scans passwd and group otherwise, trying to be more efficient.
>
>Btw., it "feels" faster now to call ls -l...

Great! Here are my patches. I think they are as we agreed on.

Pierre


2002-11-15  Pierre Humblet <pierre.humblet@ieee.org>

	* security.cc (get_attribute_from_acl): Always test "anti",
	just in case an access_denied ACE follows an access_allowed.
	Handle the case owner_sid == group_sid. Remove unnecessary
	tests for non-NULL PSIDs.
	(alloc_sd): Use existing owner and group sids if {ug}id == -1.
	Handle case where owner_sid == group_sid.
	Do not call is_grp_member. Try to preserve canonical ACE order.
	Add unrelated access_denied ACEs around the owner_allow.
	Remove unnecessary tests for non-NULL PSIDs. Reorganize
	debug_printf's.
	(get_initgroups_sidlist): Put well_known_system_sid on left
	side of ==.
	(add_access_denied_ace): Only call GetAce if inherit != 0. 
	(add_access_allowed_ace): Ditto. Use appropriate sizeof.
	* syscalls.cc (chown_worker): Pass {ug}id equal to -1 to 
	alloc_sd, which removes the need to obtain old_{ug}id.
	(chmod): Remove call to get_file_attribute (), simply pass
	{ug}id equal to -1 to alloc_sd.

--=====================_1037347494==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sec.diff"
Content-length: 13210

--- security.cc.orig	2002-10-22 23:18:40.000000000 -0400
+++ security.cc	2002-11-14 17:53:20.000000000 -0500
@@ -449,7 +449,7 @@ get_user_primary_group (WCHAR *wlogonser
   BOOL retval =3D FALSE;
   UCHAR count =3D 0;

-  if (pusersid =3D=3D well_known_system_sid)
+  if (well_known_system_sid =3D=3D pusersid)
     {
       pgrpsid =3D well_known_system_sid;
       return TRUE;
@@ -540,7 +540,7 @@ get_initgroups_sidlist (cygsidlist &grp_
 {
   grp_list +=3D well_known_world_sid;
   grp_list +=3D well_known_authenticated_users_sid;
-  if (usersid =3D=3D well_known_system_sid)
+  if (well_known_system_sid =3D=3D usersid)
     {
       auth_pos =3D -1;
       grp_list +=3D well_known_admins_sid;
@@ -1238,19 +1238,17 @@ get_attribute_from_acl (int * attribute,
       if (ace_sid =3D=3D well_known_world_sid)
 	{
 	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_IROTH
+	    *flags |=3D ((!(*anti & S_IROTH)) ? S_IROTH : 0)
 		      | ((!(*anti & S_IRGRP)) ? S_IRGRP : 0)
 		      | ((!(*anti & S_IRUSR)) ? S_IRUSR : 0);
 	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_IWOTH
+	    *flags |=3D ((!(*anti & S_IWOTH)) ? S_IWOTH : 0)
 		      | ((!(*anti & S_IWGRP)) ? S_IWGRP : 0)
 		      | ((!(*anti & S_IWUSR)) ? S_IWUSR : 0);
 	  if (ace->Mask & FILE_EXECUTE)
-	    {
-	      *flags |=3D S_IXOTH
-			| ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)
-			| ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);
-	    }
+	    *flags |=3D ((!(*anti & S_IXOTH)) ? S_IXOTH : 0)
+	              | ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)
+	              | ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);
 	  if ((*attribute & S_IFDIR) &&
 	      (ace->Mask & (FILE_WRITE_DATA | FILE_EXECUTE | FILE_DELETE_CHILD))
 	      =3D=3D (FILE_WRITE_DATA | FILE_EXECUTE))
@@ -1266,31 +1264,37 @@ get_attribute_from_acl (int * attribute,
 	  if (ace->Mask & FILE_APPEND_DATA)
 	    *flags |=3D S_ISUID;
 	}
-      else if (owner_sid && ace_sid =3D=3D owner_sid)
+      else if (ace_sid =3D=3D owner_sid)
 	{
 	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_IRUSR;
+	    *flags |=3D ((!(*anti & S_IRUSR)) ? S_IRUSR : 0);
 	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_IWUSR;
+	    *flags |=3D ((!(*anti & S_IWUSR)) ? S_IWUSR : 0);
 	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |=3D S_IXUSR;
+	    *flags |=3D ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);
 	}
-      else if (group_sid && ace_sid =3D=3D group_sid)
+      else if (ace_sid =3D=3D group_sid)
 	{
 	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_IRGRP
+	    *flags |=3D ((!(*anti & S_IRGRP)) ? S_IRGRP : 0)
 		      | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);
 	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_IWGRP
+	    *flags |=3D ((!(*anti & S_IWGRP)) ? S_IWGRP : 0)
 		      | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);
 	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |=3D S_IXGRP
+	    *flags |=3D ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)
 		      | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);
 	}
     }
   *attribute &=3D ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_IS=
UID);
+  if (owner_sid && group_sid && EqualSid (owner_sid, group_sid))
+    {
+      allow &=3D ~(S_IRGRP | S_IWGRP | S_IXGRP);
+      allow |=3D (((allow & S_IRUSR) ? S_IRGRP : 0)
+		| ((allow & S_IWUSR) ? S_IWGRP : 0)
+		| ((allow & S_IXUSR) ? S_IXGRP : 0));
+    }
   *attribute |=3D allow;
-  *attribute &=3D ~deny;
   return;
 }

@@ -1494,9 +1498,9 @@ add_access_allowed_ace (PACL acl, int of
       return FALSE;
     }
   ACCESS_ALLOWED_ACE *ace;
-  if (GetAce (acl, offset, (PVOID *) &ace))
+  if (inherit && GetAce (acl, offset, (PVOID *) &ace))
     ace->Header.AceFlags |=3D inherit;
-  len_add +=3D sizeof (ACCESS_DENIED_ACE) - sizeof (DWORD) + GetLengthSid =
(sid);
+  len_add +=3D sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD) + GetLengthSid=
 (sid);
   return TRUE;
 }

@@ -1510,7 +1514,7 @@ add_access_denied_ace (PACL acl, int off
       return FALSE;
     }
   ACCESS_DENIED_ACE *ace;
-  if (GetAce (acl, offset, (PVOID *) &ace))
+  if (inherit && GetAce (acl, offset, (PVOID *) &ace))
     ace->Header.AceFlags |=3D inherit;
   len_add +=3D sizeof (ACCESS_DENIED_ACE) - sizeof (DWORD) + GetLengthSid =
(sid);
   return TRUE;
@@ -1522,36 +1526,33 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
 {
   BOOL dummy;

-  if (!wincap.has_security ())
-    return NULL;
-
+  debug_printf("uid %d, gid %d, attribute %x",
+	       uid, gid, attribute);
   if (!sd_ret || !sd_size_ret)
     {
       set_errno (EINVAL);
       return NULL;
     }

+  /* Get owner and group from current security descriptor. */
+  PSID cur_owner_sid =3D NULL;
+  PSID cur_group_sid =3D NULL;
+  if (!GetSecurityDescriptorOwner (sd_ret, &cur_owner_sid, &dummy))
+    debug_printf ("GetSecurityDescriptorOwner %E");
+  if (!GetSecurityDescriptorGroup (sd_ret, &cur_group_sid, &dummy))
+    debug_printf ("GetSecurityDescriptorGroup %E");
+
   /* Get SID of owner. */
   cygsid owner_sid (NO_SID);
   /* Check for current user first */
   if (uid =3D=3D myself->uid)
     owner_sid =3D cygheap->user.sid ();
-  else
+  else if (uid =3D=3D ILLEGAL_UID)
+    owner_sid =3D cur_owner_sid;
+  else if (!owner_sid.getfrompw (getpwuid32 (uid)))
     {
-      /* Otherwise retrieve user data from /etc/passwd */
-      struct passwd *pw =3D getpwuid32 (uid);
-      if (!pw)
-	{
-	  debug_printf ("no /etc/passwd entry for %d", uid);
-	  set_errno (EINVAL);
-	  return NULL;
-	}
-      else if (!owner_sid.getfrompw (pw))
-	{
-	  debug_printf ("no SID for user %d", uid);
-	  set_errno (EINVAL);
-	  return NULL;
-	}
+      set_errno (EINVAL);
+      return NULL;
     }
   owner_sid.debug_print ("alloc_sd: owner SID =3D");

@@ -1560,14 +1561,15 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
   /* Check for current user first */
   if (gid =3D=3D myself->gid)
     group_sid =3D cygheap->user.groups.pgsid;
-  else
-   {
-      struct __group32 *grp =3D getgrgid32 (gid);
-      if (!grp)
-	debug_printf ("no /etc/group entry for %d", gid);
-      else if (!group_sid.getfromgr (grp))
-	debug_printf ("no SID for group %d", gid);
-   }
+  else if (gid =3D=3D ILLEGAL_GID)
+    group_sid =3D cur_group_sid;
+  else if (!group_sid.getfromgr (getgrgid32 (gid)))
+    {
+      set_errno (EINVAL);
+      return NULL;
+    }
+  group_sid.debug_print ("alloc_sd: group SID =3D");
+
   /* Initialize local security descriptor. */
   SECURITY_DESCRIPTOR sd;
   PSECURITY_DESCRIPTOR psd =3D NULL;
@@ -1594,7 +1596,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
     }

   /* Create group for local security descriptor. */
-  if (group_sid && !SetSecurityDescriptorGroup (&sd, group_sid, FALSE))
+  if (!SetSecurityDescriptorGroup (&sd, group_sid, FALSE))
     {
       __seterrno ();
       return NULL;
@@ -1611,7 +1613,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid,

   /* From here fill ACL. */
   size_t acl_len =3D sizeof (ACL);
-  int ace_off =3D 0;
+  int ace_off =3D 0, owner_off;

   /* Construct allow attribute for owner. */
   DWORD owner_allow =3D (STANDARD_RIGHTS_ALL & ~DELETE)
@@ -1664,18 +1666,25 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
       if (attribute & S_ISVTX)
 	null_allow |=3D FILE_READ_DATA;
     }
-
-  /* Construct deny attributes for owner and group. */
-  DWORD owner_deny =3D 0;
-  if (is_grp_member (uid, gid))
-    owner_deny =3D ~owner_allow & (group_allow | other_allow);
+
+  /* Add owner and group permissions if SIDs are equal
+     and construct deny attributes for group and owner. */
+  DWORD group_deny;
+  if (owner_sid =3D=3D group_sid)
+    {
+      owner_allow |=3D group_allow;
+      group_allow =3D group_deny =3D 0L;
+    }
   else
-    owner_deny =3D ~owner_allow & other_allow;
+    {
+      group_deny =3D ~group_allow & other_allow;
+      group_deny &=3D ~(STANDARD_RIGHTS_READ
+		      | FILE_READ_ATTRIBUTES | FILE_READ_EA);
+    }
+  DWORD owner_deny =3D ~owner_allow & (group_allow | other_allow);
   owner_deny &=3D ~(STANDARD_RIGHTS_READ
 		  | FILE_READ_ATTRIBUTES | FILE_READ_EA
 		  | FILE_WRITE_ATTRIBUTES | FILE_WRITE_EA);
-  DWORD group_deny =3D ~group_allow & other_allow;
-  group_deny &=3D ~(STANDARD_RIGHTS_READ | FILE_READ_ATTRIBUTES | FILE_REA=
D_EA);

   /* Construct appropriate inherit attribute. */
   DWORD inherit =3D (attribute & S_IFDIR) ? SUB_CONTAINERS_AND_OBJECTS_INH=
ERIT
@@ -1686,18 +1695,29 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
       && !add_access_denied_ace (acl, ace_off++, owner_deny,
 				 owner_sid, acl_len, inherit))
     return NULL;
+  /* Set deny ACE for group here to respect the canonical order,
+     if this does not impact owner */
+  if (group_deny && !(owner_allow & group_deny))
+    {
+      if (!add_access_denied_ace (acl, ace_off++, group_deny,
+				 group_sid, acl_len, inherit))
+	return NULL;
+      group_deny =3D 0;
+    }
   /* Set allow ACE for owner. */
+  owner_off =3D ace_off;
   if (!add_access_allowed_ace (acl, ace_off++, owner_allow,
 			       owner_sid, acl_len, inherit))
     return NULL;
-  /* Set deny ACE for group. */
+  /* Set deny ACE for group, if still needed. */
   if (group_deny
       && !add_access_denied_ace (acl, ace_off++, group_deny,
 				 group_sid, acl_len, inherit))
     return NULL;
   /* Set allow ACE for group. */
-  if (!add_access_allowed_ace (acl, ace_off++, group_allow,
-			       group_sid, acl_len, inherit))
+  if (group_allow
+      && !add_access_allowed_ace (acl, ace_off++, group_allow,
+				  group_sid, acl_len, inherit))
     return NULL;

   /* Set allow ACE for everyone. */
@@ -1710,14 +1730,6 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
 				  well_known_null_sid, acl_len, NO_INHERITANCE))
     return NULL;

-  /* Get owner and group from current security descriptor. */
-  PSID cur_owner_sid =3D NULL;
-  PSID cur_group_sid =3D NULL;
-  if (!GetSecurityDescriptorOwner (sd_ret, &cur_owner_sid, &dummy))
-    debug_printf ("GetSecurityDescriptorOwner %E");
-  if (!GetSecurityDescriptorGroup (sd_ret, &cur_group_sid, &dummy))
-    debug_printf ("GetSecurityDescriptorGroup %E");
-
   /* Fill ACL with unrelated ACEs from current security descriptor. */
   PACL oacl;
   BOOL acl_exists;
@@ -1729,20 +1741,22 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
 	{
 	  cygsid ace_sid ((PSID) &ace->SidStart);
 	  /* Check for related ACEs. */
-	  if ((cur_owner_sid && ace_sid =3D=3D cur_owner_sid)
-	      || (owner_sid && ace_sid =3D=3D owner_sid)
-	      || (cur_group_sid && ace_sid =3D=3D cur_group_sid)
-	      || (group_sid && ace_sid =3D=3D group_sid)
+	  if ((ace_sid =3D=3D cur_owner_sid)
+	      || (ace_sid =3D=3D owner_sid)
+	      || (ace_sid =3D=3D cur_group_sid)
+	      || (ace_sid =3D=3D group_sid)
 	      || (ace_sid =3D=3D well_known_world_sid)
 	      || (ace_sid =3D=3D well_known_null_sid))
 	    continue;
 	  /*
-	   * Add unrelated ACCESS_DENIED_ACE to the beginning but
-	   * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
+	   * Add unrelated ACCESS_DENIED_ACE to the beginning,
+	   * preferrably before the owner_allowed ACE,
+	   * ACCESS_ALLOWED_ACE to the end.
 	   */
 	  if (!AddAce (acl, ACL_REVISION,
 		       ace->Header.AceType =3D=3D ACCESS_DENIED_ACE_TYPE ?
-		       (owner_deny ? 1 : 0) : MAXDWORD,
+		       ace->Mask & owner_allow ? owner_off + 1 : owner_off++
+		       : MAXDWORD,
 		       (LPVOID) ace, ace->Header.AceSize))
 	    {
 	      __seterrno ();
--- syscalls.cc.orig	2002-11-12 22:12:40.000000000 -0500
+++ syscalls.cc	2002-11-12 22:30:24.000000000 -0500
@@ -773,8 +773,6 @@ static int
 chown_worker (const char *name, unsigned fmode, __uid32_t uid, __gid32_t g=
id)
 {
   int res;
-  __uid32_t old_uid;
-  __gid32_t old_gid;

   if (check_null_empty_str_errno (name))
     return -1;
@@ -806,20 +804,10 @@ chown_worker (const char *name, unsigned
 	attrib |=3D S_IFDIR;
       res =3D get_file_attribute (win32_path.has_acls (),
 				win32_path.get_win32 (),
-				(int *) &attrib,
-				&old_uid,
-				&old_gid);
+				(int *) &attrib);
       if (!res)
-	{
-	  if (uid =3D=3D ILLEGAL_UID)
-	    uid =3D old_uid;
-	  if (gid =3D=3D ILLEGAL_GID)
-	    gid =3D old_gid;
-	  if (win32_path.isdir ())
-	    attrib |=3D S_IFDIR;
-	  res =3D set_file_attribute (win32_path.has_acls (), win32_path, uid,
-				    gid, attrib);
-	}
+         res =3D set_file_attribute (win32_path.has_acls (), win32_path, u=
id,
+				   gid, attrib);
       if (res !=3D 0 && (!win32_path.has_acls () || !allow_ntsec))
 	{
 	  /* fake - if not supported, pretend we're like win95
@@ -936,19 +924,10 @@ chmod (const char *path, mode_t mode)
       /* temporary erase read only bit, to be able to set file security */
       SetFileAttributes (win32_path, (DWORD) win32_path & ~FILE_ATTRIBUTE_=
READONLY);

-      __uid32_t uid;
-      __gid32_t gid;
-
-      if (win32_path.isdir ())
-	mode |=3D S_IFDIR;
-      get_file_attribute (win32_path.has_acls (),
-			  win32_path.get_win32 (),
-			  NULL, &uid, &gid);
-      /* FIXME: Do we really need this to be specified twice? */
       if (win32_path.isdir ())
 	mode |=3D S_IFDIR;
-      if (!set_file_attribute (win32_path.has_acls (), win32_path, uid, gi=
d,
-				mode)
+      if (!set_file_attribute (win32_path.has_acls (), win32_path,
+			       ILLEGAL_UID, ILLEGAL_GID, mode)
 	  && allow_ntsec)
 	res =3D 0;


--=====================_1037347494==_--
