Return-Path: <cygwin-patches-return-3358-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9833 invoked by alias); 9 Jan 2003 03:35:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9823 invoked from network); 9 Jan 2003 03:35:15 -0000
Message-Id: <3.0.5.32.20030108223142.00833940@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 09 Jan 2003 03:35:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: ntsec: inheritance, sec_acl and chown
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1042101102==_"
X-SW-Source: 2003-q1/txt/msg00007.txt.bz2

--=====================_1042101102==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1152

Corinna,

here are
- a refresh of what I had sent before the holidays.
- a fix for chown

Pierre

2003/01/07  Pierre Humblet  <pierre.humblet@ieee.org>

	* sec_acl.cc (search_ace): Use id == -1, instead of < 0, as wildcard.
	(setacl): Start the search for a matching default at the next entry.
	Invalidate the type of merged entries instead of clearing it.
	Use well_known_creator for default owner and owning group and do 
	not try to merge non-default and default entries in these cases.
	(getacl): Recognize well_known_creator for default owner and group.
	(acl_worker): Improve errno settings and streamline the nontsec case.
	* security.cc (write_sd): Remove the call to set_process_privilege.
	(alloc_sd): If the owner changes, call set_process_privilege and return
	immediately on failure. Change inheritance rules: on new directories add
	inherit only allow ACEs for creator_owner, creator_group and everyone. 
	Preserve all inheritances through chmod and chown calls. Introduce 
	isownergroup to implement the uid == gid case, to keep the inheritance 
	code simple. Do not initialize owner_sid and group_sid and stop using 
	the variable psd.

--=====================_1042101102==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="final.diff"
Content-length: 15037

