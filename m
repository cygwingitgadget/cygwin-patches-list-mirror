Return-Path: <cygwin-patches-return-3489-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1161 invoked by alias); 4 Feb 2003 15:41:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1112 invoked from network); 4 Feb 2003 15:41:26 -0000
Message-Id: <3.0.5.32.20030204103816.008064e0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Tue, 04 Feb 2003 15:41:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: security.cc
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1044391096==_"
X-SW-Source: 2003-q1/txt/msg00138.txt.bz2

--=====================_1044391096==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 713


Corinna,

This patch defines a new function get_sids_info that greatly reduces
the number of passwd/group lookups, compared to the current approach.
There are also minor fixes in security.cc

Pierre

2003/02/04  Pierre Humblet  <pierre.humblet@ieee.org>

	* sec_helper.cc (get_sids_info): New function.
	* security.cc (extract_nt_dom_user): Simplify with strechr.
	(get_user_groups): Initialize glen to MAX_SID_LEN.
	(get_user_local_groups): Ditto.
	(get_attribute_from_acl): Define ace_sid as cygpsid.
	(get_nt_attribute): Define owner_sid and group_sid as cygpsid.
	Call get_sids_info instead of cygsid.get_{u,g}id and is_grp_member.
	(get_nt_object_attribute): Ditto.
	(alloc_sd): Define ace_sid as cygpsid.


