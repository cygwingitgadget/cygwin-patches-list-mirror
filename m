Return-Path: <cygwin-patches-return-4282-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19520 invoked by alias); 7 Oct 2003 01:26:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19511 invoked from network); 7 Oct 2003 01:26:38 -0000
Message-Id: <3.0.5.32.20031006212612.008203b0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 07 Oct 2003 01:26:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: shared.cc debug info.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00001.txt.bz2

Here is a pretty simple patch..

BTW, are there more questions about "[Patch]: Fixing the PROCESS_DUP_HANDLE
security  hole (part 1)." from last week?

Pierre

2003-10-06  Pierre Humblet <pierre.humblet@ieee.org>

	* shared.cc (open_shared): Report map name in api_fatal.


Index: shared.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.75
diff -u -p -r1.75 shared.cc
--- shared.cc   25 Sep 2003 02:29:04 -0000      1.75
+++ shared.cc   7 Oct 2003 01:02:30 -0000
@@ -99,7 +99,7 @@ open_shared (const char *name, int n, HA
       if (!shared_h &&
          !(shared_h = CreateFileMapping (INVALID_HANDLE_VALUE, psa,
                                          PAGE_READWRITE, 0, size, mapname)))
-       api_fatal ("CreateFileMapping, %E.  Terminating.");
+       api_fatal ("CreateFileMapping %s, %E.  Terminating.", mapname);
     }
 
   shared = (shared_info *)
