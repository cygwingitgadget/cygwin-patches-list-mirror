Return-Path: <cygwin-patches-return-2276-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17361 invoked by alias); 31 May 2002 02:00:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17319 invoked from network); 31 May 2002 02:00:29 -0000
Message-Id: <3.0.5.32.20020530215740.007fc380@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 30 May 2002 19:00:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Name aliasing in security.cc
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1022824660==_"
X-SW-Source: 2002-q2/txt/msg00259.txt.bz2

--=====================_1022824660==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 3772

Corinna,

1) Currently if a domain user and a local user have the same name
(a common situation) then setuid() to the local user will create 
a token with the groups of the domain user. 
This is due to always looking up group names on the primary domain 
server first, indexing with the user name, and then possibly on the
local host.

The fix uses the same method as mkpasswd: it looks up the user name
on the server responsible for the user domain.

As added benefits, no network access is required to setuid()
to a local user, and more than one domain (+ local) can be 
handled.

This patch does not address the following existing issue. User A
setuid()'s and exec()'s user B, who is privileged. User B setuid()
itself with a new gid. In this weird case, the weird behavior of
LookupAccountSid() causes the token to inherit the groups of user A.

2) The current code uses LookupAccountName() to obtain the SIDs of
the groups returned by Windows. LookupAccountName() searches 
for unqualified names everywhere in a forest of domains, returning
as soon as it finds a match.
It can thus  a) return the wrong info if it first finds a matching 
name in an unexpected domain and a) be very slow (particularly if
a name does not exist nearby).

The patch improves the situation by exploiting the fact that 
LookupAccountName() accepts qualified names of the form domain\user 
and we know that:
a) a global group has the same domain as the user
b) a local group returned by NetLocalGroupEnum has domain either 
BUILTIN or the localhost.

3) I noticed a function lookup_name() in sec_helper.cc. It also uses
LookupAccountName() but it is very careful to add domains. 
It is called only from alloc_sd() and seems to date from the time 
when the passwd and group files didn't contain the SIDs.
So it can probably be deleted.

Alternatively its use could be widened, by calling it directly 
from getfrompw() and getfromgr() whenever a SID is missing from an
entry in the passwd/group files.

It has the pecularity that the search rule depends on the user
making the call. Thus two users looking up the same name at the same
time from the same passwd/group files could obtain different answers.
This is probably undesirable.
Do you want to
a) keep lookup_name() as it is?
b) remove it entirely?
c) call it whenever a SID is missing from a passwd/group entry, using
user independent search rules (except if a user looks up itself)? 

 
The changes have been tested on a standalone PC and in two single
domain networks, with WinNT and Win2000 PCs. 
It has not been tested e.g. on a PC that is itself a domain controller, 
or in networks with several domains. If members of this list can test
setuid() (creating internal tokens) in such environments, feedback 
would be welcome.

Pierre

2002-05-30  Pierre Humblet <pierre.humblet@ieee.org>

	* security.cc (lsa2wchar): Suppressed.
	(get_lsa_srv_inf): Suppressed.
	(get_logon_server_and_user_domain): Suppressed.
	(get_logon_server): Essentially new.
	(get_user_groups): Add "domain" argument. Only lookup the
	designated server and use "domain" in LookupAccountName.
	(is_group_member): Simplify the arguments.
	(get_user_local_groups): Simplify the arguments. Do only a
	local lookup. Use "BUILTIN" and local domain in LookupAccountName.
	(get_user_primary_group). Only lookup the designated server.
	(get_group_sidlist): Remove logonserver argument. Do not lookup
	any server for the SYSTEM account.
	(create_token): Delete logonserver and call to get_logon_server.
	Adjust arguments of get_group_sidlist, see above.
	* security.h: Delete declaration of get_logon_server_and_user_domain
	and add declaration of get_logon_server.
	* uinfo.cc (internal_get_login): Call get_logon_server instead of
	get_logon_server_and_user_domain.
	
--=====================_1022824660==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="uinfo.cc.diff"
Content-length: 429

--- uinfo.cc.orig	2002-05-29 19:48:00.000000000 -0400
+++ uinfo.cc	2002-05-30 17:44:40.000000000 -0400
@@ -72,7 +72,8 @@
 	  user.set_domain (buf);
 	  NetApiBufferFree (wui);
 	}
