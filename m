Return-Path: <cygwin-patches-return-6115-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7154 invoked by alias); 16 Jun 2007 15:38:39 -0000
Received: (qmail 7136 invoked by uid 22791); 16 Jun 2007 15:38:38 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 16 Jun 2007 15:38:35 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1HzaMD-0006vf-1m; Sat, 16 Jun 2007 15:38:33 +0000
Message-ID: <467403F8.FDD06745@dessent.net>
Date: Sat, 16 Jun 2007 15:38:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: newlib@sources.redhat.com
CC: cygwin-patches@cygwin.com
Subject: Re: Failure in rebuilding Cygwin-1.5.24-2 with recent newlib
References: <Pine.OSF.4.21.0706161607350.22962-100000@ax0rm1.roma1.infn.it>
Content-Type: multipart/mixed;  boundary="------------D4464E62DC9B6DEE75464500"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00061.txt.bz2

This is a multi-part message in MIME format.
--------------D4464E62DC9B6DEE75464500
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1841

Angelo Graziosi wrote:
> 
> I want to flag that rebuilding Cygwin-1.5.24-2 with recent checkout of
> newlib fails in this way:

It's really not a good idea to mix and match like that, you can run into
subtle breakage that way as the two are meant to be kept in sync.  For
example, if newlib added a new function (as in this case) it will be
present in the headers but it won't get exported by the DLL since that
requires changes in cygwin.din.  And thus if you try to use the
combination of lib+headers that you just built you'll get failures since
the latter declares an interface that the former doesn't export.

And besides, Newlib and Cygwin are in the same CVS repository so all you
have to do is check out the cygwin module and you get the latest newlib
module automatically.

> '/home/Angelo/Downloads/cygwin_varie/Snapshots/cygwin-1.5.24-2p5/newlib/libc/string/'`strcasestr.c
> /home/Angelo/Downloads/cygwin_varie/Snapshots/cygwin-1.5.24-2p5/newlib/libc/string/strcasestr.c:72: error: parse
> error before string constant
> /home/Angelo/Downloads/cygwin_varie/Snapshots/cygwin-1.5.24-2p5/newlib/libc/string/strcasestr.c:72: warning: data
> definition has no type or storage class

This is just due to __FBSDID not getting #defined to blank properly. 
The file includes sys/cdefs.h and newlib's copy contains the required
bit (#define __FBSDID(x) /* nothing */) however when building with
Cygwin, the Cygwin headers are used and Cygwin's sys/cdefs.h doesn't
contain this.  The appropriate fix is either to modify strcasestr.c or
to fix Cygwin's sys/cdefs.h.  I think the latter is probably the better
choice, since it seems that there is precedent already in newlib for
being able to just #include <sys/cdefs.h> followed by use of __FBSDID
without having to explicitly undefine it.  Patch attached which fixes
the build for me.

Brian
--------------D4464E62DC9B6DEE75464500
Content-Type: text/plain; charset=us-ascii;
 name="cygwin-cdefs-fbsdid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-cdefs-fbsdid.patch"
Content-length: 514

2007-06-16  Brian Dessent  <brian@dessent.net>

	* include/sys/cdefs.h (__FBSDID): Define.

Index: include/sys/cdefs.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/cdefs.h,v
retrieving revision 1.4
diff -u -p -r1.4 cdefs.h
--- include/sys/cdefs.h	8 Aug 2005 18:54:28 -0000	1.4
+++ include/sys/cdefs.h	16 Jun 2007 15:28:58 -0000
@@ -21,3 +21,4 @@ details. */
 #define  __CONCAT(__x,__y)   __x##__y
 #endif
 
+#define __FBSDID(x) /* nothing */

--------------D4464E62DC9B6DEE75464500--
