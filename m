Return-Path: <cygwin-patches-return-6138-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30620 invoked by alias); 6 Sep 2007 18:30:30 -0000
Received: (qmail 30582 invoked by uid 22791); 6 Sep 2007 18:30:27 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Sep 2007 18:30:19 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1ITM7O-0005Vn-1u 	for cygwin-patches@cygwin.com; Thu, 06 Sep 2007 18:30:18 +0000
Message-ID: <46E04739.F0B0D169@dessent.net>
Date: Thu, 06 Sep 2007 18:30:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] Fix multithreaded snprintf
Content-Type: multipart/mixed;  boundary="------------0B82536B1BB383445B71EE33"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00013.txt.bz2

This is a multi-part message in MIME format.
--------------0B82536B1BB383445B71EE33
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1871


I tracked down the problem reported in
<http://www.cygwin.com/ml/cygwin/2007-09/msg00120.html>.  The crash was
occuring in pthread_mutex_lock, but that's a bit of a red herring.  The
real problem is that both newlib and Cygwin provide a
include/sys/stdio.h file, however they were out of sync with regard to
the _flockfile definition.

This comes about because vsnprintf() is implemented by creating a struct
FILE that represents the string buffer and then this is passed to the
standard vfprintf().  The 'flags' member of this FILE has the __SSTR
flag set to indicate that this is just a string buffer, and consequently
no locking should or can be performed; the lock member isn't even
initialized.

The newlib/libc/include/sys/stdio.h therefore has this:

#if !defined(_flockfile)
#ifndef __SINGLE_THREAD__
#  define _flockfile(fp) (((fp)->_flags & __SSTR) ? 0 :
__lock_acquire_recursive((fp)->_lock))
#else
#  define _flockfile(fp)
#endif
#endif

#if !defined(_funlockfile)
#ifndef __SINGLE_THREAD__
#  define _funlockfile(fp) (((fp)->_flags & __SSTR) ? 0 :
__lock_release_recursive((fp)->_lock))
#else
#  define _funlockfile(fp)
#endif
#endif

However, the Cygwin version of this header with the same name gets
preference and doesn't know to check the flags like this, and thus
unconditionally tries to lock the stream.  This leads ultimately to a
crash in pthread_mutex_lock because the lock member is just
uninitialized junk.

The attached patch fixes Cygwin's copy of the header and makes the
poster's testcase function as expected.  This only would appear in a
multithreaded program because the __cygwin_lock_* functions expand to
no-op in the case where there's only one thread.

Since this is used in a C++ file (syscalls.cc) I couldn't do the "test ?
0 : func()" idiom where void is the return type as that generates a
compiler error, so I use an 'if'.

Brian
--------------0B82536B1BB383445B71EE33
Content-Type: text/plain; charset=us-ascii;
 name="flockfile-defs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="flockfile-defs.patch"
Content-length: 1328

2007-09-06  Brian Dessent  <brian@dessent.net>

	* include/sys/stdio.h (_flockfile): Don't try to lock a FILE
	that has the __SSTR flag set.
	(_ftrylockfile): Likewise.
	(_funlockfile): Likewise.


Index: include/sys/stdio.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/stdio.h,v
retrieving revision 1.6
diff -u -p -r1.6 stdio.h
--- include/sys/stdio.h	5 Feb 2006 20:30:24 -0000	1.6
+++ include/sys/stdio.h	6 Sep 2007 18:27:33 -0000
@@ -16,13 +16,16 @@ details. */
 
 #if !defined(__SINGLE_THREAD__)
 #  if !defined(_flockfile)
-#    define _flockfile(fp) __cygwin_lock_lock ((_LOCK_T *)&(fp)->_lock)
+#    define _flockfile(fp) ({ if (!((fp)->_flags & __SSTR)) \
+                  __cygwin_lock_lock ((_LOCK_T *)&(fp)->_lock); })
 #  endif
 #  if !defined(_ftrylockfile)
-#    define _ftrylockfile(fp) __cygwin_lock_trylock ((_LOCK_T *)&(fp)->_lock)
+#    define _ftrylockfile(fp) (((fp)->_flags & __SSTR) ? 0 : \
+                  __cygwin_lock_trylock ((_LOCK_T *)&(fp)->_lock))
 #  endif
 #  if !defined(_funlockfile)
-#    define _funlockfile(fp) __cygwin_lock_unlock ((_LOCK_T *)&(fp)->_lock)
+#    define _funlockfile(fp) ({ if (!((fp)->_flags & __SSTR)) \
+                  __cygwin_lock_unlock ((_LOCK_T *)&(fp)->_lock); })
 #  endif
 #endif
 

--------------0B82536B1BB383445B71EE33--