-      if (!user.logsrv () && get_logon_server_and_user_domain (buf, NULL))
+      if (!user.logsrv () && user.domain() &&
+          get_logon_server(user.domain(), buf, NULL))
 	{
 	  user.set_logsrv (buf + 2);
 	  setenv ("LOGONSERVER", buf, 1);

--=====================_1022824660==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="security.h.diff"
Content-length: 634

--- security.h.orig	2002-05-29 19:48:00.000000000 -0400
+++ security.h	2002-05-29 19:52:14.000000000 -0400
@@ -186,8 +186,8 @@
 
 /* Extract U-domain\user field from passwd entry. */
 void extract_nt_dom_user (const struct passwd *pw, char *domain, char *user);
-/* Get default logonserver and domain for this box. */
-BOOL get_logon_server_and_user_domain (char *logonserver, char *domain);
+/* Get default logonserver for a domain. */
+BOOL get_logon_server (const char * domain, char * server, WCHAR *wserver = NULL);
 
 /* sec_helper.cc: Security helper functions. */
 BOOL __stdcall is_grp_member (__uid32_t uid, __gid32_t gid);

--=====================_1022824660==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.cc.diff"
Content-length: 11650

--- security.cc.orig	2002-05-29 19:48:00.000000000 -0400
+++ security.cc	2002-05-29 23:13:46.000000000 -0400
@@ -163,6 +163,7 @@
   sys_mbstowcs (buf, srcstr, tgt.MaximumLength);
 }

+#if 0 //unused
 static void
 lsa2wchar (WCHAR *tgt, LSA_UNICODE_STRING &src, int size)
 {
@@ -173,6 +174,7 @@
   size >>=3D 1;
   tgt[size] =3D 0;
 }
+#endif

 static void
 lsa2str (char *tgt, LSA_UNICODE_STRING &src, int size)
@@ -203,6 +205,7 @@
   lsa =3D INVALID_HANDLE_VALUE;
 }

+#if 0 // unused
 static BOOL
 get_lsa_srv_inf (LSA_HANDLE lsa, char *logonserver, char *domain)
 {
@@ -253,40 +256,52 @@
     NetApiBufferFree (buf);
   return TRUE;
 }
-
-static BOOL
-get_logon_server (LSA_HANDLE lsa, char *logonserver)
-{
-  return get_lsa_srv_inf (lsa, logonserver, NULL);
-}
+#endif

 BOOL
-get_logon_server_and_user_domain (char *logonserver, char *userdomain)
+get_logon_server (const char * domain, char * server, WCHAR *wserver)
 {
-  BOOL ret =3D FALSE;
-  LSA_HANDLE lsa =3D open_local_policy ();
-  if (lsa !=3D INVALID_HANDLE_VALUE)
+  WCHAR wdomain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
+  NET_API_STATUS ret;
+  WCHAR * buf;
+  DWORD size =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
+
+  if ((GetComputerNameA(server + 2, &size)) &&
+      !strcasecmp(domain, server + 2))
     {
-      ret =3D get_lsa_srv_inf (lsa, logonserver, userdomain);
-      close_local_policy (lsa);
+      server[0] =3D server[1] =3D '\\';
+      if (wserver)
+        sys_mbstowcs (wserver, server, INTERNET_MAX_HOST_NAME_LENGTH + 1);
+      return TRUE;
     }
-  return ret;
+
+  /* Try to get the primary domain controller for the domain */
+  sys_mbstowcs (wdomain, domain, INTERNET_MAX_HOST_NAME_LENGTH + 1);
+  if ((ret =3D NetGetDCName(NULL, wdomain, (LPBYTE *) &buf)) =3D=3D STATUS=
_SUCCESS)
+    {
+      sys_wcstombs (server, buf, INTERNET_MAX_HOST_NAME_LENGTH + 1);
+      if (wserver)
+	for (WCHAR * ptr1 =3D buf; (*wserver++ =3D *ptr1++); ) {}
+      NetApiBufferFree (buf);
+      return TRUE;
+    }
+  __seterrno_from_win_error (ret);
+  return FALSE;
 }

 static BOOL
