Return-Path: <cygwin-patches-return-2725-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5192 invoked by alias); 26 Jul 2002 04:07:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5170 invoked from network); 26 Jul 2002 04:07:40 -0000
Message-Id: <3.0.5.32.20020726000410.00813de0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 25 Jul 2002 21:07:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: setgroups
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1027670650==_"
X-SW-Source: 2002-q3/txt/msg00173.txt.bz2

--=====================_1027670650==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1481

Corinna,

Here is setgroups.
I still need to declare it in an .h file.
Should it be in src/newlib/libc/include/sys/unistd.h ?

Note the update of cygwin.din

Pierre
  
2002-07-25 Pierre Humblet <Pierre.Humblet@ieee.org>

	* cygheap.h (class cygheap_user): Add member gsids and methods
	gsids_set, gsids_alloc, gsids_free, gsids_update and issetgroups.
	* cygheap.cc (cygheap_user::gsids_set): New.
	(cygheap_user::gsids_alloc): New.
	(cygheap_user::gsids_free): New.
	(cygheap_user::gsids_update): New.
	* security.h (class cygsidarray): Create.
	(class cygsidlist): Add member maxcount and use it in method add.
	Change argument of methods add and contains to PSID. 
	Add operator+= (const PSID psid).
	Update declarations of verify_token and create_token.
	* security.cc * (get_token_group_sidlist): Create from get_group_sidlist.
	(get_initgroups_sidlist): Create from get_group_sidlist.
	(get_group_sidlist): Suppress.
	(get_setgroups_sidlist): Create.
	(verify_token): Modify arguments. Add setgroups case.
	(create_token): Modify arguments. Call get_initgroups_sidlist and
	get_setgroups_sidlist as needed. Set SE_GROUP_LOGON_ID from auth_pos
	outside of the loop. Rename the four group sid lists uniformly.
	* syscalls.cc (seteuid32): Modify to use cygheap->user.gsids.
	(setegid32): Update cygheap->user.gsids.
	* grp.cc (setgroups): New.
	(setgroups32): New.
	* uinfo.cc (internal_getlogin): Initialize and update user.gsids.
	* cygwin.din: Add setgroups and setgroups32.

--=====================_1027670650==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="setgroups.diff"
Content-length: 25746

diff -u cygwin.orig/cygheap.cc cygwin/cygheap.cc
--- cygwin.orig/cygheap.cc	2002-07-25 22:40:50.000000000 -0400
+++ cygwin/cygheap.cc	2002-07-24 21:21:20.000000000 -0400
@@ -491,3 +491,51 @@
     }
   return FALSE;
 }
+
+BOOL
+cygheap_user::gsids_set (PSID pgpsid)
+{
+  if (gsids =3D=3D NULL)
+    {
+      gsids =3D (cygsidarray *) cmalloc (HEAP_STR, gsids->size (0));
+      if (gsids !=3D NULL)
+        {
+	  gsids->suppcount =3D -1;
+	  gsids->sids[0] =3D pgpsid;
+	  return TRUE;
+	}
+    }
+  return FALSE;
+}
+
+BOOL
+cygheap_user::gsids_alloc (cygsidarray * & gsids, int scount)
+    {
+      gsids =3D (cygsidarray *) cmalloc (HEAP_STR,
+				       gsids->size (scount));
+      if (gsids !=3D NULL)
+        {
+	  gsids->suppcount =3D 0;
+	  return TRUE;
+	}
+      return FALSE;
+    }
+void
+cygheap_user::gsids_free (cygsidarray * gsids)
+{
+  return cfree (gsids);
+}
+BOOL
+cygheap_user::gsids_update (cygsidarray * newgsids)
+{
+  if (gsids)
+    {
+      newgsids->sids[0] =3D gsids->sids[0];
+      cfree (gsids);
+      gsids =3D newgsids;
+      return TRUE;
+    }
+  return FALSE;
+}
+
+
diff -u cygwin.orig/cygheap.h cygwin/cygheap.h
--- cygwin.orig/cygheap.h	2002-07-25 22:40:50.000000000 -0400
+++ cygwin/cygheap.h	2002-07-25 22:54:48.000000000 -0400
@@ -113,6 +113,7 @@
   __gid32_t orig_gid;      /* Ditto */
   __uid32_t real_uid;      /* Remains intact on seteuid, replaced by setui=
d */
   __gid32_t real_gid;      /* Ditto */
+  cygsidarray *gsids;      /* buffer for primary and supp SIDs */

   /* token is needed if set(e)uid should be called. It can be set by a call
      to `set_impersonation_token()'. */
