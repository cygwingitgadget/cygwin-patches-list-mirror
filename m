Return-Path: <cygwin-patches-return-3130-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31777 invoked by alias); 6 Nov 2002 16:31:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31766 invoked from network); 6 Nov 2002 16:31:48 -0000
Message-ID: <3DC943ED.DEA6F9F3@ieee.org>
Date: Wed, 06 Nov 2002 08:31:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: ntsec patch 2: acl
Content-Type: multipart/mixed;
 boundary="------------912E9C30197004737BB9559D"
X-SW-Source: 2002-q4/txt/msg00081.txt.bz2

This is a multi-part message in MIME format.
--------------912E9C30197004737BB9559D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1391

Hello again, Corinna,

while stracing "ls -l" to verify the "uid == gid" changes, I 
noticed that it was calling acl(). That intrigued me because 
I had never noticed "ls -l" displaying acl related info.
 
One thing led to another and to the attached patch. 
The main problem was that acl(GETACLCNT) was always 
reporting 0.

Now ls -l displays a "+" when a file acl contains more ace's 
than necessary to represent the modes (as documented in the ls
info page). 

As you know the cygwin implementation of acl's isn't complete. 
Two things are a somewhat confusing:
- the mask isn't implemented. I suggest that it would be better
  to report it as "rwx" than to set it to the group bits (as 
  Cygwin does now). Also note it in the man page.
- the default acl (of a directory) is not taken into account
  by Cygwin when creating files with ntsec on. Still it is 
  useful info because but it reflects the (Windows) behavior 
  when ntsec is off. This could be added in the man page.

2002-11-06  Pierre Humblet <pierre.humblet@ieee.org>

	* sec_acl.cc (getace): Fix the behavior when allow and
	deny entries are present in arbitrary order.
	(getacl): Report the actual number of entries when 
	aclbufp is NULL, even if nentries is zero. Fix the mask 
	reporting, handle the case where the owner and group sids
	are equal and streamline the code.
	(acl_worker): Take allow_ntsec into account.
--------------912E9C30197004737BB9559D
Content-Type: text/plain; charset=us-ascii;
 name="acl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acl.diff"
Content-length: 7363

--- sec_acl.cc.orig	2002-10-23 22:33:36.000000000 -0400
+++ sec_acl.cc	2002-10-27 12:24:30.000000000 -0500
@@ -213,29 +213,41 @@ setacl (const char *file, int nentries, 
   return write_sd (file, psd, sd_size);
 }
 
+/* Always set the user, group and other bits.
+   Access denied bits are in the high positions */
+#define ALLOW_R (S_IRUSR | S_IRGRP | S_IROTH)
+#define ALLOW_W (S_IWUSR | S_IWGRP | S_IWOTH)
+#define ALLOW_X (S_IXUSR | S_IXGRP | S_IXOTH)
+#define DENY_R 040000
+#define DENY_W 020000
+#define DENY_X 010000
+
 static void
 getace (__aclent16_t &acl, int type, int id, DWORD win_ace_mask, DWORD win_ace_type)
 {
   acl.a_type = type;
   acl.a_id = id;
 
-  if (win_ace_mask & FILE_READ_DATA)
+  if ((win_ace_mask & FILE_READ_DATA) &&
+      !(acl.a_perm & (ALLOW_R | DENY_R)))
     if (win_ace_type == ACCESS_ALLOWED_ACE_TYPE)
-      acl.a_perm |= (acl.a_perm & S_IRGRP) ? 0 : S_IRUSR;
+      acl.a_perm |= ALLOW_R;
     else if (win_ace_type == ACCESS_DENIED_ACE_TYPE)
-      acl.a_perm &= ~S_IRGRP;
+      acl.a_perm |= DENY_R;
 
-  if (win_ace_mask & FILE_WRITE_DATA)
+  if ((win_ace_mask & FILE_WRITE_DATA) &&
+      !(acl.a_perm & (ALLOW_W | DENY_W)))
     if (win_ace_type == ACCESS_ALLOWED_ACE_TYPE)
-      acl.a_perm |= (acl.a_perm & S_IWGRP) ? 0 : S_IWUSR;
+      acl.a_perm |= ALLOW_W;
     else if (win_ace_type == ACCESS_DENIED_ACE_TYPE)
-      acl.a_perm &= ~S_IWGRP;
+      acl.a_perm |= DENY_W;
 
-  if (win_ace_mask & FILE_EXECUTE)
+  if ((win_ace_mask & FILE_EXECUTE) &&
+      !(acl.a_perm & (ALLOW_X | DENY_X)))
     if (win_ace_type == ACCESS_ALLOWED_ACE_TYPE)
-      acl.a_perm |= (acl.a_perm & S_IXGRP) ? 0 : S_IXUSR;
+      acl.a_perm |= ALLOW_X;
     else if (win_ace_type == ACCESS_DENIED_ACE_TYPE)
-      acl.a_perm &= ~S_IXGRP;
+      acl.a_perm |= DENY_X;
 }
 
 static int
