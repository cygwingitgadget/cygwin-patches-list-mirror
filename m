Return-Path: <cygwin-patches-return-5780-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32315 invoked by alias); 2 Mar 2006 18:11:45 -0000
Received: (qmail 32297 invoked by uid 22791); 2 Mar 2006 18:11:43 -0000
X-Spam-Check-By: sourceware.org
Received: from web53004.mail.yahoo.com (HELO web53004.mail.yahoo.com) (206.190.49.34)     by sourceware.org (qpsmtpd/0.31) with SMTP; Thu, 02 Mar 2006 18:11:41 +0000
Received: (qmail 52072 invoked by uid 60001); 2 Mar 2006 18:11:39 -0000
Message-ID: <20060302181139.52070.qmail@web53004.mail.yahoo.com>
Received: from [69.141.137.97] by web53004.mail.yahoo.com via HTTP; Thu, 02 Mar 2006 10:11:39 PST
Date: Thu, 02 Mar 2006 18:11:00 -0000
From: Gary Zablackis <gzabl@yahoo.com>
Subject: Patch for silent crash with Cygwin1.dll v 1.5.19-4
To: Cygwin Patches <cygwin-patches@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00089.txt.bz2

Hi,
 
Since installing Cygwin1.dll v 1.5.19-4, I have a
problem with the computer algebra system SAGE dying at
startup with no error messages (i.e. I get returned to
the bash prompt with no messages of any sort).
I tracked the problem down to
verifyable_object_isvalid() in winsup/thread.cc. The
added the check below corrects this problem:

CHANGELOG:
2006-03-02 Gary Zablackis gzabl@yahoo.com
 * thread.cc (verifyable_object_isvalid): check for
NULL object or reference

CVS DIFF FILE:
Index: cygwin/thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.196
diff -u -p -r1.196 thread.cc
--- cygwin/thread.cc    6 Feb 2006 18:24:06 -0000     
 1.196
+++ cygwin/thread.cc    2 Mar 2006 18:06:50 -0000
@@ -122,6 +122,9 @@ verifyable_object_isvalid (void
const *
   if (efault.faulted ())
     return INVALID_OBJECT;

+  if(!object || !*object)
+     return INVALID_OBJECT;
+
   if ((static_ptr1 && *object == static_ptr1) ||
       (static_ptr2 && *object == static_ptr2) ||
       (static_ptr3 && *object == static_ptr3))



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