@@ -141,6 +142,11 @@
   const char *env_userprofile (const char *, size_t);
   const char *env_domain (const char *, size_t);
   const char *env_name (const char *, size_t);
+  BOOL gsids_set (PSID pgsid);
+  BOOL gsids_alloc (cygsidarray * & gsids, int scount);
+  void gsids_free (cygsidarray *gsids);
+  BOOL gsids_update (cygsidarray *newgsids);
+  BOOL issetgroups () const { return gsids && gsids->issetgroups (); }

   const char *logsrv ()
   {
diff -u cygwin.orig/cygwin.din cygwin/cygwin.din
--- cygwin.orig/cygwin.din	2002-07-25 22:40:50.000000000 -0400
+++ cygwin/cygwin.din	2002-07-25 22:49:08.000000000 -0400
@@ -678,6 +678,9 @@
 setgid
 _setgid =3D setgid
 setgid32
+setgroups
+_setgroups =3D setgroups
+setgroups32
 setjmp
 _setjmp =3D setjmp
 setlocale
diff -u cygwin.orig/grp.cc cygwin/grp.cc
--- cygwin.orig/grp.cc	2002-07-25 22:40:50.000000000 -0400
+++ cygwin/grp.cc	2002-07-25 22:41:34.000000000 -0400
@@ -457,3 +457,64 @@
 {
   return 0;
 }
+
+/* setgroups32: standards? */
+extern "C"
+int
+setgroups32 (int ngroups, const __gid32_t *grouplist)
+{
+  if (ngroups < 0 || (ngroups > 0 && !grouplist))
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  if (!wincap.has_security ())
+    return 0;
+
+  cygsidarray * gsids;
+  struct __group32 *gr;
+
+  if (!cygheap->user.gsids_alloc(gsids, ngroups))
+    return -1;
+
+  for (int gidx =3D 0; gidx < ngroups; ++gidx)
+    {
+      for (int gidy =3D 0; gidy < gidx; gidy++)
+	if (grouplist[gidy] =3D=3D grouplist[gidx])
+	  goto found; /* Duplicate */
+      for (int gidy =3D 0; (gr =3D internal_getgrent (gidy)); ++gidy)
+	if (gr->gr_gid =3D=3D (__gid32_t) grouplist[gidx])
+	  {
+	    if (gsids->addsuppfromgr (gr))
+	      goto found;
+	    break;
+	  }
+      debug_printf ("No sid found for gid %d", grouplist[gidx]);
+      cygheap->user.gsids_free(gsids);
+      set_errno (EINVAL);
+      return -1;
+    found:
+      continue;
+    }
+  cygheap->user.gsids_update(gsids);
+  return 0;
+}
+
+extern "C"
+int
+setgroups (int ngroups, const __gid16_t *grouplist)
+{
+  __gid32_t *grouplist32 =3D NULL;
+
+  if (ngroups > 0 && grouplist)
+    {
+      grouplist32 =3D (__gid32_t *) alloca (ngroups * sizeof (__gid32_t));
+      if (grouplist32 =3D=3D NULL)
+	return -1;
+      for (int i =3D 0; i < ngroups; i++)
+        grouplist32[i] =3D grouplist[i];
+    }
+  return setgroups32 (ngroups, grouplist32);
+
+}
diff -u cygwin.orig/security.cc cygwin/security.cc
--- cygwin.orig/security.cc	2002-07-25 22:40:50.000000000 -0400
+++ cygwin/security.cc	2002-07-25 23:14:12.000000000 -0400
@@ -473,57 +473,63 @@
     }
 }

