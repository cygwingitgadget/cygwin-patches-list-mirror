Return-Path: <cygwin-patches-return-3201-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1980 invoked by alias); 18 Nov 2002 03:57:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1904 invoked from network); 18 Nov 2002 03:57:11 -0000
Message-Id: <3.0.5.32.20021117224418.0083ac70@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 17 Nov 2002 19:57:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: ntsec patch #4: passwd and group
In-Reply-To: <3DD50A44.40CF5707@ieee.org>
References: <20021108171918.P21920@cygbert.vinschen.de>
 <3DCBEFF5.850B999E@ieee.org>
 <20021111145612.T10395@cygbert.vinschen.de>
 <3DCFC6BB.570DF472@ieee.org>
 <20021111174720.X10395@cygbert.vinschen.de>
 <3DCFE314.3B5B45AB@ieee.org>
 <20021111183423.A10395@cygbert.vinschen.de>
 <3DCFF8AE.66CBD751@ieee.org>
 <20021112144038.F10395@cygbert.vinschen.de>
 <3DD13433.D618DC4F@ieee.org>
 <20021112181849.K10395@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1037609058==_"
X-SW-Source: 2002-q4/txt/msg00152.txt.bz2

--=====================_1037609058==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1896

Corinna,

Almost same as last week, but with the diff and ChangeLog against current CVS.
I also made a small change.

Pierre

At 09:52 AM 11/15/2002 -0500, Pierre A. Humblet wrote:
>Corinna,
>
>Here is the ntsec patch #4 diff. As discussed before, the main motivation
>was to handle more robustly incomplete passwd and group files.
>In the process I fixed some bugs in related code and added
>getpwsid and getgrsid.
>
>This does not try to completely address the issue of invalid pointers
>after a re-read of passwd and group, that will be for later.
>
>Note that there is a small bug fix in the getgroup32 code from
>yesterday and some streamlining in is_grp_member.

(bug is already fixed in CVS)


2002/11/18  Pierre Humblet  <pierre.humblet@ieee.org>

	* security.h: Declare getpwsid and getgrsid. Undeclare 
	internal_getpwent. Define DEFAULT_UID_NT. Change DEFAULT_GID.
	* passwd.cc (getpwsid): Create.
	(internal_getpwent): Suppress.
	(read_etc_passwd): Make static. Rewrite the code for the completion
	line. Set curr_lines to 0.
	(parse_pwd): Change type to static int. Return 0 for short lines.
	(add_pwd_line): Pay attention to the value of parse_pwd.     
	(search_for): Do not look for nor return the DEFAULT_UID.
	* grp.cc (read_etc_group): Make static. Free gr_mem and set 
	curr_lines to 0. Always call add_pwd_line. Rewrite the code for the 
	completion line.
	(parse_grp): If grp.gr_mem is empty, set it to &null_ptr.
	Never NULL gr_passwd. 
	(getgrgid32): Only return the default if ntsec is off and the gid is 
	ILLEGAL_GID.
	* sec_helper.cc (cygsid::get_id): Use getpwsid and getgrsid;
	(cygsid_getfrompw): Clean up last line.
	(cygsid_getfromgr): Ditto.
	(is_grp_member): Use getpwuid32 and getgrgid32.
	* uinfo.cc (internal_getlogin): Set DEFAULT_GID at start.
	Use getpwsid. Move the read of /etc/group after the second access 
	of /etc/passwd. Change some debug_printf. 

--=====================_1037609058==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pwd.diff"
Content-length: 19920

--- security.h.orig	2002-11-12 22:07:16.000000000 -0500
+++ security.h	2002-11-15 19:15:34.000000000 -0500
@@ -11,7 +11,8 @@ details. */
 #include <accctrl.h>

 #define DEFAULT_UID DOMAIN_USER_RID_ADMIN
-#define DEFAULT_GID DOMAIN_ALIAS_RID_ADMINS
+#define DEFAULT_UID_NT 400 /* Non conflicting number */
+#define DEFAULT_GID 401

 #define MAX_SID_LEN 40
 #define MAX_DACL_LEN(n) (sizeof (ACL) \
@@ -208,6 +209,8 @@ extern BOOL allow_smbntsec;
    I didn't find a better place to declare them. */
 extern struct passwd *internal_getpwent (int);
 extern struct __group32 *internal_getgrent (int);
