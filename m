Return-Path: <cygwin-patches-return-3550-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15153 invoked by alias); 12 Feb 2003 02:28:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15144 invoked from network); 12 Feb 2003 02:28:09 -0000
Message-Id: <3.0.5.32.20030211212653.007f83c0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Wed, 12 Feb 2003 02:28:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: unpatching sshd
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00199.txt.bz2

Corinna,

now that setuid works posixly on Win95, sshd can be unpatched.

Pierre


--- session.c.orig      2003-02-10 10:12:13.000000000 -0500
+++ session.c   2003-02-10 10:13:08.000000000 -0500
@@ -1249,9 +1249,6 @@ do_setusercontext(struct passwd *pw)
                permanently_set_uid(pw);
 #endif
        }
-#ifdef HAVE_CYGWIN
-       if (is_winnt)
-#endif
        if (getuid() != pw->pw_uid || geteuid() != pw->pw_uid)
                fatal("Failed to set uids to %u.", (u_int) pw->pw_uid);
 }

