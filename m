Return-Path: <cygwin-patches-return-1760-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23148 invoked by alias); 23 Jan 2002 01:07:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23126 invoked from network); 23 Jan 2002 01:07:23 -0000
Message-ID: <3C4E0C9F.1BEECC02@yahoo.com>
Date: Tue, 22 Jan 2002 17:07:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
Subject: include/sys/strace.h
Content-Type: multipart/mixed;
 boundary="------------97DDB459E4CBD879BF770B8B"
X-SW-Source: 2002-q1/txt/msg00117.txt.bz2

This is a multi-part message in MIME format.
--------------97DDB459E4CBD879BF770B8B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 113

I've created simple macros to set strace.active ON or OFF when
--enable-debugging is enabled.

Comments?

Earnie.
--------------97DDB459E4CBD879BF770B8B
Content-Type: text/plain; charset=us-ascii;
 name="strace.h.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="strace.h.diff.txt"
Content-length: 806

2002.01.22  Earnie Boyd  <earnie@users.sf.net>

	* include/sys/strace.h (_STRACE_ON): Define.
	(_STRACE_OFF): Ditto.

Index: strace.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/strace.h,v
retrieving revision 1.12
diff -u -3 -p -r1.12 strace.h
--- strace.h	2001/04/03 02:53:25	1.12
+++ strace.h	2002/01/23 01:00:40
@@ -77,6 +77,13 @@ extern strace strace;
 #define _STRACE_MALLOC	 0x20000 // trace malloc calls
 #define _STRACE_THREAD	 0x40000 // thread-locking calls
 #define _STRACE_NOTALL	 0x80000 // don't include if _STRACE_ALL
+#if defined (DEBUGGING)
+# define _STRACE_ON strace.active = 1;
+# define _STRACE_OFF strace.active = 0;
+#else
+# define _STRACE_ON
+# define _STRACE_OFF
+#endif
 
 #ifdef __cplusplus
 extern "C" {

--------------97DDB459E4CBD879BF770B8B--


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

