Return-Path: <cygwin-patches-return-3235-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26242 invoked by alias); 26 Nov 2002 05:12:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26233 invoked from network); 26 Nov 2002 05:12:48 -0000
Message-Id: <3.0.5.32.20021126000911.00833190@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 25 Nov 2002 21:12:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Internal get{pw,gr}XX calls
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1038305351==_"
X-SW-Source: 2002-q4/txt/msg00186.txt.bz2

--=====================_1038305351==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 3553

Hello Corinna,

Here is the patch to define and use internal_get{pw,gr}XX.
Lots of small changes. Please check particularly the modification
in sec_acl.cc:acl_access.

I didn't remove the external call from glob.c. It's a C file,
so that would require a lot of work. Also it's only called during
initialization, thus it can't destroy areas used by external calls.

I made minor fixes in passwd.cc and grp.cc. 
parse_pwd now checks for incomplete entries but I didn't make
it very strict (it checks up to the pw_gid field) as I didn't want 
to break anything. Feel free to make it tougher.
A debug_printf might be nice in case of rejection, but there isn't
one in parse_grp (which is very strict) so I didn't put one here
either. It's your call.

I didn't touch anything that's thread related. That's an area still
requiring work.

Pierre
 
2002-11-25  Pierre Humblet <pierre.humblet@ieee.org>

	* security.h: Move declarations of internal_getgrent,
	internal_getpwsid and internal_getgrsid to pwdgrp.h.
	* pwdgrp.h: Declare internal_getpwsid, internal_getpwnam,
	internal_getpwuid, internal_getgrsid, internal_getgrgid, 
	internal_getgrnam, internal_getgrent and internal_getgroups. 
	Delete "emulated" from enum pwdgrp_state.
	(pwdgrp_check::isuninitialized): Create.
	(pwdgrp_check::pwdgrp_state): Change state to initializing
	rather than to uninitialized.
	(pwdgrp_read::gets): Remove trailing CRs.
	* passwd.cc (grab_string): Don't look for NLs.
	(grab_int): Ditto.
	(parse_pwd): Don't look for CRs. Return 0 if entry is too short.
	(search_for): Delete.
	(read_etc_passwd): Simplify tests to actually read the file.
	Set state to loaded before making internal_getpwXX calls.
	Replace search_for calls by equivalent internal_pwgetXX calls. 
	(internal_getpwsid): Use passwd_state.isuninitialized to decide
	to call read_etc_passwd.
	(internal_getpwuid): Create.
	(internal_getpwnam): Create.
	(getpwuid32): Simply call internal_getpwuid.
	(getpwuid_r32): Call internal_getpwuid.
	(getpwnam): Simply call internal_getpwnam.
	(getpwnam_r): Call internal_getpwnam.
	* grp.cc (parse_grp): Don't look for CRs. Adjust blank space.
	(add_grp_line): Adjust blank space.
	(class group_lock): Ditto.
	(read_etc_group): Simplify tests to actually read the file.
	Set state to loaded before making internal_getgrXX calls.
	Replace getgrXX calls by equivalent internal calls.
	(internal_getgrsid): Use group_state.isuninitialized to decide
	to call read_etc_group.
	(internal_getgrgid): Create.
	(internal_getgrnam): Create.
	(getgroups32): Simply call internal_getgrgid.
	(getgrnam32): Simply call internal_getgrnam.
	(internal_getgrent): Call group_state.isuninitialized.
	(internal_getgroups): Create from the former getgroups32, using
	two of the four arguments. Set gid to myself->gid and username
	to cygheap->user.name ().
	(getgroups32): Simply call internal_getgroup.
	(getgroups): Call internal_getgroup instead of getgroups32.
	(setgroups32): Call internal versions of get{pw,gr}XX.
	* sec_helper.cc: Include pwdgrp.h.
	(is_grp_member): Call internal versions of get{pw,gr}XX.
	* security.cc: Include pwdgrp.h.
	(alloc_sd): Call internal versions of get{pw,gr}XX.
	* syscalls.cc: Include pwdgrp.h.
	(seteuid32): Call internal versions of get{pw,gr}XX.
	(setegid32): Ditto.
	* uinfo.cc: Include pwdgrp.h.
	(internal_getlogin): Call internal versions of get{pw,gr}XX.
	(cygheap_user::ontherange): Ditto.
	* sec_acl.cc: Include pwdgrp.h.
	(setacl): Call internal versions of get{pw,gr}XX.
	(acl_access): Ditto and simplify logic.
	(aclfromtext): Ditto.

