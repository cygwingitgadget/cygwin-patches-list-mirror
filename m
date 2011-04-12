Return-Path: <cygwin-patches-return-7280-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24393 invoked by alias); 12 Apr 2011 19:17:42 -0000
Received: (qmail 24381 invoked by uid 22791); 12 Apr 2011 19:17:41 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 12 Apr 2011 19:17:36 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.10]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 12 Apr 2011 20:17:35 +0100
Message-ID: <4DA4A55F.8040407@dronecode.org.uk>
Date: Tue, 12 Apr 2011 19:17:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [PATCH] Fix for strace manpage
Content-Type: multipart/mixed; boundary="------------060906090105040908050309"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00046.txt.bz2

This is a multi-part message in MIME format.
--------------060906090105040908050309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 739


'man strace' contains the rather confusing text:

>        -T, --toggle
>               toggle tracing in a process already being
> 
>        -u, --usecs
>               toggle printing of microseconds timestamp traced. Requires -p <pid>

This seems to be due to the description of -u being added in between the two
lines which describe -T in utils.sgml revision 1.56.  Attached patch puts them
in the right order:

>        -T, --toggle
>               toggle tracing in a process already being traced. Requires -p <pid>
> 
>        -u, --usecs
>               toggle printing of microseconds timestamp 

2011-04-12  Jon TURNEY  <jon.turney@dronecode.org.uk>

        * utils.sgml (strace): Fix a pair of exchanged lines in usage text.


--------------060906090105040908050309
Content-Type: text/plain;
 name="strace_man_page_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="strace_man_page_fix.patch"
Content-length: 935

Index: utils/utils.sgml
===================================================================
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v
retrieving revision 1.91
diff -u -p -r1.91 utils.sgml
--- utils/utils.sgml	11 Aug 2010 11:01:14 -0000	1.91
+++ utils/utils.sgml	12 Apr 2011 19:16:27 -0000
@@ -1913,8 +1913,8 @@ Trace system calls and signals
   -t, --timestamp              use an absolute hh:mm:ss timestamp insted of 
                                the default microsecond timestamp.  Implies -d
   -T, --toggle                 toggle tracing in a process already being
-  -u, --usecs                  toggle printing of microseconds timestamp
                                traced. Requires -p &lt;pid&gt;
+  -u, --usecs                  toggle printing of microseconds timestamp
   -v, --version                output version information and exit
   -w, --new-window             spawn program under test in a new window
 

--------------060906090105040908050309--
