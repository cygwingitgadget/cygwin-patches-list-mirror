Return-Path: <cygwin-patches-return-7172-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5050 invoked by alias); 10 Feb 2011 02:15:59 -0000
Received: (qmail 5039 invoked by uid 22791); 10 Feb 2011 02:15:58 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm4.bullet.mail.sp2.yahoo.com (HELO nm4.bullet.mail.sp2.yahoo.com) (98.139.91.74)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 10 Feb 2011 02:15:50 +0000
Received: from [98.139.91.62] by nm4.bullet.mail.sp2.yahoo.com with NNFMP; 10 Feb 2011 02:15:49 -0000
Received: from [98.136.185.43] by tm2.bullet.mail.sp2.yahoo.com with NNFMP; 10 Feb 2011 02:15:48 -0000
Received: from [127.0.0.1] by smtp104.mail.gq1.yahoo.com with NNFMP; 10 Feb 2011 02:15:48 -0000
Received: from cgf.cx (cgf@72.70.43.36 with login)        by smtp104.mail.gq1.yahoo.com with SMTP; 09 Feb 2011 18:15:48 -0800 PST
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 7D0E613C0CA	for <cygwin-patches@cygwin.com>; Wed,  9 Feb 2011 21:15:47 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 6AA992B352; Wed,  9 Feb 2011 21:15:47 -0500 (EST)
Date: Thu, 10 Feb 2011 02:15:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: provide __xpg_strerror_r
Message-ID: <20110210021547.GA26395@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D4DAD40.3060904@redhat.com> <20110205202806.GA11118@ednor.casa.cgf.cx> <4D4DB682.3070601@redhat.com> <20110206095423.GA19356@calimero.vinschen.de> <4D532F6B.5080104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D532F6B.5080104@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00027.txt.bz2

On Wed, Feb 09, 2011 at 05:20:59PM -0700, Eric Blake wrote:
>On 02/06/2011 02:54 AM, Corinna Vinschen wrote:
>>> We already provide our own strerror() (it provides a better experience
>>> for out-of-range values that the newlib interface), but we're currently
>>> using the newlib strerror_r() (in spite of its truncation flaw).
>>>
>>> How should I rework this patch?
>> 
>> It would be better if we implement strerror_r locally, in two versions,
>> just as on Linux.  I think the best approach is to implement this in
>> newlib first (I replied to your mail there) and then, given that we use
>> the newlib string.h, copy the method over to Cygwin to match our current
>> strerror more closely.
>
>Here's the cygwin side of things, to match newlib's <string.h> changes.
> Surprisingly, strerror_r turned out to be identical even when based on
>different root strerror(), so I left that inside #if 0, but it's easy
>enough to kill the #if 0 if you don't want cygwin to use any of newlib's
>strerror*.
>
>---
> winsup/cygwin/ChangeLog                |    9 +++
> winsup/cygwin/cygwin.din               |    1 +
> winsup/cygwin/errno.cc                 |   84
>+++++++++++++++++++++-----------
> winsup/cygwin/include/cygwin/version.h |    3 +-
> 4 files changed, 68 insertions(+), 29 deletions(-)
>
>2011-02-09  Eric Blake  <eblake@redhat.com>
>
>	* errno.cc (__xpg_strerror_r): New function.
>	(strerror_r): Update comments to match newlib's fixes.
>	(strerror): Set errno on failure.
>	(_sys_errlist): Cause EINVAL failure for reserved values.
>	* cygwin.din: Export new function.
>	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
>
>-- 
>Eric Blake   eblake@redhat.com    +1-801-349-2682
>Libvirt virtualization library http://libvirt.org

>diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
>index 2e7e647..780179a 100644
>--- a/winsup/cygwin/cygwin.din
>+++ b/winsup/cygwin/cygwin.din
>@@ -1933,6 +1933,7 @@ xdrrec_skiprecord SIGFE
> __xdrrec_getrec SIGFE
> __xdrrec_setnonblock SIGFE
> xdrstdio_create SIGFE
>+__xpg_strerror_r SIGFE
> y0 NOSIGFE
> y0f NOSIGFE
> y1 NOSIGFE
>diff --git a/winsup/cygwin/errno.cc b/winsup/cygwin/errno.cc
>index a9860f4..0e9c863 100644
>--- a/winsup/cygwin/errno.cc
>+++ b/winsup/cygwin/errno.cc
>@@ -199,9 +199,9 @@ const char *_sys_errlist[] NO_COPY_INIT =
> /* EL2HLT 44 */		  "Level 2 halted",
> /* EDEADLK 45 */	  "Resource deadlock avoided",
> /* ENOLCK 46 */		  "No locks available",
>-			  "error 47",
>-			  "error 48",
>-			  "error 49",
>+			  NULL,
>+			  NULL,
>+			  NULL,
> /* EBADE 50 */		  "Invalid exchange",
> /* EBADR 51 */		  "Invalid request descriptor",
> /* EXFULL 52 */		  "Exchange full",
>@@ -210,8 +210,8 @@ const char *_sys_errlist[] NO_COPY_INIT =
> /* EBADSLT 55 */	  "Invalid slot",
> /* EDEADLOCK 56 */	  "File locking deadlock error",
> /* EBFONT 57 */		  "Bad font file format",
>-			  "error 58",
>-			  "error 59",
>+			  NULL,
>+			  NULL,
> /* ENOSTR 60 */		  "Device not a stream",
> /* ENODATA 61 */	  "No data available",
> /* ETIME 62 */		  "Timer expired",
>@@ -224,13 +224,13 @@ const char *_sys_errlist[] NO_COPY_INIT =
> /* ESRMNT 69 */		  "Srmount error",
> /* ECOMM 70 */		  "Communication error on send",
> /* EPROTO 71 */		  "Protocol error",
>-			  "error 72",
>-			  "error 73",
>+			  NULL,
>+			  NULL,
> /* EMULTIHOP 74 */	  "Multihop attempted",
> /* ELBIN 75 */		  "Inode is remote (not really error)",
> /* EDOTDOT 76 */	  "RFS specific error",
> /* EBADMSG 77 */	  "Bad message",
>-			  "error 78",
>+			  NULL,
> /* EFTYPE 79 */		  "Inappropriate file type or format",
> /* ENOTUNIQ 80 */	  "Name not unique on network",
> /* EBADFD 81 */		  "File descriptor in bad state",
>@@ -245,17 +245,17 @@ const char *_sys_errlist[] NO_COPY_INIT =
> /* ENOTEMPTY 90	*/	  "Directory not empty",
> /* ENAMETOOLONG 91 */	  "File name too long",
> /* ELOOP 92 */		  "Too many levels of symbolic links",
>-			  "error 93",
>-			  "error 94",
>+			  NULL,
>+			  NULL,
> /* EOPNOTSUPP 95 */	  "Operation not supported",
> /* EPFNOSUPPORT 96 */	  "Protocol family not supported",
>-			  "error 97",
>-			  "error 98",
>-			  "error 99",
>-			  "error 100",
>-			  "error 101",
>-			  "error 102",
>-			  "error 103",
>+			  NULL,
>+			  NULL,
>+			  NULL,
>+			  NULL,
>+			  NULL,
>+			  NULL,
>+			  NULL,
> /* ECONNRESET 104 */	  "Connection reset by peer",
> /* ENOBUFS 105 */	  "No buffer space available",
> /* EAFNOSUPPORT 106 */	  "Address family not supported by protocol",
>@@ -357,27 +357,55 @@ strerror_worker (int errnum)
>   return res;
> }
>
>-/* strerror: convert from errno values to error strings */
>+/* strerror: convert from errno values to error strings.  Newlib's
>+   strerror_r returns "" for unknown values, so we override it to
>+   provide a nicer thread-safe result string and set errno.  */
> extern "C" char *
> strerror (int errnum)
> {
>   char *errstr = strerror_worker (errnum);
>   if (!errstr)
>-    __small_sprintf (errstr = _my_tls.locals.strerror_buf, "Unknown error %u",
>-		     (unsigned) errnum);
>+    {
>+      __small_sprintf (errstr = _my_tls.locals.strerror_buf, "Unknown error %u",
>+		       (unsigned) errnum);
>+      errno = _impure_ptr->_errno = EINVAL;

This should (as should the other usage in this file), just be "set_errno (EINVAL)".

>+    }
>   return errstr;
> }
>
>+/* Newlib's <string.h> provides declarations for two strerror_r
>+   variants, according to preprocessor feature macros.  It does the
>+   right thing for GNU strerror_r, but its __xpg_strerror_r mishandles
>+   a case of EINVAL when coupled with our strerror() override.*/
> #if 0

Can't we get rid of this now?

cgf
