Return-Path: <cygwin-patches-return-3467-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4392 invoked by alias); 29 Jan 2003 17:35:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4382 invoked from network); 29 Jan 2003 17:35:36 -0000
Message-Id: <3.0.5.32.20030129123516.007e4740@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 29 Jan 2003 17:35:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Minor ntsec fixes and optimizations.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1043879716==_"
X-SW-Source: 2003-q1/txt/msg00116.txt.bz2

--=====================_1043879716==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2159

Corinna,

This patch
1) fixes a remaining chown problem, when impersonated
2) combines is_grp_member with get_id, and uses internal_getgroups
   in a new way. This makes getting group membership almost free.
  This led me to define a new class cygpsid (same as cygsid but without
  buffer) and to make minor type changes in security.cc and passwd/group.  
3) fixes nits in security.cc

Pierre

P.S.: I am getting to the end of my "ntsec to do" list. Next I will
change sec_acl to __{u,g}id32_t.


2003/01/29  Pierre Humblet  <pierre.humblet@ieee.org>

	* security.h (class cygpsid): New class.
	(class cygsid): Use cygpsid as base. Remove members psid, get_id, 
	get_uid, get_gid, string, debug_printf and the == and != operators.
	(cygsidlist::clear_supp): Only do work if setgroups has been called.
	Declare get_sids_info. Rename DEFAULT_UID_NT to UNKNOWN_UID and 
	DEFAULT_GID to UNKNOWN_GID. Add third argument to declaration of
	set_process_privilege.
	* sec_helper.cc: Define sid_auth NO_COPY. 
	(cygpsid::operator==): New operator.
	(cygpsid::get_id): New function.
	(cygpsid::string): New function.
	(cygsid::string): Delete.
	(cygsid::get_id): Delete.
	(get_sids_info): New function.
	(set_process_privilege): Add third argument and call 
	OpenThreadToken if needed. Remove duplicate debug_printf.
	* security.cc (extract_nt_dom_user): Use strechr.
	(get_user_groups): Initialize glen to MAX_SID_LEN.
	(get_user_local_groups): Ditto.
	(get_attribute_from_acl): Define ace_sid as cygpsid.
	(get_nt_attribute): Define owner_sid and group_sid as cygpsid.
	Call get_sids_info instead of cygsid.get_{u,g}id and is_grp_member.
	(get_nt_object_attribute): Ditto.
	(alloc_sd): Call set_process_privilege with three arguments.
	Define ace_sid as cygpsid.
	* autoload.cc: Autoload OpenThreadToken.
	* pwdgrp.h: Change arguments of internal_getpwsid,
	internal_getgrsid and internal_getgroups to cygpsid.
	* passwd.cc: Use UNKNOWN_UID instead of DEFAULT_UID_NT. 
	(internal_getpwsid): Change argument from cygsid to cygpsid.
	* grp.cc (internal_getgrsid): Ditto.
	(internal_getgroups): Ditto.
	* uinfo.cc (internal_getlogin): Replace DEFAULT_GID by UNKNOWN_GID.
--=====================_1043879716==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="cygpsid.diff"
Content-length: 19470

Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.36
diff -u -p -r1.36 security.h
--- security.h	14 Dec 2002 17:23:42 -0000	1.36
+++ security.h	29 Jan 2003 04:10:11 -0000
@@ -11,8 +11,8 @@ details. */
 #include <accctrl.h>

 #define DEFAULT_UID DOMAIN_USER_RID_ADMIN
-#define DEFAULT_UID_NT 400 /* Non conflicting number */
-#define DEFAULT_GID 401
+#define UNKNOWN_UID 400 /* Non conflicting number */
+#define UNKNOWN_GID 401

 #define MAX_SID_LEN 40
 #define MAX_DACL_LEN(n) (sizeof (ACL) \
@@ -20,8 +20,40 @@ details. */

 #define NO_SID ((PSID)NULL)