Index: sec_acl.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_acl.cc,v
retrieving revision 1.23
diff -u -p -r1.23 sec_acl.cc
--- sec_acl.cc	12 Dec 2002 03:09:38 -0000	1.23
+++ sec_acl.cc	9 Jan 2003 01:45:18 -0000
@@ -1,4 +1,4 @@
-/* secacl.cc: Sun compatible ACL functions.
+/* sec_acl.cc: Sun compatible ACL functions.

    Copyright 2000, 2001, 2002 Red Hat, Inc.

@@ -41,7 +41,7 @@ searchace (__aclent16_t *aclp, int nentr
   int i;

   for (i =3D 0; i < nentries; ++i)
-    if ((aclp[i].a_type =3D=3D type && (id < 0 || aclp[i].a_id =3D=3D id))
+    if ((aclp[i].a_type =3D=3D type && (id =3D=3D -1 || aclp[i].a_id =3D=
=3D id))
 	|| !aclp[i].a_type)
       return i;
   return -1;
@@ -137,26 +137,31 @@ setacl (const char *file, int nentries,
        * inheritance bits is created.
        */
       if (!(aclbufp[i].a_type & ACL_DEFAULT)
-	  && (pos =3D searchace (aclbufp, nentries,
+	  && aclbufp[i].a_type & (USER|GROUP|OTHER_OBJ)
+          && (pos =3D searchace (aclbufp + i + 1, nentries - i - 1,
 			       aclbufp[i].a_type | ACL_DEFAULT,
 			       (aclbufp[i].a_type & (USER|GROUP))
 			       ? aclbufp[i].a_id : -1)) >=3D 0
-	  && aclbufp[pos].a_type
 	  && aclbufp[i].a_perm =3D=3D aclbufp[pos].a_perm)
 	{
 	  inheritance =3D SUB_CONTAINERS_AND_OBJECTS_INHERIT;
-	  /* This eliminates the corresponding default entry. */
-	  aclbufp[pos].a_type =3D 0;
+          /* This invalidates the corresponding default entry. */
+          aclbufp[pos].a_type =3D USER|GROUP|ACL_DEFAULT;
 	}
       switch (aclbufp[i].a_type)
 	{
 	case USER_OBJ:
-	case DEF_USER_OBJ:
 	  allow |=3D STANDARD_RIGHTS_ALL & ~DELETE;
 	  if (!add_access_allowed_ace (acl, ace_off++, allow,
 					owner, acl_len, inheritance))
 	    return -1;
 	  break;
+	case DEF_USER_OBJ:
+	  allow |=3D STANDARD_RIGHTS_ALL & ~DELETE;
+	  if (!add_access_allowed_ace (acl, ace_off++, allow,
+				       well_known_creator_owner_sid, acl_len, inheritance))
+	    return -1;
+	  break;
 	case USER:
 	case DEF_USER:
 	  if (!(pw =3D internal_getpwuid (aclbufp[i].a_id))
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
 	  if (!(gr =3D internal_getgrgid (aclbufp[i].a_id))
@@ -336,6 +345,16 @@ getacl (const char *file, DWORD attr, in
 	      type =3D USER_OBJ;
 	      id =3D uid;
 	    }
+	  else if (ace_sid =3D=3D well_known_creator_group_sid)
+	    {
+	      type =3D GROUP_OBJ | ACL_DEFAULT;
+	      id =3D ILLEGAL_GID;
+	    }
+	  else if (ace_sid =3D=3D well_known_creator_owner_sid)
+	    {
+	      type =3D USER_OBJ | ACL_DEFAULT;
+	      id =3D ILLEGAL_GID;
+	    }
 	  else
 	    {
 	      id =3D ace_sid.get_id (FALSE, &type);
@@ -352,7 +371,7 @@ getacl (const char *file, DWORD attr, in
 	    }
 	  if (!type)
 	    continue;
-	  if (!(ace->Header.AceFlags & INHERIT_ONLY))
+	  if (!(ace->Header.AceFlags & INHERIT_ONLY || type & ACL_DEFAULT))
 	    {
 	      if ((pos =3D searchace (lacl, MAX_ACL_ENTRIES, type, id)) >=3D 0)
 		getace (lacl[pos], type, id, ace->Mask, ace->Header.AceType);
@@ -360,6 +379,10 @@ getacl (const char *file, DWORD attr, in
 	  if ((ace->Header.AceFlags & SUB_CONTAINERS_AND_OBJECTS_INHERIT)
 	      && (attr & FILE_ATTRIBUTE_DIRECTORY))
 	    {
+	      if (type =3D=3D USER_OBJ)
+		type =3D USER;
+	      else if (type =3D=3D GROUP_OBJ)
+		type =3D GROUP;
 	      type |=3D ACL_DEFAULT;
 	      types_def |=3D type;
 	      if ((pos =3D searchace (lacl, MAX_ACL_ENTRIES, type, id)) >=3D 0)
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
-		  lacl[0].a_type =3D USER_OBJ;
-		  lacl[0].a_id =3D st.st_uid;
-		  lacl[0].a_perm =3D (st.st_mode & S_IRWXU) >> 6;
-		}
-	      if (nentries > 1)
-		{
-		  lacl[1].a_type =3D GROUP_OBJ;
-		  lacl[1].a_id =3D st.st_gid;
-		  lacl[1].a_perm =3D (st.st_mode & S_IRWXG) >> 3;
-		}
-	      if (nentries > 2)
-		{
-		  lacl[2].a_type =3D OTHER_OBJ;
-		  lacl[2].a_id =3D ILLEGAL_GID;
-		  lacl[2].a_perm =3D st.st_mode & S_IRWXO;
-		}
-	      if (nentries > 3)
-		{
-		  lacl[3].a_type =3D CLASS_OBJ;
-		  lacl[3].a_id =3D ILLEGAL_GID;
-		  lacl[3].a_perm =3D S_IRWXU | S_IRWXG | S_IRWXO;
-		}
-	      if (nentries > 4)
-		nentries =3D 4;
-	      if (aclbufp)
-		memcpy (aclbufp, lacl, nentries * sizeof (__aclent16_t));
-	      ret =3D nentries;
+	      aclbufp[0].a_type =3D USER_OBJ;
+	      aclbufp[0].a_id =3D st.st_uid;
+	      aclbufp[0].a_perm =3D (st.st_mode & S_IRWXU) >> 6;
+	      aclbufp[1].a_type =3D GROUP_OBJ;
+	      aclbufp[1].a_id =3D st.st_gid;
+	      aclbufp[1].a_perm =3D (st.st_mode & S_IRWXG) >> 3;
+	      aclbufp[2].a_type =3D OTHER_OBJ;
+	      aclbufp[2].a_id =3D ILLEGAL_GID;
+	      aclbufp[2].a_perm =3D st.st_mode & S_IRWXO;
+	      aclbufp[3].a_type =3D CLASS_OBJ;
+	      aclbufp[3].a_id =3D ILLEGAL_GID;
+	      aclbufp[3].a_perm =3D S_IRWXU | S_IRWXG | S_IRWXO;
+	      ret =3D MIN_ACL_ENTRIES;
 	    }
 	  break;
 	case GETACLCNT:
-	  ret =3D 4;
+	  ret =3D MIN_ACL_ENTRIES;
 	  break;
 	}
       syscall_printf ("%d =3D acl (%s)", ret, path);
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
   syscall_printf ("-1 =3D acl (%s)", path);
   return -1;
 }
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.129
diff -u -p -r1.129 security.cc
--- security.cc	14 Dec 2002 16:57:25 -0000	1.129
+++ security.cc	9 Jan 2003 01:47:03 -0000
@@ -1,4 +1,4 @@
-/* security.cc: NT security functions
+ /* security.cc: NT security functions

    Copyright 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.

@@ -1142,14 +1142,6 @@ write_sd (const char *file, PSECURITY_DE
       return -1;
     }

-  /* No need to be thread save. */
-  static BOOL first_time =3D TRUE;
-  if (first_time)
-    {
-      set_process_privilege (SE_RESTORE_NAME);
-      first_time =3D FALSE;
-    }
-
   HANDLE fh;
   fh =3D CreateFile (file,
 		   WRITE_OWNER | WRITE_DAC,
@@ -1548,7 +1540,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
     debug_printf ("GetSecurityDescriptorGroup %E");

   /* Get SID of owner. */
-  cygsid owner_sid (NO_SID);
+  cygsid owner_sid;
   /* Check for current user first */
   if (uid =3D=3D myself->uid)
     owner_sid =3D cygheap->user.sid ();
@@ -1561,8 +1553,13 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
     }
   owner_sid.debug_print ("alloc_sd: owner SID =3D");

+  /* Must have SE_RESTORE_NAME privilege to change owner */
+  if (cur_owner_sid && owner_sid !=3D cur_owner_sid
+      && set_process_privilege (SE_RESTORE_NAME) < 0 )
+    return NULL;
+
   /* Get SID of new group. */
-  cygsid group_sid (NO_SID);
+  cygsid group_sid;
   /* Check for current user first */
   if (gid =3D=3D myself->gid)
     group_sid =3D cygheap->user.groups.pgsid;
@@ -1577,7 +1574,6 @@ alloc_sd (__uid32_t uid, __gid32_t gid,

   /* Initialize local security descriptor. */
   SECURITY_DESCRIPTOR sd;
-  PSECURITY_DESCRIPTOR psd =3D NULL;
   if (!InitializeSecurityDescriptor (&sd, SECURITY_DESCRIPTOR_REVISION))
     {
       __seterrno ();
@@ -1674,59 +1670,48 @@ alloc_sd (__uid32_t uid, __gid32_t gid,

   /* Add owner and group permissions if SIDs are equal
      and construct deny attributes for group and owner. */
-  DWORD group_deny;
-  if (owner_sid =3D=3D group_sid)
-    {
-      owner_allow |=3D group_allow;
-      group_allow =3D group_deny =3D 0L;
-    }
-  else
-    {
-      group_deny =3D ~group_allow & other_allow;
-      group_deny &=3D ~(STANDARD_RIGHTS_READ
-		      | FILE_READ_ATTRIBUTES | FILE_READ_EA);
-    }
+  BOOL isownergroup;
+  if ((isownergroup =3D (owner_sid =3D=3D group_sid)))
+    owner_allow |=3D group_allow;
+
   DWORD owner_deny =3D ~owner_allow & (group_allow | other_allow);
   owner_deny &=3D ~(STANDARD_RIGHTS_READ
 		  | FILE_READ_ATTRIBUTES | FILE_READ_EA
 		  | FILE_WRITE_ATTRIBUTES | FILE_WRITE_EA);
-
-  /* Construct appropriate inherit attribute. */
-  DWORD inherit =3D (attribute & S_IFDIR) ? SUB_CONTAINERS_AND_OBJECTS_INH=
ERIT
-					: NO_INHERITANCE;
+
+  DWORD group_deny =3D ~group_allow & other_allow;
+  group_deny &=3D ~(STANDARD_RIGHTS_READ
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
-      group_deny =3D 0;
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
+  if (group_deny & owner_allow && !isownergroup
       && !add_access_denied_ace (acl, ace_off++, group_deny,
-				 group_sid, acl_len, inherit))
+				 group_sid, acl_len, NO_INHERITANCE))
     return NULL;
   /* Set allow ACE for group. */
-  if (group_allow
+  if (!isownergroup
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
@@ -1736,7 +1721,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid,

   /* Fill ACL with unrelated ACEs from current security descriptor. */
   PACL oacl;
-  BOOL acl_exists;
+  BOOL acl_exists =3D FALSE;
   ACCESS_ALLOWED_ACE *ace;
   if (GetSecurityDescriptorDacl (sd_ret, &acl_exists, &oacl, &dummy)
       && acl_exists && oacl)
@@ -1745,19 +1730,26 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
 	{
 	  cygsid ace_sid ((PSID) &ace->SidStart);
 	  /* Check for related ACEs. */
+	  if (ace_sid =3D=3D well_known_null_sid)
+	    continue;
 	  if ((ace_sid =3D=3D cur_owner_sid)
 	      || (ace_sid =3D=3D owner_sid)
 	      || (ace_sid =3D=3D cur_group_sid)
 	      || (ace_sid =3D=3D group_sid)
-	      || (ace_sid =3D=3D well_known_world_sid)
-	      || (ace_sid =3D=3D well_known_null_sid))
-	    continue;
+	      || (ace_sid =3D=3D well_known_world_sid))
+	    {
+	      if (ace->Header.AceFlags & SUB_CONTAINERS_AND_OBJECTS_INHERIT)
+		ace->Header.AceFlags |=3D INHERIT_ONLY;
+	      else
+		continue;
+	    }
 	  /*
 	   * Add unrelated ACCESS_DENIED_ACE to the beginning but
 	   * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
+	   * FIXME: this would break the order of the inherit_only ACEs
 	   */
 	  if (!AddAce (acl, ACL_REVISION,
-		       ace->Header.AceType =3D=3D ACCESS_DENIED_ACE_TYPE ?
+		       ace->Header.AceType =3D=3D ACCESS_DENIED_ACE_TYPE?
 		       (owner_deny ? 1 : 0) : MAXDWORD,
 		       (LPVOID) ace, ace->Header.AceSize))
 	    {
@@ -1767,6 +1759,46 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
 	  acl_len +=3D ace->Header.AceSize;
 	}

+  /* Construct appropriate inherit attribute for new directories */
+  if (attribute & S_IFDIR && !acl_exists )
+    {
+      const DWORD inherit =3D SUB_CONTAINERS_AND_OBJECTS_INHERIT | INHERIT=
_ONLY;
+
+#if 0 /* FIXME: Not done currently as this breaks the canonical order */
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
+#endif
+      /* Set allow ACE for owner. */
+      if (!add_access_allowed_ace (acl, ace_off++, owner_allow,
+				   well_known_creator_owner_sid, acl_len, inherit))
+	return NULL;
+#if 0 /* FIXME: Not done currently as this breaks the canonical order and
+	 won't be preserved on chown and chmod */
+      /* Set deny ACE for group, conflicting with owner_allow. */
+      if (group_deny & owner_allow
+	  && !add_access_denied_ace (acl, ace_off++, group_deny,
+				     well_known_creator_group_sid, acl_len, inherit))
+	return NULL;
+#endif
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
   acl->AclSize =3D acl_len;
   debug_printf ("ACL-Size: %d", acl_len);
@@ -1791,10 +1823,9 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
       __seterrno ();
       return NULL;
     }
-  psd =3D sd_ret;
   debug_printf ("Created SD-Size: %d", *sd_size_ret);

-  return psd;
+  return sd_ret;
 }

 void

--=====================_1042101102==_--