+extern struct passwd *getpwsid (cygsid &);
+extern struct __group32 *getgrsid (cygsid &);

 /* File manipulation */
 int __stdcall set_process_privileges ();
--- passwd.cc.orig	2002-10-24 01:08:58.000000000 -0400
+++ passwd.cc	2002-11-16 13:30:12.000000000 -0500
@@ -27,7 +27,7 @@ details. */
    on the first call that needs information from it. */

 static struct passwd *passwd_buf;	/* passwd contents in memory */
-static int curr_lines;
+static int curr_lines =3D -1;
 static int max_lines;

 static pwdgrp_check passwd_state;
@@ -74,7 +74,7 @@ grab_int (char **p)
 }

 /* Parse /etc/passwd line into passwd structure. */
-void
+static int
 parse_pwd (struct passwd &res, char *buf)
 {
   /* Allocate enough room for the passwd struct and all the strings
@@ -82,6 +82,8 @@ parse_pwd (struct passwd &res, char *buf
   size_t len =3D strlen (buf);
   if (buf[--len] =3D=3D '\r')
     buf[len] =3D '\0';
+  if (len < 6)
+    return 0;

   res.pw_name =3D grab_string (&buf);
   res.pw_passwd =3D grab_string (&buf);
@@ -91,6 +93,7 @@ parse_pwd (struct passwd &res, char *buf
   res.pw_gecos =3D grab_string (&buf);
   res.pw_dir =3D  grab_string (&buf);
   res.pw_shell =3D grab_string (&buf);
+  return 1;
 }

 /* Add one line from /etc/passwd into the password cache */
@@ -102,7 +105,8 @@ add_pwd_line (char *line)
 	max_lines +=3D 10;
 	passwd_buf =3D (struct passwd *) realloc (passwd_buf, max_lines * sizeof =
(struct passwd));
       }
-    parse_pwd (passwd_buf[curr_lines++], line);
+    if (parse_pwd (passwd_buf[curr_lines], line))
+      curr_lines++;
 }

 class passwd_lock
@@ -125,10 +129,32 @@ class passwd_lock

 pthread_mutex_t NO_COPY passwd_lock::mutex =3D (pthread_mutex_t) PTHREAD_M=
UTEX_INITIALIZER;

+/* Cygwin internal */
+/* If this ever becomes non-reentrant, update all the getpw*_r functions */
+static struct passwd *
+search_for (__uid32_t uid, const char *name)
+{
+  struct passwd *res =3D 0;
+
+  for (int i =3D 0; i < curr_lines; i++)
+    {
+      res =3D passwd_buf + i;
+      /* on Windows NT user names are case-insensitive */
+      if (name)
+        {
+	  if (strcasematch (name, res->pw_name))
+	    return res;
+	}
+      else if (uid =3D=3D (__uid32_t) res->pw_uid)
+	return res;
+    }
+  return NULL;
+}
+
 /* Read in /etc/passwd and save contents in the password cache.
    This sets passwd_state to loaded or emulated so functions in this file =
can
    tell that /etc/passwd has been read in or will be emulated. */
