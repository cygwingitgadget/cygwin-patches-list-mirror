Return-Path: <cygwin-patches-return-3327-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21690 invoked by alias); 16 Dec 2002 15:30:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21579 invoked from network); 16 Dec 2002 15:30:29 -0000
Message-ID: <3DFDF1C4.575D6360@ieee.org>
Date: Mon, 16 Dec 2002 07:30:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: security.cc and sec_acl.cc (ntsec, inheritance and sec_acl)
References: <3.0.5.32.20021205222631.007d3920@mail.attbi.com> <20021210112403.B7796@cygbert.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------C3CB45558DEA636B2AF43A2D"
X-SW-Source: 2002-q4/txt/msg00278.txt.bz2

This is a multi-part message in MIME format.
--------------C3CB45558DEA636B2AF43A2D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1311

Corinna,

Here are the changes to security.cc and sec_acl.cc to use 
well_known_creator_xxx_sid.
They seem to work fine on NT4.

There is peculiar effect: if a directory was created e.g. 427 by
a ntsec user with uid != gid and a file is created in the directory by
a Windows user with gid == uid, the file will inherit permissions 447.
 
I have a question: there is code in setacl (new line 139) to merge non-default
ACE's with previous default ACEs.
As the acl was sorted, I don't see how that code can ever be exercised. 
Should we try to merge default ACEs with non-default ones? I am not sure it's 
worth it.

Pierre 


2002/12/16  Pierre Humblet  <pierre.humblet@ieee.org>

	* security.cc (alloc_sd): Change inheritance rules: on new directories add
	inherit only ACEs for creator_owner, creator_group and everyone. Preserve
	all inheritances through chmod and chown calls. Modify implementation of 
	uid == gid case by introducing isownergroup, to simplify inheritance code. 
	Do not initialize owner_sid and group_sid and stop using psd.
	* sec_acl.cc (search_ace): Make id == -1, instead of < 0, special.
	(setacl): Use well_known_creator for default owner and group.
	(getacl): Recognize well_known_creator for default owner and group.
	(acl_worker): Improve errno settings and streamline nontsec case.
--------------C3CB45558DEA636B2AF43A2D
Content-Type: text/plain; charset=us-ascii;
 name="sec4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sec4.diff"
Content-length: 7497

Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.129
diff -u -p -r1.129 security.cc
--- security.cc	14 Dec 2002 16:57:25 -0000	1.129
+++ security.cc	15 Dec 2002 20:47:18 -0000
@@ -1,4 +1,4 @@
-/* security.cc: NT security functions
+ /* security.cc: NT security functions
 
    Copyright 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.
 
@@ -1548,7 +1548,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
     debug_printf ("GetSecurityDescriptorGroup %E");
 
   /* Get SID of owner. */
-  cygsid owner_sid (NO_SID);
+  cygsid owner_sid;
   /* Check for current user first */
   if (uid == myself->uid)
     owner_sid = cygheap->user.sid ();
@@ -1562,7 +1562,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
   owner_sid.debug_print ("alloc_sd: owner SID =");
 
   /* Get SID of new group. */
-  cygsid group_sid (NO_SID);
+  cygsid group_sid;
   /* Check for current user first */
   if (gid == myself->gid)
     group_sid = cygheap->user.groups.pgsid;
@@ -1577,7 +1577,6 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
 
   /* Initialize local security descriptor. */
   SECURITY_DESCRIPTOR sd;
-  PSECURITY_DESCRIPTOR psd = NULL;
   if (!InitializeSecurityDescriptor (&sd, SECURITY_DESCRIPTOR_REVISION))
     {
       __seterrno ();
@@ -1674,59 +1673,48 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
 
   /* Add owner and group permissions if SIDs are equal
      and construct deny attributes for group and owner. */
-  DWORD group_deny;
-  if (owner_sid == group_sid)
-    {
-      owner_allow |= group_allow;
-      group_allow = group_deny = 0L;
-    }
-  else
-    {
-      group_deny = ~group_allow & other_allow;
-      group_deny &= ~(STANDARD_RIGHTS_READ
-		      | FILE_READ_ATTRIBUTES | FILE_READ_EA);
-    }
+  BOOL isownergroup;
+  if ((isownergroup = (owner_sid == group_sid)))
+    owner_allow |= group_allow;
+
   DWORD owner_deny = ~owner_allow & (group_allow | other_allow);
   owner_deny &= ~(STANDARD_RIGHTS_READ
 		  | FILE_READ_ATTRIBUTES | FILE_READ_EA
 		  | FILE_WRITE_ATTRIBUTES | FILE_WRITE_EA);
-
-  /* Construct appropriate inherit attribute. */
-  DWORD inherit = (attribute & S_IFDIR) ? SUB_CONTAINERS_AND_OBJECTS_INHERIT
-					: NO_INHERITANCE;
+    
+  DWORD group_deny = ~group_allow & other_allow;
+  group_deny &= ~(STANDARD_RIGHTS_READ
+		  | FILE_READ_ATTRIBUTES | FILE_READ_EA);
 
   /* Set deny ACE for owner. */
   if (owner_deny
       && !add_access_denied_ace (acl, ace_off++, owner_deny,
-				 owner_sid, acl_len, inherit))
+				 owner_sid, acl_len, NO_INHERITANCE))
     return NULL;
   /* Set deny ACE for group here to respect the canonical order,
      if this does not impact owner */
