Return-Path: <cygwin-patches-return-3129-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28882 invoked by alias); 6 Nov 2002 16:28:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28871 invoked from network); 6 Nov 2002 16:28:38 -0000
Message-ID: <3DC9432E.D869815C@ieee.org>
Date: Wed, 06 Nov 2002 08:28:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Content-Type: multipart/mixed;
 boundary="------------DE99E35F5197CB89C46D861B"
X-SW-Source: 2002-q4/txt/msg00080.txt.bz2

This is a multi-part message in MIME format.
--------------DE99E35F5197CB89C46D861B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 4852

Hello Corinna,

The patch below includes the uid == gid patch (now obsolete) I sent 
before you left and more recent changes that make Cygwin more robust
against incomplete /etc/passwd and /etc/group files.

The discussion below covers the main changes but doesn't go into
details about simple bug fixes, the ChangeLog has additional info.
Of course I will answer any question you may have. 
I have been running with the changes for a long time.
 
alloc_sd
********
The major change is that alloc_sd uses {ug}id == -1 in the
same way as chown does. This makes Cygwin more efficient (simplified
chown_worker and chmod in syscalls.cc), but it was motivated by 
fixing the "chmod bug" (reported a zillion times in the list).
chmod failed when the owner (or group) sid of the file was not found
in passwd. Now the sid doesn't need to be looked up, so the issue is 
gone.

alloc_sd also handles the case gid == uid and always creates
an owner_deny ACE if the group permissions are wider than the
user permissions (previously it was calling is_grp_member(uid, gid),
which has problems discussed below).

get_attribute_from_acl
**********************
Here there is a design issue.
When ntsec is off, the function is_grp_member(uid, gid),
[in sec_helper.cc], which provides input to get_attribute_from acl,
returns true if the file uid is a member of gid (reading /etc/group). 
However if ntsec is on, the function returns true if the 
current process access token contains the gid, *independent* of uid.

As a result, to a user SID_A doing ls -l on a file with uid SID_U and 
gid SID_G, it may (wrongly) appear that the file is user readable just
because it is group readable and SID_G is in the current access token 
(of SID_A) and there is no access_denied on SID_U, even if SID_U is 
not in group SID_G. 
[this is not so easy to observe, due to the way alloc_sd works]
To avoid this situation, but still try to report the true access of 
files owned by the current user SID_A, I only call is_grp_member when 
SID_A == SID_U.

Note that is_grp_member is expensive: a passwd scan + getting the token
groups in a malloc'ed structure. I am wondering if the effort is
justified, considering that it is useless when the ACL is built by
Cygwin (because Cygwin will put an access denied ACE if needed).

This raises a basic issue: What is get_attribute_from acl trying to 
accomplish? I can see several answers:
A) For "other" and "group", have "modes" report the true access rights
   A1) if the ACL was built by Cygwin
   A2) all the time.
I believe we can easily do A2.

B) For "user", have "modes" report the true access rights
   B1) if the ACL was built by Cygwin
   B2) if the file uid is the current euid
   B3) all the time
The patch stands somewhere between B1 and B2 (we don't take all the
group ACE in consideration, only the gid). Should we reduce to B1 
(by removing is_grp_member completely)
or extend to B2 (perhaps by using AccessCheck)?
Doing B3 would require looking up the PDC etc..,  not recommended. 

Although I didn't do it, I would remove is_grp_member completely.
If it is kept, the output of stat and "ls -l" can depend on the sid 
of the user running the command. That's undesirable. For the same
reason I wouldn't try to achieve B2 with AccessCheck.
What do you think?

If we keep is_grp_member I will optimize the call flow to remove
the passwd scan.


Pierre

2002-11-06  Pierre Humblet <pierre.humblet@ieee.org>

	* security.cc (get_attribute_from_acl): Always test "anti",
	just in case an access_denied ACE follows an access_allowed.
	Handle the case owner_sid == group_sid. Remove unnecessary
	tests for non-NULL PSIDs.
	(get_nt_object_attribute): Only set grp_member if myself->uid
	is uid.
	(get_nt_attribute): Ditto.
	(alloc_sd): Use existing owner and group sids if {ug}id == -1.
	Handle case where owner_sid == group_sid.
	Do not call is_grp_member. Try to preserve canonical ACE order.
	Add unrelated access_denied ACEs at the correct position.
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
	* sec_helper (cygsid::getfromstr): Reorganize to remove
	calls to strcpy and strtok_r.
	(cygsid::getfromgr): Change type to __uid32_t instead of int.
	Keep only the allow_ntsec branch. Never call LookupAccountSid 
	(which calls PDCs), simply return -1 in case of failure.
	Use cygsid == instead of calling EqualSid and remove test 
	for NULL psid.
	* security.h: Declare cygsid::getfromgr as __uid32_t.