-void
+static void
 read_etc_passwd ()
 {
   static pwdgrp_read pr;
@@ -146,97 +172,71 @@ read_etc_passwd ()
   if (passwd_state !=3D initializing)
     {
       passwd_state =3D initializing;
+      curr_lines =3D 0;
       if (pr.open ("/etc/passwd"))
 	{
 	  char *line;
 	  while ((line =3D pr.gets ()) !=3D NULL)
-	    if (strlen (line))
-	      add_pwd_line (line);
+	    add_pwd_line (line);

 	  passwd_state.set_last_modified (pr.get_fhandle (), pr.get_fname ());
-	  passwd_state =3D loaded;
 	  pr.close ();
 	  debug_printf ("Read /etc/passwd, %d lines", curr_lines);
 	}
-      else
-	{
-	  static char linebuf[1024];

-	  if (wincap.has_security ())
-	    {
-	      HANDLE ptok;
-	      cygsid tu, tg;
-	      DWORD siz;
-
-	      if (OpenProcessToken (hMainProc, TOKEN_QUERY, &ptok))
-		{
-		  if (GetTokenInformation (ptok, TokenUser, &tu, sizeof tu,
-					   &siz)
-		      && GetTokenInformation (ptok, TokenPrimaryGroup, &tg,
-					      sizeof tg, &siz))
-		    {
-		      char strbuf[100];
-		      snprintf (linebuf, sizeof (linebuf),
-				"%s::%lu:%lu:%s:%s:/bin/sh",
-				cygheap->user.name (),
-				*GetSidSubAuthority (tu,
-					     *GetSidSubAuthorityCount(tu) - 1),
-				*GetSidSubAuthority (tg,
-					     *GetSidSubAuthorityCount(tg) - 1),
-				tu.string (strbuf), getenv ("HOME") ?: "/");
-		      debug_printf ("Emulating /etc/passwd: %s", linebuf);
-		      add_pwd_line (linebuf);
-		      passwd_state =3D emulated;
-		    }
-		  CloseHandle (ptok);
-		}
-	    }
-	  if (passwd_state !=3D emulated)
-	    {
-	      snprintf (linebuf, sizeof (linebuf), "%s::%u:%u::%s:/bin/sh",
-			cygheap->user.name (), (unsigned) DEFAULT_UID,
-			(unsigned) DEFAULT_GID, getenv ("HOME") ?: "/");
-	      debug_printf ("Emulating /etc/passwd: %s", linebuf);
-	      add_pwd_line (linebuf);
-	      passwd_state =3D emulated;
-	    }
+      static char linebuf[1024];
+      char strbuf[128] =3D "";
+      BOOL searchentry =3D TRUE;
+      __uid32_t default_uid =3D DEFAULT_UID;
+      struct passwd *pw;
+
+      if (wincap.has_security ())
+	{
+	  cygsid tu =3D cygheap->user.sid ();
+	  tu.string (strbuf);
+	  if (myself->uid =3D=3D ILLEGAL_UID &&
+	      (searchentry =3D !getpwsid (tu)))
+	    default_uid =3D DEFAULT_UID_NT;
 	}
-
+      if (searchentry &&
+	  (!(pw =3D search_for (0, cygheap->user.name ())) ||
+	   (myself->uid !=3D ILLEGAL_UID &&
+	    myself->uid !=3D (__uid32_t) pw->pw_uid  &&
+	    !search_for (myself->uid, NULL))))
+	{
+	  snprintf (linebuf, sizeof (linebuf), "%s:*:%u:%u:,%s:%s:/bin/sh",
+		    cygheap->user.name (),
+		    myself->uid =3D=3D ILLEGAL_UID?default_uid:myself->uid,
+		    myself->gid,
+		    strbuf, getenv ("HOME") ?: "/");
+	  debug_printf ("Completing /etc/passwd: %s", linebuf);
+	  add_pwd_line (linebuf);
+	}
+      passwd_state =3D loaded;
     }
-
   return;
 }

-/* Cygwin internal */
-/* If this ever becomes non-reentrant, update all the getpw*_r functions */
-static struct passwd *
-search_for (__uid32_t uid, const char *name)
+struct passwd *
+getpwsid (cygsid &sid)
 {
-  struct passwd *res =3D 0;
-  struct passwd *default_pw =3D 0;
+  struct passwd *pw;
+  char *ptr1, *ptr2, *endptr;
+  char sid_string[128] =3D {0,','};

-  for (int i =3D 0; i < curr_lines; i++)
+  if (curr_lines < 0 && passwd_state  <=3D initializing)
+    read_etc_passwd ();
+
+  if (sid.string (sid_string + 2))
     {
-      res =3D passwd_buf + i;
-      if (res->pw_uid =3D=3D DEFAULT_UID)
-	default_pw =3D res;
-      /* on Windows NT user names are case-insensitive */
-      if (name)
-	{
-	  if (strcasematch (name, res->pw_name))
-	    return res;
-	}
-      else if (uid =3D=3D (__uid32_t) res->pw_uid)
-	return res;
+      endptr =3D strchr (sid_string + 2, 0) - 1;
+      for (int i =3D 0; i < curr_lines; i++)
+	if ((pw =3D passwd_buf + i)->pw_dir > pw->pw_gecos + 8)
+	  for (ptr1 =3D endptr, ptr2 =3D pw->pw_dir - 2;
+	       *ptr1 =3D=3D *ptr2; ptr2--)
+	    if (!*--ptr1)
+	      return pw;
     }
-
-  /* Return default passwd entry if passwd is emulated or it's a
-     request for the current user. */
-  if (passwd_state !=3D loaded
-      || (!name && uid =3D=3D myself->uid)
-      || (name && strcasematch (name, cygheap->user.name ())))
-    return default_pw;
-
   return NULL;
 }

@@ -399,6 +399,7 @@ setpassent ()
   return 0;
 }