-get_user_groups (WCHAR *wlogonserver, cygsidlist &grp_list, char *user)
+get_user_groups (WCHAR *wlogonserver, cygsidlist &grp_list, char *user, ch=
ar * domain)
 {
+  char dgroup[INTERNET_MAX_HOST_NAME_LENGTH + GNLEN + 2];
   WCHAR wuser[UNLEN + 1];
   sys_mbstowcs (wuser, user, UNLEN + 1);
   LPGROUP_USERS_INFO_0 buf;
-  DWORD cnt, tot;
+  DWORD cnt, tot, len;
   NET_API_STATUS ret;

+  /* Look only on logonserver */
   ret =3D NetUserGetGroups (wlogonserver, wuser, 0, (LPBYTE *) &buf,
 			  MAX_PREFERRED_LENGTH, &cnt, &tot);
-  if (ret =3D=3D ERROR_BAD_NETPATH || ret =3D=3D RPC_S_SERVER_UNAVAILABLE)
-    ret =3D NetUserGetGroups (NULL, wuser, 0, (LPBYTE *) &buf,
-			    MAX_PREFERRED_LENGTH, &cnt, &tot);
   if (ret)
     {
       __seterrno_from_win_error (ret);
@@ -294,30 +309,25 @@
       return ret =3D=3D NERR_UserNotFound;
     }

+  len =3D strlen(domain);
+  strcpy(dgroup, domain);
+  dgroup[len++] =3D '\\';
+
   for (DWORD i =3D 0; i < cnt; ++i)
     {
       cygsid gsid;
-      char group[UNLEN + 1];
+      DWORD glen =3D sizeof (gsid);
       char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-      DWORD glen =3D UNLEN + 1;
-      DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
+      DWORD dlen =3D sizeof (domain);
       SID_NAME_USE use =3D SidTypeInvalid;

-      sys_wcstombs (group, buf[i].grui0_name, UNLEN + 1);
-      if (!LookupAccountName (NULL, group, gsid, &glen, domain, &dlen, &us=
e))
-	debug_printf ("LookupAccountName(%s): %lu\n", group, GetLastError ());
-      if (!legal_sid_type (use))
-	{
-	  strcat (strcpy (group, domain), "\\");
-	  sys_wcstombs (group + strlen (group), buf[i].grui0_name,
-			UNLEN + 1 - strlen (group));
-	  glen =3D UNLEN + 1;
-	  dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
-	  if (!LookupAccountName(NULL, group, gsid, &glen, domain, &dlen, &use))
-	    debug_printf ("LookupAccountName(%s): %lu\n", group,GetLastError());
-	}
-      if (legal_sid_type (use))
-	grp_list +=3D gsid;
+      sys_wcstombs (dgroup + len, buf[i].grui0_name, GNLEN + 1);
+      if (!LookupAccountName (NULL, dgroup, gsid, &glen, domain, &dlen, &u=
se))
+	  debug_printf ("LookupAccountName(%s): %E", dgroup);
+      else if (legal_sid_type (use))
+	  grp_list +=3D gsid;
+      else debug_printf("Global group %s invalid. Domain: %s Use: %d",
+			dgroup, domain, use);
     }

   NetApiBufferFree (buf);
@@ -325,21 +335,21 @@
 }

 static BOOL
-is_group_member (WCHAR *wlogonserver, WCHAR *wgroup,
-		 cygsid &usersid, cygsidlist &grp_list)
+is_group_member (WCHAR *wgroup, PSID pusersid, cygsidlist &grp_list)
 {
   LPLOCALGROUP_MEMBERS_INFO_0 buf;
   DWORD cnt, tot;
   NET_API_STATUS ret;
   BOOL retval =3D FALSE;

+  /* Members can be users or global groups */
   ret =3D NetLocalGroupGetMembers (NULL, wgroup, 0, (LPBYTE *) &buf,
 				 MAX_PREFERRED_LENGTH, &cnt, &tot, NULL);
   if (ret)
     return FALSE;

   for (DWORD bidx =3D 0; !retval && bidx < cnt; ++bidx)
-    if (EqualSid (usersid, buf[bidx].lgrmi0_sid))
+    if (EqualSid (pusersid, buf[bidx].lgrmi0_sid))
       retval =3D TRUE;
     else
       for (int glidx =3D 0; !retval && glidx < grp_list.count; ++glidx)
@@ -351,8 +361,7 @@
 }

 static BOOL
