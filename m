Return-Path: <cygwin-patches-return-3070-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9999 invoked by alias); 21 Oct 2002 15:00:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9990 invoked from network); 21 Oct 2002 15:00:24 -0000
Message-ID: <3DB416E7.99E22851@ieee.org>
Date: Mon, 21 Oct 2002 08:00:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Avoiding /etc/passwd and /etc/group scans 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00021.txt.bz2

Chris,

Cygwin scans the passwd and group files to map sids
to/from uid & gid. It does so even for the current user,
although the relevant mappings are stored internally.
This is inefficient and causes problems (e.g. gcc produces
non executable files) as soon as /etc/passwd is incomplete.

security.cc:alloc_sd already uses internal structures to map
uid to sid. This small patch proceeds similarly to map gid
to sid and to map sid to uid/gid, thus improving both the 
efficiency and robustness of Cygwin. 

The patch is very simple, most changed lines only differ in
blank spaces.

Pierre

2002-10-21  Pierre Humblet <pierre.humblet@ieee.org>

	* sec_helper.cc (cygsid::get_id): If the sid matches a sid
	stored in cygheap->user, return the uid or gid from myself.
	* security.cc (alloc_sd): If gid == myself->gid, return the
	group sid from cygheap->user. Remove the test for uid ==
	original_uid, which is counter-productive.

--- sec_helper.cc.orig  2002-10-19 12:57:48.000000000 -0400
+++ sec_helper.cc       2002-10-21 10:25:50.000000000 -0400
@@ -162,14 +162,17 @@ cygsid::get_id (BOOL search_grp, int *ty
       if (!search_grp)
        {
          struct passwd *pw;
-         for (int pidx = 0; (pw = internal_getpwent (pidx)); ++pidx)
-           {
-             if (sid.getfrompw (pw) && sid == psid)
-               {
-                 id = pw->pw_uid;
-                 break;
-               }
-           }
+         if (EqualSid(psid, cygheap->user.sid ()))
+           id = myself->uid;
+         else
+           for (int pidx = 0; (pw = internal_getpwent (pidx)); ++pidx)
+             {
+               if (sid.getfrompw (pw) && sid == psid)
+                 {
+                   id = pw->pw_uid;
+                   break;
+                 }
+             }
          if (id >= 0)
            {
              if (type)
@@ -180,14 +183,17 @@ cygsid::get_id (BOOL search_grp, int *ty
       if (search_grp || type)
        {
          struct __group32 *gr;
-         for (int gidx = 0; (gr = internal_getgrent (gidx)); ++gidx)
-           {
-             if (sid.getfromgr (gr) && sid == psid)
-               {
-                 id = gr->gr_gid;
-                 break;
-               }
-           }
+         if (cygheap->user.groups.pgsid == psid)
+           id = myself->gid;
+         else
+           for (int gidx = 0; (gr = internal_getgrent (gidx)); ++gidx)
+             {
+               if (sid.getfromgr (gr) && sid == psid)
+                 {
+                   id = gr->gr_gid;
+                   break;
+                 }
+             }
          if (id >= 0)
            {
              if (type)
--- security.cc.orig    2002-09-30 20:24:00.000000000 -0400
+++ security.cc 2002-10-21 09:31:53.000000000 -0400
@@ -1536,9 +1536,7 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
   /* Check for current user first */
   if (uid == myself->uid)
     owner_sid = cygheap->user.sid ();
-  else if (uid == cygheap->user.orig_uid)
-    owner_sid = cygheap->user.orig_sid ();
-  if (!owner_sid)
+  else
     {
       /* Otherwise retrieve user data from /etc/passwd */
       struct passwd *pw = getpwuid32 (uid);
@@ -1559,12 +1557,17 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
 
   /* Get SID of new group. */
   cygsid group_sid (NO_SID);
-  struct __group32 *grp = getgrgid32 (gid);
-  if (!grp)
-    debug_printf ("no /etc/group entry for %d", gid);
-  else if (!group_sid.getfromgr (grp))
-    debug_printf ("no SID for group %d", gid);
-
+  /* Check for current user first */
+  if (gid == myself->gid)
+    group_sid = cygheap->user.groups.pgsid;
+  else
+   {
+      struct __group32 *grp = getgrgid32 (gid);
+      if (!grp)
+        debug_printf ("no /etc/group entry for %d", gid);
+      else if (!group_sid.getfromgr (grp))
+        debug_printf ("no SID for group %d", gid);
+   }
   /* Initialize local security descriptor. */
   SECURITY_DESCRIPTOR sd;
   PSECURITY_DESCRIPTOR psd = NULL;