+#if 0 /* Unused */
 /* Internal function. ONLY USE THIS INTERNALLY, NEVER `getpwent'!!! */
 struct passwd *
 internal_getpwent (int pos)
@@ -410,6 +411,7 @@ internal_getpwent (int pos)
     return passwd_buf + pos;
   return NULL;
 }
+#endif

 extern "C" char *
 getpass (const char * prompt)
--- grp.cc.orig	2002-11-17 19:57:58.000000000 -0500
+++ grp.cc	2002-11-16 13:28:58.000000000 -0500
@@ -30,7 +30,7 @@ details. */
    on the first call that needs information from it. */

 static struct __group32 *group_buf;		/* group contents in memory */
-static int curr_lines;
+static int curr_lines =3D -1;
 static int max_lines;

 /* Position in the group cache */
@@ -41,6 +41,7 @@ static int grp_pos =3D 0;
 #endif

 static pwdgrp_check group_state;
+static char * NO_COPY null_ptr =3D NULL;

 static int
 parse_grp (struct __group32 &grp, char *line)
@@ -62,13 +63,11 @@ parse_grp (struct __group32 &grp, char *
   if (dp)
     {
       *dp++ =3D '\0';
-      if (!strlen (grp.gr_passwd))
-	grp.gr_passwd =3D NULL;
-
       grp.gr_gid =3D strtol (dp, NULL, 10);
       dp =3D strchr (dp, ':');
       if (dp)
 	{
+	  grp.gr_mem =3D &null_ptr;
 	  if (*++dp)
 	    {
 	      int i =3D 0;
@@ -87,11 +86,9 @@ parse_grp (struct __group32 &grp, char *
 		    }
 		  namearray[i++] =3D dp;
 		  namearray[i] =3D NULL;
+		  grp.gr_mem =3D namearray;
 		}
-	      grp.gr_mem =3D namearray;
 	    }
-	  else
-	    grp.gr_mem =3D (char **) calloc (1, sizeof (char *));
 	  return 1;
 	}
     }
@@ -134,9 +131,7 @@ pthread_mutex_t NO_COPY group_lock::mute
 /* Read in /etc/group and save contents in the group cache */
 /* This sets group_in_memory_p to 1 so functions in this file can
    tell that /etc/group has been read in */
