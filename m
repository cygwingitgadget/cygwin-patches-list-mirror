Return-Path: <cygwin-patches-return-2856-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 343 invoked by alias); 24 Aug 2002 21:06:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 329 invoked from network); 24 Aug 2002 21:06:13 -0000
Message-Id: <3.0.5.32.20020824170233.007ef430@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sat, 24 Aug 2002 14:06:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: More Everyone
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00304.txt.bz2

Corinna,

The changes below, which have no effects in sane cases, will
- greatly reduce the likelihood of denying access
- have "ls -l" reflect the actual situation.
Things can still be strange when group==Everyone, e.g. 
- chmod 707 will both deny and allow access to Everyone, with
  the net outcome being denied (as shown by ls -l)
- ls -l and getfacl report different settings for group

Pierre

2002-08-24 Pierre Humblet <Pierre.Humblet@ieee.org>
	
	* sec_acl.cc (getacl): Check ace_sid == well_known_world_sid
	before group_sid so that well_known_world_sid means "other"
	even when group_sid is Everyone. 
	* security.cc (get_nt_attribute): Ditto.

--- sec_acl.cc.orig     2002-07-02 20:29:16.000000000 -0400
+++ sec_acl.cc  2002-08-23 18:39:32.000000000 -0400
@@ -319,16 +319,16 @@
          type = USER_OBJ;
          id = uid;
        }
-      else if (ace_sid == group_sid)
-       {
-         type = GROUP_OBJ;
-         id = gid;
-       }
       else if (ace_sid == well_known_world_sid)
        {
          type = OTHER_OBJ;
          id = 0;
        }
+      else if (ace_sid == group_sid)
+       {
+         type = GROUP_OBJ;
+         id = gid;
+       }
       else
        {
          id = ace_sid.get_id (FALSE, &type);

--- security.cc.orig    2002-08-23 18:37:10.000000000 -0400
+++ security.cc 2002-08-24 15:01:04.000000000 -0400
@@ -1300,18 +1300,6 @@
          if (ace->Mask & FILE_EXECUTE)
            *flags |= S_IXUSR;
        }
-      else if (group_sid && ace_sid == group_sid)
-       {
-         if (ace->Mask & FILE_READ_DATA)
-           *flags |= S_IRGRP
-                     | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);
-         if (ace->Mask & FILE_WRITE_DATA)
-           *flags |= S_IWGRP
-                     | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);
-         if (ace->Mask & FILE_EXECUTE)
-           *flags |= S_IXGRP
-                     | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);
-       }
       else if (ace_sid == well_known_world_sid)
        {
          if (ace->Mask & FILE_READ_DATA)
@@ -1343,6 +1331,18 @@
          if (ace->Mask & FILE_APPEND_DATA)
            *flags |= S_ISUID;
        }
+      else if (group_sid && ace_sid == group_sid)
+       {
+         if (ace->Mask & FILE_READ_DATA)
+           *flags |= S_IRGRP
+                     | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);
+         if (ace->Mask & FILE_WRITE_DATA)
+           *flags |= S_IWGRP
+                     | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);
+         if (ace->Mask & FILE_EXECUTE)
+           *flags |= S_IXGRP
+                     | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);
+       }
     }
   *attribute &= ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_ISUID);
   *attribute |= allow;