-  if (group_deny && !(owner_allow & group_deny))
-    {
-      if (!add_access_denied_ace (acl, ace_off++, group_deny,
-				 group_sid, acl_len, inherit))
-	return NULL;
-      group_deny = 0;
-    }
+  if (group_deny && !(group_deny & owner_allow) && !isownergroup
+      && !add_access_denied_ace (acl, ace_off++, group_deny,
+				 group_sid, acl_len, NO_INHERITANCE))
+    return NULL;
   /* Set allow ACE for owner. */
   if (!add_access_allowed_ace (acl, ace_off++, owner_allow,
-			       owner_sid, acl_len, inherit))
+			       owner_sid, acl_len, NO_INHERITANCE))
     return NULL;
   /* Set deny ACE for group, if still needed. */
-  if (group_deny
+  if (group_deny & owner_allow
       && !add_access_denied_ace (acl, ace_off++, group_deny,
-				 group_sid, acl_len, inherit))
+				 group_sid, acl_len, NO_INHERITANCE))
     return NULL;
   /* Set allow ACE for group. */
-  if (group_allow
+  if (group_allow  && !isownergroup
       && !add_access_allowed_ace (acl, ace_off++, group_allow,
-				  group_sid, acl_len, inherit))
+				  group_sid, acl_len, NO_INHERITANCE))
     return NULL;
 
   /* Set allow ACE for everyone. */
   if (!add_access_allowed_ace (acl, ace_off++, other_allow,
-			       well_known_world_sid, acl_len, inherit))
+			       well_known_world_sid, acl_len, NO_INHERITANCE))
     return NULL;
   /* Set null ACE for special bits. */
   if (null_allow
@@ -1736,7 +1724,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
 
   /* Fill ACL with unrelated ACEs from current security descriptor. */
   PACL oacl;
-  BOOL acl_exists;
+  BOOL acl_exists = FALSE;
   ACCESS_ALLOWED_ACE *ace;
   if (GetSecurityDescriptorDacl (sd_ret, &acl_exists, &oacl, &dummy)
       && acl_exists && oacl)
@@ -1745,19 +1733,27 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
 	{
 	  cygsid ace_sid ((PSID) &ace->SidStart);
 	  /* Check for related ACEs. */
+	  if (ace_sid == well_known_null_sid)
+	    continue;
 	  if ((ace_sid == cur_owner_sid)
 	      || (ace_sid == owner_sid)
 	      || (ace_sid == cur_group_sid)
 	      || (ace_sid == group_sid)
-	      || (ace_sid == well_known_world_sid)
-	      || (ace_sid == well_known_null_sid))
-	    continue;
+	      || (ace_sid == well_known_world_sid))
+	    {
+	      if (ace->Header.AceFlags & SUB_CONTAINERS_AND_OBJECTS_INHERIT)
+		ace->Header.AceFlags |= INHERIT_ONLY;
+	      else
+		continue;
+	    }
 	  /*
 	   * Add unrelated ACCESS_DENIED_ACE to the beginning but
 	   * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
+	   * Inherit_only go to the end, preserving their order.
 	   */
 	  if (!AddAce (acl, ACL_REVISION,
-		       ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
+		       ace->Header.AceType == ACCESS_DENIED_ACE_TYPE
+		       && !ace->Header.AceFlags & INHERIT_ONLY?
 		       (owner_deny ? 1 : 0) : MAXDWORD,
 		       (LPVOID) ace, ace->Header.AceSize))
 	    {
@@ -1767,6 +1763,41 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
 	  acl_len += ace->Header.AceSize;
 	}
 
+  /* Construct appropriate inherit attribute for new directories */
+  if (attribute & S_IFDIR && !acl_exists )
+    {
+      const DWORD inherit = SUB_CONTAINERS_AND_OBJECTS_INHERIT | INHERIT_ONLY;
+
+      /* Set deny ACE for owner. */
+      if (owner_deny
+	  && !add_access_denied_ace (acl, ace_off++, owner_deny,
+				     well_known_creator_owner_sid, acl_len, inherit))
+	return NULL;
+      /* Set deny ACE for group here to respect the canonical order,
+	 if this does not impact owner */
+      if (group_deny && !(group_deny & owner_allow) 
+	  && !add_access_denied_ace (acl, ace_off++, group_deny,
+				     well_known_creator_group_sid, acl_len, inherit))
+	return NULL;
+      /* Set allow ACE for owner. */
+      if (!add_access_allowed_ace (acl, ace_off++, owner_allow,
+				   well_known_creator_owner_sid, acl_len, inherit))
+	return NULL;
+      /* Set deny ACE for group, conflicting with owner_allow. */
+      if (group_deny & owner_allow
+	  && !add_access_denied_ace (acl, ace_off++, group_deny,
+				     well_known_creator_group_sid, acl_len, inherit))
+	return NULL;
+      /* Set allow ACE for group. */
+      if (!add_access_allowed_ace (acl, ace_off++, group_allow,
+				   well_known_creator_group_sid, acl_len, inherit))
+	return NULL;
+      /* Set allow ACE for everyone. */
+      if (!add_access_allowed_ace (acl, ace_off++, other_allow,
+				   well_known_world_sid, acl_len, inherit))
+	return NULL; 
+    }
+
   /* Set AclSize to computed value. */
   acl->AclSize = acl_len;
   debug_printf ("ACL-Size: %d", acl_len);
@@ -1791,10 +1822,9 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
       __seterrno ();
       return NULL;
     }
