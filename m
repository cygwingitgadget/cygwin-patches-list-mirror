Return-Path: <cygwin-patches-return-2861-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6241 invoked by alias); 25 Aug 2002 22:02:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6226 invoked from network); 25 Aug 2002 22:02:51 -0000
Message-Id: <3.0.5.32.20020825175114.0080a290@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Sun, 25 Aug 2002 15:02:00 -0000
To: "Chris January" <chris@atomice.net>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: RE: More more Everyone
Cc: cygwin-patches@cygwin.com
In-Reply-To: <LPEHIHGCJOAIPFLADJAHGEIMCKAA.chris@atomice.net>
References: <3.0.5.32.20020824171457.00811b80@mail.attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1030326674==_"
X-SW-Source: 2002-q3/txt/msg00309.txt.bz2

--=====================_1030326674==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 789

At 11:04 AM 8/25/2002 +0100, Chris January wrote:
>Can you please make sure these changes are also reflected in
>get_nt_object_attribute?

Good point. Thanks. 
I took this opportunity to collect a chunk of common code in a new function.
This patch supersedes those I sent yesterday.

Pierre

2002-08-25 Pierre Humblet <Pierre.Humblet@ieee.org>
	
	* sec_acl.cc (getacl): Check ace_sid == well_known_world_sid
	before owner_sid and group_sid so that well_known_world_sid 
	means "other" even when owner_sid and/or group_sid are Everyone. 
	* security.cc (get_attribute_from_acl): Created from code common
	to get_nt_attribute() and get_nt_object_attribute(), with same 
	reordering as in getacl() above.
	(get_nt_attribute): Call get_attribute_from_acl().
	(get_nt_object_attribute): Ditto.

--=====================_1030326674==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="Everyone.diff"
Content-length: 8649

--- sec_acl.cc.orig	2002-07-02 20:29:16.000000000 -0400
+++ sec_acl.cc	2002-08-24 17:01:02.000000000 -0400
@@ -314,7 +314,12 @@
       int id;
       int type =3D 0;

-      if (ace_sid =3D=3D owner_sid)
+      if (ace_sid =3D=3D well_known_world_sid)
+	{
+	  type =3D OTHER_OBJ;
+	  id =3D 0;
+	}
+      else if (ace_sid =3D=3D owner_sid)
 	{
 	  type =3D USER_OBJ;
 	  id =3D uid;
@@ -324,11 +329,6 @@
 	  type =3D GROUP_OBJ;
 	  id =3D gid;
 	}
-      else if (ace_sid =3D=3D well_known_world_sid)
-	{
-	  type =3D OTHER_OBJ;
-	  id =3D 0;
-	}
       else
 	{
 	  id =3D ace_sid.get_id (FALSE, &type);
--- security.cc.orig	2002-08-23 18:37:10.000000000 -0400
+++ security.cc	2002-08-25 10:51:48.000000000 -0400
@@ -1202,6 +1202,95 @@
   return 0;
 }

