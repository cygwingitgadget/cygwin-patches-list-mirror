Return-Path: <cygwin-patches-return-4723-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19871 invoked by alias); 6 May 2004 23:54:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19505 invoked from network); 6 May 2004 23:54:07 -0000
Message-Id: <3.0.5.32.20040506195101.008064e0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 06 May 2004 23:54:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: mount_info::conv_to_posix_path
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00075.txt.bz2

A missing return causes trouble when chroot is in effect.

Pierre 

2004-05-07  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (mount_info::conv_to_posix_path): Add return.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.309
diff -u -p -r1.309 path.cc
--- path.cc     6 May 2004 16:26:10 -0000       1.309
+++ path.cc     6 May 2004 23:27:31 -0000
@@ -1703,6 +1703,7 @@ mount_info::conv_to_posix_path (const ch
          posix_path[0] = '/';
          posix_path[1] = '\0';
        }
+      return 0;
     }
   else
     return ENOENT;
