Return-Path: <cygwin-patches-return-5322-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24830 invoked by alias); 28 Jan 2005 02:56:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24805 invoked from network); 28 Jan 2005 02:56:51 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.205.203)
  by sourceware.org with SMTP; 28 Jan 2005 02:56:51 -0000
Received: from [192.168.1.115] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id IB0B1Q-005195-JG
	for cygwin-patches@cygwin.com; Thu, 27 Jan 2005 22:01:02 -0500
Message-Id: <3.0.5.32.20050127215809.00f1d4c0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 28 Jan 2005 02:56:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: fs_info::update
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q1/txt/msg00025.txt.bz2


When a user has no read access to the root of a drive, GetVolumeInformation
fails and has_acls is left unset. Consequently ntsec is off on that drive.
If a user "chmod -r" the root of a drive, ntsec is turned off and "chmod +r"
has no effect.
The patch does its best to set has_acls even in case of failure.

2005-01-28  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (fs_info::update) Set has_acls even in case of failure.


Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.340
diff -u -p -r1.340 path.cc
--- path.cc     26 Jan 2005 04:34:19 -0000      1.340
+++ path.cc     28 Jan 2005 02:48:54 -0000
@@ -381,6 +381,8 @@ fs_info::update (const char *win32_path)
       debug_printf ("Cannot get volume information (%s), %E", root_dir);
       has_buggy_open (false);
       has_ea (false);
+      has_acls (GetLastError () == ERROR_ACCESS_DENIED
+                && (allow_smbntsec || !is_remote_drive ()));
       flags () = serial () = 0;
       return false;
     }