--=====================_1038305351==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="intern.diff"
Content-length: 26293

Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.34
diff -u -p -r1.34 security.h
--- security.h	20 Nov 2002 17:10:05 -0000	1.34
+++ security.h	26 Nov 2002 00:57:13 -0000
@@ -204,13 +204,6 @@ extern BOOL allow_ntea;
 extern BOOL allow_ntsec;
 extern BOOL allow_smbntsec;

-/* These functions are needed to allow walking through the passwd
-   and group lists so they are somehow security related. Besides that
-   I didn't find a better place to declare them. */
-extern struct __group32 *internal_getgrent (int);
-extern struct passwd *internal_getpwsid (cygsid &);
-extern struct __group32 *internal_getgrsid (cygsid &);
-
 /* File manipulation */
 int __stdcall set_process_privileges ();
 int __stdcall get_file_attribute (int, const char *, int *,
Index: pwdgrp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pwdgrp.h,v
retrieving revision 1.7
diff -u -p -r1.7 pwdgrp.h
--- pwdgrp.h	24 Oct 2002 14:33:13 -0000	1.7
+++ pwdgrp.h	26 Nov 2002 01:06:53 -0000
@@ -10,10 +10,20 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */

+/* These functions are needed to allow searching and walking through
+   the passwd and group lists */
+extern struct passwd *internal_getpwsid (cygsid &);
+extern struct passwd *internal_getpwnam (const char *, BOOL =3D FALSE);
+extern struct passwd *internal_getpwuid (__uid32_t, BOOL =3D FALSE);
+extern struct __group32 *internal_getgrsid (cygsid &);
+extern struct __group32 *internal_getgrgid (__gid32_t gid, BOOL =3D FALSE);
+extern struct __group32 *internal_getgrnam (const char *, BOOL =3D FALSE);
+extern struct __group32 *internal_getgrent (int);
+int internal_getgroups (int, __gid32_t *);
+
 enum pwdgrp_state {
   uninitialized =3D 0,
   initializing,
-  emulated,
   loaded
 };

@@ -34,7 +44,7 @@ public:
 	  if ((h =3D FindFirstFile (file_w32, &data)) !=3D INVALID_HANDLE_VALUE)
 	    {
 	      if (CompareFileTime (&data.ftLastWriteTime, &last_modified) > 0)
-		state =3D uninitialized;
+		state =3D initializing;
 	      FindClose (h);
 	    }
 	}
@@ -44,6 +54,7 @@ public:
     {
       state =3D nstate;
     }
+  BOOL isuninitialized () const { return state =3D=3D uninitialized; }
   void set_last_modified (HANDLE fh, const char *name)
     {
       if (!file_w32[0])
@@ -101,7 +112,11 @@ public:
       lptr =3D eptr;
     eptr =3D strchr (lptr, '\n');
     if (eptr)
-      *eptr++ =3D '\0';
+      {
+	if (eptr > lptr && *(eptr - 1) =3D=3D '\r')
+          *(eptr - 1) =3D 0;
+	*eptr++ =3D '\0';
+      }
     return lptr;
   }
   inline HANDLE get_fhandle () { return fh; }
Index: passwd.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.53
diff -u -p -r1.53 passwd.cc
--- passwd.cc	25 Nov 2002 15:11:39 -0000	1.53
+++ passwd.cc	26 Nov 2002 01:25:42 -0000
@@ -27,7 +27,7 @@ details. */
    on the first call that needs information from it. */

 static struct passwd *passwd_buf;	/* passwd contents in memory */
-static int curr_lines =3D -1;
+static int curr_lines;
 static int max_lines;

 static pwdgrp_check passwd_state;
@@ -47,7 +47,7 @@ grab_string (char **p)
   char *src =3D *p;
   char *res =3D src;

-  while (*src && *src !=3D ':' && *src !=3D '\n')
+  while (*src && *src !=3D ':')
     src++;

   if (*src =3D=3D ':')