@@ -281,6 +293,7 @@ getacl (const char *file, DWORD attr, in
   lacl[1].a_type = GROUP_OBJ;
   lacl[1].a_id = gid;
   lacl[2].a_type = OTHER_OBJ;
+  lacl[3].a_type = CLASS_OBJ;
 
   PACL acl;
   BOOL acl_exists;
@@ -292,106 +305,91 @@ getacl (const char *file, DWORD attr, in
       return -1;
     }
 
-  int pos, i;
+  int pos, i, types_def = 0;
 
   if (!acl_exists || !acl)
-    {
-      for (pos = 0; pos < MIN_ACL_ENTRIES; ++pos)
-	lacl[pos].a_perm = S_IRWXU | S_IRWXG | S_IRWXO;
-      pos = nentries < MIN_ACL_ENTRIES ? nentries : MIN_ACL_ENTRIES;
-      memcpy (aclbufp, lacl, pos * sizeof (__aclent16_t));
-      return pos;
-    }
-
-  for (i = 0; i < acl->AceCount && (!nentries || i < nentries); ++i)
-    {
-      ACCESS_ALLOWED_ACE *ace;
-
-      if (!GetAce (acl, i, (PVOID *) &ace))
-	continue;
+    for (pos = 0; pos < MIN_ACL_ENTRIES; ++pos)
+      lacl[pos].a_perm = ALLOW_R | ALLOW_W | ALLOW_X;
+  else
+    {
+      for (i = 0; i < acl->AceCount; ++i)
+	{
+	  ACCESS_ALLOWED_ACE *ace;
+	  
+	  if (!GetAce (acl, i, (PVOID *) &ace))
+	    continue;
 
-      cygsid ace_sid ((PSID) &ace->SidStart);
-      int id;
-      int type = 0;
+	  cygsid ace_sid ((PSID) &ace->SidStart);
+	  int id;
+	  int type = 0;
 
-      if (ace_sid == well_known_world_sid)
-	{
-	  type = OTHER_OBJ;
-	  id = 0;
-	}
-      else if (ace_sid == owner_sid)
-	{
-	  type = USER_OBJ;
-	  id = uid;
-	}
-      else if (ace_sid == group_sid)
-	{
-	  type = GROUP_OBJ;
-	  id = gid;
-	}
-      else
-	{
-	  id = ace_sid.get_id (FALSE, &type);
-	  if (type != GROUP)
+	  if (ace_sid == well_known_world_sid)
+	    {
+	      type = OTHER_OBJ;
+	      id = 0;
+	    }
+	  else if (ace_sid == group_sid)
+	    {
+	      type = GROUP_OBJ;
+	      id = gid;
+	    }
+	  else if (ace_sid == owner_sid)
 	    {
-	      int type2 = 0;
-	      int id2 = ace_sid.get_id (TRUE, &type2);
-	      if (type2 == GROUP)
+	      type = USER_OBJ;
+	      id = uid;
+	    }
+	  else
+	    {
+	      id = ace_sid.get_id (FALSE, &type);
+	      if (type != GROUP)
 		{
-		  id = id2;
-		  type = GROUP;
+		  int type2 = 0;
+		  int id2 = ace_sid.get_id (TRUE, &type2);
+		  if (type2 == GROUP)
+		    {
+		      id = id2;
+		      type = GROUP;
+		    }
 		}
 	    }
+	  if (!type)
+	    continue;
+	  if (!(ace->Header.AceFlags & INHERIT_ONLY))
+	    {
+	      if ((pos = searchace (lacl, MAX_ACL_ENTRIES, type, id)) >= 0)
+		getace (lacl[pos], type, id, ace->Mask, ace->Header.AceType);
+	    }
+	  if ((ace->Header.AceFlags & SUB_CONTAINERS_AND_OBJECTS_INHERIT)
+	      && (attr & FILE_ATTRIBUTE_DIRECTORY))
+	    {
+	      type |= ACL_DEFAULT;
+	      types_def |= type;
+	      if ((pos = searchace (lacl, MAX_ACL_ENTRIES, type, id)) >= 0)
+		getace (lacl[pos], type, id, ace->Mask, ace->Header.AceType);
+	    }
 	}
-      if (!type)
-	continue;
-      if (!(ace->Header.AceFlags & INHERIT_ONLY))
-	{
-	  if ((pos = searchace (lacl, MAX_ACL_ENTRIES, type, id)) >= 0)
-	    getace (lacl[pos], type, id, ace->Mask, ace->Header.AceType);
-	}
-      if ((ace->Header.AceFlags & SUB_CONTAINERS_AND_OBJECTS_INHERIT)
-	  && (attr & FILE_ATTRIBUTE_DIRECTORY))
-	{
-	  type |= ACL_DEFAULT;
-	  if ((pos = searchace (lacl, MAX_ACL_ENTRIES, type, id)) >= 0)
-	    getace (lacl[pos], type, id, ace->Mask, ace->Header.AceType);
+      /* Include CLASS_OBJ to insure count > 4 (MIN_ACL_ENTRIES)
+	 if any default ace exists */
+      lacl[3].a_perm = lacl[1].a_perm;
+      int dgpos;
+      if ((types_def & (USER|GROUP)) 
+	  && ((dgpos = searchace (lacl, MAX_ACL_ENTRIES, DEF_GROUP_OBJ)),
+	      (pos = searchace (lacl, MAX_ACL_ENTRIES, DEF_CLASS_OBJ)) >= 0))
+	{
+	  lacl[pos].a_type = DEF_CLASS_OBJ;
+	  lacl[pos].a_perm = lacl[dgpos].a_perm;
 	}
     }
   if ((pos = searchace (lacl, MAX_ACL_ENTRIES, 0)) < 0)
     pos = MAX_ACL_ENTRIES;
-  for (i = 0; i < pos; ++i)
-    {
-      lacl[i].a_perm = (lacl[i].a_perm & S_IRWXU)
-		       & ~((lacl[i].a_perm & S_IRWXG) << 3);
-      lacl[i].a_perm |= (lacl[i].a_perm & S_IRWXU) >> 3
-			| (lacl[i].a_perm & S_IRWXU) >> 6;
-    }
-  if ((searchace (lacl, MAX_ACL_ENTRIES, USER) >= 0
-       || searchace (lacl, MAX_ACL_ENTRIES, GROUP) >= 0)
-      && (pos = searchace (lacl, MAX_ACL_ENTRIES, CLASS_OBJ)) >= 0)
-    {
-      lacl[pos].a_type = CLASS_OBJ;
-      lacl[pos].a_perm =
-	  lacl[searchace (lacl, MAX_ACL_ENTRIES, GROUP_OBJ)].a_perm;
-    }
-  int dgpos;
-  if ((searchace (lacl, MAX_ACL_ENTRIES, DEF_USER) >= 0
-       || searchace (lacl, MAX_ACL_ENTRIES, DEF_GROUP) >= 0)
-      && (dgpos = searchace (lacl, MAX_ACL_ENTRIES, DEF_GROUP_OBJ)) >= 0
-      && (pos = searchace (lacl, MAX_ACL_ENTRIES, DEF_CLASS_OBJ)) >= 0
-      && (attr & FILE_ATTRIBUTE_DIRECTORY))
-    {
-      lacl[pos].a_type = DEF_CLASS_OBJ;
-      lacl[pos].a_perm = lacl[dgpos].a_perm;
-    }
-  if ((pos = searchace (lacl, MAX_ACL_ENTRIES, 0)) < 0)
-    pos = MAX_ACL_ENTRIES;
-  if (pos > nentries)
-    pos = nentries;
-  if (aclbufp)
+  if (aclbufp) {
+    if (EqualSid (owner_sid, group_sid)) 
+      lacl[0].a_perm = lacl[1].a_perm;
+    aclsort (pos, 0, aclbufp);
+    if (pos > nentries)
+      pos = nentries;
     memcpy (aclbufp, lacl, pos * sizeof (__aclent16_t));
-  aclsort (pos, 0, aclbufp);
+  }
   syscall_printf ("%d = getacl (%s)", pos, file);
   return pos;
 }
@@ -472,7 +470,7 @@ acl_worker (const char *path, int cmd, i
       syscall_printf ("-1 = acl (%s)", path);
       return -1;
     }
-  if (!real_path.has_acls ())
+  if (!real_path.has_acls () || !allow_ntsec)
     {
       struct __stat64 st;
       int ret = -1;

--------------912E9C30197004737BB9559D--
