Return-Path: <cygwin-patches-return-3181-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8013 invoked by alias); 15 Nov 2002 14:52:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8004 invoked from network); 15 Nov 2002 14:52:39 -0000
Message-ID: <3DD50A44.40CF5707@ieee.org>
Date: Fri, 15 Nov 2002 06:52:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch #4: passwd and group
References: <20021108171918.P21920@cygbert.vinschen.de> <3DCBEFF5.850B999E@ieee.org> <20021111145612.T10395@cygbert.vinschen.de> <3DCFC6BB.570DF472@ieee.org> <20021111174720.X10395@cygbert.vinschen.de> <3DCFE314.3B5B45AB@ieee.org> <20021111183423.A10395@cygbert.vinschen.de> <3DCFF8AE.66CBD751@ieee.org> <20021112144038.F10395@cygbert.vinschen.de> <3DD13433.D618DC4F@ieee.org> <20021112181849.K10395@cygbert.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------7A99FD95C91434A655728A70"
X-SW-Source: 2002-q4/txt/msg00132.txt.bz2

This is a multi-part message in MIME format.
--------------7A99FD95C91434A655728A70
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1910

Corinna,

Here is the ntsec patch #4 diff. As discussed before, the main motivation
was to handle more robustly incomplete passwd and group files.
In the process I fixed some bugs in related code and added
getpwsid and getgrsid.

This does not try to completely address the issue of invalid pointers
after a re-read of passwd and group, that will be for later.

Note that there is a small bug fix in the getgroup32 code from
yesterday and some streamlining in is_grp_member.

Pierre

2002/11/15  Pierre Humblet  <pierre.humblet@ieee.org>

        * security.h: Declare getpwsid and getgrsid. Undeclare 
        internal_getpwent. Define DEFAULT_UID_NT. Change DEFAULT_GID.
        * passwd.cc (getpwsid): Create.
        (internal_getpwent): Suppress.
        (read_etc_passwd): Make static. Rewrite the code for the completion
        line. Reset curr_lines.
        (parse_pwd): Change type to static int. Return 0 for short lines.
        (add_pwd_line): Pay attention to the value of parse_pwd.     
        (search_for): Do not look for nor return the DEFAULT_UID.
        * grp.cc (read_etc_group): Make static. Free gr_mem and reset 
        curr_lines. Always call add_pwd_line. Rewrite the code for the 
        completion line.
        (parse_grp): If grp.gr_mem is empty, set it to &null_ptr.
        Never NULL gr_passwd. 
        (getgrgid32): Only return the default if ntsec is off and the gid is 
        ILLEGAL_GID.
        (getgroups32): Never close the impersonation token handle.           
        * sec_helper.cc (cygsid::get_id): Use getpwsid and getgrsid;
        (cygsid_getfrompw): Clean up last line.
        (cygsid_getfromgr): Ditto.
        (is_grp_member): Use getpwuid32 and getgrgid32.
        * uinfo.cc (internal_getlogin): Set DEFAULT_GID at start.
        Use getpwsid. Move the read of /etc/group after the second access 
        of /etc/passwd. Change some debug_printf.
--------------7A99FD95C91434A655728A70
Content-Type: text/plain; charset=us-ascii;
 name="pwd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pwd.diff"
Content-length: 19390

--- security.h.orig	2002-11-12 22:07:16.000000000 -0500
+++ security.h	2002-11-12 22:15:54.000000000 -0500
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
+extern struct passwd *getpwsid (cygsid &, BOOL = FALSE);
+extern struct __group32 *getgrsid (cygsid &, BOOL = FALSE);
 
 /* File manipulation */
 int __stdcall set_process_privileges ();
--- passwd.cc.orig	2002-10-24 01:08:58.000000000 -0400
+++ passwd.cc	2002-11-14 21:31:22.000000000 -0500
@@ -74,7 +74,7 @@ grab_int (char **p)
 }
 
 /* Parse /etc/passwd line into passwd structure. */
