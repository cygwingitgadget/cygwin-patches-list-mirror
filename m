Return-Path: <cygwin-patches-return-4667-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24395 invoked by alias); 11 Apr 2004 03:45:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24384 invoked from network); 11 Apr 2004 03:45:26 -0000
Message-Id: <3.0.5.32.20040410234239.00819ea0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 11 Apr 2004 03:45:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: dtable.cc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00019.txt.bz2

Here is a minor fix in dtable.cc.

My next fix is to remove the normalized_path from path_conv,
and the attendant malloc and path_conv destructor. The patch is
not big, but it may have unexpected corner effects.
I will wait until after the next release is out.

Pierre

2004-04-11  Pierre Humblet <pierre.humblet@ieee.org>

	* dtable.cc (dtable::extend): Change order of memcpy and cfree.

Index: dtable.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.139
diff -u -p -r1.139 dtable.cc
--- dtable.cc   10 Apr 2004 13:45:09 -0000      1.139
+++ dtable.cc   10 Apr 2004 19:25:15 -0000
@@ -91,8 +91,8 @@ dtable::extend (int howmuch)
     }
   if (fds)
     {
-      cfree (fds);
       memcpy (newfds, fds, size * sizeof (fds[0]));
+      cfree (fds);
     }
 
   size = new_size;
