Return-Path: <cygwin-patches-return-3494-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13583 invoked by alias); 5 Feb 2003 14:17:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13567 invoked from network); 5 Feb 2003 14:17:45 -0000
Message-Id: <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Wed, 05 Feb 2003 14:17:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: sec_acl.cc
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1044472505==_"
X-SW-Source: 2003-q1/txt/msg00143.txt.bz2

--=====================_1044472505==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2242

Corinna,

This patch implements __{u,g}id32_t in sec_acl.cc and performs a
few optimizations using the new argument of internal_getgroups,
cygpsid and strechr.

is_grp_member is now unused and will disappear in the next installment.

Three remarks:
1) I changed a STANDARD_RIGHTS_ALL to STANDARD_RIGHTS_WRITE in setacl.
   Is that what you meant?
2) Because of the ~DELETE stuff in setacl, the owner may not have DELETE
right, 
   even when the file is writable. unlink calls chmod if needed so it's OK
   (but then what's the point of ~DELETE ?), but a Windows program would 
   have trouble with DeleteFile (in some directories). 
   Should we add DELETE for USER_OBJ when it has write access, or should we 
   remove ~DELETE in setacl and alloc_sd?
3) In security.cc I had to move set_process_privilege back to write_sd
   because setacl may need it.

Pierre