-static BOOL
-get_group_sidlist (cygsidlist &grp_list,
-		   cygsid &usersid, cygsid &pgrpsid, struct passwd *pw,
-		   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos,
-		   BOOL *special_pgrp)
-{
-  char user[UNLEN + 1];
-  char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-  WCHAR wserver[INTERNET_MAX_HOST_NAME_LENGTH + 3];
-  char server[INTERNET_MAX_HOST_NAME_LENGTH + 3];
-  cygsidlist sup_list;
-
+static void
+get_token_group_sidlist(cygsidlist &grp_list, PTOKEN_GROUPS my_grps,
+			LUID auth_luid, int &auth_pos)
+{
   auth_pos =3D -1;
+  if (my_grps)
+    {
+      if (sid_in_token_groups (my_grps, well_known_local_sid))
+	grp_list +=3D well_known_local_sid;
+      if (sid_in_token_groups (my_grps, well_known_dialup_sid))
+	grp_list +=3D well_known_dialup_sid;
+      if (sid_in_token_groups (my_grps, well_known_network_sid))
+	grp_list +=3D well_known_network_sid;
+      if (sid_in_token_groups (my_grps, well_known_batch_sid))
+	grp_list +=3D well_known_batch_sid;
+      if (sid_in_token_groups (my_grps, well_known_interactive_sid))
+	grp_list +=3D well_known_interactive_sid;
+      if (sid_in_token_groups (my_grps, well_known_service_sid))
+	grp_list +=3D well_known_service_sid;
+    }
+  else
+    {
+      grp_list +=3D well_known_local_sid;
+      grp_list +=3D well_known_interactive_sid;
+    }
+  if (auth_luid.QuadPart !=3D 999) /* !=3D SYSTEM_LUID */
+    {
+      char buf[64];
+      __small_sprintf (buf, "S-1-5-5-%u-%u", auth_luid.HighPart,
+		       auth_luid.LowPart);
+      grp_list +=3D buf;
+      auth_pos =3D grp_list.count - 1;
+    }
+}

+static BOOL
+get_initgroups_sidlist (cygsidlist &grp_list,
+			PSID usersid, PSID pgrpsid, struct passwd *pw,
+			PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos,
+			BOOL &special_pgrp)
+{
   grp_list +=3D well_known_world_sid;
   grp_list +=3D well_known_authenticated_users_sid;
   if (usersid =3D=3D well_known_system_sid)
     {
+      auth_pos =3D -1;
       grp_list +=3D well_known_admins_sid;
       get_unix_group_sidlist (pw, grp_list);
     }
   else
     {
-      if (my_grps)
-	{
-	  if (sid_in_token_groups (my_grps, well_known_local_sid))
-	    grp_list +=3D well_known_local_sid;
-	  if (sid_in_token_groups (my_grps, well_known_dialup_sid))
-	    grp_list +=3D well_known_dialup_sid;
-	  if (sid_in_token_groups (my_grps, well_known_network_sid))
-	    grp_list +=3D well_known_network_sid;
-	  if (sid_in_token_groups (my_grps, well_known_batch_sid))
-	    grp_list +=3D well_known_batch_sid;
-	  if (sid_in_token_groups (my_grps, well_known_interactive_sid))
-	    grp_list +=3D well_known_interactive_sid;
-	  if (sid_in_token_groups (my_grps, well_known_service_sid))
-	    grp_list +=3D well_known_service_sid;
-	}
-      else
-	{
-	  grp_list +=3D well_known_local_sid;
-	  grp_list +=3D well_known_interactive_sid;
-	}
-      if (auth_luid.QuadPart !=3D 999) /* !=3D SYSTEM_LUID */
-	{
-	  char buf[64];
-	  __small_sprintf (buf, "S-1-5-5-%u-%u", auth_luid.HighPart,
-						 auth_luid.LowPart);
-	  grp_list +=3D buf;
-	  auth_pos =3D grp_list.count - 1;
-	}
+      char user[UNLEN + 1];
+      char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
+      WCHAR wserver[INTERNET_MAX_HOST_NAME_LENGTH + 3];
+      char server[INTERNET_MAX_HOST_NAME_LENGTH + 3];
+
+      get_token_group_sidlist(grp_list, my_grps, auth_luid, auth_pos);
       extract_nt_dom_user (pw, domain, user);
       if (get_logon_server (domain, server, wserver))
 	get_user_groups (wserver, grp_list, user, domain);
@@ -531,16 +537,26 @@
       if (!get_user_local_groups (grp_list, usersid))
 	return FALSE;
     }
-  /* special_pgrp true if pgrpsid is not null and not in normal groups */
-  *special_pgrp =3D FALSE;
-  if (pgrpsid && !grp_list.contains (pgrpsid))
-    {
-       *special_pgrp =3D TRUE;
-       grp_list +=3D pgrpsid;
-    }
+  /* special_pgrp true if pgrpsid is not in normal groups */
+  if ((special_pgrp =3D !grp_list.contains (pgrpsid)))
+    grp_list +=3D pgrpsid;
   return TRUE;
 }

+static void
+get_setgroups_sidlist(cygsidlist &grp_list, PTOKEN_GROUPS my_grps,
+		      cygsidarray &gsids, LUID auth_luid, int &auth_pos)
+{
+  PSID pgpsid =3D gsids.pgpsid ();
+  grp_list +=3D well_known_world_sid;
+  grp_list +=3D well_known_authenticated_users_sid;
+  get_token_group_sidlist(grp_list, my_grps, auth_luid, auth_pos);
+  for (int gidx =3D 1; gidx <=3D gsids.suppcount; gidx++)
+    grp_list +=3D gsids.sids[gidx];
+  if (gsids.position (1, pgpsid) < 0)
+    grp_list +=3D pgpsid;
+}
+
 static const char *sys_privs[] =3D {
   SE_TCB_NAME,
   SE_ASSIGNPRIMARYTOKEN_NAME,
@@ -654,8 +670,21 @@
   return privs;
 }

+/* Accept a token if
+   - the requested usersid matches the TokenUser and
+   - if setgroups has been called:
+        the token groups that are listed in /etc/group match the union of
+	the requested primary and supplementary groups in gsids.
+   - else the (unknown) implicitly requested supplementary groups and those
+        in the token are the groups associated with the usersid. We assume
+	they match and verify only the primary groups.
+	The requested primary group must appear in the token.
+	The primary group in the token is a group associated with the usersid,
+	except if the token is internal and the group is in the token SD
+	(see create_token). In that latter case that group must match the
+	requested primary group.  */
 BOOL
-verify_token (HANDLE token, cygsid &usersid, cygsid &pgrpsid, BOOL *pinter=
n)
+verify_token (HANDLE token, cygsid &usersid, cygsidarray &gsids, BOOL * pi=
ntern)
 {
   DWORD size;
   BOOL intern =3D FALSE;
@@ -675,9 +704,9 @@
       debug_printf ("GetTokenInformation(): %E");
   if (usersid !=3D tok_usersid) return FALSE;

-  /* In an internal token, if the sd group is not well_known_null_sid,
-     it must match pgrpsid */
-  if (intern)
+  /* For an internal token, if setgroups was not called and if the sd group
+     is not well_known_null_sid, it must match pgrpsid */
+  if (intern && !gsids.issetgroups ())
     {
        char sd_buf[MAX_SID_LEN + sizeof (SECURITY_DESCRIPTOR)];
        PSID gsid =3D NO_SID;
@@ -688,14 +717,14 @@
        else if (!GetSecurityDescriptorGroup ((PSECURITY_DESCRIPTOR) sd_buf,
 					    &gsid, (BOOL *) &size))
 	   debug_printf ("GetSecurityDescriptorGroup(): %E");
-       if (well_known_null_sid !=3D gsid) return pgrpsid =3D=3D gsid;
+       if (well_known_null_sid !=3D gsid) return gsid =3D=3D gsids.pgpsid =
();
     }
-  /* See if the pgrpsid is the tok_usersid in the token groups */
+
   PTOKEN_GROUPS my_grps =3D NULL;
   BOOL ret =3D FALSE;
-
-  if ( pgrpsid =3D=3D tok_usersid)
-    return TRUE;
+  char saw_buf[NGROUPS_MAX + 1] =3D {};
+  char *saw =3D saw_buf;
+
   if (!GetTokenInformation (token, TokenGroups, NULL, 0, &size) &&
       GetLastError () !=3D ERROR_INSUFFICIENT_BUFFER)
     debug_printf ("GetTokenInformation(token, TokenGroups): %E\n");
@@ -703,34 +732,63 @@
     debug_printf ("malloc (my_grps) failed.");
   else if (!GetTokenInformation (token, TokenGroups, my_grps, size, &size))
     debug_printf ("GetTokenInformation(my_token, TokenGroups): %E\n");
-  else
-    ret =3D sid_in_token_groups (my_grps, pgrpsid);
-  if (my_grps)
-    free (my_grps);
+  else if (!gsids.issetgroups ()) /* setgroups was never called */
+    {
+      ret =3D sid_in_token_groups (my_grps, *(gsids.pgcygsidptr ()));
+      if (ret =3D=3D FALSE) ret =3D (gsids.pgpsid () =3D=3D tok_usersid);
+    }
+  else /* setgroups was called */
+    {
+      struct __group32 *gr;
+      cygsid gsid;
+      if (gsids.suppcount + 1 > (int) sizeof (saw_buf) &&
+	  !(saw =3D (char *) calloc (gsids.suppcount + 1, sizeof(char))))
+	goto done;
+
+      /* See if the pgid is also a supplementary group */
+      int first =3D (gsids.position (1, gsids.pgpsid ()) >=3D 0)?1:0;
+
+      /* token groups found in /etc/group match the user.gsids ? */
+      for (int gidx =3D 0; (gr =3D internal_getgrent (gidx)); ++gidx)
+	if (gsid.getfromgr (gr) && sid_in_token_groups (my_grps, gsid))
+	  {
+	    int pos =3D gsids.position (first, gsid);
+	    if (pos < 0)
+	      goto done;
+	    saw[pos] =3D TRUE;
+          }
+      for (int gidx =3D first; gidx <=3D gsids.suppcount; gidx++)
+        if (!saw[gidx])
+	  goto done;
+      ret =3D TRUE;
+    }
+ done:
+  if (my_grps) free (my_grps);
+  if (saw !=3D saw_buf) free(saw);
   return ret;
 }

 HANDLE
-create_token (cygsid &usersid, cygsid &pgrpsid, struct passwd *pw)
+create_token (cygsid &usersid, cygsidarray &new_gsids, struct passwd *pw)
 {
   NTSTATUS ret;
   LSA_HANDLE lsa =3D INVALID_HANDLE_VALUE;
   int old_priv_state;

-  cygsidlist grpsids;
+  cygsidlist tmp_gsids;

   SECURITY_QUALITY_OF_SERVICE sqos =3D
     { sizeof sqos, SecurityImpersonation, SECURITY_STATIC_TRACKING, FALSE =
};
   OBJECT_ATTRIBUTES oa =3D
     { sizeof oa, 0, 0, 0, 0, &sqos };
   PSECURITY_ATTRIBUTES psa;
-  BOOL special_pgrp;
+  BOOL special_pgrp =3D FALSE;
   char sa_buf[1024];
   LUID auth_luid =3D SYSTEM_LUID;
   LARGE_INTEGER exp =3D { QuadPart:0x7fffffffffffffffLL  };

   TOKEN_USER user;
-  PTOKEN_GROUPS grps =3D NULL;
+  PTOKEN_GROUPS new_tok_gsids =3D NULL;
   PTOKEN_PRIVILEGES privs =3D NULL;
   TOKEN_OWNER owner;
   TOKEN_PRIMARY_GROUP pgrp;
@@ -746,7 +804,7 @@
   HANDLE primary_token =3D INVALID_HANDLE_VALUE;

   HANDLE my_token =3D INVALID_HANDLE_VALUE;
-  PTOKEN_GROUPS my_grps =3D NULL;
+  PTOKEN_GROUPS my_tok_gsids =3D NULL;
   DWORD size;

   /* SE_CREATE_TOKEN_NAME privilege needed to call NtCreateToken. */
@@ -781,54 +839,56 @@
       if (!GetTokenInformation (my_token, TokenGroups, NULL, 0, &size) &&
 	  GetLastError () !=3D ERROR_INSUFFICIENT_BUFFER)
 	debug_printf ("GetTokenInformation(my_token, TokenGroups): %E\n");
-      else if (!(my_grps =3D (PTOKEN_GROUPS) malloc (size)))
-	debug_printf ("malloc (my_grps) failed.");
-      else if (!GetTokenInformation (my_token, TokenGroups, my_grps,
+      else if (!(my_tok_gsids =3D (PTOKEN_GROUPS) malloc (size)))
+	debug_printf ("malloc (my_tok_gsids) failed.");
+      else if (!GetTokenInformation (my_token, TokenGroups, my_tok_gsids,
 				     size, &size))
 	{
 	  debug_printf ("GetTokenInformation(my_token, TokenGroups): %E\n");
-	  free (my_grps);
-	  my_grps =3D NULL;
+	  free (my_tok_gsids);
+	  my_tok_gsids =3D NULL;
 	}
       CloseHandle (my_token);
     }

   /* Create list of groups, the user is member in. */
   int auth_pos;
-  if (!get_group_sidlist (grpsids, usersid, pgrpsid, pw,
-			  my_grps, auth_luid, auth_pos, &special_pgrp))
+  if (new_gsids.issetgroups ())
+    get_setgroups_sidlist (tmp_gsids, my_tok_gsids, new_gsids, auth_luid, =
auth_pos);
+  else if (!get_initgroups_sidlist (tmp_gsids, usersid, new_gsids.pgpsid (=
), pw,
+				    my_tok_gsids, auth_luid, auth_pos, special_pgrp))
     goto out;

   /* Primary group. */
-  pgrp.PrimaryGroup =3D pgrpsid;
+  pgrp.PrimaryGroup =3D new_gsids.pgpsid ();

   /* Create a TOKEN_GROUPS list from the above retrieved list of sids. */
-  char grps_buf[sizeof (ULONG) + grpsids.count * sizeof (SID_AND_ATTRIBUTE=
S)];
-  grps =3D (PTOKEN_GROUPS) grps_buf;
-  grps->GroupCount =3D grpsids.count;
-  for (DWORD i =3D 0; i < grps->GroupCount; ++i)
+  char grps_buf[sizeof (ULONG) + tmp_gsids.count * sizeof (SID_AND_ATTRIBU=
TES)];
+  new_tok_gsids =3D (PTOKEN_GROUPS) grps_buf;
+  new_tok_gsids->GroupCount =3D tmp_gsids.count;
+  for (DWORD i =3D 0; i < new_tok_gsids->GroupCount; ++i)
     {
-      grps->Groups[i].Sid =3D grpsids.sids[i];
-      grps->Groups[i].Attributes =3D SE_GROUP_MANDATORY |
+      new_tok_gsids->Groups[i].Sid =3D tmp_gsids.sids[i];
+      new_tok_gsids->Groups[i].Attributes =3D SE_GROUP_MANDATORY |
 				   SE_GROUP_ENABLED_BY_DEFAULT |
 				   SE_GROUP_ENABLED;
-      if (auth_pos >=3D 0 && i =3D=3D (DWORD) auth_pos)
-	grps->Groups[i].Attributes |=3D SE_GROUP_LOGON_ID;
     }
+  if (auth_pos > 0)
+    new_tok_gsids->Groups[auth_pos].Attributes |=3D SE_GROUP_LOGON_ID;

   /* Retrieve list of privileges of that user. */
-  if (!(privs =3D get_priv_list (lsa, usersid, grpsids)))
+  if (!(privs =3D get_priv_list (lsa, usersid, tmp_gsids)))
     goto out;

   /* Create default dacl. */
   if (!sec_acl ((PACL) acl_buf, FALSE,
-		grpsids.contains (well_known_admins_sid)?well_known_admins_sid:usersid))
+		tmp_gsids.contains (well_known_admins_sid)?well_known_admins_sid:usersid=
))
     goto out;
   dacl.DefaultDacl =3D (PACL) acl_buf;

   /* Let's be heroic... */
   ret =3D NtCreateToken (&token, TOKEN_ALL_ACCESS, &oa, TokenImpersonation,
-		       &auth_luid, &exp, &user, grps, privs, &owner, &pgrp,
+		       &auth_luid, &exp, &user, new_tok_gsids, privs, &owner, &pgrp,
 		       &dacl, &source);
   if (ret)
     __seterrno_from_win_error (RtlNtStatusToDosError (ret));
@@ -843,8 +903,8 @@
       psa =3D __sec_user (sa_buf, usersid, TRUE);
       if (psa->lpSecurityDescriptor &&
 	  !SetSecurityDescriptorGroup (
-	      (PSECURITY_DESCRIPTOR) psa->lpSecurityDescriptor,
-	      special_pgrp ? pgrpsid : well_known_null_sid, FALSE))
+	    (PSECURITY_DESCRIPTOR) psa->lpSecurityDescriptor,
+	    special_pgrp ? *(new_gsids.pgcygsidptr ()): well_known_null_sid, FALS=
E))
 	  debug_printf ("SetSecurityDescriptorGroup %E");
       /* Convert to primary token. */
       if (!DuplicateTokenEx (token, MAXIMUM_ALLOWED, psa,
@@ -862,8 +922,8 @@
     CloseHandle (token);
   if (privs)
     free (privs);
-  if (my_grps)
-    free (my_grps);
+  if (my_tok_gsids)
+    free (my_tok_gsids);
   close_local_policy (lsa);

   debug_printf ("%d =3D create_token ()", primary_token);
@@ -1828,3 +1888,4 @@
 			     myself->uid, myself->gid,
 			     attribute);
 }