--------------DE99E35F5197CB89C46D861B
Content-Type: text/plain; charset=us-ascii;
 name="sec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sec.diff"
Content-length: 18382

--- security.cc.orig	2002-10-22 22:18:40.000000000 -0400
+++ security.cc	2002-10-26 17:35:18.000000000 -0400
@@ -449,7 +449,7 @@ get_user_primary_group (WCHAR *wlogonser
   BOOL retval = FALSE;
   UCHAR count = 0;
 
-  if (pusersid == well_known_system_sid)
+  if (well_known_system_sid == pusersid)
     {
       pgrpsid = well_known_system_sid;
       return TRUE;
@@ -540,7 +540,7 @@ get_initgroups_sidlist (cygsidlist &grp_
 {
   grp_list += well_known_world_sid;
   grp_list += well_known_authenticated_users_sid;
-  if (usersid == well_known_system_sid)
+  if (well_known_system_sid == usersid)
     {
       auth_pos = -1;
       grp_list += well_known_admins_sid;
@@ -1238,19 +1238,17 @@ get_attribute_from_acl (int * attribute,
       if (ace_sid == well_known_world_sid)
 	{
 	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |= S_IROTH
+	    *flags |= ((!(*anti & S_IROTH)) ? S_IROTH : 0)
 		      | ((!(*anti & S_IRGRP)) ? S_IRGRP : 0)
 		      | ((!(*anti & S_IRUSR)) ? S_IRUSR : 0);
 	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |= S_IWOTH
+	    *flags |= ((!(*anti & S_IWOTH)) ? S_IWOTH : 0)
 		      | ((!(*anti & S_IWGRP)) ? S_IWGRP : 0)
 		      | ((!(*anti & S_IWUSR)) ? S_IWUSR : 0);
 	  if (ace->Mask & FILE_EXECUTE)
-	    {
-	      *flags |= S_IXOTH
-			| ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)
-			| ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);
-	    }
+	    *flags |= ((!(*anti & S_IXOTH)) ? S_IXOTH : 0)
+	              | ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)
+	              | ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);
 	  if ((*attribute & S_IFDIR) &&
 	      (ace->Mask & (FILE_WRITE_DATA | FILE_EXECUTE | FILE_DELETE_CHILD))
 	      == (FILE_WRITE_DATA | FILE_EXECUTE))
@@ -1266,31 +1264,37 @@ get_attribute_from_acl (int * attribute,
 	  if (ace->Mask & FILE_APPEND_DATA)
 	    *flags |= S_ISUID;
 	}
-      else if (owner_sid && ace_sid == owner_sid)
+      else if (ace_sid == owner_sid)
 	{
 	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |= S_IRUSR;
+	    *flags |= ((!(*anti & S_IRUSR)) ? S_IRUSR : 0);
 	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |= S_IWUSR;
+	    *flags |= ((!(*anti & S_IWUSR)) ? S_IWUSR : 0);
 	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |= S_IXUSR;
+	    *flags |= ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);
 	}
-      else if (group_sid && ace_sid == group_sid)
+      else if (ace_sid == group_sid)
 	{
 	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |= S_IRGRP
+	    *flags |= ((!(*anti & S_IRGRP)) ? S_IRGRP : 0)
 		      | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);
 	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |= S_IWGRP
+	    *flags |= ((!(*anti & S_IWGRP)) ? S_IWGRP : 0)
 		      | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);
 	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |= S_IXGRP
+	    *flags |= ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)
 		      | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);
 	}
     }
   *attribute &= ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_ISUID);
+  if (owner_sid && group_sid && EqualSid (owner_sid, group_sid))
+    {
+      allow &= ~(S_IRGRP | S_IWGRP | S_IXGRP);
+      allow |= (((allow & S_IRUSR) ? S_IRGRP : 0) 
+		| ((allow & S_IWUSR) ? S_IWGRP : 0)
+		| ((allow & S_IXUSR) ? S_IXGRP : 0));
+    }
   *attribute |= allow;
-  *attribute &= ~deny;
   return;
 }
 
@@ -1347,7 +1351,7 @@ get_nt_attribute (const char *file, int 
       return 0;
     }
 
