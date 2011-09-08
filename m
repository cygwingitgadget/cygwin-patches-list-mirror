Return-Path: <cygwin-patches-return-7505-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15031 invoked by alias); 8 Sep 2011 18:37:45 -0000
Received: (qmail 14863 invoked by uid 22791); 8 Sep 2011 18:37:43 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 08 Sep 2011 18:37:29 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.6]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 08 Sep 2011 19:37:27 +0100
Message-ID: <4E690B69.6020306@dronecode.org.uk>
Date: Thu, 08 Sep 2011 18:37:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0) Gecko/20110905 Thunderbird/7.0
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [PATCH] Fix strace -T
Content-Type: multipart/mixed; boundary="------------070406020501000206020800"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00081.txt.bz2

This is a multi-part message in MIME format.
--------------070406020501000206020800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 345


strace -T to toggle stracing of a process doesn't seem to work at the moment. 
Attached is a patch to make it work again.

2011-09-08  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* include/sys/strace.h (strace): Add toggle() method
	* strace.cc (toggle): Implement toggle() method
	* sigproc.cc (wait_sig): Use strace.toggle() in __SIGSTRACE



--------------070406020501000206020800
Content-Type: text/plain;
 name="strace_toggle.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="strace_toggle.patch"
Content-length: 1187

Fix 'strace -T -pid=<pid>'

Index: cygwin/include/sys/strace.h
===================================================================
--- cygwin/include/sys/strace.h.orig
+++ cygwin/include/sys/strace.h
@@ -40,6 +40,7 @@ class strace
   unsigned char _active;
 public:
   void activate ();
+  void toggle ();
   strace () {activate ();}
   int microseconds ();
   int version;
Index: cygwin/sigproc.cc
===================================================================
--- cygwin/sigproc.cc.orig
+++ cygwin/sigproc.cc
@@ -1194,7 +1194,7 @@ wait_sig (VOID *)
 	  talktome (&pack.si);
 	  break;
 	case __SIGSTRACE:
-	  strace.activate ();
+	  strace.toggle ();
 	  strace.hello ();
 	  break;
 	case __SIGPENDING:
Index: cygwin/strace.cc
===================================================================
--- cygwin/strace.cc.orig
+++ cygwin/strace.cc
@@ -43,6 +43,21 @@ strace::activate ()
 }
 
 void
+strace::toggle()
+{
+  if (active())
+    {
+      /* turn off stracing */
+      _active ^= 1;
+    }
+  else
+    {
+      /* announcing _STRACE_INTERFACE_ACTIVATE_ADDR makes the stracer turn on stracing */
+      activate ();
+    }
+}
+
+void
 strace::hello ()
 {
   if (active ())

--------------070406020501000206020800--