+
diff -u cygwin.orig/security.h cygwin/security.h
--- cygwin.orig/security.h	2002-07-25 22:40:52.000000000 -0400
+++ cygwin/security.h	2002-07-25 22:37:24.000000000 -0400
@@ -87,33 +87,39 @@
 };

 class cygsidlist {
+  int maxcount;
 public:
   int count;
   cygsid *sids;

-  cygsidlist () : count (0), sids (NULL) {}
+  cygsidlist () : maxcount(12), count (0), sids (new cygsid [12]) {}
   ~cygsidlist () { delete [] sids; }

-  BOOL add (cygsid &nsi)
+  BOOL add (PSID nsi)
     {
-      cygsid *tmp =3D new cygsid [count + 1];
-      if (!tmp)
-	return FALSE;
-      for (int i =3D 0; i < count; ++i)
-	tmp[i] =3D sids[i];
-      delete [] sids;
-      sids =3D tmp;
+      if ( count >=3D maxcount)
+        {
+	  cygsid *tmp =3D new cygsid [ 2 * maxcount];
+	  if (!tmp)
+	    return FALSE;
+	  maxcount *=3D 2;
+	  for (int i =3D 0; i < count; ++i)
+	    tmp[i] =3D sids[i];
+	  delete [] sids;
+	  sids =3D tmp;
+	}
       sids[count++] =3D nsi;
       return TRUE;
     }
-  BOOL add (const PSID nsid) { return add (nsid); }
+  BOOL add (cygsid &nsi) { return add ((PSID) nsi); }
   BOOL add (const char *sidstr)
     { cygsid nsi (sidstr); return add (nsi); }

   BOOL operator+=3D (cygsid &si) { return add (si); }
   BOOL operator+=3D (const char *sidstr) { return add (sidstr); }
+  BOOL operator+=3D (const PSID psid) { return add (psid); }

-  BOOL contains (cygsid &sid) const
+  BOOL contains (PSID sid) const
     {
       for (int i =3D 0; i < count; ++i)
 	if (sids[i] =3D=3D sid)
@@ -131,6 +137,34 @@
     }
 };

