Return-Path: <cygwin-patches-return-2663-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14672 invoked by alias); 19 Jul 2002 01:16:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14633 invoked from network); 19 Jul 2002 01:16:18 -0000
Message-Id: <3.0.5.32.20020718211250.0080a5e0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 18 Jul 2002 18:16:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Corinna or Pierre please comment? [jason@tishler.net: Re:
  setuid
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1027055570==_"
X-SW-Source: 2002-q3/txt/msg00111.txt.bz2

--=====================_1027055570==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 621

Corinna,

Here is the patch.

Pierre


2002-07-18  Pierre Humblet <pierre.humblet@ieee.org>

	* security.cc (get_unix_group_sidlist): Create.
	(get_supplementary_group_sidlist): Evolve into get_unix_group_sidlist.
	(get_user_local_groups): Add check for duplicates.
	(get_user_primary_group): Suppress.
	(get_group_sidlist): Silently ignore PDC unavailability. 
	Call get_unix_group_sidlist() before get_user_local_groups().
	Remove call to get_supplementary_group_sidlist(). Never call 
	get_user_primary_group() as the passwd group is always included.
 	Add well_known_authenticated_users_sid in only one statement.
	
	
--=====================_1027055570==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.cc.diff"
Content-length: 4692

--- security.cc.orig	2002-07-16 21:45:52.000000000 -0400
+++ security.cc	2002-07-18 20:27:58.000000000 -0400
@@ -389,17 +389,17 @@
 	if (!LookupAccountName (NULL, bgroup, gsid, &glen, domain, &dlen, &use))
 	  {
 	     if (GetLastError () !=3D ERROR_NONE_MAPPED)
-		 debug_printf ("LookupAccountName(%s): %E", bgroup);
+               debug_printf ("LookupAccountName(%s): %E", bgroup);
 	     strcpy (lgroup + llen, bgroup + blen);
 	     if (!LookupAccountName (NULL, lgroup, gsid, &glen,
 				     domain, &dlen, &use))
-		 debug_printf ("LookupAccountName(%s): %E", lgroup);
+               debug_printf ("LookupAccountName(%s): %E", lgroup);
 	  }
-	if (legal_sid_type (use))
+	if (!legal_sid_type (use))
+	  debug_printf ("Rejecting local %s. use: %d", bgroup + blen, use);
+	else if (!grp_list.contains (gsid))
 	  grp_list +=3D gsid;
-	else debug_printf ("Rejecting local %s. use: %d", bgroup + blen, use);
       }
-
   NetApiBufferFree (buf);
   return TRUE;
 }
@@ -415,6 +415,7 @@
   return FALSE;
 }

+#if 0 /* Unused */
 static BOOL
 get_user_primary_group (WCHAR *wlogonserver, const char *user,
 			PSID pusersid, cygsid &pgrpsid)
@@ -448,34 +449,33 @@
   NetApiBufferFree (buf);
   return retval;
 }
+#endif

-static int
-get_supplementary_group_sidlist (const char *username, cygsidlist &grp_lis=
t)
+static void
+get_unix_group_sidlist (struct passwd * pw, cygsidlist &grp_list)
 {
   struct __group32 *gr;
-  int cnt =3D 0;
+  cygsid gsid;

   for (int gidx =3D 0; (gr =3D internal_getgrent (gidx)); ++gidx)
     {
-      if (gr->gr_mem)
+      if (gr->gr_gid =3D=3D (__gid32_t) pw->pw_gid)
+	goto found;
+      else if (gr->gr_mem)
 	for (int gi =3D 0; gr->gr_mem[gi]; ++gi)
-	  if (strcasematch (username, gr->gr_mem[gi]))
-	    {
-	      if (gr->gr_passwd && *gr->gr_passwd)
-		{
-		  cygsid sid (gr->gr_passwd);
-		  if ((PSID)sid && grp_list.add (sid))
-		    ++cnt;
-		}
-	      break;
-	    }
+	  if (strcasematch (pw->pw_name, gr->gr_mem[gi]))
+	    goto found;
+      continue;
+    found:
+      if (gsid.getfromgr (gr) && !grp_list.contains (gsid))
+	grp_list +=3D gsid;
+
     }
-  return cnt;
 }

 static BOOL
 get_group_sidlist (cygsidlist &grp_list,
-		  cygsid &usersid, cygsid &pgrpsid, struct passwd * pw,
+		   cygsid &usersid, cygsid &pgrpsid, struct passwd * pw,
 		   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos,
 		   BOOL * special_pgrp)
 {
@@ -488,16 +488,14 @@
   auth_pos =3D -1;

   grp_list +=3D well_known_world_sid;
+  grp_list +=3D well_known_authenticated_users_sid;
   if (usersid =3D=3D well_known_system_sid)
     {
-      grp_list +=3D well_known_authenticated_users_sid;
       grp_list +=3D well_known_admins_sid;
+      get_unix_group_sidlist (pw, grp_list);
     }
   else
     {
-      extract_nt_dom_user (pw, domain, user);
-      if (!get_logon_server (domain, server, wserver))
-	return FALSE;
       if (my_grps)
 	{
 	  if (sid_in_token_groups (my_grps, well_known_local_sid))
@@ -512,13 +510,11 @@
 	    grp_list +=3D well_known_interactive_sid;
 	  if (sid_in_token_groups (my_grps, well_known_service_sid))
 	    grp_list +=3D well_known_service_sid;
-	  grp_list +=3D well_known_authenticated_users_sid;
 	}
       else
 	{
 	  grp_list +=3D well_known_local_sid;
 	  grp_list +=3D well_known_interactive_sid;
-	  grp_list +=3D well_known_authenticated_users_sid;
 	}
       if (auth_luid.QuadPart !=3D 999) /* !=3D SYSTEM_LUID */
 	{
@@ -528,28 +524,22 @@
 	  grp_list +=3D buf;
 	  auth_pos =3D grp_list.count - 1;
 	}
-      if (!get_user_groups (wserver, grp_list, user, domain) ||
-	  !get_user_local_groups (grp_list, usersid))
+      extract_nt_dom_user (pw, domain, user);
+      /* Fail silently if DC is not reachable */
+      if (get_logon_server (domain, server, wserver) &&
+	  !get_user_groups (wserver, grp_list, user, domain))
+	return FALSE;
+      get_unix_group_sidlist (pw, grp_list);
+      if (!get_user_local_groups (grp_list, usersid))
 	return FALSE;
     }
   /* special_pgrp true if pgrpsid is not null and not in normal groups */
-  if (!pgrpsid)
-    {
-      *special_pgrp =3D FALSE;
-      get_user_primary_group (wserver, user, usersid, pgrpsid);
-    }
-  else
-    *special_pgrp =3D TRUE;
-  if (pw->pw_name && get_supplementary_group_sidlist (pw->pw_name, sup_lis=
t))
+  *special_pgrp =3D FALSE;
+  if (pgrpsid && !grp_list.contains (pgrpsid))
     {
-      for (int i =3D 0; i < sup_list.count; ++i)
-	if (!grp_list.contains (sup_list.sids[i]))
-	  grp_list +=3D sup_list.sids[i];
+       *special_pgrp =3D TRUE;
+       grp_list +=3D pgrpsid;
     }
-  if (!grp_list.contains (pgrpsid))
-    grp_list +=3D pgrpsid;
-  else
-    *special_pgrp =3D FALSE;
   return TRUE;
 }


--=====================_1027055570==_--