--=====================_1044391096==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sec.diff"
Content-length: 6145

Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.133
diff -u -p -r1.133 security.cc
--- security.cc	3 Feb 2003 15:55:19 -0000	1.133
+++ security.cc	4 Feb 2003 15:10:02 -0000
@@ -90,15 +90,13 @@ extract_nt_dom_user (const struct passwd
   if ((d =3D strstr (pw->pw_gecos, "U-")) !=3D NULL &&
       (d =3D=3D pw->pw_gecos || d[-1] =3D=3D ','))
     {
-      c =3D strchr (d + 2, ',');
-      if ((u =3D strchr (d + 2, '\\')) =3D=3D NULL || (c !=3D NULL && u > =
c))
+      c =3D strechr (d + 2, ',');
+      if ((u =3D strechr (d + 2, '\\')) >=3D c)
 	u =3D d + 1;
       else if (u - d <=3D INTERNET_MAX_HOST_NAME_LENGTH + 2)
 	strlcpy (domain, d + 2, u - d - 1);
-      if (c =3D=3D NULL)
-	c =3D u + UNLEN + 1;
       if (c - u <=3D UNLEN + 1)
-	strlcpy (user, u + 1, c - u);
+        strlcpy (user, u + 1, c - u);
     }
   if (domain[0])
     return;
@@ -329,7 +327,7 @@ get_user_groups (WCHAR *wlogonserver, cy
   for (DWORD i =3D 0; i < cnt; ++i)
     {
       cygsid gsid;
-      DWORD glen =3D sizeof (gsid);
+      DWORD glen =3D MAX_SID_LEN;
       char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
       DWORD dlen =3D sizeof (domain);
       SID_NAME_USE use =3D SidTypeInvalid;
@@ -407,7 +405,7 @@ get_user_local_groups (cygsidlist &grp_l
     if (is_group_member (buf[i].lgrpi0_name, pusersid, grp_list))
       {
 	cygsid gsid;
-	DWORD glen =3D sizeof (gsid);
+	DWORD glen =3D MAX_SID_LEN;
 	char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
 	DWORD dlen =3D sizeof (domain);

@@ -1230,7 +1228,7 @@ get_attribute_from_acl (int * attribute,
 	  continue;
 	}

-      cygsid ace_sid ((PSID) &ace->SidStart);
+      cygpsid ace_sid ((PSID) &ace->SidStart);
       if (ace_sid =3D=3D well_known_world_sid)
 	{
 	  if (ace->Mask & FILE_READ_DATA)
@@ -1317,13 +1315,13 @@ get_nt_attribute (const char *file, int
       return -1;
     }

-  PSID owner_sid;
-  PSID group_sid;
+  cygpsid owner_sid;
+  cygpsid group_sid;
   BOOL dummy;

-  if (!GetSecurityDescriptorOwner (psd, &owner_sid, &dummy))
+  if (!GetSecurityDescriptorOwner (psd, (void **) &owner_sid, &dummy))
     debug_printf ("GetSecurityDescriptorOwner %E");
-  if (!GetSecurityDescriptorGroup (psd, &group_sid, &dummy))
+  if (!GetSecurityDescriptorGroup (psd, (void **) &group_sid, &dummy))
     debug_printf ("GetSecurityDescriptorGroup %E");

   PACL acl;
@@ -1336,8 +1334,9 @@ get_nt_attribute (const char *file, int
       return -1;
     }

-  __uid32_t uid =3D cygsid (owner_sid).get_uid ();
-  __gid32_t gid =3D cygsid (group_sid).get_gid ();
+  __uid32_t uid;
+  __gid32_t gid;
+  BOOL grp_member =3D get_sids_info (owner_sid, group_sid, &uid, &gid);
   if (uidret)
     *uidret =3D uid;
   if (gidret)
@@ -1349,8 +1348,6 @@ get_nt_attribute (const char *file, int
       return 0;
     }

-  BOOL grp_member =3D is_grp_member (uid, gid);
-
   if (!acl_exists || !acl)
     {
       *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;
@@ -1420,15 +1417,15 @@ get_nt_object_attribute (HANDLE handle,
     return 0;

   PSECURITY_DESCRIPTOR psd =3D NULL;
-  PSID owner_sid;
-  PSID group_sid;
+  cygpsid owner_sid;
+  cygpsid group_sid;
   PACL acl;

   if (ERROR_SUCCESS !=3D GetSecurityInfo (handle, object_type,
 					DACL_SECURITY_INFORMATION |
 					GROUP_SECURITY_INFORMATION |
 					OWNER_SECURITY_INFORMATION,
-					&owner_sid, &group_sid,
+					(void **) &owner_sid, (void **) &group_sid,
 					&acl, NULL, &psd))
     {
       __seterrno ();
@@ -1436,8 +1433,10 @@ get_nt_object_attribute (HANDLE handle,
       return -1;
     }

-  __uid32_t uid =3D cygsid (owner_sid).get_uid ();
-  __gid32_t gid =3D cygsid (group_sid).get_gid ();
+  __uid32_t uid;
+  __gid32_t gid;
+  BOOL grp_member =3D get_sids_info (owner_sid, group_sid, &uid, &gid);
+
   if (uidret)
     *uidret =3D uid;
   if (gidret)
@@ -1450,8 +1449,6 @@ get_nt_object_attribute (HANDLE handle,
       return 0;
     }

-  BOOL grp_member =3D is_grp_member (uid, gid);
-
   if (!acl)
     {
       *attribute |=3D S_IRWXU | S_IRWXG | S_IRWXO;
@@ -1749,7 +1746,8 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
     for (DWORD i =3D 0; i < oacl->AceCount; ++i)
       if (GetAce (oacl, i, (PVOID *) &ace))
 	{
-	  cygsid ace_sid ((PSID) &ace->SidStart);
+	  cygpsid ace_sid ((PSID) &ace->SidStart);
+
 	  /* Check for related ACEs. */
 	  if (ace_sid =3D=3D well_known_null_sid)
 	    continue;
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.34
diff -u -p -r1.34 sec_helper.cc
--- sec_helper.cc	4 Feb 2003 14:58:04 -0000	1.34
+++ sec_helper.cc	4 Feb 2003 15:10:45 -0000
@@ -186,6 +186,43 @@ cygsid::getfromgr (const struct __group3
   return (*this =3D sp) !=3D NULL;
 }

+bool
+get_sids_info (cygpsid owner_sid, cygpsid group_sid, __uid32_t * uidret, _=
_gid32_t * gidret)
+{
+  struct passwd *pw;
+  struct __group32 *gr =3D NULL;
+  bool ret =3D false;
+
+  if (group_sid =3D=3D cygheap->user.groups.pgsid)
+    *gidret =3D myself->gid;
+  else if ((gr =3D internal_getgrsid (group_sid)))
+    *gidret =3D gr->gr_gid;
+  else
+    *gidret =3D ILLEGAL_GID;
+
+  if (owner_sid =3D=3D cygheap->user.sid ())
+    {
+      *uidret =3D myself->uid;
+      if (*gidret =3D=3D myself->gid)
+	ret =3D true;
+      else
+	ret =3D (internal_getgroups (0, NULL, &group_sid) > 0);
+    }
+  else if ((pw =3D internal_getpwsid (owner_sid)))
+    {
+      *uidret =3D pw->pw_uid;
+      if (gr || (*gidret !=3D ILLEGAL_GID
+		 && (gr =3D internal_getgrgid (*gidret))))
+	for (int idx =3D 0; gr->gr_mem[idx]; ++idx)
+	  if ((ret =3D strcasematch (pw->pw_name, gr->gr_mem[idx])))
+	    break;
+    }
+  else
+    *uidret =3D ILLEGAL_UID;
+
+  return ret;
+}
+
 BOOL
 is_grp_member (__uid32_t uid, __gid32_t gid)
 {

--=====================_1044391096==_--
