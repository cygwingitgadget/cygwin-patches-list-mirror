Return-Path: <cygwin-patches-return-5359-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16167 invoked by alias); 27 Feb 2005 02:37:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16129 invoked from network); 27 Feb 2005 02:37:28 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 27 Feb 2005 02:37:28 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.34)
	id 1D5EIp-00024Y-ED
	for cygwin-patches@cygwin.com; Sun, 27 Feb 2005 02:37:03 +0000
Message-ID: <422133BC.62A176E1@dessent.net>
Date: Sun, 27 Feb 2005 02:37:00 -0000
From: Brian Dessent <brian@dessent.net>
Organization: My own little world...
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] Fix buffer overflow in kill utility
Content-Type: multipart/mixed;
 boundary="------------4821E5F2CAC2C69F78902FA1"
X-SW-Source: 2005-q1/txt/msg00062.txt.bz2

This is a multi-part message in MIME format.
--------------4821E5F2CAC2C69F78902FA1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 931


In kill.cc there exists the possibility to overflow the "char buf[80]"
array by supplying malformed command line arguments.

An attacker could use this to overwrite the return value on the stack
and execute arbitrary code, but the amount of space available on the
stack for shellcode is approx 108 bytes so you'd have to be mighty
creative to do anything significant with it.  A far-fetched scenario
might be some kind of perl or other CGI script running under Apache that
somehow allows a user-specified signal name to reach the command line of
/bin/kill.  Emphasis on the "far-fetched" part though.

Example:

$ /bin/kill -s `perl -e 'print "A"x200'`       
Segmentation fault (core dumped)

As far as I can tell from CVS history this has existed in kill.cc since
its first version (~5 years.)  Trivial patch below.

2005-02-26  Brian Dessent  <brian@dessent.net>

	* kill.cc (getsig): Use snprintf to prevent overflowing `buf'.
--------------4821E5F2CAC2C69F78902FA1
Content-Type: text/plain; charset=us-ascii;
 name="kill-overflow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kill-overflow.patch"
Content-length: 547

Index: winsup/utils/kill.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/kill.cc,v
retrieving revision 1.25
diff -u -p -r1.25 kill.cc
--- winsup/utils/kill.cc	13 Nov 2004 16:30:19 -0000	1.25
+++ winsup/utils/kill.cc	27 Feb 2005 02:29:40 -0000
@@ -87,7 +87,7 @@ getsig (const char *in_sig)
     sig = in_sig;
   else
     {
-      sprintf (buf, "SIG%s", in_sig);
+      snprintf (buf, sizeof(buf), "SIG%s", in_sig);
       sig = buf;
     }
   intsig = strtosigno (sig) ?: atoi (in_sig);


--------------4821E5F2CAC2C69F78902FA1--