-get_user_local_groups (WCHAR *wlogonserver, const char *logonserver,
-		       cygsidlist &grp_list, cygsid &usersid)
+get_user_local_groups (cygsidlist &grp_list, PSID pusersid)
 {
   LPLOCALGROUP_INFO_0 buf;
   DWORD cnt, tot;
@@ -366,40 +375,39 @@
       return FALSE;
     }

+  char bgroup[sizeof ("BUILTIN\\") + GNLEN] =3D "BUILTIN\\";
+  char lgroup[INTERNET_MAX_HOST_NAME_LENGTH + GNLEN + 2];
+  const DWORD blen =3D sizeof ("BUILTIN\\") - 1;
+  DWORD llen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
+  if (!GetComputerNameA(lgroup, & llen))
+    {
+       __seterrno();
+       return FALSE;
+    }
+  lgroup[llen++] =3D '\\';
+
   for (DWORD i =3D 0; i < cnt; ++i)
-    if (is_group_member (wlogonserver, buf[i].lgrpi0_name, usersid, grp_li=
st))
+    if (is_group_member (buf[i].lgrpi0_name, pusersid, grp_list))
       {
 	cygsid gsid;
-	char group[UNLEN + 1];
+	DWORD glen =3D sizeof (gsid);
 	char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-	DWORD glen =3D UNLEN + 1;
-	DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
+	DWORD dlen =3D sizeof (domain);
 	SID_NAME_USE use =3D SidTypeInvalid;

-	sys_wcstombs (group, buf[i].lgrpi0_name, UNLEN + 1);
-	if (!LookupAccountName (NULL, group, gsid, &glen, domain, &dlen, &use))
-	  {
-	    glen =3D UNLEN + 1;
-	    dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
-	    if (!LookupAccountName (logonserver + 2, group,
-				    gsid, &glen, domain, &dlen, &use))
-	      debug_printf ("LookupAccountName(%s): %lu\n", group,
-							    GetLastError ());
-	  }
-	else if (!legal_sid_type (use))
+	sys_wcstombs (bgroup + blen, buf[i].lgrpi0_name, GNLEN + 1);
+	if (!LookupAccountName (NULL, bgroup, gsid, &glen, domain, &dlen, &use))
 	  {
-	    strcat (strcpy (group, domain), "\\");
-	    sys_wcstombs (group + strlen (group), buf[i].lgrpi0_name,
-			  UNLEN + 1 - strlen (group));
-	    glen =3D UNLEN + 1;
-	    dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
-	    if (!LookupAccountName (NULL, group, gsid, &glen,
-				    domain, &dlen, &use))
-	      debug_printf ("LookupAccountName(%s): %lu\n", group,
-							    GetLastError ());
+	     if (GetLastError () !=3D ERROR_NONE_MAPPED)
+		 debug_printf ("LookupAccountName(%s): %E", bgroup);
+	     strcpy(lgroup + llen, bgroup + blen);
+	     if (!LookupAccountName (NULL, lgroup, gsid, &glen,
+				     domain, &dlen, &use))
+		 debug_printf ("LookupAccountName(%s): %E", lgroup);
 	  }
 	if (legal_sid_type (use))
 	  grp_list +=3D gsid;
+	else debug_printf("Rejecting local %s. use: %d", bgroup + blen, use);
       }

   NetApiBufferFree (buf);