-/* FIXME: should be static but this is called in uinfo_init outside this
-   file */
-void
+static void
 read_etc_group ()
 {
   static pwdgrp_read gr;
@@ -150,76 +145,74 @@ read_etc_group ()
   if (group_state !=3D initializing)
     {
       group_state =3D initializing;
+      for (int i =3D 0; i < curr_lines; i++)
+	if ((group_buf + i)->gr_mem !=3D &null_ptr)
+	  free ((group_buf + i)->gr_mem);
+
+      curr_lines =3D 0;
       if (gr.open ("/etc/group"))
 	{
 	  char *line;
 	  while ((line =3D gr.gets ()) !=3D NULL)
-	    if (strlen (line))
-	      add_grp_line (line);
+            add_grp_line (line);

 	  group_state.set_last_modified (gr.get_fhandle (), gr.get_fname ());
-	  group_state =3D loaded;
 	  gr.close ();
 	  debug_printf ("Read /etc/group, %d lines", curr_lines);
 	}
-      else /* /etc/group doesn't exist -- create default one in memory */
-	{
-	  char group_name [UNLEN + 1];
-	  DWORD group_name_len =3D UNLEN + 1;
-	  char domain_name [INTERNET_MAX_HOST_NAME_LENGTH + 1];
-	  DWORD domain_name_len =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
-	  SID_NAME_USE acType;
+
+      /* Complete /etc/group in memory if needed */
+      if (!getgrgid32 (myself->gid))
+        {
 	  static char linebuf [200];
+	  char group_name [UNLEN + 1] =3D "unknown";
+	  char strbuf[128] =3D "";

 	  if (wincap.has_security ())
-	    {
-	      HANDLE ptok;
-	      cygsid tg;
-	      DWORD siz;
-
-	      if (OpenProcessToken (hMainProc, TOKEN_QUERY, &ptok))
-		{
-		  if (GetTokenInformation (ptok, TokenPrimaryGroup, &tg,
-					   sizeof tg, &siz)
-		      && LookupAccountSidA (NULL, tg, group_name,
-					    &group_name_len, domain_name,
-					    &domain_name_len, &acType))
-		    {
-		      char strbuf[100];
-		      snprintf (linebuf, sizeof (linebuf), "%s:%s:%lu:",
-				group_name,
-				tg.string (strbuf),
-				*GetSidSubAuthority (tg,
-					     *GetSidSubAuthorityCount (tg) - 1));
-		      debug_printf ("Emulating /etc/group: %s", linebuf);
-		      add_grp_line (linebuf);
-		      group_state =3D emulated;
-		    }
-		  CloseHandle (ptok);
-		}
-	    }
-	  if (group_state !=3D emulated)
-	    {
-	      strncpy (group_name, "Administrators", sizeof (group_name));
-	      if (!LookupAccountSidA (NULL, well_known_admins_sid, group_name,
-				      &group_name_len, domain_name,
-				      &domain_name_len, &acType))
-		{
-		  strcpy (group_name, "unknown");
-		  debug_printf ("Failed to get local admins group name. %E");
+            {
+	      DWORD group_name_len =3D UNLEN + 1;
+	      char domain_name [INTERNET_MAX_HOST_NAME_LENGTH + 1];
+	      DWORD domain_name_len =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
+	      SID_NAME_USE acType;
+	      struct __group32 *gr;
+
+	      cygheap->user.groups.pgsid.string (strbuf);
+	      if (!(gr =3D getgrsid (cygheap->user.groups.pgsid)))
+	        {
+		  if (!LookupAccountSidA (NULL, cygheap->user.groups.pgsid,
+					  group_name, &group_name_len,
+					  domain_name, &domain_name_len,
+					  &acType))
+		    debug_printf ("Failed to get primary group name. %E");
 		}
-	      snprintf (linebuf, sizeof (linebuf), "%s::%u:", group_name,
-			(unsigned) DEFAULT_GID);
-	      debug_printf ("Emulating /etc/group: %s", linebuf);
-	      add_grp_line (linebuf);
-	      group_state =3D emulated;
+	      else
+		strlcpy (group_name, gr->gr_name, sizeof (group_name));
 	    }
+	  snprintf (linebuf, sizeof (linebuf), "%s:%s:%lu:%s",
+		    group_name, strbuf, myself->gid, cygheap->user.name ());
+	  debug_printf ("Completing /etc/group: %s", linebuf);
+	  add_grp_line (linebuf);
 	}
+      group_state =3D loaded;
     }
-
   return;
 }

+struct __group32 *
+getgrsid (cygsid &sid)
+{
+  char sid_string[128];
+
+  if (curr_lines < 0 && group_state  <=3D initializing)
+    read_etc_group ();
+
+  if (sid.string (sid_string))
+    for (int i =3D 0; i < curr_lines; i++)
+      if (!strcmp (sid_string, (group_buf + i)->gr_passwd))
+        return group_buf + i;
+  return NULL;
+}
+
 static
 struct __group16 *
 grp32togrp16 (struct __group16 *gp16, struct __group32 *gp32)
@@ -246,13 +239,12 @@ getgrgid32 (__gid32_t gid)

   for (int i =3D 0; i < curr_lines; i++)
     {
-      if (group_buf[i].gr_gid =3D=3D DEFAULT_GID)
+      if (group_buf[i].gr_gid =3D=3D myself->gid)
 	default_grp =3D group_buf + i;
       if (group_buf[i].gr_gid =3D=3D gid)
 	return group_buf + i;
     }
-
-  return allow_ntsec ? NULL : default_grp;
+  return (!allow_ntsec && gid =3D=3D ILLEGAL_GID)?default_grp:NULL;
 }

 extern "C" struct __group16 *
@@ -482,13 +474,9 @@ setgroups32 (int ngroups, const __gid32_
       for (int gidy =3D 0; gidy < gidx; gidy++)
 	if (grouplist[gidy] =3D=3D grouplist[gidx])
 	  goto found; /* Duplicate */
-      for (int gidy =3D 0; (gr =3D internal_getgrent (gidy)); ++gidy)
-	if (gr->gr_gid =3D=3D (__gid32_t) grouplist[gidx])
-	  {
-	    if (gsids.addfromgr (gr))
-	      goto found;
-	    break;
-	  }
+      if ((gr =3D getgrgid32 (grouplist[gidx])) &&
+	  gsids.addfromgr (gr))
+	goto found;
       debug_printf ("No sid found for gid %d", grouplist[gidx]);
       gsids.free_sids ();
       set_errno (EINVAL);
--- sec_helper.cc.orig	2002-11-14 17:41:00.000000000 -0500
+++ sec_helper.cc	2002-11-16 16:18:10.000000000 -0500
@@ -118,21 +118,20 @@ BOOL
 cygsid::getfrompw (const struct passwd *pw)
 {
   char *sp =3D (pw && pw->pw_gecos) ? strrchr (pw->pw_gecos, ',') : NULL;
-  return (*this =3D sp ? sp + 1 : "") !=3D NULL;
+  return (*this =3D sp ? sp + 1 : sp) !=3D NULL;
 }

 BOOL
 cygsid::getfromgr (const struct __group32 *gr)
 {
   char *sp =3D (gr && gr->gr_passwd) ? gr->gr_passwd : NULL;
-  return (*this =3D sp ?: "") !=3D NULL;
+  return (*this =3D sp) !=3D NULL;
 }

 __uid32_t
 cygsid::get_id (BOOL search_grp, int *type)
 {
   /* First try to get SID from passwd or group entry */
-  cygsid sid;
   __uid32_t id =3D ILLEGAL_UID;

   if (!search_grp)
@@ -140,42 +139,25 @@ cygsid::get_id (BOOL search_grp, int *ty
       struct passwd *pw;
       if (*this =3D=3D cygheap->user.sid ())
 	id =3D myself->uid;
-      else
-	for (int pidx =3D 0; (pw =3D internal_getpwent (pidx)); ++pidx)
-          {
-	    if (sid.getfrompw (pw) && sid =3D=3D psid)
-	      {
-		id =3D pw->pw_uid;
-		break;
-	      }
-	  }
+      else if ((pw =3D getpwsid (*this)))
+	id =3D pw->pw_uid;
       if (id !=3D ILLEGAL_UID)
 	{
 	  if (type)
 	    *type =3D USER;
 	   return id;
-	 }
+	}
     }
   if (search_grp || type)
     {
       struct __group32 *gr;
       if (cygheap->user.groups.pgsid =3D=3D psid)
 	id =3D myself->gid;
-      else
-	for (int gidx =3D 0; (gr =3D internal_getgrent (gidx)); ++gidx)
-	  {
-	    if (sid.getfromgr (gr) && sid =3D=3D psid)
-	      {
-		id =3D gr->gr_gid;
-		break;
-	      }
-	  }
-      if (id !=3D ILLEGAL_UID)
-	{
-	  if (type)
-	    *type =3D GROUP;
-	}
-     }
+      else if ((gr =3D getgrsid (*this)))
+	id =3D gr->gr_gid;
+      if (id !=3D ILLEGAL_UID && type)
+	*type =3D GROUP;
+    }
   return id;
 }

@@ -208,24 +190,17 @@ is_grp_member (__uid32_t uid, __gid32_t
     }

   /* Otherwise try getting info from examining passwd and group files. */
-  for (int idx =3D 0; (pw =3D internal_getpwent (idx)); ++idx)
-    if ((__uid32_t) pw->pw_uid =3D=3D uid)
-      {
-	/* If gid =3D=3D primary group of uid, return immediately. */
-	if ((__gid32_t) pw->pw_gid =3D=3D gid)
-	  return TRUE;
-	/* Otherwise search for supplementary user list of this group. */
-	for (idx =3D 0; (gr =3D internal_getgrent (idx)); ++idx)
-	  if ((__gid32_t) gr->gr_gid =3D=3D gid)
-	    {
-	      if (gr->gr_mem)
-		for (idx =3D 0; gr->gr_mem[idx]; ++idx)
-		  if (strcasematch (cygheap->user.name (), gr->gr_mem[idx]))
-		    return TRUE;
-	      return FALSE;
-	    }
-        return FALSE;
-      }
+  if ((pw =3D getpwuid32 (uid)))
+    {
+      /* If gid =3D=3D primary group of uid, return immediately. */
+      if ((__gid32_t) pw->pw_gid =3D=3D gid)
+	return TRUE;
+      /* Otherwise search for supplementary user list of this group. */
+      if ((gr =3D getgrgid32 (gid)) && gr->gr_mem)
+	for (idx =3D 0; gr->gr_mem[idx]; ++idx)
+	  if (strcasematch (cygheap->user.name (), gr->gr_mem[idx]))
+	    return TRUE;
+    }
   return FALSE;
 }