-  psd = sd_ret;
   debug_printf ("Created SD-Size: %d", *sd_size_ret);
 
-  return psd;
+  return sd_ret;
 }
 
 void

--------------C3CB45558DEA636B2AF43A2D
Content-Type: text/plain; charset=us-ascii;
 name="acl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acl.diff"
Content-length: 5430

Index: sec_acl.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_acl.cc,v
retrieving revision 1.23
diff -u -p -r1.23 sec_acl.cc
--- sec_acl.cc	12 Dec 2002 03:09:38 -0000	1.23
+++ sec_acl.cc	15 Dec 2002 20:48:24 -0000
@@ -41,7 +41,7 @@ searchace (__aclent16_t *aclp, int nentr
   int i;
 
   for (i = 0; i < nentries; ++i)
-    if ((aclp[i].a_type == type && (id < 0 || aclp[i].a_id == id))
+    if ((aclp[i].a_type == type && (id == -1 || aclp[i].a_id == id))
 	|| !aclp[i].a_type)
       return i;
   return -1;
@@ -151,12 +151,17 @@ setacl (const char *file, int nentries, 
       switch (aclbufp[i].a_type)
 	{
 	case USER_OBJ:
-	case DEF_USER_OBJ:
 	  allow |= STANDARD_RIGHTS_ALL & ~DELETE;
 	  if (!add_access_allowed_ace (acl, ace_off++, allow,
 					owner, acl_len, inheritance))
 	    return -1;
 	  break;
+	case DEF_USER_OBJ:
+	  allow |= STANDARD_RIGHTS_ALL & ~DELETE;
+	  if (!add_access_allowed_ace (acl, ace_off++, allow,
+				       well_known_creator_owner_sid, acl_len, inheritance))
+	    return -1;
+	  break;
 	case USER:
 	case DEF_USER:
 	  if (!(pw = internal_getpwuid (aclbufp[i].a_id))
@@ -166,11 +171,15 @@ setacl (const char *file, int nentries, 
 	    return -1;
 	  break;
 	case GROUP_OBJ:
-	case DEF_GROUP_OBJ:
 	  if (!add_access_allowed_ace (acl, ace_off++, allow,
 					group, acl_len, inheritance))
 	    return -1;
 	  break;
+	case DEF_GROUP_OBJ:
+	  if (!add_access_allowed_ace (acl, ace_off++, allow,
+				       well_known_creator_group_sid, acl_len, inheritance))
+	    return -1;
+	  break;
 	case GROUP:
 	case DEF_GROUP:
 	  if (!(gr = internal_getgrgid (aclbufp[i].a_id))
@@ -336,6 +345,16 @@ getacl (const char *file, DWORD attr, in
 	      type = USER_OBJ;
 	      id = uid;
 	    }
+	  else if (ace_sid == well_known_creator_group_sid)
+	    {
+	      type = GROUP_OBJ | ACL_DEFAULT;
+	      id = ILLEGAL_GID;
+	    }
+	  else if (ace_sid == well_known_creator_owner_sid)
+	    {
+	      type = USER_OBJ | ACL_DEFAULT;
+	      id = ILLEGAL_GID;
+	    }
 	  else
 	    {
 	      id = ace_sid.get_id (FALSE, &type);
@@ -352,7 +371,7 @@ getacl (const char *file, DWORD attr, in
 	    }
 	  if (!type)
 	    continue;
-	  if (!(ace->Header.AceFlags & INHERIT_ONLY))
+	  if (!(ace->Header.AceFlags & INHERIT_ONLY || type & ACL_DEFAULT))
 	    {
 	      if ((pos = searchace (lacl, MAX_ACL_ENTRIES, type, id)) >= 0)
 		getace (lacl[pos], type, id, ace->Mask, ace->Header.AceType);
@@ -360,6 +379,10 @@ getacl (const char *file, DWORD attr, in
 	  if ((ace->Header.AceFlags & SUB_CONTAINERS_AND_OBJECTS_INHERIT)
 	      && (attr & FILE_ATTRIBUTE_DIRECTORY))
 	    {
+	      if (type == USER_OBJ)
+		type = USER;
+	      else if (type == GROUP_OBJ)
+		type = GROUP;
 	      type |= ACL_DEFAULT;
 	      types_def |= type;
 	      if ((pos = searchace (lacl, MAX_ACL_ENTRIES, type, id)) >= 0)
@@ -475,45 +498,30 @@ acl_worker (const char *path, int cmd, i
 	  set_errno (ENOSYS);
 	  break;
 	case GETACL:
-	  if (nentries < 1)
-	    set_errno (EINVAL);
+	  if (!aclbufp)
+	    set_errno(EFAULT);
+	  else if (nentries < MIN_ACL_ENTRIES) 
+	    set_errno (ENOSPC);
 	  else if ((nofollow && !lstat64 (path, &st))
 		   || (!nofollow && !stat64 (path, &st)))
 	    {
-	      __aclent16_t lacl[4];
-	      if (nentries > 0)
-		{
-		  lacl[0].a_type = USER_OBJ;
-		  lacl[0].a_id = st.st_uid;
-		  lacl[0].a_perm = (st.st_mode & S_IRWXU) >> 6;
-		}
-	      if (nentries > 1)
-		{
-		  lacl[1].a_type = GROUP_OBJ;
-		  lacl[1].a_id = st.st_gid;
-		  lacl[1].a_perm = (st.st_mode & S_IRWXG) >> 3;
-		}
-	      if (nentries > 2)
-		{
-		  lacl[2].a_type = OTHER_OBJ;
-		  lacl[2].a_id = ILLEGAL_GID;
-		  lacl[2].a_perm = st.st_mode & S_IRWXO;
-		}
-	      if (nentries > 3)
-		{
-		  lacl[3].a_type = CLASS_OBJ;
-		  lacl[3].a_id = ILLEGAL_GID;
-		  lacl[3].a_perm = S_IRWXU | S_IRWXG | S_IRWXO;
-		}
-	      if (nentries > 4)
-		nentries = 4;
-	      if (aclbufp)
-		memcpy (aclbufp, lacl, nentries * sizeof (__aclent16_t));
-	      ret = nentries;
+	      aclbufp[0].a_type = USER_OBJ;
+	      aclbufp[0].a_id = st.st_uid;
+	      aclbufp[0].a_perm = (st.st_mode & S_IRWXU) >> 6;
+	      aclbufp[1].a_type = GROUP_OBJ;
+	      aclbufp[1].a_id = st.st_gid;
+	      aclbufp[1].a_perm = (st.st_mode & S_IRWXG) >> 3;
+	      aclbufp[2].a_type = OTHER_OBJ;
+	      aclbufp[2].a_id = ILLEGAL_GID;
+	      aclbufp[2].a_perm = st.st_mode & S_IRWXO;
+	      aclbufp[3].a_type = CLASS_OBJ;
+	      aclbufp[3].a_id = ILLEGAL_GID;
+	      aclbufp[3].a_perm = S_IRWXU | S_IRWXG | S_IRWXO;
+	      ret = MIN_ACL_ENTRIES;
 	    }
 	  break;
 	case GETACLCNT:
-	  ret = 4;
+	  ret = MIN_ACL_ENTRIES;
 	  break;
 	}
       syscall_printf ("%d = acl (%s)", ret, path);
@@ -527,19 +535,20 @@ acl_worker (const char *path, int cmd, i
 			 nentries, aclbufp);
 	break;
       case GETACL:
-	if (nentries < 1)
-	  break;
-	return getacl (real_path.get_win32 (),
-		       real_path.file_attributes (),
-		       nentries, aclbufp);
+	if (!aclbufp)
+	  set_errno(EFAULT);
+	else return getacl (real_path.get_win32 (),
+			    real_path.file_attributes (),
+			    nentries, aclbufp);
+	break;
       case GETACLCNT:
 	return getacl (real_path.get_win32 (),
 		       real_path.file_attributes (),
 		       0, NULL);
       default:
+	set_errno (EINVAL);
 	break;
     }
-  set_errno (EINVAL);
   syscall_printf ("-1 = acl (%s)", path);
   return -1;
 }

--------------C3CB45558DEA636B2AF43A2D--
