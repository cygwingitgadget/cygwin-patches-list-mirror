Return-Path: <cygwin-patches-return-3200-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32389 invoked by alias); 18 Nov 2002 03:55:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32335 invoked from network); 18 Nov 2002 03:55:40 -0000
Message-Id: <3.0.5.32.20021117224255.00830bc0@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Sun, 17 Nov 2002 19:55:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
In-Reply-To: <20021115185609.Q24928@cygbert.vinschen.de>
References: <3DD52F08.44B62AAE@ieee.org>
 <3DD3D75C.99C07A78@ieee.org>
 <20021114182323.L10395@cygbert.vinschen.de>
 <20021114202105.N10395@cygbert.vinschen.de>
 <3.0.5.32.20021114220454.0082ca20@mail.attbi.com>
 <20021115105000.A24928@cygbert.vinschen.de>
 <3DD5053C.E50A33@ieee.org>
 <20021115160223.L24928@cygbert.vinschen.de>
 <3DD511B4.DBF3846E@ieee.org>
 <20021115180630.A31146@cygbert.vinschen.de>
 <3DD52F08.44B62AAE@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1037608975==_"
X-SW-Source: 2002-q4/txt/msg00151.txt.bz2

--=====================_1037608975==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2932

At 06:56 PM 11/15/2002 +0100, Corinna Vinschen wrote:
>On Fri, Nov 15, 2002 at 12:29:44PM -0500, Pierre A. Humblet wrote:
>> Alternatively I could add it, but add a check for group 
>> sid is SYSTEM, and then skip the step. That would be very easy
>> to do, and to remove later when ssh is ready.
>> I like this best actually.
>
>Good idea!  Me too.  But that must go into both functions,
>get_attribute_from_acl() and alloc_sd().

OK for get_attribute_from_acl (which is where the /var/empty
problem originates), but why for alloc_sd () ? 
The patch will do the right thing, whereas the current code 
can give rise to unexpected results. See below.

chmod 755 /var/empty  (which has owner == group)
With patch
**********
owner: system
group: system
acl:   system    7
       everybody 5   ==> Effective result 775
Currently
*********
owner: system
group: system
acl:   system    7
       system    5   ==> Note duplicate entry
       everybody 5   ==> Effective result 775

A more interesting case is
chmod 575 /var/empty   (just as an illustration)
With patch
**********
owner: system
group: system
acl:   system    7  ==> Single entry, 5 | 7
       everybody 5  ==> Effective result 775
Currently (if user system is NOT listed as a member of group system in
/etc/group)
*********
owner: system
group: system
acl:   system    5
       system    7
       everybody 5  ==> Effective result 775
Currently (change mkgroup -u to list user system in group system)
*********
owner: system
group: system
acl:	system   deny 2
	system    5
       system    7
       everybody 5  ==> Effective result 555 !!!!!

B.t.w. let's not change mkgroup, it's not necessary with the patch.

>Greetings from him (Michael Hirmke), btw.!
Hi Michael! I now put 2 and 2 together. Michael wrote to me
he was coming back from 5 a week vacation. For a while I was wondering
if October was to Germany as August is to France.

B.t.w. I don't have access to NT on weekends, so it's untested. I don't 
expect any trouble but...

Pierre

2002-11-18  Pierre Humblet <pierre.humblet@ieee.org>

	* security.cc (get_attribute_from_acl): Always test "anti",
	just in case an access_denied ACE follows an access_allowed.
	Handle the case owner_sid == group_sid, with a FIXME. 
	Remove unnecessary tests for non-NULL PSIDs.
	(alloc_sd): Use existing owner and group sids if {ug}id == -1.
	Handle case where owner_sid == group_sid.
	Do not call is_grp_member. Try to preserve canonical ACE order.
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

--=====================_1037608975==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sec.diff"
Content-length: 12415

--- security.cc.orig	2002-10-22 23:18:40.000000000 -0400
+++ security.cc	2002-11-15 19:26:22.000000000 -0500
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
@@ -1266,31 +1264,39 @@ get_attribute_from_acl (int * attribute,
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
+  if (owner_sid && group_sid && EqualSid (owner_sid, group_sid)
+      /* FIXME: temporary exception for /var/empty */
+      && well_known_system_sid !=3D group_sid)
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

@@ -1494,9 +1500,9 @@ add_access_allowed_ace (PACL acl, int of
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

@@ -1510,7 +1516,7 @@ add_access_denied_ace (PACL acl, int off
       return FALSE;
     }
   ACCESS_DENIED_ACE *ace;
-  if (GetAce (acl, offset, (PVOID *) &ace))
+  if (inherit && GetAce (acl, offset, (PVOID *) &ace))
     ace->Header.AceFlags |=3D inherit;
   len_add +=3D sizeof (ACCESS_DENIED_ACE) - sizeof (DWORD) + GetLengthSid =
(sid);
   return TRUE;
@@ -1522,36 +1528,33 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
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

@@ -1560,14 +1563,15 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
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
@@ -1594,7 +1598,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
     }

   /* Create group for local security descriptor. */
-  if (group_sid && !SetSecurityDescriptorGroup (&sd, group_sid, FALSE))
+  if (!SetSecurityDescriptorGroup (&sd, group_sid, FALSE))
     {
       __seterrno ();
       return NULL;
@@ -1664,18 +1668,25 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
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
@@ -1686,18 +1697,28 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
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
@@ -1710,14 +1731,6 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
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
@@ -1729,10 +1742,10 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
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


--=====================_1037608975==_--
