Return-Path: <cygwin-patches-return-3487-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9819 invoked by alias); 3 Feb 2003 18:11:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9621 invoked from network); 3 Feb 2003 18:11:28 -0000
Message-Id: <3.0.5.32.20030203130845.007fca80@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Mon, 03 Feb 2003 18:11:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: class cygpsid
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1044313725==_"
X-SW-Source: 2003-q1/txt/msg00136.txt.bz2

--=====================_1044313725==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 966

Corinna,

this patch defines class cygpsid (basically just moving items from cygsid)
and optimizes user_groups::clear_supp ().
The changes in passwd/group are just type changes from cygsid to cygpsid.

Pierre

2003/02/03  Pierre Humblet  <pierre.humblet@ieee.org>

	* security.h (class cygpsid): New class.
	(class cygsid): Use cygpsid as base. Remove members psid, get_id, 
	get_uid, get_gid, string, debug_printf and the == and != operators.
	(cygsidlist::clear_supp): Only do work if setgroups has been called.
	* sec_helper.cc: Define sid_auth NO_COPY. 
	(cygpsid::operator==): New operator.
	(cygpsid::get_id): New function.
	(cygpsid::string): New function.
	(cygsid::string): Delete.
	(cygsid::get_id): Delete.
	* pwdgrp.h: Change arguments of internal_getpwsid,
	internal_getgrsid and internal_getgroups to cygpsid.
	* passwd.cc (internal_getpwsid): Change argument from cygsid to cygpsid.
	* grp.cc (internal_getgrsid): Ditto.
	(internal_getgroups): Ditto.

--=====================_1044313725==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="cygpsid.diff"
Content-length: 9918

Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.37
diff -u -p -r1.37 security.h
--- security.h	3 Feb 2003 15:55:20 -0000	1.37
+++ security.h	3 Feb 2003 16:25:03 -0000
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
@@ -221,6 +228,8 @@ BOOL __stdcall add_access_denied_ace (PA

 void set_security_attribute (int attribute, PSECURITY_ATTRIBUTES psa,
 			     void *sd_buf, DWORD sd_buf_size);
+
+bool get_sids_info (cygpsid, cygpsid, __uid32_t * , __gid32_t *);

 /* Try a subauthentication. */
 HANDLE subauth (struct passwd *pw);
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.33
diff -u -p -r1.33 sec_helper.cc
--- sec_helper.cc	3 Feb 2003 15:55:19 -0000	1.33
+++ sec_helper.cc	3 Feb 2003 16:43:55 -0000
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
@@ -146,39 +184,6 @@ cygsid::getfromgr (const struct __group3
 {
   char *sp =3D (gr && gr->gr_passwd) ? gr->gr_passwd : NULL;
   return (*this =3D sp) !=3D NULL;
-}
-
-__uid32_t
-cygsid::get_id (BOOL search_grp, int *type)
-{
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
-    }
-  return id;
 }

 BOOL
Index: passwd.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.68
diff -u -p -r1.68 passwd.cc
--- passwd.cc	1 Feb 2003 18:41:29 -0000	1.68
+++ passwd.cc	3 Feb 2003 18:00:09 -0000
@@ -97,7 +97,7 @@ pwdgrp::read_passwd ()
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
retrieving revision 1.74
diff -u -p -r1.74 grp.cc
--- grp.cc	1 Feb 2003 18:41:29 -0000	1.74
+++ grp.cc	3 Feb 2003 18:00:27 -0000
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
Index: pwdgrp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pwdgrp.h,v
retrieving revision 1.20
diff -u -p -r1.20 pwdgrp.h
--- pwdgrp.h	1 Feb 2003 18:41:29 -0000	1.20
+++ pwdgrp.h	3 Feb 2003 18:04:07 -0000
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

--=====================_1044313725==_--