+class cygsidarray {
+public:
+  int suppcount;
+  cygsid sids[];
+
+  int size (int suppcount) const
+    { return sizeof(int) + (suppcount + 1) * sizeof(cygsid); }
+  BOOL addsuppfromgr(const struct __group32 *gr)
+    {
+      if (sids[1 + suppcount].getfromgr(gr))
+        {
+	  suppcount++;
+	  return TRUE;
+	}
+      return FALSE;
+    }
+  int position (int from, PSID psid) const
+    {
+      for (int i =3D from; i <=3D suppcount; ++i)
+	if (sids[i] =3D=3D psid)
+	  return i;
+      return -1;
+    }
+  BOOL issetgroups () const { return (suppcount >=3D 0); }
+  PSID pgpsid () { return (PSID) sids[0]; }
+  cygsid * pgcygsidptr () { return &sids[0]; }
+};
+
 extern cygsid well_known_null_sid;
 extern cygsid well_known_world_sid;
 extern cygsid well_known_local_sid;
@@ -180,9 +214,9 @@
 /* Try a subauthentication. */
 HANDLE subauth (struct passwd *pw);
 /* Try creating a token directly. */
-HANDLE create_token (cygsid &usersid, cygsid &pgrpsid, struct passwd * pw);
+HANDLE create_token (cygsid &usersid, cygsidarray &gsids, struct passwd * =
pw);
 /* Verify an existing token */
