Return-Path: <cygwin-patches-return-5386-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23261 invoked by alias); 27 Mar 2005 20:23:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23245 invoked from network); 27 Mar 2005 20:23:36 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.219.218)
  by sourceware.org with SMTP; 27 Mar 2005 20:23:36 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id IE11RP-000230-J3
	for cygwin-patches@cygwin.com; Sun, 27 Mar 2005 15:19:01 -0500
Message-Id: <3.0.5.32.20050327151900.00b60730@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 27 Mar 2005 20:23:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: hires_ms::usecs
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q1/txt/msg00089.txt.bz2

The old test below will only detect the wraparound when "now" is
in the interval [0, inittime_ms), so it's likely to miss if
inittime_ms is very small (e.g. daemon starting at reboot).

With the new test, the wraparound will be detected if the function
is called at any time between the 25th and 49th day after startup.

Pierre

 

2005-03-27  Pierre Humblet <pierre.humblet@ieee.org>

	*times.cc (hires_ms::usecs): Compare the difference.

Index: times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.62
diff -u -p -r1.62 times.cc
--- times.cc    2 Mar 2005 08:28:54 -0000       1.62
+++ times.cc    27 Mar 2005 20:10:34 -0000
@@ -597,7 +597,7 @@ hires_ms::usecs (bool justdelta)
   if (!minperiod) /* NO_COPY variable */
     prime ();
   DWORD now = timeGetTime ();
-  if (now < initime_ms)
+  if (now - initime_ms < 0)
     {
       inited = 0;
       prime ();