-  BOOL grp_member = is_grp_member (uid, gid);
+  BOOL grp_member = (myself->uid == uid ) && is_grp_member (uid, gid);
 
   if (!acl_exists || !acl)
     {
@@ -1438,7 +1442,7 @@ get_nt_object_attribute (HANDLE handle, 
       return 0;
     }
 
-  BOOL grp_member = is_grp_member (uid, gid);
+  BOOL grp_member = (myself->uid == uid ) && is_grp_member (uid, gid);
 
   if (!acl)
     {
@@ -1494,9 +1498,9 @@ add_access_allowed_ace (PACL acl, int of
       return FALSE;
     }
   ACCESS_ALLOWED_ACE *ace;
-  if (GetAce (acl, offset, (PVOID *) &ace))
+  if (inherit && GetAce (acl, offset, (PVOID *) &ace))
     ace->Header.AceFlags |= inherit;
-  len_add += sizeof (ACCESS_DENIED_ACE) - sizeof (DWORD) + GetLengthSid (sid);
+  len_add += sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD) + GetLengthSid (sid);
   return TRUE;
 }
 
@@ -1510,7 +1514,7 @@ add_access_denied_ace (PACL acl, int off
       return FALSE;
     }
   ACCESS_DENIED_ACE *ace;
-  if (GetAce (acl, offset, (PVOID *) &ace))
+  if (inherit && GetAce (acl, offset, (PVOID *) &ace))
     ace->Header.AceFlags |= inherit;
   len_add += sizeof (ACCESS_DENIED_ACE) - sizeof (DWORD) + GetLengthSid (sid);
   return TRUE;
@@ -1522,52 +1526,56 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
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
+  PSID cur_owner_sid = NULL;
+  PSID cur_group_sid = NULL;
+  if (!GetSecurityDescriptorOwner (sd_ret, &cur_owner_sid, &dummy))
+    debug_printf ("GetSecurityDescriptorOwner %E");
+  if (!GetSecurityDescriptorGroup (sd_ret, &cur_group_sid, &dummy))
+    debug_printf ("GetSecurityDescriptorGroup %E");
+
   /* Get SID of owner. */
   cygsid owner_sid (NO_SID);
   /* Check for current user first */
   if (uid == myself->uid)
     owner_sid = cygheap->user.sid ();
+  else if (uid == ILLEGAL_UID)
+    owner_sid = cur_owner_sid;   
   else
     {
       /* Otherwise retrieve user data from /etc/passwd */
       struct passwd *pw = getpwuid32 (uid);
-      if (!pw)
-	{
-	  debug_printf ("no /etc/passwd entry for %d", uid);
-	  set_errno (EINVAL);
-	  return NULL;
-	}
-      else if (!owner_sid.getfrompw (pw))
+      if (!owner_sid.getfrompw (pw))
 	{
-	  debug_printf ("no SID for user %d", uid);
 	  set_errno (EINVAL);
 	  return NULL;
 	}
     }
-  owner_sid.debug_print ("alloc_sd: owner SID =");
 
   /* Get SID of new group. */
   cygsid group_sid (NO_SID);
   /* Check for current user first */
   if (gid == myself->gid)
     group_sid = cygheap->user.groups.pgsid;
+  else if (uid == ILLEGAL_GID)
+    group_sid = cur_group_sid;   
   else
-   {
+    {
       struct __group32 *grp = getgrgid32 (gid);
-      if (!grp)
-	debug_printf ("no /etc/group entry for %d", gid);
-      else if (!group_sid.getfromgr (grp))
-	debug_printf ("no SID for group %d", gid);
-   }
+      if (!group_sid.getfromgr (grp))
+        {
+	  set_errno (EINVAL);
+	  return NULL;
+	}
+    }
   /* Initialize local security descriptor. */
   SECURITY_DESCRIPTOR sd;
   PSECURITY_DESCRIPTOR psd = NULL;
@@ -1594,7 +1602,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
     }
 
   /* Create group for local security descriptor. */
-  if (group_sid && !SetSecurityDescriptorGroup (&sd, group_sid, FALSE))
+  if (!SetSecurityDescriptorGroup (&sd, group_sid, FALSE))
     {
       __seterrno ();
       return NULL;
@@ -1611,7 +1619,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
 
   /* From here fill ACL. */
   size_t acl_len = sizeof (ACL);
-  int ace_off = 0;
+  int ace_off = 0, owner_off;
 
   /* Construct allow attribute for owner. */
   DWORD owner_allow = (STANDARD_RIGHTS_ALL & ~DELETE)
@@ -1664,18 +1672,25 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
       if (attribute & S_ISVTX)
 	null_allow |= FILE_READ_DATA;
     }