--- uinfo.cc.orig	2002-11-02 11:51:30.000000000 -0500
+++ uinfo.cc	2002-11-04 21:00:14.000000000 -0500
@@ -34,10 +34,11 @@ void
 internal_getlogin (cygheap_user &user)
 {
   struct passwd *pw =3D NULL;
+  HANDLE ptok =3D INVALID_HANDLE_VALUE;

+  myself->gid =3D DEFAULT_GID;
   if (wincap.has_security ())
     {
-      HANDLE ptok =3D INVALID_HANDLE_VALUE;
       DWORD siz;
       cygsid tu;
       DWORD ret =3D 0;
@@ -58,52 +59,39 @@ internal_getlogin (cygheap_user &user)
 	 If we have a SID, try to get the corresponding Cygwin
 	 password entry. Set user name which can be different
 	 from the Windows user name */
-       if (ret)
-	 {
-	  cygsid gsid (NO_SID);
-	  cygsid psid;
-
-	  for (int pidx =3D 0; (pw =3D internal_getpwent (pidx)); ++pidx)
-	    if (psid.getfrompw (pw) && EqualSid (user.sid (), psid))
-	      {
-		user.set_name (pw->pw_name);
-		struct __group32 *gr =3D getgrgid32 (pw->pw_gid);
-		if (gr)
-		  if (!gsid.getfromgr (gr))
-		      gsid =3D NO_SID;
-		break;
-	      }
-
-	  /* Set token owner to the same value as token user and
-	     primary group to the group in /etc/passwd. */
+      if (ret)
+	{
+	  if ((pw =3D getpwsid (tu)))
+	    user.set_name (pw->pw_name);
+	  /* Set token owner to the same value as token user */
 	  if (!SetTokenInformation (ptok, TokenOwner, &tu, sizeof tu))
 	    debug_printf ("SetTokenInformation(TokenOwner): %E");
-	  if (gsid)
-	    {
-	      user.groups.pgsid =3D gsid;
-	      if (!SetTokenInformation (ptok, TokenPrimaryGroup,
-					&gsid, sizeof gsid))
-		debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
-	    }
 	 }
-      if (ptok !=3D INVALID_HANDLE_VALUE)
-	CloseHandle (ptok);
     }

-  if (!pw)
-    pw =3D getpwnam (user.name ());
-
-  if (pw)
+  if (!pw && !(pw =3D getpwnam (user.name ())))
+    debug_printf("user name not found in augmented /etc/passwd");
+  else
     {
       myself->uid =3D pw->pw_uid;
       myself->gid =3D pw->pw_gid;
+      if (wincap.has_security ())
+        {
+	  cygsid gsid;
+	  if (gsid.getfromgr (getgrgid32 (pw->pw_gid)))
+	    {
+	      /* Set primary group to the group in /etc/passwd. */
+	      user.groups.pgsid =3D gsid;
+	      if (!SetTokenInformation (ptok, TokenPrimaryGroup,
+					&gsid, sizeof gsid))
+		debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
+	    }
+	  else
+	    debug_printf ("gsid not found in augmented /etc/group");
+	}
     }
-  else
-    {
-      myself->uid =3D DEFAULT_UID;
-      myself->gid =3D DEFAULT_GID;
-    }
-
+  if (ptok !=3D INVALID_HANDLE_VALUE)
+    CloseHandle (ptok);
   (void) cygheap->user.ontherange (CH_HOME, pw);

   return;

--=====================_1037609058==_--
