Return-Path: <cygwin-patches-return-5041-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4654 invoked by alias); 10 Oct 2004 06:36:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4642 invoked from network); 10 Oct 2004 06:36:38 -0000
Message-ID: <n2m-g.ckajsj.3vv9689.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck (add_path): A little memory-leak.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Sun, 10 Oct 2004 06:36:00 -0000
X-SW-Source: 2004-q4/txt/msg00042.txt.bz2

In cygcheck.cc, in function add_path, if paths[num_paths] was already
in the list, the mallocced memory was not released. The trivial (IMO)
patch follows...


ChangeLog-entry:

2004-10-10  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
	* cygcheck.cc (add_path): Don't leak memory when path is already in
	``paths''.


--- src/winsup/utils/cygcheck.cc	9 Oct 2004 23:19:38 -0000	1.47
+++ src/winsup/utils/cygcheck.cc	10 Oct 2004 03:27:22 -0000
@@ -130,7 +130,10 @@ add_path (char *s, int maxlen)
     *--e = 0;
   for (int i = 1; i < num_paths; i++)
     if (strcasecmp (paths[num_paths], paths[i]) == 0)
-      return;
+      {
+	free (paths[num_paths]);
+	return;
+      }
   num_paths++;
 }
 


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