-
-  /* Construct deny attributes for owner and group. */
-  DWORD owner_deny = 0;
-  if (is_grp_member (uid, gid))
-    owner_deny = ~owner_allow & (group_allow | other_allow);
+  
+  /* Add owner and group permissions if SIDs are equal
+     and construct deny attributes for group and owner. */
+  DWORD group_deny;
+  if (owner_sid == group_sid)
+    {
+      owner_allow |= group_allow;
+      group_allow = group_deny = 0L;
+    }
   else
-    owner_deny = ~owner_allow & other_allow;
+    {
+      group_deny = ~group_allow & other_allow;
+      group_deny &= ~(STANDARD_RIGHTS_READ 
+		      | FILE_READ_ATTRIBUTES | FILE_READ_EA);
+    }
+  DWORD owner_deny = ~owner_allow & (group_allow | other_allow);
   owner_deny &= ~(STANDARD_RIGHTS_READ
 		  | FILE_READ_ATTRIBUTES | FILE_READ_EA
 		  | FILE_WRITE_ATTRIBUTES | FILE_WRITE_EA);
-  DWORD group_deny = ~group_allow & other_allow;
-  group_deny &= ~(STANDARD_RIGHTS_READ | FILE_READ_ATTRIBUTES | FILE_READ_EA);
 
   /* Construct appropriate inherit attribute. */
   DWORD inherit = (attribute & S_IFDIR) ? SUB_CONTAINERS_AND_OBJECTS_INHERIT
@@ -1686,18 +1701,29 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
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
+      group_deny = 0;
+    }
   /* Set allow ACE for owner. */
+  owner_off = ace_off; 
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
@@ -1710,14 +1736,6 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
 				  well_known_null_sid, acl_len, NO_INHERITANCE))
     return NULL;
 
-  /* Get owner and group from current security descriptor. */
-  PSID cur_owner_sid = NULL;
-  PSID cur_group_sid = NULL;
-  if (!GetSecurityDescriptorOwner (sd_ret, &cur_owner_sid, &dummy))
-    debug_printf ("GetSecurityDescriptorOwner %E");
-  if (!GetSecurityDescriptorGroup (sd_ret, &cur_group_sid, &dummy))
-    debug_printf ("GetSecurityDescriptorGroup %E");
-
   /* Fill ACL with unrelated ACEs from current security descriptor. */
   PACL oacl;
   BOOL acl_exists;