@@ -65,7 +65,7 @@ grab_int (char **p)
 {
   char *src =3D *p;
   int val =3D strtol (src, NULL, 10);
-  while (*src && *src !=3D ':' && *src !=3D '\n')
+  while (*src && *src !=3D ':')
     src++;
   if (*src =3D=3D ':')
     src++;
@@ -79,15 +79,11 @@ parse_pwd (struct passwd &res, char *buf
 {
   /* Allocate enough room for the passwd struct and all the strings
      in it in one go */
-  size_t len =3D strlen (buf);
-  if (buf[--len] =3D=3D '\r')
-    buf[len] =3D '\0';
-  if (len < 6)
-    return 0;
-
   res.pw_name =3D grab_string (&buf);
   res.pw_passwd =3D grab_string (&buf);
   res.pw_uid =3D grab_int (&buf);
+  if (!*buf)
+    return 0;
   res.pw_gid =3D grab_int (&buf);
   res.pw_comment =3D 0;
   res.pw_gecos =3D grab_string (&buf);
@@ -129,28 +125,6 @@ class passwd_lock

 pthread_mutex_t NO_COPY passwd_lock::mutex =3D (pthread_mutex_t) PTHREAD_M=
UTEX_INITIALIZER;

-/* Cygwin internal */
-/* If this ever becomes non-reentrant, update all the getpw*_r functions */
-static struct passwd *
-search_for (__uid32_t uid, const char *name)
-{
-  struct passwd *res =3D 0;
-
-  for (int i =3D 0; i < curr_lines; i++)
-    {
-      res =3D passwd_buf + i;
-      /* on Windows NT user names are case-insensitive */
-      if (name)
-        {
-	  if (strcasematch (name, res->pw_name))
-	    return res;
-	}
-      else if (uid =3D=3D (__uid32_t) res->pw_uid)
-	return res;
-    }
-  return NULL;
-}
-
 /* Read in /etc/passwd and save contents in the password cache.
    This sets passwd_state to loaded or emulated so functions in this file =
can
    tell that /etc/passwd has been read in or will be emulated. */
@@ -166,12 +140,8 @@ read_etc_passwd ()
   passwd_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_passwd may have been process=
ed */
-  if (passwd_state !=3D uninitialized)
-    return;
-
-  if (passwd_state !=3D initializing)
+  if (passwd_state <=3D initializing)
     {
-      passwd_state =3D initializing;
       curr_lines =3D 0;
       if (pr.open ("/etc/passwd"))
 	{
@@ -183,6 +153,7 @@ read_etc_passwd ()
 	  pr.close ();
 	  debug_printf ("Read /etc/passwd, %d lines", curr_lines);
 	}
+      passwd_state =3D loaded;

       static char linebuf[1024];
       char strbuf[128] =3D "";
@@ -199,12 +170,12 @@ read_etc_passwd ()
 	    default_uid =3D DEFAULT_UID_NT;
 	}
       else if (myself->uid =3D=3D ILLEGAL_UID)
-        searchentry =3D !search_for (DEFAULT_UID, NULL);
+        searchentry =3D !internal_getpwuid (DEFAULT_UID);
       if (searchentry &&
-	  (!(pw =3D search_for (0, cygheap->user.name ())) ||
+	  (!(pw =3D internal_getpwnam (cygheap->user.name ())) ||
 	   (myself->uid !=3D ILLEGAL_UID &&
 	    myself->uid !=3D (__uid32_t) pw->pw_uid  &&
-	    !search_for (myself->uid, NULL))))
+	    !internal_getpwuid (myself->uid))))
 	{
 	  snprintf (linebuf, sizeof (linebuf), "%s:*:%lu:%lu:,%s:%s:/bin/sh",
 		    cygheap->user.name (),
@@ -214,7 +185,6 @@ read_etc_passwd ()
 	  debug_printf ("Completing /etc/passwd: %s", linebuf);
 	  add_pwd_line (linebuf);
 	}
-      passwd_state =3D loaded;
     }
   return;
 }
@@ -226,7 +196,7 @@ internal_getpwsid (cygsid &sid)
   char *ptr1, *ptr2, *endptr;
   char sid_string[128] =3D {0,','};

-  if (curr_lines < 0 && passwd_state  <=3D initializing)
+  if (passwd_state.isuninitialized ())
     read_etc_passwd ();

   if (sid.string (sid_string + 2))
@@ -242,15 +212,40 @@ internal_getpwsid (cygsid &sid)
   return NULL;
 }

