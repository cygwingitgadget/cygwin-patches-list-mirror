Return-Path: <cygwin-patches-return-5817-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8108 invoked by alias); 12 Apr 2006 13:53:40 -0000
Received: (qmail 8096 invoked by uid 22791); 12 Apr 2006 13:53:39 -0000
X-Spam-Check-By: sourceware.org
Received: from web53003.mail.yahoo.com (HELO web53003.mail.yahoo.com) (206.190.49.33)     by sourceware.org (qpsmtpd/0.31) with SMTP; Wed, 12 Apr 2006 13:53:36 +0000
Received: (qmail 72246 invoked by uid 60001); 12 Apr 2006 13:53:33 -0000
Message-ID: <20060412135333.72244.qmail@web53003.mail.yahoo.com>
Received: from [69.141.137.97] by web53003.mail.yahoo.com via HTTP; Wed, 12 Apr 2006 06:53:33 PDT
Date: Wed, 12 Apr 2006 13:53:00 -0000
From: Gary Zablackis <gzabl@yahoo.com>
Subject: Patch for silent crash with Cygwin1.dll v 1.5.19-4
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Bernhard Loos <bernloos@web.de>
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
X-SW-Source: 2006-q2/txt/msg00005.txt.bz2


Hi,
  
Since installing Cygwin1.dll v 1.5.19-4, I have a
problem with the computer algebra system SAGE dying
at startup with no error messages (i.e. I get returned
to the bash prompt with no messages of any sort).
The problem occurs when a dll that is created with c++
is dlopen()'d. Microsoft's LoadLibrary() function
installs its own exception handler (at fs:0) which
does not pass control back to Cygwin's exception
handler; thus, when the dll is loaded, 
   pthread::once() gets called, which calls
(indirectly) into
   pthread_key_create() which call into 
   verifyable_object_isvalid() in winsup/thread.cc. 
This last function raises an exception which
LoadLibrary() assumes to be fatal, thereby
short-circuiting the exception mechanism built into
verifyable_object_isvalid().

The code below corrects this problem. 

CHANGELOG:
2006-04-11 Gary Zablackis gzabl@yahoo.com
 * (Thanks to Bernhard Loos for pointing the way)
 * dll_init.cc (dll_dllcrt0()): install Cygwin
exception handler so that Cygwin can handle checking
for invalid pointers in dlopen()'ed dlls.

CVS DIFF FILE:
Index: dll_init.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dll_init.cc,v
retrieving revision 1.49
diff -u -p -r1.49 dll_init.cc
--- dll_init.cc 14 Mar 2006 19:07:36 -0000      1.49
+++ dll_init.cc 12 Apr 2006 13:41:24 -0000
@@ -351,6 +351,8 @@ dll_list::load_after_fork (HANDLE
parent
 extern "C" int
 dll_dllcrt0 (HMODULE h, per_process *p)
 {
+  _my_tls.init_exception_handler
(_cygtls::handle_exceptions);
+
   if (p == NULL)
     p = &__cygwin_user_data;
   else


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
