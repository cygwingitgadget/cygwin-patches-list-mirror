Return-Path: <cygwin-patches-return-5616-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19661 invoked by alias); 11 Aug 2005 16:56:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19636 invoked by uid 22791); 11 Aug 2005 16:55:59 -0000
Received: from zproxy.gmail.com (HELO zproxy.gmail.com) (64.233.162.194)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 11 Aug 2005 16:55:59 +0000
Received: by zproxy.gmail.com with SMTP id f1so278764nzc
        for <cygwin-patches@cygwin.com>; Thu, 11 Aug 2005 09:55:57 -0700 (PDT)
Received: by 10.36.2.9 with SMTP id 9mr1629082nzb;
        Thu, 11 Aug 2005 09:55:57 -0700 (PDT)
Received: from ?129.46.14.79? ([129.46.14.79])
        by mx.gmail.com with ESMTP id 15sm864679nzn.2005.08.11.09.55.57;
        Thu, 11 Aug 2005 09:55:57 -0700 (PDT)
Message-ID: <42FB831B.6090108@gmail.com>
Date: Thu, 11 Aug 2005 16:56:00 -0000
From: Troy Curtiss <trcurtiss@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
CC:  peter@rehley.net
Subject: [PATCH]: Fix for errant tcgetattr() behavior
Content-Type: multipart/mixed;
 boundary="------------050008080108080707020201"
X-SW-Source: 2005-q3/txt/msg00071.txt.bz2

This is a multi-part message in MIME format.
--------------050008080108080707020201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 803

Way back in 02/01/2003, a patch of mine was applied that enhanced 
tcsetattr() to handle setting baud rate B0 correctly (ie. dropping DTR, 
leave actual baud rate alone), but added some incorrect behavior in 
tcgetattr().  The correct behavior, I believe, should be as follows:

1) When a baud rate of B0 is passed to tcsetattr(), it should not change 
the actual baud rate, but instead drop DTR.
2) In tcgetattr(), the presently set baud rate should be returned, 
regardless of the state of DTR.

My earlier patch broke #2.  The attached patch fixes this error, and 
tcgetattr() now returns the correct baud rate regardless of DTR state.  
Thanks,

-Troy

Changelog entry:
* fhandler_serial.cc (fhandler_serial::tcgetattr):  Make tcgetattr() 
return current baud rate regardless of current DTR state.


--------------050008080108080707020201
Content-Type: text/plain;
 name="sttyfix_tcgetattr_b0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sttyfix_tcgetattr_b0.patch"
Content-length: 1989

--- old_fhandler_serial.cc	2005-08-11 09:31:05.202669500 -0600
+++ new_fhandler_serial.cc	2005-08-11 09:38:36.104522300 -0600
@@ -908,55 +908,50 @@ fhandler_serial::tcgetattr (struct termi
   memset (t, 0, sizeof (*t));
 
   /* -------------- Baud rate ------------------ */
-
-  /* If DTR is NOT set, return B0 as our speed */
-  if (dtr != TIOCM_DTR)
-    t->c_cflag = t->c_ospeed = t->c_ispeed = B0;
-  else
-    switch (state.BaudRate)
-      {
-      case CBR_110:
+  switch (state.BaudRate)
+    {
+    case CBR_110:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B110;
 	break;
-      case CBR_300:
+    case CBR_300:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B300;
 	break;
-      case CBR_600:
+    case CBR_600:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B600;
 	break;
-      case CBR_1200:
+    case CBR_1200:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B1200;
 	break;
-      case CBR_2400:
+    case CBR_2400:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B2400;
 	break;
-      case CBR_4800:
+    case CBR_4800:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B4800;
 	break;
-      case CBR_9600:
+    case CBR_9600:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B9600;
 	break;
-      case CBR_19200:
+    case CBR_19200:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B19200;
 	break;
-      case CBR_38400:
+    case CBR_38400:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B38400;
 	break;
-      case CBR_57600:
+    case CBR_57600:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B57600;
 	break;
-      case CBR_115200:
+    case CBR_115200:
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B115200;
 	break;
-      case 230400: /* CBR_230400 - not defined */
+    case 230400: /* CBR_230400 - not defined */
 	t->c_cflag = t->c_ospeed = t->c_ispeed = B230400;
 	break;
-      default:
+    default:
 	/* Unsupported baud rate! */
 	termios_printf ("Invalid baud rate %d", state.BaudRate);
 	set_errno (EINVAL);
 	return -1;
-      }
+    }
 
   /* -------------- Byte size ------------------ */
 

--------------050008080108080707020201--
