Return-Path: <cygwin-patches-return-7145-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17526 invoked by alias); 5 Jan 2011 19:50:42 -0000
Received: (qmail 17503 invoked by uid 22791); 5 Jan 2011 19:50:41 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,TW_YG
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 Jan 2011 19:50:35 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.8]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 05 Jan 2011 19:50:33 +0000
Message-ID: <4D24CB9A.2030906@dronecode.org.uk>
Date: Wed, 05 Jan 2011 19:50:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygcheck -s should not imply -d
Content-Type: multipart/mixed; boundary="------------010207030109010509020406"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------010207030109010509020406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 451


Currently, for cygcheck -s implies -d.  This seems rather unhelpful.

I'm afraid I've lost the thread which inspired this, but in it the reporter
provided cygcheck -svr output as requested, but this did not help diagnose
what ultimately turned out to be the problem, that a DLL was actually an older
version (presumably due to replace-in-use problems)

Attached a patch to modify cygcheck so -s no longer implies -d (although -d
can still be used).


--------------010207030109010509020406
Content-Type: text/plain;
 name="cygcheck_s_not_imply_d.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygcheck_s_not_imply_d.patch"
Content-length: 1467


2011-01-05  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* cygcheck.cc (main): don't imply -d from -s option to cygcheck

Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.124
diff -u -r1.124 cygcheck.cc
--- cygcheck.cc	28 Aug 2010 11:22:37 -0000	1.124
+++ cygcheck.cc	5 Jan 2011 15:49:47 -0000
@@ -2180,7 +2180,7 @@
   -c, --check-setup    show installed version of PACKAGE and verify integrity\n\
                        (or for all installed packages if none specified)\n\
   -d, --dump-only      just list packages, do not verify (with -c)\n\
-  -s, --sysinfo        produce diagnostic system information (implies -c -d)\n\
+  -s, --sysinfo        produce diagnostic system information (implies -c)\n\
   -r, --registry       also scan registry for Cygwin settings (with -s)\n\
   -k, --keycheck       perform a keyboard check session (must be run from a\n\
                        plain console only, not from a pty/rxvt/xterm)\n\
@@ -2406,7 +2406,7 @@
       && unique_object_name_opt)
     usage (stderr, 1);
 
-  if (dump_only && !check_setup)
+  if (dump_only && !check_setup && !sysinfo)
     usage (stderr, 1);
 
   if (find_package + list_package + grep_packages > 1)
@@ -2454,7 +2454,7 @@
       if (!check_setup)
 	{
 	  puts ("");
-	  dump_setup (verbose, NULL, false);
+	  dump_setup (verbose, NULL, !dump_only);
 	}
 
       if (!givehelp)


--------------010207030109010509020406--