-BOOL verify_token (HANDLE token, cygsid &usersid, cygsid &pgrpsid, BOOL * =
pintern =3D NULL);
+BOOL verify_token (HANDLE token, cygsid &usersid, cygsidarray &gsids, BOOL=
 * pintern =3D NULL);

 /* Extract U-domain\user field from passwd entry. */
 void extract_nt_dom_user (const struct passwd *pw, char *domain, char *use=
r);
diff -u cygwin.orig/syscalls.cc cygwin/syscalls.cc
--- cygwin.orig/syscalls.cc	2002-07-25 22:40:52.000000000 -0400
+++ cygwin/syscalls.cc	2002-07-24 21:37:18.000000000 -0400
@@ -1960,6 +1960,7 @@

   if (!wincap.has_security ()
       || (!cygheap->user.issetuid ()
+	  && !cygheap->user.issetgroups ()
 	  && uid =3D=3D myself->uid
 	  && myself->gid =3D=3D cygheap->user.orig_gid)
       || uid =3D=3D ILLEGAL_UID)
@@ -1969,7 +1970,8 @@
     }

   sigframe thisframe (mainthread);
-  cygsid usersid, pgrpsid;
+  cygsid usersid;
+  cygsidarray *gsids =3D cygheap->user.gsids;
   HANDLE ptok, sav_token;
   BOOL sav_impersonated, sav_token_is_internal_token;
   BOOL process_ok, explicitly_created_token =3D FALSE;