@@ -1729,20 +1747,22 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
 	{
 	  cygsid ace_sid ((PSID) &ace->SidStart);
 	  /* Check for related ACEs. */
-	  if ((cur_owner_sid && ace_sid == cur_owner_sid)
-	      || (owner_sid && ace_sid == owner_sid)
-	      || (cur_group_sid && ace_sid == cur_group_sid)
-	      || (group_sid && ace_sid == group_sid)
+	  if ((ace_sid == cur_owner_sid)
+	      || (ace_sid == owner_sid)
+	      || (ace_sid == cur_group_sid)
+	      || (ace_sid == group_sid)
 	      || (ace_sid == well_known_world_sid)
 	      || (ace_sid == well_known_null_sid))
 	    continue;
 	  /*
-	   * Add unrelated ACCESS_DENIED_ACE to the beginning but
-	   * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
+	   * Add unrelated ACCESS_DENIED_ACE to the beginning,
+	   * preferrably before the owner_allowed ACE,
+	   * ACCESS_ALLOWED_ACE to the end.
 	   */
 	  if (!AddAce (acl, ACL_REVISION,
 		       ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
-		       (owner_deny ? 1 : 0) : MAXDWORD,
+		       ace->Mask & owner_allow ? owner_off + 1 : owner_off++ 
+		       : MAXDWORD,
 		       (LPVOID) ace, ace->Header.AceSize))
 	    {
 	      __seterrno ();
--- syscalls.cc.orig	2002-10-20 21:38:02.000000000 -0400
+++ syscalls.cc	2002-10-26 17:42:18.000000000 -0400
@@ -773,8 +773,6 @@ static int
 chown_worker (const char *name, unsigned fmode, __uid32_t uid, __gid32_t gid)
 {
   int res;
-  __uid32_t old_uid;
-  __gid32_t old_gid;
 
   if (check_null_empty_str_errno (name))
     return -1;
@@ -806,20 +804,10 @@ chown_worker (const char *name, unsigned
 	attrib |= S_IFDIR;
       res = get_file_attribute (win32_path.has_acls (),
 				win32_path.get_win32 (),
-				(int *) &attrib,
-				&old_uid,
-				&old_gid);
+				(int *) &attrib);
       if (!res)
-	{
-	  if (uid == ILLEGAL_UID)
-	    uid = old_uid;
-	  if (gid == ILLEGAL_GID)
-	    gid = old_gid;
-	  if (win32_path.isdir ())
-	    attrib |= S_IFDIR;
-	  res = set_file_attribute (win32_path.has_acls (), win32_path, uid,
-				    gid, attrib);
-	}
+         res = set_file_attribute (win32_path.has_acls (), win32_path, uid,
+				   gid, attrib);
       if (res != 0 && (!win32_path.has_acls () || !allow_ntsec))
 	{
 	  /* fake - if not supported, pretend we're like win95
@@ -936,19 +924,10 @@ chmod (const char *path, mode_t mode)
       /* temporary erase read only bit, to be able to set file security */
       SetFileAttributes (win32_path, (DWORD) win32_path & ~FILE_ATTRIBUTE_READONLY);
 
-      __uid32_t uid;
-      __gid32_t gid;
-
-      if (win32_path.isdir ())
-	mode |= S_IFDIR;
-      get_file_attribute (win32_path.has_acls (),
-			  win32_path.get_win32 (),
-			  NULL, &uid, &gid);
-      /* FIXME: Do we really need this to be specified twice? */
       if (win32_path.isdir ())
 	mode |= S_IFDIR;
-      if (!set_file_attribute (win32_path.has_acls (), win32_path, uid, gid,
-				mode)
+      if (!set_file_attribute (win32_path.has_acls (), win32_path, 
+			       ILLEGAL_UID, ILLEGAL_GID, mode)
 	  && allow_ntsec)
 	res = 0;
 
@@ -967,7 +946,7 @@ chmod (const char *path, mode_t mode)
       else
 	{
 	  /* Correct NTFS security attributes have higher priority */
-	  if (res == 0 || !allow_ntsec)
+	  if (!allow_ntsec)
 	    res = 0;
 	}
     }
--- sec_helper.cc.orig	2002-10-22 22:18:40.000000000 -0400
+++ sec_helper.cc	2002-10-26 14:59:18.000000000 -0400
@@ -99,29 +99,19 @@ cygsid::get_sid (DWORD s, DWORD cnt, DWO
 const PSID
 cygsid::getfromstr (const char *nsidstr)
 {
-  char sid_buf[256];
-  char *t, *lasts;
-  DWORD cnt = 0;
-  DWORD s = 0;
-  DWORD i, r[8];
-
-  if (!nsidstr || strncmp (nsidstr, "S-1-", 4))
-    {
-      psid = NO_SID;
-      return NULL;
+  char *lasts;
+  DWORD s, cnt = 0;
+  DWORD r[8];
+
+  if (nsidstr && !strncmp (nsidstr, "S-1-", 4))
+    {
+      s = strtoul (nsidstr + 4, &lasts, 10);
+      while ( cnt < 8 && *lasts == '-')
+	r[cnt++] = strtoul (lasts + 1, &lasts, 10);
+      if (!*lasts)
+	return get_sid (s, cnt, r);
     }
-
-  strcpy (sid_buf, nsidstr);
-
-  for (t = sid_buf + 4, i = 0;
-       cnt < 8 && (t = strtok_r (t, "-", &lasts));
-       t = NULL, ++i)
-    if (i == 0)
-      s = strtoul (t, NULL, 10);
-    else
-      r[cnt++] = strtoul (t, NULL, 10);
-
-  return get_sid (s, cnt, r);
+  return psid = NO_SID;
 }
 
 BOOL
@@ -138,124 +128,54 @@ cygsid::getfromgr (const struct __group3
   return (*this = sp ?: "") != NULL;
 }
 
-int
+__uid32_t
 cygsid::get_id (BOOL search_grp, int *type)
 {
-  if (!psid)
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
-  if (!IsValidSid (psid))
-    {
-      __seterrno ();
-      system_printf ("IsValidSid failed with %E");
-      return -1;
-    }
-
   /* First try to get SID from passwd or group entry */
-  if (allow_ntsec)
-    {
-      cygsid sid;
-      int id = -1;
-
-      if (!search_grp)
-	{
-	  struct passwd *pw;
-	 if (EqualSid(psid, cygheap->user.sid ()))
-	   id = myself->uid;
-	 else
-	   for (int pidx = 0; (pw = internal_getpwent (pidx)); ++pidx)
-	     {
-	       if (sid.getfrompw (pw) && sid == psid)
-		 {
-		   id = pw->pw_uid;
-		   break;
-		 }
-	     }
-	  if (id >= 0)
-	    {
-	      if (type)
-		*type = USER;
-	      return id;
-	    }
-	}
-      if (search_grp || type)
-	{
-	  struct __group32 *gr;
-	 if (cygheap->user.groups.pgsid == psid)
-	   id = myself->gid;
-	 else
-	   for (int gidx = 0; (gr = internal_getgrent (gidx)); ++gidx)
-	     {
-	       if (sid.getfromgr (gr) && sid == psid)
-		 {
-		   id = gr->gr_gid;
-		   break;
-		 }
-	     }
-	  if (id >= 0)
-	    {
-	      if (type)
-		*type = GROUP;
-	      return id;
-	    }
-	}
-    }
-
-  /* We use the RID as default UID/GID */
-  int id = *GetSidSubAuthority (psid, *GetSidSubAuthorityCount (psid) - 1);
-
-  /*
-   * The RID maybe -1 if accountname == computername.
-   * In this case we search for the accountname in the passwd and group files.
-   * If type is needed, we search in each case.
-   */
-  if (id == -1 || type)
-    {
-      char account[UNLEN + 1];
-      char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-      DWORD acc_len = UNLEN + 1;
-      DWORD dom_len = INTERNET_MAX_HOST_NAME_LENGTH + 1;
-      SID_NAME_USE acc_type;
-
-      if (!LookupAccountSid (NULL, psid, account, &acc_len,
-			     domain, &dom_len, &acc_type))
-	{
-	  __seterrno ();
-	  return -1;
-	}
+  cygsid sid;
+  __uid32_t id = ILLEGAL_UID;
 
-      switch (acc_type)
-	{
-	  case SidTypeGroup:
-	  case SidTypeAlias:
-	  case SidTypeWellKnownGroup:
-	    if (type)
-	      *type = GROUP;
-	    if (id == -1)
+  if (!search_grp)
+    {
+      struct passwd *pw;
+      if (*this == cygheap->user.sid ())
+	id = myself->uid;
+      else
+	for (int pidx = 0; (pw = internal_getpwent (pidx)); ++pidx)
+          {
+	    if (sid.getfrompw (pw) && sid == psid)
 	      {
-		struct __group32 *gr = getgrnam32 (account);
-		if (gr)
-		  id = gr->gr_gid;
+		id = pw->pw_uid;
+		break;
 	      }
-	    break;
-	  case SidTypeUser:
-	    if (type)
-	      *type = USER;
-	    if (id == -1)
+	  }
+      if (id != ILLEGAL_UID)
+	{
+	  if (type)
+	    *type = USER;
+	   return id;
+	 }
+    }
+  if (search_grp || type)
+    {
+      struct __group32 *gr;
+      if (cygheap->user.groups.pgsid == psid)
+	id = myself->gid;
+      else
+	for (int gidx = 0; (gr = internal_getgrent (gidx)); ++gidx)
+	  {
+	    if (sid.getfromgr (gr) && sid == psid)
 	      {
-		struct passwd *pw = getpwnam (account);
-		if (pw)
-		  id = pw->pw_uid;
+		id = gr->gr_gid;
+		break;
 	      }
-	    break;
-	  default:
-	    break;
+	  }
+      if (id != ILLEGAL_UID)
+	{
+	  if (type)
+	    *type = GROUP;
 	}
-    }
-  if (id == -1)
-    id = getuid32 ();
+     }
   return id;
 }
 
--- security.h.orig	2002-09-26 21:46:28.000000000 -0400
+++ security.h	2002-10-22 23:14:22.000000000 -0400
@@ -57,7 +57,7 @@ public:
   BOOL getfrompw (const struct passwd *pw);
   BOOL getfromgr (const struct __group32 *gr);
 
-  int get_id (BOOL search_grp, int *type = NULL);
+  __uid32_t get_id (BOOL search_grp, int *type = NULL);
   inline int get_uid () { return get_id (FALSE); }
   inline int get_gid () { return get_id (TRUE); }
 

--------------DE99E35F5197CB89C46D861B--
