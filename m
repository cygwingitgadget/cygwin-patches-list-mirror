Return-Path: <cygwin-patches-return-2189-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19716 invoked by alias); 15 May 2002 03:30:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19679 invoked from network); 15 May 2002 03:30:25 -0000
Message-Id: <3.0.5.32.20020514215138.007fa950@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Tue, 14 May 2002 20:30:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Security patches
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1021441898==_"
X-SW-Source: 2002-q2/txt/msg00173.txt.bz2

--=====================_1021441898==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 888

Hello Corinna,

One item (setegid) was missing in the changelog I sent 
yesterday. Also I corrected a debug_printf() in security.cc,
a new diff (replacing yesterday's) is attached.

Pierre

2002-05-13  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (seteuid): Set default dacl in process token.
	Replace in-line code by call to verify_token().
	(setegid): Reverse change from 2002-01-21. Add call to
	RevertToSelf and set primary group in impersonation token.
	* security.cc (create_token): Store pgrpsid in token security
	descriptor, except if it already appears in my_grps. 
	Use sec_acl() in place of get_dacl().
	(verify_token): Create from code in seteuid(), with tighter checks.
	(get_dacl) Deleted.
	(get_group_sidlist): Add argument to indicate if pgrpsid is already
	in the groups.
	* security.h: Define verify_token().
	* autoload.cc: Load GetKernelObjectSecurity().

--=====================_1021441898==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.cc.diff"
Content-length: 6328

--- security.cc.orig	Sun May  5 10:49:32 2002
+++ security.cc	Tue May 14 21:38:14 2002
@@ -476,7 +476,8 @@
 static BOOL
 get_group_sidlist (const char *logonserver, cygsidlist &grp_list,
 		   cygsid &usersid, cygsid &pgrpsid,
-		   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos)
+		   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos,
+		   BOOL * special_pgrp)
 {
   WCHAR wserver[INTERNET_MAX_HOST_NAME_LENGTH + 1];
   char user[INTERNET_MAX_HOST_NAME_LENGTH + 1];
@@ -533,19 +534,25 @@
 	  auth_pos =3D grp_list.count - 1;
 	}
     }
+  /* special_pgrp true if pgrpsid is not null and not in normal groups */
   if (!pgrpsid)
-    get_user_primary_group (wserver, user, usersid, pgrpsid);
+    {
+      * special_pgrp =3D FALSE;
+      get_user_primary_group (wserver, user, usersid, pgrpsid);
+    }
+  else * special_pgrp =3D TRUE;
   if (!get_user_groups (wserver, grp_list, user) ||
       !get_user_local_groups (wserver, logonserver, grp_list, usersid))
     return FALSE;
-  if (!grp_list.contains (pgrpsid))
-    grp_list +=3D pgrpsid;
   if (get_supplementary_group_sidlist (user, sup_list))
     {
       for (int i =3D 0; i < sup_list.count; ++i)
 	if (!grp_list.contains (sup_list.sids[i]))
 	  grp_list +=3D sup_list.sids[i];
     }
+  if (!grp_list.contains (pgrpsid))
+    grp_list +=3D pgrpsid;
+  else * special_pgrp =3D FALSE;
   return TRUE;
 }

@@ -663,38 +670,56 @@
   return privs;
 }

