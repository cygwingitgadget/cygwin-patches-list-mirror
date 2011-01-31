Return-Path: <cygwin-patches-return-7158-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9021 invoked by alias); 31 Jan 2011 19:44:21 -0000
Received: (qmail 9011 invoked by uid 22791); 31 Jan 2011 19:44:20 -0000
X-SWARE-Spam-Status: No, hits=-0.2 required=5.0	tests=AWL,BAYES_40,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout04.t-online.de (HELO mailout04.t-online.de) (194.25.134.18)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 31 Jan 2011 19:44:15 +0000
Received: from fwd10.aul.t-online.de (fwd10.aul.t-online.de )	by mailout04.t-online.de with smtp 	id 1PjzfY-0000wK-Kn; Mon, 31 Jan 2011 20:44:12 +0100
Received: from [192.168.2.100] (JbFFu-ZcrhhPFH3eLAr4XW59VKQ4SCUpRlq-k00ksbuZ5a4bK6bShms1cYVRpuWg38@[79.224.122.203]) by fwd10.aul.t-online.de	with esmtp id 1PjzfS-0gg9dQ0; Mon, 31 Jan 2011 20:44:06 +0100
Message-ID: <4D471106.4050304@t-online.de>
Date: Mon, 31 Jan 2011 19:44:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.15) Gecko/20101027 SeaMonkey/2.0.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix bogus fsync() error
Content-Type: multipart/mixed; boundary="------------060109000809010803090308"
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
X-SW-Source: 2011-q1/txt/msg00013.txt.bz2

This is a multi-part message in MIME format.
--------------060109000809010803090308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 495

If used on raw devices like /dev/sda fsync() always fails with EBADRQC 
(54) because FlushFileBuffers() always fails with ERROR_INVALID_FUNCTION 
(1).

The attached patch fixes this by simply ignoring this error in the 
fhandler_base implementation. This should not affect any real flush 
errors which likely would return other error codes.

An alternative approach would be to ignore the error only in a new 
fhandler_raw_dev/floppy::fsync(). IMO not worth the effort is this case.

Christian


--------------060109000809010803090308
Content-Type: text/x-patch;
 name="fsync-rawdev-err.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fsync-rawdev-err.patch"
Content-length: 763

2011-01-31  Christian Franke  <franke@computer.org>

	* fhandler.cc (fhandler_base::fsync): Ignore ERROR_INVALID_FUNCTION
	error from FlushFileBuffers().


diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index c97cc01..d7f46ec 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -1588,7 +1588,15 @@ fhandler_base::fsync ()
     return 0;
   if (FlushFileBuffers (get_handle ()))
     return 0;
-  __seterrno ();
+
+  /* Ignore ERROR_INVALID_FUNCTION because FlushFileBuffers()
+     always fails with this code on raw devices which are
+     unbuffered by default.  */
+  DWORD errcode = GetLastError();
+  if (errcode == ERROR_INVALID_FUNCTION)
+    return 0;
+
+  __seterrno_from_win_error (errcode);
   return -1;
 }
 

--------------060109000809010803090308--