-void
+static int
 parse_pwd (struct passwd &res, char *buf)
 {
   /* Allocate enough room for the passwd struct and all the strings
@@ -82,6 +82,8 @@ parse_pwd (struct passwd &res, char *buf
   size_t len = strlen (buf);
   if (buf[--len] == '\r')
     buf[len] = '\0';
+  if (len < 6)
+    return 0;
 
   res.pw_name = grab_string (&buf);
   res.pw_passwd = grab_string (&buf);
@@ -91,6 +93,7 @@ parse_pwd (struct passwd &res, char *buf
   res.pw_gecos = grab_string (&buf);
   res.pw_dir =  grab_string (&buf);
   res.pw_shell = grab_string (&buf);
+  return 1;
 }
 
 /* Add one line from /etc/passwd into the password cache */
@@ -102,7 +105,8 @@ add_pwd_line (char *line)
 	max_lines += 10;
 	passwd_buf = (struct passwd *) realloc (passwd_buf, max_lines * sizeof (struct passwd));
       }
-    parse_pwd (passwd_buf[curr_lines++], line);
+    if (parse_pwd (passwd_buf[curr_lines], line))
+      curr_lines++;	
 }
 
 class passwd_lock
@@ -125,10 +129,32 @@ class passwd_lock
 
 pthread_mutex_t NO_COPY passwd_lock::mutex = (pthread_mutex_t) PTHREAD_MUTEX_INITIALIZER;
 
+/* Cygwin internal */
+/* If this ever becomes non-reentrant, update all the getpw*_r functions */
+static struct passwd *
+search_for (__uid32_t uid, const char *name)
+{
+  struct passwd *res = 0;
+
+  for (int i = 0; i < curr_lines; i++)
+    {
+      res = passwd_buf + i;
+      /* on Windows NT user names are case-insensitive */
+      if (name)
+        {
+	  if (strcasematch (name, res->pw_name))
+	    return res;
+	}
+      else if (uid == (__uid32_t) res->pw_uid)
+	return res;
+    }
+  return NULL;
+}
+
 /* Read in /etc/passwd and save contents in the password cache.
    This sets passwd_state to loaded or emulated so functions in this file can
    tell that /etc/passwd has been read in or will be emulated. */
-void
+static void
 read_etc_passwd ()
 {
   static pwdgrp_read pr;
@@ -146,97 +172,71 @@ read_etc_passwd ()
   if (passwd_state != initializing)
     {
       passwd_state = initializing;
+      curr_lines = 0;
       if (pr.open ("/etc/passwd"))
 	{
 	  char *line;
 	  while ((line = pr.gets ()) != NULL)
-	    if (strlen (line))
-	      add_pwd_line (line);
+	    add_pwd_line (line);
 
 	  passwd_state.set_last_modified (pr.get_fhandle (), pr.get_fname ());
-	  passwd_state = loaded;
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
-		      passwd_state = emulated;
-		    }
-		  CloseHandle (ptok);
-		}
-	    }
-	  if (passwd_state != emulated)
-	    {
-	      snprintf (linebuf, sizeof (linebuf), "%s::%u:%u::%s:/bin/sh",
-			cygheap->user.name (), (unsigned) DEFAULT_UID,
-			(unsigned) DEFAULT_GID, getenv ("HOME") ?: "/");
-	      debug_printf ("Emulating /etc/passwd: %s", linebuf);
-	      add_pwd_line (linebuf);
-	      passwd_state = emulated;
-	    }
+      static char linebuf[1024];
+      char strbuf[128] = "";
+      BOOL searchentry = TRUE;
+      __uid32_t default_uid = DEFAULT_UID;
+      struct passwd *pw;
+      
+      if (wincap.has_security ())
+	{
+	  cygsid tu = cygheap->user.sid ();
+	  tu.string (strbuf);
+	  if (myself->uid == ILLEGAL_UID &&
+	      (searchentry = !getpwsid (tu, TRUE)))
+	    default_uid = DEFAULT_UID_NT;
 	}