+static void
+get_attribute_from_acl(int * attribute, PACL acl, PSID owner_sid,
+		       PSID group_sid, BOOL grp_member)
+{
+  ACCESS_ALLOWED_ACE *ace;
+  int allow =3D 0;
+  int deny =3D 0;
+  int *flags, *anti;
+
+  for (DWORD i =3D 0; i < acl->AceCount; ++i)
+    {
+      if (!GetAce (acl, i, (PVOID *) &ace))
+	continue;
+      if (ace->Header.AceFlags & INHERIT_ONLY)
+	continue;
+      switch (ace->Header.AceType)
+	{
+	case ACCESS_ALLOWED_ACE_TYPE:
+	  flags =3D &allow;
+	  anti =3D &deny;
+	  break;
+	case ACCESS_DENIED_ACE_TYPE:
+	  flags =3D &deny;
+	  anti =3D &allow;
+	  break;
+	default:
+	  continue;
+	}
+
+      cygsid ace_sid ((PSID) &ace->SidStart);
+      if (ace_sid =3D=3D well_known_world_sid)
+	{
+	  if (ace->Mask & FILE_READ_DATA)
+	    *flags |=3D S_IROTH
+		      | ((!(*anti & S_IRGRP)) ? S_IRGRP : 0)
+		      | ((!(*anti & S_IRUSR)) ? S_IRUSR : 0);
+	  if (ace->Mask & FILE_WRITE_DATA)
+	    *flags |=3D S_IWOTH
+		      | ((!(*anti & S_IWGRP)) ? S_IWGRP : 0)
+		      | ((!(*anti & S_IWUSR)) ? S_IWUSR : 0);
+	  if (ace->Mask & FILE_EXECUTE)
+	    {
+	      *flags |=3D S_IXOTH
+			| ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)
+			| ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);
+	    }
+	  if ((*attribute & S_IFDIR) &&
+	      (ace->Mask & (FILE_WRITE_DATA | FILE_EXECUTE | FILE_DELETE_CHILD))
+	      =3D=3D (FILE_WRITE_DATA | FILE_EXECUTE))
+	    *flags |=3D S_ISVTX;
+	}
+      else if (ace_sid =3D=3D well_known_null_sid)
+	{
+	  /* Read SUID, SGID and VTX bits from NULL ACE. */
+	  if (ace->Mask & FILE_READ_DATA)
+	    *flags |=3D S_ISVTX;
+	  if (ace->Mask & FILE_WRITE_DATA)
+	    *flags |=3D S_ISGID;
+	  if (ace->Mask & FILE_APPEND_DATA)
+	    *flags |=3D S_ISUID;
+	}
+      else if (owner_sid && ace_sid =3D=3D owner_sid)
+	{
+	  if (ace->Mask & FILE_READ_DATA)
+	    *flags |=3D S_IRUSR;
+	  if (ace->Mask & FILE_WRITE_DATA)
+	    *flags |=3D S_IWUSR;
+	  if (ace->Mask & FILE_EXECUTE)
+	    *flags |=3D S_IXUSR;
+	}
+      else if (group_sid && ace_sid =3D=3D group_sid)
+	{
+	  if (ace->Mask & FILE_READ_DATA)
+	    *flags |=3D S_IRGRP
+		      | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);
+	  if (ace->Mask & FILE_WRITE_DATA)
+	    *flags |=3D S_IWGRP
+		      | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);
+	  if (ace->Mask & FILE_EXECUTE)
+	    *flags |=3D S_IXGRP
+		      | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);
+	}
+    }
+  *attribute &=3D ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_IS=
UID);
+  *attribute |=3D allow;
+  *attribute &=3D ~deny;
+  return;
+}
+
 static int
 get_nt_attribute (const char *file, int *attribute,
 		  __uid32_t *uidret, __gid32_t *gidret)
@@ -1264,89 +1353,8 @@
 		      file, *attribute, uid, gid);
       return 0;
     }
+  get_attribute_from_acl (attribute, acl, owner_sid, group_sid, grp_member=
);

-  ACCESS_ALLOWED_ACE *ace;
-  int allow =3D 0;
-  int deny =3D 0;
-  int *flags, *anti;
-
-  for (DWORD i =3D 0; i < acl->AceCount; ++i)
-    {
-      if (!GetAce (acl, i, (PVOID *) &ace))
-	continue;
-      if (ace->Header.AceFlags & INHERIT_ONLY)
-	continue;
-      switch (ace->Header.AceType)
-	{
-	case ACCESS_ALLOWED_ACE_TYPE:
-	  flags =3D &allow;
-	  anti =3D &deny;
-	  break;
-	case ACCESS_DENIED_ACE_TYPE:
-	  flags =3D &deny;
-	  anti =3D &allow;
-	  break;
-	default:
-	  continue;
-	}
-
-      cygsid ace_sid ((PSID) &ace->SidStart);
-      if (owner_sid && ace_sid =3D=3D owner_sid)
-	{
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_IRUSR;
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_IWUSR;
-	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |=3D S_IXUSR;
-	}
-      else if (group_sid && ace_sid =3D=3D group_sid)
-	{
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_IRGRP
-		      | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_IWGRP
-		      | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);
-	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |=3D S_IXGRP
-		      | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);
-	}
-      else if (ace_sid =3D=3D well_known_world_sid)
-	{
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_IROTH
-		      | ((!(*anti & S_IRGRP)) ? S_IRGRP : 0)
-		      | ((!(*anti & S_IRUSR)) ? S_IRUSR : 0);
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_IWOTH
-		      | ((!(*anti & S_IWGRP)) ? S_IWGRP : 0)
-		      | ((!(*anti & S_IWUSR)) ? S_IWUSR : 0);
-	  if (ace->Mask & FILE_EXECUTE)
-	    {
-	      *flags |=3D S_IXOTH
-			| ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)
-			| ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);
-	    }
-	  if ((*attribute & S_IFDIR) &&
-	      (ace->Mask & (FILE_WRITE_DATA | FILE_EXECUTE | FILE_DELETE_CHILD))
-	      =3D=3D (FILE_WRITE_DATA | FILE_EXECUTE))
-	    *flags |=3D S_ISVTX;
-	}
-      else if (ace_sid =3D=3D well_known_null_sid)
-	{
-	  /* Read SUID, SGID and VTX bits from NULL ACE. */
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_ISVTX;
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_ISGID;
-	  if (ace->Mask & FILE_APPEND_DATA)
-	    *flags |=3D S_ISUID;
-	}
-    }
-  *attribute &=3D ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_IS=
UID);
-  *attribute |=3D allow;
-  *attribute &=3D ~deny;
   syscall_printf ("file: %s %x, uid %d, gid %d", file, *attribute, uid, gi=
d);
   return 0;
 }