2003-02-05  Pierre Humblet  <pierre.humblet@ieee.org>

	* sec_acl.cc: Change all  __aclent16_t to  __aclent32_t except in
	wrapper function definitions. Replace call to the aclXYZ functions by 
	calls aclXYZ32.
	(searchace): Change type of third argument to __uid32_t and use
	ILLEGAL_UID instead of -1;
	(setacl): Remove some initializations. Only give STANDARD_RIGHTS_WRITE
	for S_IWOTH. Replace -1 by ILLEGAL_UID.
	(getacl): Change type of owner_sid, group_sid and ace_sid to cygpsid.
	In last else clause, suppress second call to ace_sid.get_id and use
	TRUE in first call. Replace EqualSid by ==.
	(acl_access): Call internal_getgroups in USER and GROUP cases.
	(acecmp: Define static.
	(acl32): Create from 16 bit type.
	(facl32): Ditto.
	(lacl32): Ditto.
	(aclcheck32): Ditto.
	(aclsort32): Ditto.
	(acltomode32): Ditto.
	(aclfrommode32): Ditto.
	(acltopbits32): Ditto.
	(aclfrompbits32): Ditto.
	(acltotext32): Ditto.
	(aclfromtext32): Ditto, and use strechr.
	(acl16to32): Create.
	(acl): Make it a wrapper function.
	(facl): Ditto.
	(lacl): Ditto.
	(aclcheck): Ditto.
	(aclsort): Ditto.
	(acltomode): Ditto.
	(aclfrommode): Ditto.
	(acltopbits): Ditto.
	(aclfrompbits): Ditto.
	(acltotext): Ditto.
	(aclfromtext): Ditto.
	* security.cc (write_sd): Call set_process_privilege and check ownership.
	(alloc_sd): Remove call to set_process_privilege and the owner check.
	

--=====================_1044472505==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sec_acl.diff"
Content-length: 18206

Index: sec_acl.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_acl.cc,v
retrieving revision 1.25
diff -u -p -r1.25 sec_acl.cc
--- sec_acl.cc	26 Jan 2003 06:42:40 -0000	1.25
+++ sec_acl.cc	5 Feb 2003 14:05:22 -0000
@@ -32,23 +32,23 @@ details. */
 #include "cygheap.h"
 #include "pwdgrp.h"

-extern "C" int aclsort (int nentries, int, __aclent16_t *aclbufp);
-extern "C" int acl (const char *path, int cmd, int nentries, __aclent16_t =
*aclbufp);
+extern "C" int aclsort32 (int nentries, int, __aclent32_t *aclbufp);
+extern "C" int acl32 (const char *path, int cmd, int nentries, __aclent32_=
t *aclbufp);

 static int
-searchace (__aclent16_t *aclp, int nentries, int type, int id =3D -1)
+searchace (__aclent32_t *aclp, int nentries, int type, __uid32_t id =3D IL=
LEGAL_UID)
 {
   int i;

   for (i =3D 0; i < nentries; ++i)
-    if ((aclp[i].a_type =3D=3D type && (id =3D=3D -1 || aclp[i].a_id =3D=
=3D id))
+    if ((aclp[i].a_type =3D=3D type && (id =3D=3D ILLEGAL_UID || aclp[i].a=
_id =3D=3D id))
 	|| !aclp[i].a_type)
       return i;
   return -1;
 }

 static int
-setacl (const char *file, int nentries, __aclent16_t *aclbufp)
+setacl (const char *file, int nentries, __aclent32_t *aclbufp)
 {
   DWORD sd_size =3D 4096;
   char sd_buf[4096];
@@ -63,7 +63,7 @@ setacl (const char *file, int nentries,
   BOOL dummy;

   /* Get owner SID. */
-  PSID owner_sid =3D NULL;
+  PSID owner_sid;
   if (!GetSecurityDescriptorOwner (psd, &owner_sid, &dummy))
     {
       __seterrno ();
@@ -72,7 +72,7 @@ setacl (const char *file, int nentries,
   cygsid owner (owner_sid);

   /* Get group SID. */
-  PSID group_sid =3D NULL;
+  PSID group_sid;
   if (!GetSecurityDescriptorGroup (psd, &group_sid, &dummy))
     {
       __seterrno ();
@@ -92,8 +92,7 @@ setacl (const char *file, int nentries,
       __seterrno ();
       return -1;
     }
-  if (group
-      && !SetSecurityDescriptorGroup (&sd, group, FALSE))
+  if (!SetSecurityDescriptorGroup (&sd, group, FALSE))
     {
       __seterrno ();
       return -1;
@@ -122,7 +121,7 @@ setacl (const char *file, int nentries,
       if (aclbufp[i].a_perm & S_IROTH)
 	allow |=3D FILE_GENERIC_READ;
       if (aclbufp[i].a_perm & S_IWOTH)
-	allow |=3D STANDARD_RIGHTS_ALL | FILE_GENERIC_WRITE;
+	allow |=3D STANDARD_RIGHTS_WRITE | FILE_GENERIC_WRITE;
       if (aclbufp[i].a_perm & S_IXOTH)
 	allow |=3D FILE_GENERIC_EXECUTE;
       if ((aclbufp[i].a_perm & (S_IWOTH | S_IXOTH)) =3D=3D (S_IWOTH | S_IX=
OTH))
@@ -141,7 +140,7 @@ setacl (const char *file, int nentries,
 	  && (pos =3D searchace (aclbufp + i + 1, nentries - i - 1,
 			       aclbufp[i].a_type | ACL_DEFAULT,
 			       (aclbufp[i].a_type & (USER|GROUP))
-			       ? aclbufp[i].a_id : -1)) >=3D 0
+			       ? aclbufp[i].a_id : ILLEGAL_UID)) >=3D 0
 	  && aclbufp[i].a_perm =3D=3D aclbufp[pos].a_perm)
 	{
 	  inheritance =3D SUB_CONTAINERS_AND_OBJECTS_INHERIT;
@@ -167,12 +166,12 @@ setacl (const char *file, int nentries,
 	  if (!(pw =3D internal_getpwuid (aclbufp[i].a_id))
 	      || !sid.getfrompw (pw)
 	      || !add_access_allowed_ace (acl, ace_off++, allow,
-					   sid, acl_len, inheritance))
+					  sid, acl_len, inheritance))
 	    return -1;
 	  break;
 	case GROUP_OBJ:
 	  if (!add_access_allowed_ace (acl, ace_off++, allow,
-					group, acl_len, inheritance))
+				       group, acl_len, inheritance))
 	    return -1;
 	  break;
 	case DEF_GROUP_OBJ:
@@ -185,7 +184,7 @@ setacl (const char *file, int nentries,
 	  if (!(gr =3D internal_getgrgid (aclbufp[i].a_id))
 	      || !sid.getfromgr (gr)
 	      || !add_access_allowed_ace (acl, ace_off++, allow,
-					   sid, acl_len, inheritance))
+					  sid, acl_len, inheritance))
 	    return -1;
 	  break;
 	case OTHER_OBJ:
@@ -229,7 +228,7 @@ setacl (const char *file, int nentries,
 #define DENY_X 010000

 static void
-getace (__aclent16_t &acl, int type, int id, DWORD win_ace_mask,
+getace (__aclent32_t &acl, int type, int id, DWORD win_ace_mask,
 	DWORD win_ace_type)
 {
   acl.a_type =3D type;
@@ -255,7 +254,7 @@ getace (__aclent16_t &acl, int type, int
 }

 static int
-getacl (const char *file, DWORD attr, int nentries, __aclent16_t *aclbufp)
+getacl (const char *file, DWORD attr, int nentries, __aclent32_t *aclbufp)
 {
   DWORD sd_size =3D 4096;
   char sd_buf[4096];
@@ -268,30 +267,30 @@ getacl (const char *file, DWORD attr, in
       return ret;
     }

-  PSID owner_sid;
-  PSID group_sid;
+  cygpsid owner_sid;
+  cygpsid group_sid;
   BOOL dummy;
   __uid32_t uid;
   __gid32_t gid;

-  if (!GetSecurityDescriptorOwner (psd, &owner_sid, &dummy))
+  if (!GetSecurityDescriptorOwner (psd, (PSID *) &owner_sid, &dummy))
     {
       debug_printf ("GetSecurityDescriptorOwner %E");
       __seterrno ();
       return -1;
     }
-  uid =3D cygsid (owner_sid).get_uid ();
+  uid =3D owner_sid.get_uid ();

-  if (!GetSecurityDescriptorGroup (psd, &group_sid, &dummy))
+  if (!GetSecurityDescriptorGroup (psd, (PSID *) &group_sid, &dummy))
     {
       debug_printf ("GetSecurityDescriptorGroup %E");
       __seterrno ();
       return -1;
     }
-  gid =3D cygsid (group_sid).get_gid ();
+  gid =3D group_sid.get_gid ();

-  __aclent16_t lacl[MAX_ACL_ENTRIES];
-  memset (&lacl, 0, MAX_ACL_ENTRIES * sizeof (__aclent16_t));
+  __aclent32_t lacl[MAX_ACL_ENTRIES];
+  memset (&lacl, 0, MAX_ACL_ENTRIES * sizeof (__aclent32_t));
   lacl[0].a_type =3D USER_OBJ;
   lacl[0].a_id =3D uid;
   lacl[1].a_type =3D GROUP_OBJ;
@@ -326,7 +325,7 @@ getacl (const char *file, DWORD attr, in
 	  if (!GetAce (acl, i, (PVOID *) &ace))
 	    continue;

-	  cygsid ace_sid ((PSID) &ace->SidStart);
+	  cygpsid ace_sid ((PSID) &ace->SidStart);
 	  int id;
 	  int type =3D 0;

@@ -356,19 +355,8 @@ getacl (const char *file, DWORD attr, in
 	      id =3D ILLEGAL_GID;
 	    }
 	  else
-	    {
-	      id =3D ace_sid.get_id (FALSE, &type);
-	      if (type !=3D GROUP)
-		{
-		  int type2 =3D 0;
-		  int id2 =3D ace_sid.get_id (TRUE, &type2);
-		  if (type2 =3D=3D GROUP)
-		    {
-		      id =3D id2;
-		      type =3D GROUP;
-		    }
-		}
-	    }
+	    id =3D ace_sid.get_id (TRUE, &type);
+
 	  if (!type)
 	    continue;
 	  if (!(ace->Header.AceFlags & INHERIT_ONLY || type & ACL_DEFAULT))
@@ -401,17 +389,17 @@ getacl (const char *file, DWORD attr, in
   if ((pos =3D searchace (lacl, MAX_ACL_ENTRIES, 0)) < 0)
     pos =3D MAX_ACL_ENTRIES;
   if (aclbufp) {
-    if (EqualSid (owner_sid, group_sid))
+    if (owner_sid =3D=3D group_sid)
       lacl[0].a_perm =3D lacl[1].a_perm;
     if (pos > nentries)
       {
 	set_errno (ENOSPC);
 	return -1;
       }
-    memcpy (aclbufp, lacl, pos * sizeof (__aclent16_t));
+    memcpy (aclbufp, lacl, pos * sizeof (__aclent32_t));
     for (i =3D 0; i < pos; ++i)
       aclbufp[i].a_perm &=3D ~(DENY_R | DENY_W | DENY_X);
-    aclsort (pos, 0, aclbufp);
+    aclsort32 (pos, 0, aclbufp);
   }
   syscall_printf ("%d =3D getacl (%s)", pos, file);
   return pos;
@@ -420,13 +408,13 @@ getacl (const char *file, DWORD attr, in
 int
 acl_access (const char *path, int flags)
 {
-  __aclent16_t acls[MAX_ACL_ENTRIES];
+  __aclent32_t acls[MAX_ACL_ENTRIES];
   int cnt;

-  if ((cnt =3D acl (path, GETACL, MAX_ACL_ENTRIES, acls)) < 1)
+  if ((cnt =3D acl32 (path, GETACL, MAX_ACL_ENTRIES, acls)) < 1)
     return -1;

-  /* Only check existance. */
+  /* Only check existence. */
   if (!(flags & (R_OK | W_OK | X_OK)))
     return 0;

@@ -440,25 +428,31 @@ acl_access (const char *path, int flags)
 	    {
 	      /*
 	       * Check if user is a NT group:
-	       * Take SID from passwd, search SID in group, check is_grp_member.
+	       * Take SID from passwd, search SID in token groups
 	       */
 	      cygsid owner;
 	      struct passwd *pw;
-	      struct __group32 *gr =3D NULL;

 	      if ((pw =3D internal_getpwuid (acls[i].a_id)) !=3D NULL
 		  && owner.getfrompw (pw)
-		  && (gr =3D internal_getgrsid (owner))
-		  && is_grp_member (myself->uid, gr->gr_gid))
+		  && internal_getgroups (0, NULL, &owner) > 0)
 		break;
 	      continue;
 	    }
 	  break;
 	case GROUP_OBJ:
 	case GROUP:
-	  if (acls[i].a_id !=3D myself->gid &&
-	      !is_grp_member (myself->uid, acls[i].a_id))
-	    continue;
+	  if (acls[i].a_id !=3D myself->gid)
+            {
+	      cygsid group;
+	      struct __group32 *gr =3D NULL;
+
+	      if ((gr =3D internal_getgrgid (acls[i].a_id)) !=3D NULL
+		  && group.getfromgr (gr)
+		  && internal_getgroups (0, NULL, &group) > 0)
+		break;
+	      continue;
+	    }
 	  break;
 	case OTHER_OBJ:
 	  break;
@@ -476,7 +470,7 @@ acl_access (const char *path, int flags)

 static
 int
-acl_worker (const char *path, int cmd, int nentries, __aclent16_t *aclbufp,
+acl_worker (const char *path, int cmd, int nentries, __aclent32_t *aclbufp,
 	    int nofollow)
 {
   extern suffix_info stat_suffixes[];
@@ -530,7 +524,7 @@ acl_worker (const char *path, int cmd, i
   switch (cmd)
     {
       case SETACL:
-	if (!aclsort (nentries, 0, aclbufp))
+	if (!aclsort32 (nentries, 0, aclbufp))
 	  return setacl (real_path.get_win32 (),
 			 nentries, aclbufp);
 	break;
@@ -556,21 +550,21 @@ acl_worker (const char *path, int cmd, i

 extern "C"
 int
-acl (const char *path, int cmd, int nentries, __aclent16_t *aclbufp)
+acl32 (const char *path, int cmd, int nentries, __aclent32_t *aclbufp)
 {
   return acl_worker (path, cmd, nentries, aclbufp, 0);
 }

 extern "C"
 int
-lacl (const char *path, int cmd, int nentries, __aclent16_t *aclbufp)
+lacl32 (const char *path, int cmd, int nentries, __aclent32_t *aclbufp)
 {
   return acl_worker (path, cmd, nentries, aclbufp, 1);
 }

 extern "C"
 int
-facl (int fd, int cmd, int nentries, __aclent16_t *aclbufp)
+facl32 (int fd, int cmd, int nentries, __aclent32_t *aclbufp)
 {
   cygheap_fdget cfd (fd);
   if (cfd < 0)
@@ -591,7 +585,7 @@ facl (int fd, int cmd, int nentries, __a

 extern "C"
 int
-aclcheck (__aclent16_t *aclbufp, int nentries, int *which)
+aclcheck32 (__aclent32_t *aclbufp, int nentries, int *which)
 {
   BOOL has_user_obj =3D FALSE;
   BOOL has_group_obj =3D FALSE;
@@ -722,10 +716,10 @@ aclcheck (__aclent16_t *aclbufp, int nen
   return 0;
 }

-extern "C"
+static
 int acecmp (const void *a1, const void *a2)
 {
-#define ace(i) ((const __aclent16_t *) a##i)
+#define ace(i) ((const __aclent32_t *) a##i)
   int ret =3D ace (1)->a_type - ace (2)->a_type;
   if (!ret)
     ret =3D ace (1)->a_id - ace (2)->a_id;
@@ -735,22 +729,22 @@ int acecmp (const void *a1, const void *

 extern "C"
 int
-aclsort (int nentries, int, __aclent16_t *aclbufp)
+aclsort32 (int nentries, int, __aclent32_t *aclbufp)
 {
-  if (aclcheck (aclbufp, nentries, NULL))
+  if (aclcheck32 (aclbufp, nentries, NULL))
     return -1;
   if (!aclbufp || nentries < 1)
     {
       set_errno (EINVAL);
       return -1;
     }
-  qsort ((void *) aclbufp, nentries, sizeof (__aclent16_t), acecmp);
+  qsort ((void *) aclbufp, nentries, sizeof (__aclent32_t), acecmp);
   return 0;
 }

 extern "C"
 int
-acltomode (__aclent16_t *aclbufp, int nentries, mode_t *modep)
+acltomode32 (__aclent32_t *aclbufp, int nentries, mode_t *modep)
 {
   int pos;

@@ -790,7 +784,7 @@ acltomode (__aclent16_t *aclbufp, int ne

 extern "C"
 int
-aclfrommode (__aclent16_t *aclbufp, int nentries, mode_t *modep)
+aclfrommode32 (__aclent32_t *aclbufp, int nentries, mode_t *modep)
 {
   int pos;

@@ -828,16 +822,16 @@ aclfrommode (__aclent16_t *aclbufp, int

 extern "C"
 int
-acltopbits (__aclent16_t *aclbufp, int nentries, mode_t *pbitsp)
+acltopbits32 (__aclent32_t *aclbufp, int nentries, mode_t *pbitsp)
 {
-  return acltomode (aclbufp, nentries, pbitsp);
+  return acltomode32 (aclbufp, nentries, pbitsp);
 }

 extern "C"
 int
-aclfrompbits (__aclent16_t *aclbufp, int nentries, mode_t *pbitsp)
+aclfrompbits32 (__aclent32_t *aclbufp, int nentries, mode_t *pbitsp)
 {
-  return aclfrommode (aclbufp, nentries, pbitsp);
+  return aclfrommode32 (aclbufp, nentries, pbitsp);
 }

 static char *
@@ -854,10 +848,10 @@ permtostr (mode_t perm)

 extern "C"
 char *
-acltotext (__aclent16_t *aclbufp, int aclcnt)
+acltotext32 (__aclent32_t *aclbufp, int aclcnt)
 {
   if (!aclbufp || aclcnt < 1 || aclcnt > MAX_ACL_ENTRIES
-      || aclcheck (aclbufp, aclcnt, NULL))
+      || aclcheck32 (aclbufp, aclcnt, NULL))
     {
       set_errno (EINVAL);
       return NULL;
@@ -930,8 +924,8 @@ permfromstr (char *perm)
 }

 extern "C"
-__aclent16_t *
-aclfromtext (char *acltextp, int *)
+__aclent32_t *
+aclfromtext32 (char *acltextp, int *)
 {
   if (!acltextp)
     {
@@ -939,7 +933,7 @@ aclfromtext (char *acltextp, int *)
       return NULL;
     }
   char buf[strlen (acltextp) + 1];
-  __aclent16_t lacl[MAX_ACL_ENTRIES];
+  __aclent32_t lacl[MAX_ACL_ENTRIES];
   memset (lacl, 0, sizeof lacl);
   int pos =3D 0;
   strcpy (buf, acltextp);
@@ -970,11 +964,11 @@ aclfromtext (char *acltextp, int *)
 		      return NULL;
 		    }
 		  lacl[pos].a_id =3D pw->pw_uid;
-		  c =3D strchr (c, ':');
+		  c =3D strechr (c, ':');
 		}
 	      else if (isdigit (*c))
 		lacl[pos].a_id =3D strtol (c, &c, 10);
-	      if (!c || *c !=3D ':')
+	      if (*c !=3D ':')
 		{
 		  set_errno (EINVAL);
 		  return NULL;
@@ -998,11 +992,11 @@ aclfromtext (char *acltextp, int *)
 		      return NULL;
 		    }
 		  lacl[pos].a_id =3D gr->gr_gid;
-		  c =3D strchr (c, ':');
+		  c =3D strechr (c, ':');
 		}
 	      else if (isdigit (*c))
 		lacl[pos].a_id =3D strtol (c, &c, 10);
-	      if (!c || *c !=3D ':')
+	      if (*c !=3D ':')
 		{
 		  set_errno (EINVAL);
 		  return NULL;
@@ -1036,9 +1030,97 @@ aclfromtext (char *acltextp, int *)
 	}
       ++pos;
     }
-  __aclent16_t *aclp =3D (__aclent16_t *) malloc (pos * sizeof (__aclent16=
_t));
+  __aclent32_t *aclp =3D (__aclent32_t *) malloc (pos * sizeof (__aclent32=
_t));
   if (aclp)
-    memcpy (aclp, lacl, pos * sizeof (__aclent16_t));
+    memcpy (aclp, lacl, pos * sizeof (__aclent32_t));
   return aclp;
 }

+/* __aclent16_t and __aclent32_t have same size and same member offsets */
+static __aclent32_t *
+acl16to32 (__aclent16_t *aclbufp, int nentries)
+{
+  __aclent32_t *aclbufp32 =3D (__aclent32_t *) aclbufp;
+  if (aclbufp32)
+    for (int i =3D 0; i < nentries; i++)
+      aclbufp32[i].a_id &=3D USHRT_MAX;
+  return aclbufp32;
+}
+
+extern "C"
+int
+acl (const char *path, int cmd, int nentries, __aclent16_t *aclbufp)
+{
+  return acl32 (path, cmd, nentries, acl16to32 (aclbufp, nentries));
+}
+
+extern "C"
+int
+facl (int fd, int cmd, int nentries, __aclent16_t *aclbufp)
+{
+  return facl32 (fd, cmd, nentries, acl16to32 (aclbufp, nentries));
+}
+
+extern "C"
+int
+lacl (const char *path, int cmd, int nentries, __aclent16_t *aclbufp)
+{
+  return lacl32 (path, cmd, nentries, acl16to32 (aclbufp, nentries));
+}
+
+extern "C"
+int
+aclcheck (__aclent16_t *aclbufp, int nentries, int *which)
+{
+  return aclcheck32 (acl16to32 (aclbufp, nentries), nentries, which);
+}
+
+extern "C"
+int
+aclsort (int nentries, int i, __aclent16_t *aclbufp)
+{
+  return aclsort32 (nentries, i, acl16to32 (aclbufp, nentries));
+}
+
+
+extern "C"
+int
+acltomode (__aclent16_t *aclbufp, int nentries, mode_t *modep)
+{
+  return acltomode32 (acl16to32 (aclbufp, nentries), nentries, modep);
+}
+
+extern "C"
+int
+aclfrommode (__aclent16_t *aclbufp, int nentries, mode_t *modep)
+{
+  return aclfrommode32 ((__aclent32_t *)aclbufp, nentries, modep);
+}
+
+extern "C"
+int
+acltopbits (__aclent16_t *aclbufp, int nentries, mode_t *pbitsp)
+{
+  return acltopbits32 (acl16to32 (aclbufp, nentries), nentries, pbitsp);
+}
+
+extern "C"
+int
+aclfrompbits (__aclent16_t *aclbufp, int nentries, mode_t *pbitsp)
+{
+  return aclfrompbits32 ((__aclent32_t *)aclbufp, nentries, pbitsp);
+}
+
+extern "C"
+char *
+acltotext (__aclent16_t *aclbufp, int aclcnt)
+{
+  return acltotext32 (acl16to32 (aclbufp, aclcnt), aclcnt);
+}
+
+extern "C"
+__aclent16_t *
+aclfromtext (char *acltextp, int * aclcnt)
+{
+  return (__aclent16_t *) aclfromtext32 (acltextp, aclcnt);
+}
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.135
diff -u -p -r1.135 security.cc
--- security.cc	5 Feb 2003 13:47:47 -0000	1.135
+++ security.cc	5 Feb 2003 14:05:48 -0000
@@ -1140,6 +1140,30 @@ write_sd (const char *file, PSECURITY_DE
       return -1;
     }

+  BOOL dummy;
+  cygpsid owner;
+
+  if (!GetSecurityDescriptorOwner (sd_buf, (PSID *) &owner, &dummy))
+    {
+      __seterrno ();
+      return -1;
+    }
+  /* Try turning privilege on, may not have WRITE_OWNER or WRITE_DAC acces=
s.
+     Must have privilege to set different owner, else BackupWrite misbehav=
es */
+  static int NO_COPY saved_res; /* 0: never, 1: failed, 2 & 3: OK */
+  int res;
+  if (!saved_res || cygheap->user.issetuid ())
+    {
+      res =3D 2 + set_process_privilege (SE_RESTORE_NAME, true,
+				       cygheap->user.issetuid ());
+      if (!cygheap->user.issetuid ())
+	saved_res =3D res;
+    }
+  else
+    res =3D saved_res;
+  if (res =3D=3D 1 && owner !=3D cygheap->user.sid ())
+    return -1;
+
   HANDLE fh;
   fh =3D CreateFile (file,
 		   WRITE_OWNER | WRITE_DAC,
@@ -1560,22 +1584,6 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
       return NULL;
     }
   owner_sid.debug_print ("alloc_sd: owner SID =3D");
-
-  /* Try turning privilege on, may not have WRITE_OWNER or WRITE_DAC acces=
s.
-     Must have privilege to set different owner, else BackupWrite misbehav=
es */
-  static int NO_COPY saved_res; /* 0: never, 1: failed, 2 & 3: OK */
-  int res;
-  if (!saved_res || cygheap->user.issetuid ())
-    {
-      res =3D 2 + set_process_privilege (SE_RESTORE_NAME, true,
-				       cygheap->user.issetuid ());
-      if (!cygheap->user.issetuid ())
-	saved_res =3D res;
-    }
-  else
-    res =3D saved_res;
-  if (res =3D=3D 1 && owner_sid !=3D cygheap->user.sid ())
-    return NULL;

   /* Get SID of new group. */
   cygsid group_sid;

--=====================_1044472505==_--
