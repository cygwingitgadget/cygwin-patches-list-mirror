Return-Path: <cygwin-patches-return-5009-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30851 invoked by alias); 5 Oct 2004 05:15:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30749 invoked from network); 5 Oct 2004 05:15:15 -0000
Message-ID: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag>
X-Newsgroups: local.ml.cygwin-patches
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: warn about empty path-components
Reply-To: Buzz <ngs@bavag.tmfweb.nl>
Organisation: Ehm...
User-Agent: slrn/0.9.8.0pl1 (CYGWIN_95-4.0) Hamster/2.0.5.5
To: cygwin-patches@cygwin.com
X-Gate: Hamster/2.0.5.5 NewsToMail-Gate
X-Processed-By: Eudora 6.0.1.1, Hamster Classic 2.0.5.5, KorrNews 4.2
Date: Tue, 05 Oct 2004 05:15:00 -0000
X-SW-Source: 2004-q4/txt/msg00010.txt.bz2

Hi,

This little patch makes cygcheck warn about empty path-components
(leading/trailing/double ':'/';' in $PATH).


ChangeLog-entry:

2004-10-05  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (dump_sysinfo): Warn about empty path-components.


--- src/winsup/utils/cygcheck.cc	4 Oct 2004 09:42:08 -0000	1.44
+++ src/winsup/utils/cygcheck.cc	5 Oct 2004 02:19:35 -0000
@@ -957,7 +957,10 @@ dump_sysinfo ()
   while (1)
     {
       for (e = s; *e && *e != sep; e++);
-      printf ("\t%.*s\n", e - s, s);
+      if (e-s)
+	printf ("\t%.*s\n", e - s, s);
+      else
+	puts ("\tWarning: Empty path-component");
       count_path_items++;
       if (!*e)
 	break;


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^r