-class cygsid {
+class cygpsid {
+protected:
   PSID psid;
+public:
+  cygpsid () {}
+  cygpsid (PSID nsid) { psid =3D nsid; }
+  operator const PSID () { return psid; }
+  const PSID operator=3D (PSID nsid) { return psid =3D nsid;}
+  __uid32_t get_id (BOOL search_grp, int *type =3D NULL);
+  int get_uid () { return get_id (FALSE); }
+  int get_gid () { return get_id (TRUE); }
+
+  char *string (char *nsidstr) const;
+
+  bool operator=3D=3D (const PSID nsid) const
+    {
+      if (!psid || !nsid)
+	return nsid =3D=3D psid;
+      return EqualSid (psid, nsid);
+    }
+  bool operator!=3D (const PSID nsid) const
+    { return !(*this =3D=3D nsid); }
+  bool operator=3D=3D (const char *nsidstr) const;
+  bool operator!=3D (const char *nsidstr) const
+    { return !(*this =3D=3D nsidstr); }
+
+  void debug_print (const char *prefix =3D NULL) const
+    {
+      char buf[256];
+      debug_printf ("%s %s", prefix ?: "", string (buf) ?: "NULL");
+    }
+};
+
+class cygsid : public cygpsid {
   char sbuf[MAX_SID_LEN];

   const PSID getfromstr (const char *nsidstr);
@@ -50,7 +82,7 @@ public:
   inline const PSID operator=3D (const char *nsidstr)
     { return getfromstr (nsidstr); }

-  inline cygsid () : psid ((PSID) sbuf) {}
+  inline cygsid () : cygpsid ((PSID) sbuf) {}
   inline cygsid (const PSID nsid) { *this =3D nsid; }
   inline cygsid (const char *nstrsid) { *this =3D nstrsid; }

@@ -58,34 +90,6 @@ public:

   BOOL getfrompw (const struct passwd *pw);
   BOOL getfromgr (const struct __group32 *gr);
-
-  __uid32_t get_id (BOOL search_grp, int *type =3D NULL);
-  inline int get_uid () { return get_id (FALSE); }
-  inline int get_gid () { return get_id (TRUE); }
-
-  char *string (char *nsidstr) const;
-
-  inline BOOL operator=3D=3D (const PSID nsid) const
-    {
-      if (!psid || !nsid)
-	return nsid =3D=3D psid;
-      return EqualSid (psid, nsid);
-    }
-  inline BOOL operator=3D=3D (const char *nsidstr) const
-    {
-      cygsid nsid (nsidstr);
-      return *this =3D=3D nsid;
-    }
-  inline BOOL operator!=3D (const PSID nsid) const
-    { return !(*this =3D=3D nsid); }
-  inline BOOL operator!=3D (const char *nsidstr) const
-    { return !(*this =3D=3D nsidstr); }
-
-  void debug_print (const char *prefix =3D NULL) const
-    {
-      char buf[256];
-      debug_printf ("%s %s", prefix ?: "", string (buf) ?: "NULL");
-    }
 };

 typedef enum { cygsidlist_empty, cygsidlist_alloc, cygsidlist_auto } cygsi=
dlist_type;
@@ -171,8 +175,11 @@ public:
     }
   void clear_supp ()
     {
-      sgsids.free_sids ();
-      ischanged =3D TRUE;
+      if (issetgroups ())
+        {
+	  sgsids.free_sids ();
+	  ischanged =3D TRUE;
+	}
     }
   void update_pgrp (const PSID sid)
     {
@@ -222,6 +229,8 @@ BOOL __stdcall add_access_denied_ace (PA
 void set_security_attribute (int attribute, PSECURITY_ATTRIBUTES psa,
 			     void *sd_buf, DWORD sd_buf_size);

+bool get_sids_info (cygpsid, cygpsid, __uid32_t * , __gid32_t *);
+
 /* Try a subauthentication. */
 HANDLE subauth (struct passwd *pw);
 /* Try creating a token directly. */
@@ -236,7 +245,7 @@ BOOL get_logon_server (const char * doma

 /* sec_helper.cc: Security helper functions. */
 BOOL __stdcall is_grp_member (__uid32_t uid, __gid32_t gid);
-int set_process_privilege (const char *privilege, BOOL enable =3D TRUE);
+int set_process_privilege (const char *privilege, bool enable =3D true, bo=
ol check_thread =3D false);

 /* shared.cc: */
 /* Retrieve a security descriptor that allows all access */
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.32
diff -u -p -r1.32 sec_helper.cc
--- sec_helper.cc	26 Jan 2003 06:42:40 -0000	1.32
+++ sec_helper.cc	29 Jan 2003 04:12:45 -0000
@@ -39,7 +39,7 @@ SECURITY_ATTRIBUTES NO_COPY sec_none_nih
 SECURITY_ATTRIBUTES NO_COPY sec_all;
 SECURITY_ATTRIBUTES NO_COPY sec_all_nih;

-SID_IDENTIFIER_AUTHORITY sid_auth[] =3D {
+SID_IDENTIFIER_AUTHORITY NO_COPY sid_auth[] =3D {
 	{SECURITY_NULL_SID_AUTHORITY},
 	{SECURITY_WORLD_SID_AUTHORITY},
 	{SECURITY_LOCAL_SID_AUTHORITY},
@@ -62,6 +62,63 @@ cygsid well_known_authenticated_users_si
 cygsid well_known_system_sid;
 cygsid well_known_admins_sid;

+bool
+cygpsid::operator=3D=3D (const char *nsidstr) const
+{
+  cygsid nsid (nsidstr);
+  return psid =3D=3D nsid;
+}
+
+__uid32_t
+cygpsid::get_id (BOOL search_grp, int *type)
+{
+    /* First try to get SID from group, then passwd */
+  __uid32_t id =3D ILLEGAL_UID;
+
+  if (search_grp)
+    {
+      struct __group32 *gr;
+      if (cygheap->user.groups.pgsid =3D=3D psid)
+	id =3D myself->gid;
+      else if ((gr =3D internal_getgrsid (*this)))
+	id =3D gr->gr_gid;
+      if (id !=3D ILLEGAL_UID)
+        {
+	  if (type)
+	    *type =3D GROUP;
+	  return id;
+	}
+    }
+  if (!search_grp || type)
+    {
+      struct passwd *pw;
+      if (*this =3D=3D cygheap->user.sid ())
+	id =3D myself->uid;
+      else if ((pw =3D internal_getpwsid (*this)))
+	id =3D pw->pw_uid;
+      if (id !=3D ILLEGAL_UID && type)
+        *type =3D USER;
+    }
+  return id;
+}
+
+
+char *
+cygpsid::string (char *nsidstr) const
+{
+  char *t;
+  DWORD i;
+
+  if (!psid || !nsidstr)
+    return NULL;
+  strcpy (nsidstr, "S-1-");
+  t =3D nsidstr + sizeof ("S-1-") - 1;
+  t +=3D __small_sprintf (t, "%u", GetSidIdentifierAuthority (psid)->Value=
[5]);
+  for (i =3D 0; i < *GetSidSubAuthorityCount (psid); ++i)
+    t +=3D __small_sprintf (t, "-%lu", *GetSidSubAuthority (psid, i));
+  return nsidstr;
+}
+
 void
 cygsid::init ()
 {
@@ -80,25 +137,6 @@ cygsid::init ()
   well_known_admins_sid =3D "S-1-5-32-544";
 }

-char *
-cygsid::string (char *nsidstr) const
-{
-  char t[32];
-  DWORD i;
-
-  if (!psid || !nsidstr)
-    return NULL;
-  strcpy (nsidstr, "S-1-");
-  __small_sprintf (t, "%u", GetSidIdentifierAuthority (psid)->Value[5]);
-  strcat (nsidstr, t);
-  for (i =3D 0; i < *GetSidSubAuthorityCount (psid); ++i)
-    {
-      __small_sprintf (t, "-%lu", *GetSidSubAuthority (psid, i));
-      strcat (nsidstr, t);
-    }
-  return nsidstr;
-}
-
 PSID
 cygsid::get_sid (DWORD s, DWORD cnt, DWORD *r)
 {
@@ -148,37 +186,42 @@ cygsid::getfromgr (const struct __group3
   return (*this =3D sp) !=3D NULL;
 }

-__uid32_t
-cygsid::get_id (BOOL search_grp, int *type)
+bool
+get_sids_info (cygpsid owner_sid, cygpsid group_sid, __uid32_t * uidret, _=
_gid32_t * gidret)
 {
-  /* First try to get SID from passwd or group entry */
-  __uid32_t id =3D ILLEGAL_UID;
-
-  if (!search_grp)
-    {
-      struct passwd *pw;
-      if (*this =3D=3D cygheap->user.sid ())
-	id =3D myself->uid;
-      else if ((pw =3D internal_getpwsid (*this)))
-	id =3D pw->pw_uid;
-      if (id !=3D ILLEGAL_UID)
-	{
-	  if (type)
-	    *type =3D USER;
-	   return id;
-	}
-    }
-  if (search_grp || type)
-    {
-      struct __group32 *gr;
-      if (cygheap->user.groups.pgsid =3D=3D psid)
-	id =3D myself->gid;
-      else if ((gr =3D internal_getgrsid (*this)))
-	id =3D gr->gr_gid;
-      if (id !=3D ILLEGAL_UID && type)
-	*type =3D GROUP;
+  struct passwd *pw;
+  struct __group32 *gr =3D NULL;
+  BOOL ret =3D FALSE;
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
+	ret =3D TRUE;
+      else
+	ret =3D (internal_getgroups (0, NULL, &group_sid) > 0);
+    }
+  else if ((pw =3D internal_getpwsid (owner_sid)))
+    {
+      *uidret =3D pw->pw_uid;
+      if (*gidret =3D=3D ILLEGAL_GID
+	  || (!gr && !(gr =3D internal_getgrsid (group_sid))))
+	return FALSE;
+      for (int idx =3D 0; gr->gr_mem[idx]; ++idx)
+	if ((ret =3D strcasematch (pw->pw_name, gr->gr_mem[idx])))
+	  break;
     }
-  return id;
+  else
+    *uidret =3D ILLEGAL_UID;
+
+  return ret;
 }

 BOOL
@@ -294,7 +337,7 @@ got_it:
 #endif //unused

 int
-set_process_privilege (const char *privilege, BOOL enable)
+set_process_privilege (const char *privilege, bool enable, bool check_thre=
ad)
 {
   HANDLE hToken =3D NULL;
   LUID restore_priv;
@@ -302,8 +345,11 @@ set_process_privilege (const char *privi
   int ret =3D -1;
   DWORD size;

-  if (!OpenProcessToken (hMainProc, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES,
-			 &hToken))
+  if ((check_thread && cygheap->user.issetuid ()
+       && !OpenThreadToken (GetCurrentThread (), TOKEN_QUERY | TOKEN_ADJUS=
T_PRIVILEGES,
+			    0, &hToken))
+      || !OpenProcessToken (hMainProc, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEG=
ES,
+			    &hToken))
     {
       __seterrno ();
       goto out;
@@ -329,7 +375,6 @@ set_process_privilege (const char *privi
      be enabled. GetLastError () returns an correct error code, though. */
   if (enable && GetLastError () =3D=3D ERROR_NOT_ALL_ASSIGNED)
     {
-      debug_printf ("Privilege %s couldn't be assigned", privilege);
       __seterrno ();
       goto out;
     }
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.132
diff -u -p -r1.132 security.cc
--- security.cc	26 Jan 2003 06:42:40 -0000	1.132
+++ security.cc	29 Jan 2003 04:16:56 -0000
@@ -90,13 +90,11 @@ extract_nt_dom_user (const struct passwd
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
 	strlcpy (user, u + 1, c - u);
     }
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
@@ -1565,7 +1562,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid,

   /* Must have SE_RESTORE_NAME privilege to change owner */
   if (cur_owner_sid && owner_sid !=3D cur_owner_sid
-      && set_process_privilege (SE_RESTORE_NAME) < 0 )
+      && set_process_privilege (SE_RESTORE_NAME, true, true) < 0 )
     return NULL;

   /* Get SID of new group. */
@@ -1738,7 +1735,8 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
     for (DWORD i =3D 0; i < oacl->AceCount; ++i)
       if (GetAce (oacl, i, (PVOID *) &ace))
 	{
-	  cygsid ace_sid ((PSID) &ace->SidStart);
+	  cygpsid ace_sid ((PSID) &ace->SidStart);
+
 	  /* Check for related ACEs. */
 	  if (ace_sid =3D=3D well_known_null_sid)
 	    continue;
Index: autoload.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.59
diff -u -p -r1.59 autoload.cc
--- autoload.cc	15 Jan 2003 10:21:23 -0000	1.59
+++ autoload.cc	29 Jan 2003 04:17:16 -0000
@@ -352,6 +352,7 @@ LoadDLLfunc (LsaOpenPolicy, 16, advapi32
 LoadDLLfunc (LsaQueryInformationPolicy, 12, advapi32)
 LoadDLLfunc (MakeSelfRelativeSD, 12, advapi32)
 LoadDLLfunc (OpenProcessToken, 12, advapi32)
+LoadDLLfunc (OpenThreadToken, 16, advapi32)
 LoadDLLfunc (RegCloseKey, 4, advapi32)
 LoadDLLfunc (RegCreateKeyExA, 36, advapi32)
 LoadDLLfunc (RegDeleteKeyA, 8, advapi32)
Index: pwdgrp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pwdgrp.h,v
retrieving revision 1.18
diff -u -p -r1.18 pwdgrp.h
--- pwdgrp.h	27 Jan 2003 00:16:01 -0000	1.18
+++ pwdgrp.h	29 Jan 2003 04:17:39 -0000
@@ -12,14 +12,14 @@ details. */

 /* These functions are needed to allow searching and walking through
    the passwd and group lists */
-extern struct passwd *internal_getpwsid (cygsid &);
+extern struct passwd *internal_getpwsid (cygpsid &);
 extern struct passwd *internal_getpwnam (const char *, bool =3D FALSE);
 extern struct passwd *internal_getpwuid (__uid32_t, bool =3D FALSE);
-extern struct __group32 *internal_getgrsid (cygsid &);
+extern struct __group32 *internal_getgrsid (cygpsid &);
 extern struct __group32 *internal_getgrgid (__gid32_t gid, bool =3D FALSE);
 extern struct __group32 *internal_getgrnam (const char *, bool =3D FALSE);
 extern struct __group32 *internal_getgrent (int);
-int internal_getgroups (int, __gid32_t *, cygsid * =3D NULL);
+int internal_getgroups (int, __gid32_t *, cygpsid * =3D NULL);

 #include "sync.h"
 class pwdgrp
Index: passwd.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.66
diff -u -p -r1.66 passwd.cc
--- passwd.cc	27 Jan 2003 17:00:17 -0000	1.66
+++ passwd.cc	29 Jan 2003 04:18:05 -0000
@@ -85,7 +85,7 @@ pwdgrp::read_passwd ()
       (void) cygheap->user.ontherange (CH_HOME, NULL);
       snprintf (linebuf, sizeof (linebuf), "%s:*:%lu:%lu:,%s:%s:/bin/sh",
 		cygheap->user.name (),
-		myself->uid =3D=3D ILLEGAL_UID ? DEFAULT_UID_NT : myself->uid,
+		myself->uid =3D=3D ILLEGAL_UID ? UNKNOWN_UID : myself->uid,
 		myself->gid,
 		strbuf, getenv ("HOME") ?: "");
       debug_printf ("Completing /etc/passwd: %s", linebuf);
@@ -95,7 +95,7 @@ pwdgrp::read_passwd ()
 }

 struct passwd *
-internal_getpwsid (cygsid &sid)
+internal_getpwsid (cygpsid &sid)
 {
   struct passwd *pw;
   char *ptr1, *ptr2, *endptr;
Index: grp.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.73
diff -u -p -r1.73 grp.cc
--- grp.cc	27 Jan 2003 00:16:01 -0000	1.73
+++ grp.cc	29 Jan 2003 04:18:23 -0000
@@ -107,7 +107,7 @@ pwdgrp::read_group ()
 }

 struct __group32 *
-internal_getgrsid (cygsid &sid)
+internal_getgrsid (cygpsid &sid)
 {
   char sid_string[128];

@@ -231,7 +231,7 @@ internal_getgrent (int pos)
 }

 int
-internal_getgroups (int gidsetsize, __gid32_t *grouplist, cygsid * srchsid)
+internal_getgroups (int gidsetsize, __gid32_t *grouplist, cygpsid * srchsi=
d)
 {
   HANDLE hToken =3D NULL;
   DWORD size;
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.110
diff -u -p -r1.110 uinfo.cc
--- uinfo.cc	27 Jan 2003 00:31:30 -0000	1.110
+++ uinfo.cc	29 Jan 2003 04:18:48 -0000
@@ -37,7 +37,7 @@ internal_getlogin (cygheap_user &user)
   struct passwd *pw =3D NULL;
   HANDLE ptok =3D INVALID_HANDLE_VALUE;

-  myself->gid =3D DEFAULT_GID;
+  myself->gid =3D UNKNOWN_GID;
   if (wincap.has_security ())
     {
       DWORD siz;

--=====================_1043879716==_--