-#define token_acl_size (sizeof (ACL) + \
-			2 * (sizeof (ACCESS_ALLOWED_ACE) + MAX_SID_LEN))
-
-static BOOL
-get_dacl (PACL acl, cygsid usersid, cygsidlist &grp_list)
+BOOL
+verify_token (HANDLE token, cygsid &usersid, cygsid &pgrpsid, BOOL * pinte=
rn)
 {
-  if (!InitializeAcl(acl, token_acl_size, ACL_REVISION))
-    {
-      __seterrno ();
-      return FALSE;
-    }
-  if (grp_list.contains (well_known_admins_sid))
-    {
-      if (!AddAccessAllowedAce(acl, ACL_REVISION, GENERIC_ALL,
-			       well_known_admins_sid))
-	{
-	  __seterrno ();
-	  return FALSE;
-	}
-    }
-  else if (!AddAccessAllowedAce(acl, ACL_REVISION, GENERIC_ALL, usersid))
-    {
-      __seterrno ();
-      return FALSE;
-    }
-  if (!AddAccessAllowedAce(acl, ACL_REVISION, GENERIC_ALL,
-			   well_known_system_sid))
+  DWORD size;
+  BOOL intern =3D FALSE;
+
+  if (pintern)
     {
-      __seterrno ();
-      return FALSE;
+      TOKEN_SOURCE ts;
+      if (!GetTokenInformation (cygheap->user.token, TokenSource,
+				&ts, sizeof ts, &size))
+	debug_printf ("GetTokenInformation(): %E");
+      else *pintern =3D intern =3D !memcmp (ts.SourceName, "Cygwin.1", 8);
+    }
+  /* Verify usersid */
+  cygsid tok_usersid =3D NO_SID;
+  if (!GetTokenInformation (token, TokenUser,
+			    &tok_usersid, sizeof tok_usersid, &size))
+      debug_printf ("GetTokenInformation(): %E");
+  if (usersid !=3D tok_usersid) return FALSE;
+
+  /* In an internal token, if the sd group is not well_known_null_sid,
+     it must match pgrpsid */
+  if (intern)
+    {
+       char sd_buf[MAX_SID_LEN + sizeof (SECURITY_DESCRIPTOR)];
+       PSID gsid =3D NO_SID;
+       if (!GetKernelObjectSecurity(token, GROUP_SECURITY_INFORMATION,
+				    (PSECURITY_DESCRIPTOR) sd_buf,
+				    sizeof sd_buf, &size))
+	   debug_printf ("GetKernelObjectSecurity(): %E");
+       else if (!GetSecurityDescriptorGroup((PSECURITY_DESCRIPTOR) sd_buf,
+					    &gsid, (BOOL *) &size))
+	   debug_printf ("GetSecurityDescriptorGroup(): %E");
+       if (well_known_null_sid !=3D gsid) return pgrpsid =3D=3D gsid;
     }
-  return TRUE;
+  /* See if the pgrpsid is in the token groups */
+  PTOKEN_GROUPS my_grps =3D NULL;
+  BOOL ret =3D FALSE;
+
+  if (!GetTokenInformation (token, TokenGroups, NULL, 0, &size) &&
+	  GetLastError () !=3D ERROR_INSUFFICIENT_BUFFER)
+	debug_printf ("GetTokenInformation(token, TokenGroups): %E\n");
+  else if (!(my_grps =3D (PTOKEN_GROUPS) malloc (size)))
+	debug_printf ("malloc (my_grps) failed.");
+  else if (!GetTokenInformation (token, TokenGroups, my_grps, size, &size))
+	debug_printf ("GetTokenInformation(my_token, TokenGroups): %E\n");
+  else 	ret =3D sid_in_token_groups (my_grps, pgrpsid);
+  if (my_grps) free (my_grps);
+  return ret;
 }

 HANDLE
@@ -711,6 +736,8 @@
     { sizeof sqos, SecurityImpersonation, SECURITY_STATIC_TRACKING, FALSE =
};
   OBJECT_ATTRIBUTES oa =3D
     { sizeof oa, 0, 0, 0, 0, &sqos };
+  PSECURITY_ATTRIBUTES psa;
+  BOOL special_pgrp;
   char sa_buf[1024];
   LUID auth_luid =3D SYSTEM_LUID;
   LARGE_INTEGER exp =3D { QuadPart:0x7fffffffffffffffLL  };
@@ -720,7 +747,7 @@
   PTOKEN_PRIVILEGES privs =3D NULL;
   TOKEN_OWNER owner;
   TOKEN_PRIMARY_GROUP pgrp;
-  char acl_buf[token_acl_size];
+  char acl_buf[MAX_DACL_LEN(5)];
   TOKEN_DEFAULT_DACL dacl;
   TOKEN_SOURCE source;
   TOKEN_STATISTICS stats;
@@ -786,7 +813,7 @@
   /* Create list of groups, the user is member in. */
   int auth_pos;
   if (!get_group_sidlist (logonserver, grpsids, usersid, pgrpsid,
-			  my_grps, auth_luid, auth_pos))
+			  my_grps, auth_luid, auth_pos, &special_pgrp))
     goto out;

   /* Primary group. */
@@ -811,7 +838,8 @@
     goto out;

   /* Create default dacl. */
-  if (!get_dacl ((PACL) acl_buf, usersid, grpsids))
+  if (!sec_acl((PACL) acl_buf, FALSE,
+		grpsids.contains (well_known_admins_sid)?well_known_admins_sid:usersid))
     goto out;
   dacl.DefaultDacl =3D (PACL) acl_buf;

@@ -826,11 +854,22 @@
       __seterrno ();
       debug_printf ("Loading NtCreateToken failed.");
     }
-
-  /* Convert to primary token. */
-  if (!DuplicateTokenEx (token, MAXIMUM_ALLOWED, sec_user (sa_buf, usersid=
),
-			 SecurityImpersonation, TokenPrimary, &primary_token))
-    __seterrno ();
+  else
+    {
+      /* Set security descriptor and primary group */
+      psa =3D sec_user (sa_buf, usersid);
+      if (!SetSecurityDescriptorGroup (
+                   (PSECURITY_DESCRIPTOR) psa->lpSecurityDescriptor,
+                   special_pgrp?pgrpsid:well_known_null_sid, FALSE))
+          debug_printf ("SetSecurityDescriptorGroup %E");
+      /* Convert to primary token. */
+      if (!DuplicateTokenEx (token, MAXIMUM_ALLOWED, psa,
+                             SecurityImpersonation, TokenPrimary, &primary=
_token))
+        {
+          __seterrno ();
+          debug_printf ("DuplicateTokenEx %E");
+        }
+    }

 out:
   if (old_priv_state >=3D 0)

--=====================_1021441898==_--