@@ -1977,8 +1979,7 @@
   PSID origpsid, psid2 =3D NO_SID;

   pw_new =3D getpwuid32 (uid);
-  if (!usersid.getfrompw (pw_new) ||
-      (!pgrpsid.getfromgr (getgrgid32 (myself->gid))))
+  if (!usersid.getfrompw (pw_new) || !gsids)
     {
       set_errno (EINVAL);
       return -1;
@@ -1996,7 +1997,7 @@
   /* Verify if the process token is suitable.
      Currently we do not try to differentiate between
 	 internal tokens and others */
-  process_ok =3D verify_token (ptok, usersid, pgrpsid);
+  process_ok =3D verify_token (ptok, usersid, *gsids);
   debug_printf("Process token %sverified", process_ok ? "" : "not ");
   if (process_ok)
     {
@@ -2012,7 +2013,7 @@
   if (!process_ok && cygheap->user.token !=3D INVALID_HANDLE_VALUE)
     {
       /* Verify if the current tokem is suitable */
-      BOOL token_ok =3D verify_token (cygheap->user.token, usersid, pgrpsi=
d,
+      BOOL token_ok =3D verify_token (cygheap->user.token, usersid, *gsids,
 				    & sav_token_is_internal_token);
       debug_printf("Thread token %d %sverified",
 		   cygheap->user.token, token_ok?"":"not ");
@@ -2049,7 +2050,7 @@
     {
       /* If no impersonation token is available, try to
 	 authenticate using NtCreateToken() or subauthentication. */
-      cygheap->user.token =3D create_token (usersid, pgrpsid, pw_new);
+      cygheap->user.token =3D create_token (usersid, *gsids, pw_new);
       if (cygheap->user.token !=3D INVALID_HANDLE_VALUE)
 	explicitly_created_token =3D TRUE;
       else
@@ -2077,7 +2078,7 @@
 	  /* Try setting primary group in token to current group */
 	  if (!SetTokenInformation (cygheap->user.token,
 				    TokenPrimaryGroup,
-				    &pgrpsid, sizeof pgrpsid))
+				    gsids->pgcygsidptr (), sizeof(cygsid)))
 	    debug_printf ("SetTokenInformation(user.token, "
 			  "TokenPrimaryGroup): %E");
 	}
@@ -2143,17 +2144,19 @@
     return 0;

   sigframe thisframe (mainthread);
+  cygsidarray *gsids =3D cygheap->user.gsids;
   cygsid gsid;
   HANDLE ptok;

   struct __group32 * gr =3D getgrgid32 (gid);
-  if (!gr || gr->gr_gid !=3D gid || !gsid.getfromgr (gr))
+  if (!gr || gr->gr_gid !=3D gid || !gsid.getfromgr (gr) || !gsids)
     {
       set_errno (EINVAL);
       return -1;
     }
   myself->gid =3D gid;

+  *(gsids->pgcygsidptr ()) =3D gsid;
   /* If impersonated, update primary group and revert */
   if (cygheap->user.issetuid ())
     {
diff -u cygwin.orig/uinfo.cc cygwin/uinfo.cc
--- cygwin.orig/uinfo.cc	2002-07-25 22:40:54.000000000 -0400
+++ cygwin/uinfo.cc	2002-07-24 21:38:46.000000000 -0400
@@ -39,7 +39,7 @@
     {
       HANDLE ptok =3D INVALID_HANDLE_VALUE;
       DWORD siz;
-      cygsid tu;
+      cygsid tu, tpg;
       DWORD ret =3D 0;

       /* Try to get the SID either from current process and
@@ -50,7 +50,11 @@
       else if (!GetTokenInformation (ptok, TokenUser, &tu, sizeof tu, &siz=
))
 	system_printf ("GetTokenInformation(): %E");
       else if (!(ret =3D user.set_sid (tu)))
-	system_printf ("Couldn't retrieve SID from access token!");
+	system_printf ("Couldn't retrieve user SID from access token!");
+      else if (!GetTokenInformation (ptok, TokenPrimaryGroup, &tpg, sizeof=
 tu, &siz))
+	system_printf ("GetTokenInformation(): %E");
+      else if (!(ret =3D user.gsids_set (tpg)))
+	system_printf ("Couldn't retrieve primary group SID from access token!");
        /* We must set the user name, uid and gid.
 	 If we have a SID, try to get the corresponding Cygwin
 	 password entry. Set user name which can be different
@@ -75,11 +79,14 @@
 	     primary group to the group in /etc/passwd. */
 	  if (!SetTokenInformation (ptok, TokenOwner, &tu, sizeof tu))
 	    debug_printf ("SetTokenInformation(TokenOwner): %E");
-	  if (gsid && !SetTokenInformation (ptok, TokenPrimaryGroup,
-					    &gsid, sizeof gsid))
-	    debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
+	  if (gsid)
+	    {
+	      *(user.gsids->pgcygsidptr ()) =3D gsid;
+	      if (!SetTokenInformation (ptok, TokenPrimaryGroup,
+					&gsid, sizeof gsid))
+		debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
+	    }
 	 }
-
       if (ptok !=3D INVALID_HANDLE_VALUE)
 	CloseHandle (ptok);
     }

--=====================_1027670650==_--