@@ -419,7 +427,7 @@

 static BOOL
 get_user_primary_group (WCHAR *wlogonserver, const char *user,
-			cygsid &usersid, cygsid &pgrpsid)
+			PSID pusersid, cygsid &pgrpsid)
 {
   LPUSER_INFO_3 buf;
   WCHAR wuser[UNLEN + 1];
@@ -427,7 +435,7 @@
   BOOL retval =3D FALSE;
   UCHAR count =3D 0;

-  if (usersid =3D=3D well_known_system_sid)
+  if (pusersid =3D=3D well_known_system_sid)
     {
       pgrpsid =3D well_known_system_sid;
       return TRUE;
@@ -435,15 +443,13 @@

   sys_mbstowcs (wuser, user, UNLEN + 1);
   ret =3D NetUserGetInfo (wlogonserver, wuser, 3, (LPBYTE *) &buf);
-  if (ret =3D=3D ERROR_BAD_NETPATH || ret =3D=3D RPC_S_SERVER_UNAVAILABLE)
-    ret =3D NetUserGetInfo (NULL, wuser, 3, (LPBYTE *) &buf);
   if (ret)
     {
       __seterrno_from_win_error (ret);
       return FALSE;
     }

-  pgrpsid =3D usersid;
+  pgrpsid =3D pusersid;
   if (IsValidSid (pgrpsid) && (count =3D *GetSidSubAuthorityCount (pgrpsid=
)) > 1)
     {
       *GetSidSubAuthority (pgrpsid, count - 1) =3D buf->usri3_primary_grou=
p_id;
@@ -478,27 +484,28 @@
 }

 static BOOL
-get_group_sidlist (const char *logonserver, cygsidlist &grp_list,
+get_group_sidlist (cygsidlist &grp_list,
 		   cygsid &usersid, cygsid &pgrpsid,
 		   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos,
 		   BOOL * special_pgrp)
 {
-  WCHAR wserver[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-  char user[INTERNET_MAX_HOST_NAME_LENGTH + 1];
+  char user[UNLEN + 1];
   char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
-  DWORD ulen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
-  DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
+  WCHAR wserver[INTERNET_MAX_HOST_NAME_LENGTH + 3];
+  char server[INTERNET_MAX_HOST_NAME_LENGTH + 3];
+  DWORD ulen =3D sizeof (user);
+  DWORD dlen =3D sizeof (domain);
   SID_NAME_USE use;
   cygsidlist sup_list;

   auth_pos =3D -1;
-  sys_mbstowcs (wserver, logonserver, INTERNET_MAX_HOST_NAME_LENGTH + 1);
   if (!LookupAccountSid (NULL, usersid, user, &ulen, domain, &dlen, &use))
     {
       debug_printf ("LookupAccountSid () %E");
       __seterrno ();
       return FALSE;
     }
+
   grp_list +=3D well_known_world_sid;
   if (usersid =3D=3D well_known_system_sid)
     {
@@ -507,6 +514,8 @@
     }
   else
     {
+      if (!get_logon_server( domain, server, wserver))
+        return FALSE;
       if (my_grps)
 	{
 	  if (sid_in_token_groups (my_grps, well_known_local_sid))
@@ -537,6 +546,9 @@
 	  grp_list +=3D buf;
 	  auth_pos =3D grp_list.count - 1;
 	}
+      if (!get_user_groups (wserver, grp_list, user, domain) ||
+          !get_user_local_groups (grp_list, usersid))
+        return FALSE;
     }
   /* special_pgrp true if pgrpsid is not null and not in normal groups */
   if (!pgrpsid)
@@ -545,9 +557,6 @@
       get_user_primary_group (wserver, user, usersid, pgrpsid);
     }
   else * special_pgrp =3D TRUE;
-  if (!get_user_groups (wserver, grp_list, user) ||
-      !get_user_local_groups (wserver, logonserver, grp_list, usersid))
-    return FALSE;
   if (get_supplementary_group_sidlist (user, sup_list))
     {
       for (int i =3D 0; i < sup_list.count; ++i)
@@ -730,7 +739,6 @@
 {
   NTSTATUS ret;
   LSA_HANDLE lsa =3D INVALID_HANDLE_VALUE;
-  char logonserver[INTERNET_MAX_HOST_NAME_LENGTH + 1];
   int old_priv_state;

   cygsidlist grpsids;
@@ -773,10 +781,6 @@
   if ((lsa =3D open_local_policy ()) =3D=3D INVALID_HANDLE_VALUE)
     goto out;

-  /* Get logon server. */
-  if (!get_logon_server (lsa, logonserver))
-    goto out;
-
   /* User, owner, primary group. */
   user.User.Sid =3D usersid;
   user.User.Attributes =3D 0;
@@ -815,7 +819,7 @@

   /* Create list of groups, the user is member in. */
   int auth_pos;
-  if (!get_group_sidlist (logonserver, grpsids, usersid, pgrpsid,
+  if (!get_group_sidlist (grpsids, usersid, pgrpsid,
 			  my_grps, auth_luid, auth_pos, &special_pgrp))
     goto out;


--=====================_1022824660==_--