-
+      if (searchentry &&
+	  (!(pw = search_for (0, cygheap->user.name ())) || 
+	   (myself->uid != ILLEGAL_UID && 
+	    myself->uid != (__uid32_t) pw->pw_uid  && 
+	    !search_for (myself->uid, NULL))))
+	{
+	  snprintf (linebuf, sizeof (linebuf), "%s:*:%u:%u:,%s:%s:/bin/sh",
+		    cygheap->user.name (), 
+		    myself->uid == ILLEGAL_UID?default_uid:myself->uid,
+		    myself->gid,
+		    strbuf, getenv ("HOME") ?: "/");
+	  debug_printf ("Completing /etc/passwd: %s", linebuf);
+	  add_pwd_line (linebuf);
+	}
+      passwd_state = loaded;	  
     }
-
   return;
 }
 
-/* Cygwin internal */
-/* If this ever becomes non-reentrant, update all the getpw*_r functions */
-static struct passwd *
-search_for (__uid32_t uid, const char *name)
+struct passwd *
+getpwsid (cygsid &sid, BOOL no_check)
 {
-  struct passwd *res = 0;
-  struct passwd *default_pw = 0;
+  struct passwd *pw;
+  char *ptr1, *ptr2, *endptr;
+  char sid_string[128] = {0,','};
 
-  for (int i = 0; i < curr_lines; i++)
+  if (!no_check && passwd_state  <= initializing)
+    read_etc_passwd ();
+
+  if (sid.string (sid_string + 2))
     {
-      res = passwd_buf + i;
-      if (res->pw_uid == DEFAULT_UID)
-	default_pw = res;
-      /* on Windows NT user names are case-insensitive */
-      if (name)
-	{
-	  if (strcasematch (name, res->pw_name))
-	    return res;
-	}
-      else if (uid == (__uid32_t) res->pw_uid)
-	return res;
+      endptr = strchr (sid_string + 2, 0) - 1;
+      for (int i = 0; i < curr_lines; i++)
+	if ((pw = passwd_buf + i)->pw_dir > pw->pw_gecos + 8) 
+	  for (ptr1 = endptr, ptr2 = pw->pw_dir - 2;
+	       *ptr1 == *ptr2; ptr2--) 
+	    if (!*--ptr1) 
+	      return pw;
     }
-
-  /* Return default passwd entry if passwd is emulated or it's a
-     request for the current user. */
-  if (passwd_state != loaded
-      || (!name && uid == myself->uid)
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
--- grp.cc.orig	2002-11-14 17:41:00.000000000 -0500
+++ grp.cc	2002-11-14 18:18:56.000000000 -0500
@@ -41,6 +41,7 @@ static int grp_pos = 0;
 #endif
 
 static pwdgrp_check group_state;
+static char * NO_COPY null_ptr = NULL;
 
 static int
 parse_grp (struct __group32 &grp, char *line)
@@ -62,13 +63,11 @@ parse_grp (struct __group32 &grp, char *
   if (dp)
     {
       *dp++ = '\0';
-      if (!strlen (grp.gr_passwd))
-	grp.gr_passwd = NULL;
-
       grp.gr_gid = strtol (dp, NULL, 10);
       dp = strchr (dp, ':');
       if (dp)
 	{
+	  grp.gr_mem = &null_ptr;
 	  if (*++dp)
 	    {
 	      int i = 0;
@@ -87,11 +86,9 @@ parse_grp (struct __group32 &grp, char *
 		    }
 		  namearray[i++] = dp;
 		  namearray[i] = NULL;
+		  grp.gr_mem = namearray;
 		}
-	      grp.gr_mem = namearray;
 	    }
-	  else
-	    grp.gr_mem = (char **) calloc (1, sizeof (char *));
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
   if (group_state != initializing)
     {
       group_state = initializing;
+      for (int i = 0; i < curr_lines; i++)
+	if ((group_buf + i)->gr_mem != &null_ptr)
+	  free ((group_buf + i)->gr_mem);
+    
+      curr_lines = 0;
       if (gr.open ("/etc/group"))
 	{
 	  char *line;
 	  while ((line = gr.gets ()) != NULL)
-	    if (strlen (line))
-	      add_grp_line (line);
+            add_grp_line (line);
 
 	  group_state.set_last_modified (gr.get_fhandle (), gr.get_fname ());
-	  group_state = loaded;
 	  gr.close ();
 	  debug_printf ("Read /etc/group, %d lines", curr_lines);
 	}
-      else /* /etc/group doesn't exist -- create default one in memory */
-	{
-	  char group_name [UNLEN + 1];
-	  DWORD group_name_len = UNLEN + 1;
-	  char domain_name [INTERNET_MAX_HOST_NAME_LENGTH + 1];
-	  DWORD domain_name_len = INTERNET_MAX_HOST_NAME_LENGTH + 1;
-	  SID_NAME_USE acType;
+      
+      /* Complete /etc/group in memory if needed */
+      if (!getgrgid32 (myself->gid))
+        {
 	  static char linebuf [200];
+	  char group_name [UNLEN + 1] = "unknown";
+	  char strbuf[128] = "";
 
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
-		      group_state = emulated;
-		    }
-		  CloseHandle (ptok);
-		}
-	    }
-	  if (group_state != emulated)
-	    {
-	      strncpy (group_name, "Administrators", sizeof (group_name));
-	      if (!LookupAccountSidA (NULL, well_known_admins_sid, group_name,
-				      &group_name_len, domain_name,
-				      &domain_name_len, &acType))
-		{
-		  strcpy (group_name, "unknown");
-		  debug_printf ("Failed to get local admins group name. %E");
+            {
+	      DWORD group_name_len = UNLEN + 1;
+	      char domain_name [INTERNET_MAX_HOST_NAME_LENGTH + 1];
+	      DWORD domain_name_len = INTERNET_MAX_HOST_NAME_LENGTH + 1;
+	      SID_NAME_USE acType;
+	      struct __group32 *gr;
+
+	      cygheap->user.groups.pgsid.string (strbuf);
+	      if (!(gr = getgrsid (cygheap->user.groups.pgsid)))
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
-	      group_state = emulated;
+	      else 
+		strlcpy (group_name, gr->gr_name, sizeof (group_name));
 	    }
+	  snprintf (linebuf, sizeof (linebuf), "%s:%s:%lu:%s",
+		    group_name, strbuf, myself->gid, cygheap->user.name ());
+	  debug_printf ("Completing /etc/group: %s", linebuf);
+	  add_grp_line (linebuf);
 	}
+      group_state = loaded;
     }
-
   return;
 }
 
+struct __group32 *
+getgrsid (cygsid &sid, BOOL no_check)
+{
+  char sid_string[128];
+
+  if (!no_check && group_state  <= initializing)
+    read_etc_group ();
+
+  if (sid.string (sid_string))
+    for (int i = 0; i < curr_lines; i++)
+      if (!strcmp (sid_string, (group_buf + i)->gr_passwd))
+        return group_buf + i;
+  return NULL;
+}
+
 static
 struct __group16 *
 grp32togrp16 (struct __group16 *gp16, struct __group32 *gp32)
@@ -246,13 +239,12 @@ getgrgid32 (__gid32_t gid)
 
   for (int i = 0; i < curr_lines; i++)
     {
-      if (group_buf[i].gr_gid == DEFAULT_GID)
+      if (group_buf[i].gr_gid == myself->gid)
 	default_grp = group_buf + i;
       if (group_buf[i].gr_gid == gid)
 	return group_buf + i;
     }
-
-  return allow_ntsec ? NULL : default_grp;
+  return (!allow_ntsec && gid == ILLEGAL_GID)?default_grp:NULL;
 }
 
 extern "C" struct __group16 *
@@ -372,7 +364,8 @@ getgroups32 (int gidsetsize, __gid32_t *
 			++cnt;
 			if (gidsetsize && cnt > gidsetsize)
 			  {
-			    CloseHandle (hToken);
+			    if (hToken != cygheap->user.token)
+			      CloseHandle (hToken);
 			    goto error;
 			  }
 			break;
@@ -481,13 +474,9 @@ setgroups32 (int ngroups, const __gid32_
       for (int gidy = 0; gidy < gidx; gidy++)
 	if (grouplist[gidy] == grouplist[gidx])
 	  goto found; /* Duplicate */
-      for (int gidy = 0; (gr = internal_getgrent (gidy)); ++gidy)
-	if (gr->gr_gid == (__gid32_t) grouplist[gidx])
-	  {
-	    if (gsids.addfromgr (gr))
-	      goto found;
-	    break;
-	  }
+      if ((gr = getgrgid32 (grouplist[gidx])) &&
+	  gsids.addfromgr (gr))
+	goto found;
       debug_printf ("No sid found for gid %d", grouplist[gidx]);
       gsids.free_sids ();
       set_errno (EINVAL);
--- sec_helper.cc.orig	2002-11-14 17:41:00.000000000 -0500
+++ sec_helper.cc	2002-11-14 19:18:42.000000000 -0500
@@ -118,21 +118,20 @@ BOOL
 cygsid::getfrompw (const struct passwd *pw)
 {
   char *sp = (pw && pw->pw_gecos) ? strrchr (pw->pw_gecos, ',') : NULL;
-  return (*this = sp ? sp + 1 : "") != NULL;
+  return (*this = sp ? sp + 1 : sp) != NULL;
 }
 
 BOOL
 cygsid::getfromgr (const struct __group32 *gr)
 {
   char *sp = (gr && gr->gr_passwd) ? gr->gr_passwd : NULL;
-  return (*this = sp ?: "") != NULL;
+  return (*this = sp) != NULL;
 }
 
 __uid32_t
 cygsid::get_id (BOOL search_grp, int *type)
 {
   /* First try to get SID from passwd or group entry */
-  cygsid sid;
   __uid32_t id = ILLEGAL_UID;
 
   if (!search_grp)
@@ -140,42 +139,25 @@ cygsid::get_id (BOOL search_grp, int *ty
       struct passwd *pw;
       if (*this == cygheap->user.sid ())
 	id = myself->uid;
-      else
-	for (int pidx = 0; (pw = internal_getpwent (pidx)); ++pidx)
-          {
-	    if (sid.getfrompw (pw) && sid == psid)
-	      {
-		id = pw->pw_uid;
-		break;
-	      }
-	  }
+      else if ((pw = getpwsid (*this, TRUE)))  
+	id = pw->pw_uid;
       if (id != ILLEGAL_UID)
 	{
 	  if (type)
 	    *type = USER;
 	   return id;
-	 }
+	}
     }
   if (search_grp || type)
     {
       struct __group32 *gr;
       if (cygheap->user.groups.pgsid == psid)
 	id = myself->gid;
-      else
-	for (int gidx = 0; (gr = internal_getgrent (gidx)); ++gidx)
-	  {
-	    if (sid.getfromgr (gr) && sid == psid)
-	      {
-		id = gr->gr_gid;
-		break;
-	      }
-	  }
-      if (id != ILLEGAL_UID)
-	{
-	  if (type)
-	    *type = GROUP;
-	}
-     }
+      else if ((gr = getgrsid (*this, TRUE)))
+	id = gr->gr_gid;
+      if (id != ILLEGAL_UID && type)
+	*type = GROUP;
+    }
   return id;
 }
 
@@ -208,24 +190,17 @@ is_grp_member (__uid32_t uid, __gid32_t 
     }
 
   /* Otherwise try getting info from examining passwd and group files. */
-  for (int idx = 0; (pw = internal_getpwent (idx)); ++idx)
-    if ((__uid32_t) pw->pw_uid == uid)
-      {
-	/* If gid == primary group of uid, return immediately. */
-	if ((__gid32_t) pw->pw_gid == gid)
-	  return TRUE;
-	/* Otherwise search for supplementary user list of this group. */
-	for (idx = 0; (gr = internal_getgrent (idx)); ++idx)
-	  if ((__gid32_t) gr->gr_gid == gid)
-	    {
-	      if (gr->gr_mem)
-		for (idx = 0; gr->gr_mem[idx]; ++idx)
-		  if (strcasematch (cygheap->user.name (), gr->gr_mem[idx]))
-		    return TRUE;
-	      return FALSE;
-	    }
-        return FALSE;
-      }
+  if ((pw = getpwuid32 (uid)))
+    {
+      /* If gid == primary group of uid, return immediately. */
+      if ((__gid32_t) pw->pw_gid == gid)
+	return TRUE;
+      /* Otherwise search for supplementary user list of this group. */
+      if ((gr = getgrgid32 (gid)) && gr->gr_mem)
+	for (idx = 0; gr->gr_mem[idx]; ++idx)
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
   struct passwd *pw = NULL;
+  HANDLE ptok = INVALID_HANDLE_VALUE;
 
+  myself->gid = DEFAULT_GID;
   if (wincap.has_security ())
     {
-      HANDLE ptok = INVALID_HANDLE_VALUE;
       DWORD siz;
       cygsid tu;
       DWORD ret = 0;
@@ -58,52 +59,39 @@ internal_getlogin (cygheap_user &user)
 	 If we have a SID, try to get the corresponding Cygwin
 	 password entry. Set user name which can be different
 	 from the Windows user name */
-       if (ret)
-	 {
-	  cygsid gsid (NO_SID);
-	  cygsid psid;
-
-	  for (int pidx = 0; (pw = internal_getpwent (pidx)); ++pidx)
-	    if (psid.getfrompw (pw) && EqualSid (user.sid (), psid))
-	      {
-		user.set_name (pw->pw_name);
-		struct __group32 *gr = getgrgid32 (pw->pw_gid);
-		if (gr)
-		  if (!gsid.getfromgr (gr))
-		      gsid = NO_SID;
-		break;
-	      }
-
-	  /* Set token owner to the same value as token user and
-	     primary group to the group in /etc/passwd. */
+      if (ret)
+	{
+	  if ((pw = getpwsid (tu)))
+	    user.set_name (pw->pw_name);
+	  /* Set token owner to the same value as token user */
 	  if (!SetTokenInformation (ptok, TokenOwner, &tu, sizeof tu))
 	    debug_printf ("SetTokenInformation(TokenOwner): %E");
-	  if (gsid)
-	    {
-	      user.groups.pgsid = gsid;
-	      if (!SetTokenInformation (ptok, TokenPrimaryGroup,
-					&gsid, sizeof gsid))
-		debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
-	    }
 	 }
-      if (ptok != INVALID_HANDLE_VALUE)
-	CloseHandle (ptok);
     }
 
-  if (!pw)
-    pw = getpwnam (user.name ());
-
-  if (pw)
+  if (!pw && !(pw = getpwnam (user.name ())))
+    debug_printf("user name not found in augmented /etc/passwd");
+  else
     {
       myself->uid = pw->pw_uid;
       myself->gid = pw->pw_gid;
+      if (wincap.has_security ())
+        {
+	  cygsid gsid;
+	  if (gsid.getfromgr (getgrgid32 (pw->pw_gid)))
+	    {
+	      /* Set primary group to the group in /etc/passwd. */
+	      user.groups.pgsid = gsid;
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
-      myself->uid = DEFAULT_UID;
-      myself->gid = DEFAULT_GID;
-    }
-
+  if (ptok != INVALID_HANDLE_VALUE)
+    CloseHandle (ptok);
   (void) cygheap->user.ontherange (CH_HOME, pw);
 
   return;

--------------7A99FD95C91434A655728A70--
