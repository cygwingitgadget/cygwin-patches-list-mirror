Return-Path: <cygwin-patches-return-3047-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26243 invoked by alias); 27 Sep 2002 14:51:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26173 invoked from network); 27 Sep 2002 14:51:29 -0000
Message-ID: <3D9470B5.87AAB099@ieee.org>
Date: Fri, 27 Sep 2002 07:51:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Modes of files with uid = gid
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00495.txt.bz2

Corinna,

Motivated by a Cygwin list e-mail on this subject last weekend I have
improved the handling of the modes of files with uid = gid.
The patch below does that, as well as some other things I did not
expect when I started. It also raises some questions and makes
this e-mail rather long :(

get_attribute_from_acl
**********************
1) When ntsec is off, the function is_grp_member(uid, gid) 
[in sec_helper.cc] returns true if the uid is a member of gid 
(reading /etc/group). However if ntsec is on, the function returns
true if the current process access token contains the gid,
independent of the uid.

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
Cygwin (because Cygwin will put an access denied ACE, see below).

This raises a basic issue: What is this function trying to accomplish? 
I can see several answers:
A) For "other" and "group", have "modes" report the true access rights
   A1) if the ACL was built by Cygwin
   A2) all the time.
I believe we can easily do A2.

B) For "user", have "modes" report the true access rights
   B1) if the ACL was built by Cygwin
   B2) if the file uid is the current euid
   B3) all the time
The patch stands somewhere between B1 and B2 (we don't take all the ACL
groups in consideration, only the gid). Should we reduce to B1 
or extend to B2 (perhaps by using AccessCheck)?
Doing B3 would require looking up the PDC etc..,  not recommended. 
Removing is_grp_member would preserve B1.
What do you think? We want to keep "ls -l" fast.

If we keep is_grp_member I will optimize the call flow to remove
the passwd scan.
 
2) ACLs produced by third parties may well (stupidly) contain an
access_denied ACE after a matching access_allowed ACE. To report
the mode correctly in this situation (and do A2) it is necessary
to always use constructs such as
	    *flags |= ((!(*anti & S_IROTH)) ? S_IROTH : 0)

3) When SID_U == SID_G, the group mode is now set to the user mode
in the returned attribute.

alloc_sd 
********
4) The same problem with is_grp_member also occurs here. To
avoid it I have suppressed the call and always set
owner_deny = ~owner_allow & (group_allow | other_allow);
As a result the ACL is independent of what uid's are in the
gid, which is as it should be.

5) When SID_U == SID_G I construct owner_allow from the OR
of the user modes and group modes. That's an arbitrary decision,
designed to be permissive. 

Finally I have done some minor cleanup, added unrelated access
denied ACE is position 0 (never 1), and removed a bunch of 
unnecessary "(! psid)" tests. 
"cygsid == psid" is valid even when psid is NULL.

Pierre

P.S.: Please don't apply this patch in the next official cygwin if 
it comes out this weekend, it should be tested in cvs for a few days.

Also, as I write this e-mail I realize that getgroups32 should
open the thread access token during impersonation.

2002-09-27  Pierre Humblet <pierre.humblet@ieee.org>

	* security.c (get_attribute_from_acl): Always test "anti".
	Handle case owner_sid == group_sid. Remove unnecessary
	tests for non-NULL PSIDs.
	(get_nt_object_attribute): Only set grp_member if myself->uid
	is uid.
	(get_nt_attribute): Ditto.
	(alloc_sd): Handle case where owner_sid == group_sid.
	Do not call is_grp_member. Try to preserve canonical order.
	Always add unrelated access_denied ACEs in position 0.
	Remove unnecessary tests for non-NULL PSIDs. Reorganize
	debug_printf's.

--- security.cc.orig	2002-09-25 19:35:48.000000000 -0400
+++ security.cc	2002-09-26 23:14:26.000000000 -0400
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
@@ -1522,9 +1526,8 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
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
@@ -1542,28 +1545,21 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
     {
       /* Otherwise retrieve user data from /etc/passwd */
       struct passwd *pw = getpwuid32 (uid);
-      if (!pw)
+      if (!owner_sid.getfrompw (pw))
 	{
-	  debug_printf ("no /etc/passwd entry for %d", uid);
-	  set_errno (EINVAL);
-	  return NULL;
-	}
-      else if (!owner_sid.getfrompw (pw))
-	{
-	  debug_printf ("no SID for user %d", uid);
 	  set_errno (EINVAL);
 	  return NULL;
 	}
     }
-  owner_sid.debug_print ("alloc_sd: owner SID =");
 
   /* Get SID of new group. */
   cygsid group_sid (NO_SID);
   struct __group32 *grp = getgrgid32 (gid);
-  if (!grp)
-    debug_printf ("no /etc/group entry for %d", gid);
-  else if (!group_sid.getfromgr (grp))
-    debug_printf ("no SID for group %d", gid);
+  if (!group_sid.getfromgr (grp))
+    {
+      set_errno (EINVAL);
+      return NULL;
+    }
 
   /* Initialize local security descriptor. */
   SECURITY_DESCRIPTOR sd;
@@ -1591,7 +1587,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
     }
 
   /* Create group for local security descriptor. */
-  if (group_sid && !SetSecurityDescriptorGroup (&sd, group_sid, FALSE))
+  if (!SetSecurityDescriptorGroup (&sd, group_sid, FALSE))
     {
       __seterrno ();
       return NULL;
@@ -1661,18 +1657,25 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
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
@@ -1683,18 +1686,28 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
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
@@ -1726,20 +1739,20 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
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
+	   * Add unrelated ACCESS_DENIED_ACE to the beginning 
+	   * ACCESS_ALLOWED_ACE to the end.
 	   */
 	  if (!AddAce (acl, ACL_REVISION,
 		       ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
-		       (owner_deny ? 1 : 0) : MAXDWORD,
+		       0 : MAXDWORD,
 		       (LPVOID) ace, ace->Header.AceSize))
 	    {
 	      __seterrno ();
@@ -1798,9 +1811,6 @@ static int
 set_nt_attribute (const char *file, __uid32_t uid, __gid32_t gid,
 		  int attribute)
 {
-  if (!wincap.has_security ())
-    return 0;
-
   DWORD sd_size = 4096;
   char sd_buf[4096];
   PSECURITY_DESCRIPTOR psd = (PSECURITY_DESCRIPTOR) sd_buf;
