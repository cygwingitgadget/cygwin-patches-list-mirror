Return-Path: <cygwin-patches-return-2572-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24275 invoked by alias); 1 Jul 2002 22:39:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24251 invoked from network); 1 Jul 2002 22:39:58 -0000
Message-ID: <3D20DA17.7B521B43@ieee.org>
Date: Mon, 01 Jul 2002 15:39:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Any ideas with xterm/xfree problem?
References: <20020701204140.GA25217@redhat.com> <3D20C1DA.26509E01@ieee.org> <20020701212139.GE25306@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00020.txt.bz2

Chris,

The following bandaid should take care of the problem,
until we determine exactly what's going on and how
prevalent it is.

xterm does
	    (void) setgid(screen->gid);
<snip>
	    if (setuid(screen->uid)) {
		perror("setuid failed");
		exit(errno);
	    }
For some unknown reason the process has no right to
setgid(screen->gid);
but the problem does not show up until the setuid ().

2002-07-01  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.c (seteuid32): Do not return an error when
	the token cannot be created only because of a problem
	with the gid.

--- syscalls.cc.orig    2002-06-26 21:19:38.000000000 -0400
+++ syscalls.cc 2002-07-01 18:22:18.000000000 -0400
@@ -2104,6 +2104,7 @@
   if (cygheap->user.issetuid ()
        && !ImpersonateLoggedOnUser (cygheap->user.token))
     system_printf ("Impersonating in seteuid failed: %E");
+  if (uid == myself->uid) return 0;
   return -1;
 }
