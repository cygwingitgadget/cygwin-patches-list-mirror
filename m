Return-Path: <cygwin-patches-return-3334-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3629 invoked by alias); 16 Dec 2002 18:59:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3583 invoked from network); 16 Dec 2002 18:59:01 -0000
Message-ID: <3DFE22AE.FAD569D4@ieee.org>
Date: Mon, 16 Dec 2002 10:59:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: security.cc and sec_acl.cc (ntsec, inheritance and sec_acl)
References: <3.0.5.32.20021205222631.007d3920@mail.attbi.com> <20021210112403.B7796@cygbert.vinschen.de> <3DFDF1C4.575D6360@ieee.org> <20021216184320.H19104@cygbert.vinschen.de> <3DFE151D.B657F3EF@ieee.org> <3DFE1867.1242AEFC@ieee.org> <3DFE1AD7.76CA224D@ieee.org>
Content-Type: multipart/mixed;
 boundary="------------FD3B862E62E87E0686884FF7"
X-SW-Source: 2002-q4/txt/msg00285.txt.bz2

This is a multi-part message in MIME format.
--------------FD3B862E62E87E0686884FF7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 689

"Pierre A. Humblet" wrote:

> ... and thus it may merge entries for the current owner and
> for the default owner (creator_owner). Ditto for groups.
> That's not good, I need to take care of these special cases.

Done. This e-mail includes only the sec_acl patch. 

Pierre

2002/12/16  Pierre Humblet  <pierre.humblet@ieee.org>

        * sec_acl.cc (search_ace): Make id == -1, instead of < 0, special.
        (setacl): Use well_known_creator for default owner and owning group 
	and do not merge non-default with default in these cases.
        (getacl): Recognize well_known_creator for default owner and group.
        (acl_worker): Improve errno settings and streamline nontsec case.
--------------FD3B862E62E87E0686884FF7
Content-Type: text/plain; charset=us-ascii;
 name="acl2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acl2.diff"
Content-length: 5778

--- sec_acl.cc.orig	2002-12-16 13:34:04.000000000 -0500
+++ sec_acl.cc	2002-12-16 13:39:15.000000000 -0500
@@ -41,7 +41,7 @@ searchace (__aclent16_t *aclp, int nentr
   int i;
 
   for (i = 0; i < nentries; ++i)
-    if ((aclp[i].a_type == type && (id < 0 || aclp[i].a_id == id))
+    if ((aclp[i].a_type == type && (id == -1 || aclp[i].a_id == id))
 	|| !aclp[i].a_type)
       return i;
   return -1;
@@ -137,11 +137,11 @@ setacl (const char *file, int nentries, 
        * inheritance bits is created.
        */
       if (!(aclbufp[i].a_type & ACL_DEFAULT)
+	  && aclbufp[pos].a_type & (USER|GROUP|OTHER_OBJ)
 	  && (pos = searchace (aclbufp, nentries,
 			       aclbufp[i].a_type | ACL_DEFAULT,
 			       (aclbufp[i].a_type & (USER|GROUP))
 			       ? aclbufp[i].a_id : -1)) >= 0
-	  && aclbufp[pos].a_type
 	  && aclbufp[i].a_perm == aclbufp[pos].a_perm)
 	{
 	  inheritance = SUB_CONTAINERS_AND_OBJECTS_INHERIT;
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

--------------FD3B862E62E87E0686884FF7--