@@ -1437,88 +1445,7 @@
       return 0;
     }

-  ACCESS_ALLOWED_ACE *ace;
-  int allow =3D 0;
-  int deny =3D 0;
-  int *flags, *anti;
-
-  for (DWORD i =3D 0; i < acl->AceCount; ++i)
-    {
-      if (!GetAce (acl, i, (PVOID *) & ace))
-	continue;
-      if (ace->Header.AceFlags & INHERIT_ONLY)
-	continue;
-      switch (ace->Header.AceType)
-	{
-	case ACCESS_ALLOWED_ACE_TYPE:
-	  flags =3D &allow;
-	  anti =3D &deny;
-	  break;
-	case ACCESS_DENIED_ACE_TYPE:
-	  flags =3D &deny;
-	  anti =3D &allow;
-	  break;
-	default:
-	  continue;
-	}
-
-      cygsid ace_sid ((PSID) & ace->SidStart);
-      if (owner_sid && ace_sid =3D=3D owner_sid)
-	{
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_IRUSR;
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_IWUSR;
-	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |=3D S_IXUSR;
-	}
-      else if (group_sid && ace_sid =3D=3D group_sid)
-	{
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_IRGRP
-		      | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_IWGRP
-		      | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);
-	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |=3D S_IXGRP
-		      | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);
-	}
-      else if (ace_sid =3D=3D well_known_world_sid)
-	{
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_IROTH
-		      | ((!(*anti & S_IRGRP)) ? S_IRGRP : 0)
-		      | ((!(*anti & S_IRUSR)) ? S_IRUSR : 0);
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_IWOTH
-		      | ((!(*anti & S_IWGRP)) ? S_IWGRP : 0)
-		      | ((!(*anti & S_IWUSR)) ? S_IWUSR : 0);
-	  if (ace->Mask & FILE_EXECUTE)
-	    {
-	      *flags |=3D S_IXOTH
-			| ((!(*anti & S_IXGRP)) ? S_IXGRP : 0)
-			| ((!(*anti & S_IXUSR)) ? S_IXUSR : 0);
-	    }
-	  if ((*attribute & S_IFDIR) &&
-	      (ace->Mask & (FILE_WRITE_DATA | FILE_EXECUTE | FILE_DELETE_CHILD))
-	      =3D=3D (FILE_WRITE_DATA | FILE_EXECUTE))
-	    *flags |=3D S_ISVTX;
-	}
-      else if (ace_sid =3D=3D well_known_null_sid)
-	{
-	  /* Read SUID, SGID and VTX bits from NULL ACE. */
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |=3D S_ISVTX;
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |=3D S_ISGID;
-	  if (ace->Mask & FILE_APPEND_DATA)
-	    *flags |=3D S_ISUID;
-	}
-    }
-  *attribute &=3D ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_IS=
UID);
-  *attribute |=3D allow;
-  *attribute &=3D ~deny;
+  get_attribute_from_acl (attribute, acl, owner_sid, group_sid, grp_member=
);

   LocalFree (psd);


--=====================_1030326674==_--
