Return-Path: <cygwin-patches-return-2501-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18339 invoked by alias); 24 Jun 2002 03:55:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18278 invoked from network); 24 Jun 2002 03:55:39 -0000
Message-Id: <3.0.5.32.20020623235117.008008f0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 24 Jun 2002 03:05:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Windows username in get_group_sidlist
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00484.txt.bz2

Corinna,

get_group_sidlist currently uses the Windows username when
getting the supplementary group list. Here is a fix.

It may be paranoid in checking pw->pw_name is not NULL
(it's not always done in Cygwin, because it can't 
happen currently), delete that if you wish.

Pierre

2002-06-23  Pierre Humblet <pierre.humblet@ieee.org>

	security.cc (get_group_sidlist): Add pw argument and use
	pw->pw_name in call to get_supplementary_group_sidlist.
	(create_token): Add pw argument and use it in call to 
	get_group_sidlist.
	security.h: Add pw argument in declaration of create_token.
	syscalls.cc (seteuid32): Add pw argument in call to create_token.


--- security.cc.orig    2002-06-23 13:46:58.000000000 -0400
+++ security.cc 2002-06-23 15:18:02.000000000 -0400
@@ -482,7 +482,7 @@
 
 static BOOL
 get_group_sidlist (cygsidlist &grp_list,
-                  cygsid &usersid, cygsid &pgrpsid,
+                  cygsid &usersid, cygsid &pgrpsid, struct passwd * pw,
                   PTOKEN_GROUPS my_grps, LUID auth_luid, int &auth_pos,
                   BOOL * special_pgrp)
 {
@@ -554,7 +554,7 @@
       get_user_primary_group (wserver, user, usersid, pgrpsid);
     }
   else * special_pgrp = TRUE;
-  if (get_supplementary_group_sidlist (user, sup_list))
+  if (pw->pw_name && get_supplementary_group_sidlist (pw->pw_name, sup_list))
     {
       for (int i = 0; i < sup_list.count; ++i)
        if (!grp_list.contains (sup_list.sids[i]))
@@ -734,7 +734,7 @@
 }
 
 HANDLE
-create_token (cygsid &usersid, cygsid &pgrpsid)
+create_token (cygsid &usersid, cygsid &pgrpsid, struct passwd * pw)
 {
   NTSTATUS ret;
   LSA_HANDLE lsa = INVALID_HANDLE_VALUE;
@@ -818,7 +818,7 @@
 
   /* Create list of groups, the user is member in. */
   int auth_pos;
-  if (!get_group_sidlist (grpsids, usersid, pgrpsid,
+  if (!get_group_sidlist (grpsids, usersid, pgrpsid, pw,
                          my_grps, auth_luid, auth_pos, &special_pgrp))
     goto out;
 

--- security.h.orig     2002-06-06 07:17:50.000000000 -0400
+++ security.h  2002-06-23 13:54:10.000000000 -0400
@@ -180,7 +180,7 @@
 /* Try a subauthentication. */
 HANDLE subauth (struct passwd *pw);
 /* Try creating a token directly. */
-HANDLE create_token (cygsid &usersid, cygsid &pgrpsid);
+HANDLE create_token (cygsid &usersid, cygsid &pgrpsid, struct passwd * pw);
 /* Verify an existing token */
 BOOL verify_token (HANDLE token, cygsid &usersid, cygsid &pgrpsid, BOOL *
pintern = NULL);

--- syscalls.cc.orig    2002-06-21 21:33:40.000000000 -0400
+++ syscalls.cc 2002-06-23 13:54:56.000000000 -0400
@@ -2043,7 +2043,7 @@
     {
       /* If no impersonation token is available, try to
         authenticate using NtCreateToken() or subauthentication. */
-      cygheap->user.token = create_token (usersid, pgrpsid);
+      cygheap->user.token = create_token (usersid, pgrpsid, pw_new);
       if (cygheap->user.token != INVALID_HANDLE_VALUE)
        explicitly_created_token = TRUE;
       else