-extern "C" struct passwd *
-getpwuid32 (__uid32_t uid)
+struct passwd *
+internal_getpwuid (__uid32_t uid, BOOL check)
 {
-  if (passwd_state  <=3D initializing)
+  if (passwd_state.isuninitialized ()
+      || (check && passwd_state  <=3D initializing))
     read_etc_passwd ();

-  pthread_testcancel ();
+  for (int i =3D 0; i < curr_lines; i++)
+    if (uid =3D=3D (__uid32_t) passwd_buf[i].pw_uid)
+      return passwd_buf + i;
+  return NULL;
+}
+
+struct passwd *
+internal_getpwnam (const char *name, BOOL check)
+{
+  if (passwd_state.isuninitialized ()
+      || (check && passwd_state  <=3D initializing))
+    read_etc_passwd ();
+
+  for (int i =3D 0; i < curr_lines; i++)
+    /* on Windows NT user names are case-insensitive */
+    if (strcasematch (name, passwd_buf[i].pw_name))
+      return passwd_buf + i;
+  return NULL;
+}

-  return search_for (uid, 0);
+
+extern "C" struct passwd *
+getpwuid32 (__uid32_t uid)
+{
+  struct passwd *temppw =3D internal_getpwuid (uid, TRUE);
+  pthread_testcancel ();
+  return temppw;
 }

 extern "C" struct passwd *
