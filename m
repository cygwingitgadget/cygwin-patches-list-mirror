Return-Path: <cygwin-patches-return-5700-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1628 invoked by alias); 5 Jan 2006 20:50:53 -0000
Received: (qmail 1618 invoked by uid 22791); 5 Jan 2006 20:50:51 -0000
X-Spam-Check-By: sourceware.org
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 05 Jan 2006 20:50:50 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.160]) 	by main.electric-cloud.com (8.13.1/8.13.1) with ESMTP id k05KolUc023315 	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO) 	for <cygwin-patches@cygwin.com>; Thu, 5 Jan 2006 12:50:47 -0800
Subject: sigproc_init() handling CreateThread() failures
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain
Date: Thu, 05 Jan 2006 20:50:00 -0000
Message-Id: <1136494247.6371.16.camel@fulgurite>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00009.txt.bz2

I was debugging a frozen job (in the mysql build) and ran into an
interesting stack trace:

#0  0x61093427 in wait_for_sigthread ()
    at ../../../../winsup/cygwin/sigproc.cc:136
#1  0x61094221 in sig_send (p=0x0, si=@0x23ab30, tls=0x0)
    at ../../../../winsup/cygwin/sigproc.cc:560
#2  0x61094810 in sig_send (p=0x1dc0, sig=6)
    at ../../../../winsup/cygwin/sigproc.cc:519
#3  0x61095e6e in sigproc_terminate (es=ES_FINAL)
    at ../../../../winsup/cygwin/sigproc.cc:505
#4  0x6106e964 in pinfo::exit (this=0x6, n=1)
    at ../../../../winsup/cygwin/pinfo.cc:151
#5  0x61004f01 in __api_fatal (
    fmt=0x611057c4 "CreateThread failed for %s - %p<%p>, %E")
    at ../../../../winsup/cygwin/dcrt0.cc:1167
#6  0x610036c5 in cygthread::cygthread (this=???, start=???, n=???, param=???,
    name=???, notify=???) at ../../../../winsup/cygwin/cygthread.cc:214

buf in frame 5 is "C:\\cygwin\\bin\\bash.exe: *** fatal error -
CreateThread failed for sig - 0x0<0x0>, Win32 error 0".  This
suggests that what's happening is that sigproc_init()
initializes wait_sig_inited, calls the cygthread constructor,
CreateThread fails (though that Win32 error 0 is just a little
suspicious), and calls api_fatal().  When pinfo::exit() calls
sigproc_terminate(), sig_send() sees that wait_sig_inited
is nonzero and calls wait_for_sigthread()-- but the sigthread
hasn't started yet.

I notice that no_signals_available() tests my_sendsig using !.
INVALID_HANDLE_VALUE is -1.  If no_signals_available() evaluates
to true, that should prevent sig_send() from getting to the
wait_for_sigthread() when there's no sigthread to wait for.
Here's the patch:


2006-01-05  Max Kaehn  <slothman@electric-cloud.com>

	* sigproc.cc (no_signals_available):  test for my_sendsig ==
	INVALID_HANDLE_VALUE.



Index: winsup/cygwin/sigproc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v
retrieving revision 1.271
diff -u -p -r1.271 sigproc.cc
--- winsup/cygwin/sigproc.cc    5 Jan 2006 16:26:22 -0000       1.271
+++ winsup/cygwin/sigproc.cc    5 Jan 2006 20:39:50 -0000
@@ -39,7 +39,7 @@ details. */
 #define WSSC             60000 // Wait for signal completion
 #define WPSP             40000 // Wait for proc_subproc mutex

-#define no_signals_available(x) (!my_sendsig || ((x) && myself->exitcode & EXITCODE_SET) || &_my_tls == _sig_tls)
+#define no_signals_available(x) (!my_sendsig || my_sendsig == INVALID_HANDLE_VALUE || ((x) && myself->exitcode & EXITCODE_SET) || &_my_tls == _sig_tls)

 #define NPROCS 256