@@ -267,13 +262,8 @@ getpwuid_r32 (__uid32_t uid, struct pass
   if (!pwd || !buffer)
     return ERANGE;

-  if (passwd_state  <=3D initializing)
-    read_etc_passwd ();
-
+  struct passwd *temppw =3D internal_getpwuid (uid, TRUE);
   pthread_testcancel ();
-
-  struct passwd *temppw =3D search_for (uid, 0);
-
   if (!temppw)
     return 0;

@@ -310,12 +300,9 @@ getpwuid_r (__uid16_t uid, struct passwd
 extern "C" struct passwd *
 getpwnam (const char *name)
 {
-  if (passwd_state  <=3D initializing)
-    read_etc_passwd ();
-
+  struct passwd *temppw =3D internal_getpwnam (name, TRUE);
   pthread_testcancel ();
-
-  return search_for (0, name);
+  return temppw;
 }


@@ -331,13 +318,9 @@ getpwnam_r (const char *nam, struct pass
   if (!pwd || !buffer || !nam)
     return ERANGE;

-  if (passwd_state  <=3D initializing)
-    read_etc_passwd ();
-
+  struct passwd *temppw =3D internal_getpwnam (nam, TRUE);
   pthread_testcancel ();

-  struct passwd *temppw =3D search_for (0, nam);
-
   if (!temppw)
     return 0;

@@ -400,20 +383,6 @@ setpassent ()
 {
   return 0;
 }
-
-#if 0 /* Unused */
-/* Internal function. ONLY USE THIS INTERNALLY, NEVER `getpwent'!!! */
-struct passwd *
-internal_getpwent (int pos)
-{
-  if (passwd_state  <=3D initializing)
-    read_etc_passwd ();
-
-  if (pos < curr_lines)
-    return passwd_buf + pos;
-  return NULL;
-}
-#endif

 extern "C" char *
 getpass (const char * prompt)
Index: grp.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.60
diff -u -p -r1.60 grp.cc
--- grp.cc	20 Nov 2002 17:10:05 -0000	1.60
+++ grp.cc	26 Nov 2002 02:47:05 -0000
@@ -30,7 +30,7 @@ details. */
    on the first call that needs information from it. */

 static struct __group32 *group_buf;		/* group contents in memory */
-static int curr_lines =3D -1;
+static int curr_lines;
 static int max_lines;

 /* Position in the group cache */
@@ -46,10 +46,6 @@ static char * NO_COPY null_ptr =3D NULL;
 static int
 parse_grp (struct __group32 &grp, char *line)
 {
-  int len =3D strlen (line);
-  if (line[--len] =3D=3D '\r')
-    line[len] =3D '\0';
-
   char *dp =3D strchr (line, ':');

   if (!dp)
@@ -100,10 +96,10 @@ static void
 add_grp_line (char *line)
 {
     if (curr_lines =3D=3D max_lines)
-    {
+      {
 	max_lines +=3D 10;
 	group_buf =3D (struct __group32 *) realloc (group_buf, max_lines * sizeof=
 (struct __group32));
-    }
+      }
     if (parse_grp (group_buf[curr_lines], line))
       curr_lines++;
 }
@@ -114,15 +110,15 @@ class group_lock
   static NO_COPY pthread_mutex_t mutex;
  public:
   group_lock (bool doit)
-  {
-    if (armed =3D doit)
-      pthread_mutex_lock (&mutex);
-  }
+    {
+      if (armed =3D doit)
+        pthread_mutex_lock (&mutex);
+    }
   ~group_lock ()
-  {
-    if (armed)
-      pthread_mutex_unlock (&mutex);
-  }
+    {
+      if (armed)
+        pthread_mutex_unlock (&mutex);
+    }
 };

 pthread_mutex_t NO_COPY group_lock::mutex =3D (pthread_mutex_t) PTHREAD_MU=
TEX_INITIALIZER;
@@ -139,12 +135,8 @@ read_etc_group ()
   group_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_group may have been processe=
d */
-  if (group_state !=3D uninitialized)
-    return;
-
-  if (group_state !=3D initializing)
+  if (group_state <=3D initializing)
     {
-      group_state =3D initializing;
       for (int i =3D 0; i < curr_lines; i++)
 	if ((group_buf + i)->gr_mem !=3D &null_ptr)
 	  free ((group_buf + i)->gr_mem);
@@ -160,9 +152,10 @@ read_etc_group ()
 	  gr.close ();
 	  debug_printf ("Read /etc/group, %d lines", curr_lines);
 	}
+      group_state =3D loaded;

       /* Complete /etc/group in memory if needed */
-      if (!getgrgid32 (myself->gid))
+      if (!internal_getgrgid (myself->gid))
         {
 	  static char linebuf [200];
 	  char group_name [UNLEN + 1] =3D "unknown";
@@ -181,7 +174,6 @@ read_etc_group ()
 	  debug_printf ("Completing /etc/group: %s", linebuf);
 	  add_grp_line (linebuf);
 	}
-      group_state =3D loaded;
     }
   return;
 }
@@ -191,16 +183,50 @@ internal_getgrsid (cygsid &sid)
 {
   char sid_string[128];

-  if (curr_lines < 0 && group_state  <=3D initializing)
+  if (group_state.isuninitialized ())
     read_etc_group ();

   if (sid.string (sid_string))
     for (int i =3D 0; i < curr_lines; i++)
-      if (!strcmp (sid_string, (group_buf + i)->gr_passwd))
+      if (!strcmp (sid_string, group_buf[i].gr_passwd))
         return group_buf + i;
   return NULL;
 }

+struct __group32 *
+internal_getgrgid (__gid32_t gid, BOOL check)
+{
+  struct __group32 * default_grp =3D NULL;
+
+  if (group_state.isuninitialized ()
+      || (check && group_state  <=3D initializing))
+    read_etc_group ();
+
+  for (int i =3D 0; i < curr_lines; i++)
+    {
+      if (group_buf[i].gr_gid =3D=3D myself->gid)
+	default_grp =3D group_buf + i;
+      if (group_buf[i].gr_gid =3D=3D gid)
+	return group_buf + i;
+    }
+  return allow_ntsec || gid !=3D ILLEGAL_GID ? NULL : default_grp;
+}
+
+struct __group32 *
+internal_getgrnam (const char *name, BOOL check)
+{
+  if (group_state.isuninitialized ()
+      || (check && group_state  <=3D initializing))
+    read_etc_group ();
+
+  for (int i =3D 0; i < curr_lines; i++)
+    if (strcasematch (group_buf[i].gr_name, name))
+      return group_buf + i;
+
+  /* Didn't find requested group */
+  return NULL;
+}
+
 static
 struct __group16 *
 grp32togrp16 (struct __group16 *gp16, struct __group32 *gp32)
@@ -221,18 +247,7 @@ grp32togrp16 (struct __group16 *gp16, st
 extern "C" struct __group32 *
 getgrgid32 (__gid32_t gid)
 {
-  struct __group32 * default_grp =3D NULL;
-  if (group_state  <=3D initializing)
-    read_etc_group ();
-
-  for (int i =3D 0; i < curr_lines; i++)
-    {
-      if (group_buf[i].gr_gid =3D=3D myself->gid)
-	default_grp =3D group_buf + i;
-      if (group_buf[i].gr_gid =3D=3D gid)
-	return group_buf + i;
-    }
-  return allow_ntsec || gid !=3D ILLEGAL_GID ? NULL : default_grp;
+  return internal_getgrgid (gid, TRUE);
 }

 extern "C" struct __group16 *
@@ -246,15 +261,7 @@ getgrgid (__gid16_t gid)
 extern "C" struct __group32 *
 getgrnam32 (const char *name)
 {
-  if (group_state  <=3D initializing)
-    read_etc_group ();
-
-  for (int i =3D 0; i < curr_lines; i++)
-    if (strcasematch (group_buf[i].gr_name, name))
-      return group_buf + i;
-
-  /* Didn't find requested group */
-  return NULL;
+  return internal_getgrnam (name, TRUE);
 }

 extern "C" struct __group16 *
@@ -301,7 +308,7 @@ setgrent ()
 struct __group32 *
 internal_getgrent (int pos)
 {
-  if (group_state  <=3D initializing)
+  if (group_state.isuninitialized ())
     read_etc_group ();

   if (pos < curr_lines)
@@ -310,16 +317,14 @@ internal_getgrent (int pos)
 }

 int
-getgroups32 (int gidsetsize, __gid32_t *grouplist, __gid32_t gid,
-	     const char *username)
+internal_getgroups (int gidsetsize, __gid32_t *grouplist)
 {
   HANDLE hToken =3D NULL;
   DWORD size;
   int cnt =3D 0;
   struct __group32 *gr;
-
-  if (group_state  <=3D initializing)
-    read_etc_group ();
+  __gid32_t gid;
+  const char *username;

   if (allow_ntsec)
     {
@@ -368,6 +373,8 @@ getgroups32 (int gidsetsize, __gid32_t *
 	return cnt;
     }

+  gid =3D myself->gid;
+  username =3D cygheap->user.name ();
   for (int gidx =3D 0; (gr =3D internal_getgrent (gidx)); ++gidx)
     if (gid =3D=3D gr->gr_gid)
       {
@@ -397,8 +404,7 @@ error:
 extern "C" int
 getgroups32 (int gidsetsize, __gid32_t *grouplist)
 {
-  return getgroups32 (gidsetsize, grouplist, myself->gid,
-		      cygheap->user.name ());
+  return internal_getgroups (gidsetsize, grouplist);
 }

 extern "C" int
@@ -414,8 +420,7 @@ getgroups (int gidsetsize, __gid16_t *gr
   if (gidsetsize > 0 && grouplist)
     grouplist32 =3D (__gid32_t *) alloca (gidsetsize * sizeof (__gid32_t));

-  int ret =3D getgroups32 (gidsetsize, grouplist32, myself->gid,
-			 cygheap->user.name ());
+  int ret =3D internal_getgroups (gidsetsize, grouplist32);

   if (gidsetsize > 0 && grouplist)
     for (int i =3D 0; i < ret; ++ i)
@@ -462,7 +467,7 @@ setgroups32 (int ngroups, const __gid32_
       for (int gidy =3D 0; gidy < gidx; gidy++)
 	if (grouplist[gidy] =3D=3D grouplist[gidx])
 	  goto found; /* Duplicate */
-      if ((gr =3D getgrgid32 (grouplist[gidx])) &&
+      if ((gr =3D internal_getgrgid (grouplist[gidx])) &&
 	  gsids.addfromgr (gr))
 	goto found;
       debug_printf ("No sid found for gid %d", grouplist[gidx]);
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.29
diff -u -p -r1.29 sec_helper.cc
--- sec_helper.cc	20 Nov 2002 17:10:05 -0000	1.29
+++ sec_helper.cc	26 Nov 2002 02:49:45 -0000
@@ -31,6 +31,7 @@ details. */
 #include "dtable.h"
 #include "pinfo.h"
 #include "cygheap.h"
+#include "pwdgrp.h"

 /* General purpose security attribute objects for global use. */
 SECURITY_ATTRIBUTES NO_COPY sec_none;
@@ -164,7 +165,6 @@ cygsid::get_id (BOOL search_grp, int *ty
 BOOL
 is_grp_member (__uid32_t uid, __gid32_t gid)
 {
-  extern int getgroups32 (int, __gid32_t *, __gid32_t, const char *);
   struct passwd *pw;
   struct __group32 *gr;
   int idx;
@@ -176,12 +176,11 @@ is_grp_member (__uid32_t uid, __gid32_t
       /* If gid =3D=3D primary group of current user, return immediately. =
*/
       if (gid =3D=3D myself->gid)
         return TRUE;
-      /* Calling getgroups32 only makes sense when reading the access toke=
n. */
+      /* Calling getgroups only makes sense when reading the access token.=
 */
       if (allow_ntsec)
         {
 	  __gid32_t grps[NGROUPS_MAX];
-	  int cnt =3D getgroups32 (NGROUPS_MAX, grps, myself->gid,
-				 cygheap->user.name ());
+	  int cnt =3D internal_getgroups (NGROUPS_MAX, grps);
 	  for (idx =3D 0; idx < cnt; ++idx)
 	    if (grps[idx] =3D=3D gid)
 	      return TRUE;
@@ -190,13 +189,13 @@ is_grp_member (__uid32_t uid, __gid32_t
     }

   /* Otherwise try getting info from examining passwd and group files. */
-  if ((pw =3D getpwuid32 (uid)))
+  if ((pw =3D internal_getpwuid (uid)))
     {
       /* If gid =3D=3D primary group of uid, return immediately. */
       if ((__gid32_t) pw->pw_gid =3D=3D gid)
 	return TRUE;
       /* Otherwise search for supplementary user list of this group. */
-      if ((gr =3D getgrgid32 (gid)) && gr->gr_mem)
+      if ((gr =3D internal_getgrgid (gid)))
 	for (idx =3D 0; gr->gr_mem[idx]; ++idx)
 	  if (strcasematch (cygheap->user.name (), gr->gr_mem[idx]))
 	    return TRUE;
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.127
diff -u -p -r1.127 security.cc
--- security.cc	20 Nov 2002 09:23:20 -0000	1.127
+++ security.cc	26 Nov 2002 02:52:05 -0000
@@ -39,6 +39,7 @@ details. */
 #include <ntdef.h>
 #include "ntdll.h"
 #include "lm.h"
+#include "pwdgrp.h"

 extern BOOL allow_ntea;
 BOOL allow_ntsec;
@@ -1550,7 +1551,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
     owner_sid =3D cygheap->user.sid ();
   else if (uid =3D=3D ILLEGAL_UID)
     owner_sid =3D cur_owner_sid;
-  else if (!owner_sid.getfrompw (getpwuid32 (uid)))
+  else if (!owner_sid.getfrompw (internal_getpwuid (uid)))
     {
       set_errno (EINVAL);
       return NULL;
@@ -1564,7 +1565,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
     group_sid =3D cygheap->user.groups.pgsid;
   else if (gid =3D=3D ILLEGAL_GID)
     group_sid =3D cur_group_sid;
-  else if (!group_sid.getfromgr (getgrgid32 (gid)))
+  else if (!group_sid.getfromgr (internal_getgrgid (gid)))
     {
       set_errno (EINVAL);
       return NULL;
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.236
diff -u -p -r1.236 syscalls.cc
--- syscalls.cc	22 Nov 2002 20:51:13 -0000	1.236
+++ syscalls.cc	26 Nov 2002 02:53:41 -0000
@@ -45,6 +45,7 @@ details. */
 #define NEED_VFORK
 #include <setjmp.h>
 #include "perthread.h"
+#include "pwdgrp.h"

 #undef _close
 #undef _lseek
@@ -1970,7 +1971,7 @@ seteuid32 (__uid32_t uid)
   struct passwd * pw_new;
   PSID origpsid, psid2 =3D NO_SID;

-  pw_new =3D getpwuid32 (uid);
+  pw_new =3D internal_getpwuid (uid);
   if (!usersid.getfrompw (pw_new))
     {
       set_errno (EINVAL);
@@ -2146,7 +2147,7 @@ setegid32 (__gid32_t gid)
   cygsid gsid;
   HANDLE ptok;

-  struct __group32 * gr =3D getgrgid32 (gid);
+  struct __group32 * gr =3D internal_getgrgid (gid);
   if (!gr || gr->gr_gid !=3D gid || !gsid.getfromgr (gr))
     {
       set_errno (EINVAL);
Index: uinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.95
diff -u -p -r1.95 uinfo.cc
--- uinfo.cc	25 Nov 2002 15:11:39 -0000	1.95
+++ uinfo.cc	26 Nov 2002 02:55:38 -0000
@@ -29,6 +29,7 @@ details. */
 #include "registry.h"
 #include "child_info.h"
 #include "environ.h"
+#include "pwdgrp.h"

 void
 internal_getlogin (cygheap_user &user)
@@ -68,8 +69,8 @@ internal_getlogin (cygheap_user &user)
 	 }
     }

-  if (!pw && !(pw =3D getpwnam (user.name ()))
-      && !(pw =3D getpwuid32 (DEFAULT_UID)))
+  if (!pw && !(pw =3D internal_getpwnam (user.name ()))
+      && !(pw =3D internal_getpwuid (DEFAULT_UID)))
     debug_printf("user not found in augmented /etc/passwd");
   else
     {
@@ -79,7 +80,7 @@ internal_getlogin (cygheap_user &user)
       if (wincap.has_security ())
         {
 	  cygsid gsid;
-	  if (gsid.getfromgr (getgrgid32 (pw->pw_gid)))
+	  if (gsid.getfromgr (internal_getgrgid (pw->pw_gid)))
 	    {
 	      /* Set primary group to the group in /etc/passwd. */
 	      user.groups.pgsid =3D gsid;
@@ -214,7 +215,7 @@ cygheap_user::ontherange (homebodies wha
       else
 	{
 	  if (!pw)
-	    pw =3D getpwnam (name ());
+	    pw =3D internal_getpwnam (name ());
 	  if (pw && pw->pw_dir && *pw->pw_dir)
 	    {
 	      debug_printf ("Set HOME (from /etc/passwd) to %s", pw->pw_dir);
@@ -238,7 +239,7 @@ cygheap_user::ontherange (homebodies wha
   if (what !=3D CH_HOME && homepath =3D=3D NULL && newhomepath =3D=3D NULL)
     {
       if (!pw)
-	pw =3D getpwnam (name ());
+	pw =3D internal_getpwnam (name ());
       if (pw && pw->pw_dir && *pw->pw_dir)
 	cygwin_conv_to_full_win32_path (pw->pw_dir, homepath_env_buf);
       else
Index: sec_acl.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_acl.cc,v
retrieving revision 1.21
diff -u -p -r1.21 sec_acl.cc
--- sec_acl.cc	25 Nov 2002 11:23:21 -0000	1.21
+++ sec_acl.cc	26 Nov 2002 04:57:30 -0000
@@ -30,6 +30,7 @@ details. */
 #include "dtable.h"
 #include "pinfo.h"
 #include "cygheap.h"
+#include "pwdgrp.h"

 extern "C" int aclsort (int nentries, int, __aclent16_t *aclbufp);
 extern "C" int acl (const char *path, int cmd, int nentries, __aclent16_t =
*aclbufp);
@@ -158,7 +159,7 @@ setacl (const char *file, int nentries,
 	  break;
 	case USER:
 	case DEF_USER:
-	  if (!(pw =3D getpwuid32 (aclbufp[i].a_id))
+	  if (!(pw =3D internal_getpwuid (aclbufp[i].a_id))
 	      || !sid.getfrompw (pw)
 	      || !add_access_allowed_ace (acl, ace_off++, allow,
 					   sid, acl_len, inheritance))
@@ -172,7 +173,7 @@ setacl (const char *file, int nentries,
 	  break;
 	case GROUP:
 	case DEF_GROUP:
-	  if (!(gr =3D getgrgid32 (aclbufp[i].a_id))
+	  if (!(gr =3D internal_getgrgid (aclbufp[i].a_id))
 	      || !sid.getfromgr (gr)
 	      || !add_access_allowed_ace (acl, ace_off++, allow,
 					   sid, acl_len, inheritance))
@@ -419,21 +420,15 @@ acl_access (const char *path, int flags)
 	       * Take SID from passwd, search SID in group, check is_grp_member.
 	       */
 	      cygsid owner;
-	      cygsid group;
 	      struct passwd *pw;
 	      struct __group32 *gr =3D NULL;

-	      if ((pw =3D getpwuid32 (acls[i].a_id)) !=3D NULL
-		  && owner.getfrompw (pw))
-		{
-		  for (int gidx =3D 0; (gr =3D internal_getgrent (gidx)); ++gidx)
-		    if (group.getfromgr (gr)
-			&& owner =3D=3D group
-			&& is_grp_member (myself->uid, gr->gr_gid))
-		      break;
-		}
-	      if (!gr)
-		continue;
+	      if ((pw =3D internal_getpwuid (acls[i].a_id)) !=3D NULL
+		  && owner.getfrompw (pw)
+		  && (gr =3D internal_getgrsid (owner))
+		  && is_grp_member (myself->uid, gr->gr_gid))
+		break;
+	      continue;
 	    }
 	  break;
 	case GROUP_OBJ:
@@ -958,7 +953,7 @@ aclfromtext (char *acltextp, int *)
 	      c +=3D 5;
 	      if (isalpha (*c))
 		{
-		  struct passwd *pw =3D getpwnam (c);
+		  struct passwd *pw =3D internal_getpwnam (c);
 		  if (!pw)
 		    {
 		      set_errno (EINVAL);
@@ -986,7 +981,7 @@ aclfromtext (char *acltextp, int *)
 	      c +=3D 5;
 	      if (isalpha (*c))
 		{
-		  struct __group32 *gr =3D getgrnam32 (c);
+		  struct __group32 *gr =3D internal_getgrnam (c);
 		  if (!gr)
 		    {
 		      set_errno (EINVAL);

--=====================_1038305351==_--
