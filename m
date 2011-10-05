Return-Path: <cygwin-patches-return-7511-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10414 invoked by alias); 5 Oct 2011 13:26:39 -0000
Received: (qmail 10390 invoked by uid 22791); 5 Oct 2011 13:26:37 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,TW_XF,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm7-vm0.access.bullet.mail.mud.yahoo.com (HELO nm7-vm0.access.bullet.mail.mud.yahoo.com) (66.94.237.189)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 05 Oct 2011 13:26:21 +0000
Received: from [66.94.237.196] by nm7.access.bullet.mail.mud.yahoo.com with NNFMP; 05 Oct 2011 13:26:21 -0000
Received: from [66.94.237.109] by tm7.access.bullet.mail.mud.yahoo.com with NNFMP; 05 Oct 2011 13:26:21 -0000
Received: from [127.0.0.1] by omp1014.access.mail.mud.yahoo.com with NNFMP; 05 Oct 2011 13:26:21 -0000
Received: (qmail 76788 invoked from network); 5 Oct 2011 13:26:21 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@173.76.45.30 with login)        by smtp103.vzn.mail.bf1.yahoo.com with SMTP; 05 Oct 2011 06:26:20 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 369CA13C0D3	for <cygwin-patches@cygwin.com>; Wed,  5 Oct 2011 09:26:20 -0400 (EDT)
Date: Wed, 05 Oct 2011 13:26:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow usage of union wait for wait() functions and macros
Message-ID: <20111005132620.GA8422@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E8C3828.4010009@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E8C3828.4010009@t-online.de>
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
X-SW-Source: 2011-q4/txt/msg00001.txt.bz2

On Wed, Oct 05, 2011 at 12:57:44PM +0200, Christian Franke wrote:
>The file include/sys/wait.h provides union wait but neither the wait() 
>functions nor the W*() macros allow to actually use it. Compilation of 
>cdrkit 1.1.11 fails because the configure check assumes that union wait 
>is the status parameter type if its declaration exists.
>
>The attached patch fixes this. It uses GCC extensions for C and 
>overloading for C++. Works also with the old Cygwin gcc-3.
>
>Christian
>

>2011-10-05  Christian Franke  <franke@computer.org>
>
>	* include/cygwin/wait.h: Use new __wait_status_to_int()
>	macro to access status value in W*() status checks.
>	* include/sys/wait.h: Allow `int' and `union wait' as
>	wait status parameter.  Change __wait_status_to_int()
>	macro and wait () prototypes accordingly.  Add inline
>	functions for C++.  Remove extra `;'.
>
>diff --git a/winsup/cygwin/include/cygwin/wait.h b/winsup/cygwin/include/cygwin/wait.h
>index bed81b7..e4edba2 100644
>--- a/winsup/cygwin/include/cygwin/wait.h
>+++ b/winsup/cygwin/include/cygwin/wait.h
>@@ -1,6 +1,6 @@
> /* cygwin/wait.h
> 
>-   Copyright 2006, 2009 Red Hat, Inc.
>+   Copyright 2006, 2009, 2011 Red Hat, Inc.
> 
> This file is part of Cygwin.
> 
>@@ -16,6 +16,9 @@ details. */
> #define WCONTINUED 8
> #define __W_CONTINUED	0xffff
> 
>+/* Will be redefined in sys/wait.h.  */
>+#define __wait_status_to_int(w)  (w)
>+

Why is this necessary?  It doesn't look like it is ever expanded in cygwin/wait.h.
If a redefinition is necessary why not put it all in one place?

And why is redefinition needed inside Cygwin?

> /* A status looks like:
>       <2 bytes info> <2 bytes code>
> 
>@@ -25,13 +28,14 @@ details. */
>       <code> == 80, there was a core dump.
> */
> 
>-#define WIFEXITED(w)	(((w) & 0xff) == 0)
>-#define WIFSIGNALED(w)	(((w) & 0x7f) > 0 && (((w) & 0x7f) < 0x7f))
>-#define WIFSTOPPED(w)	(((w) & 0xff) == 0x7f)
>-#define WIFCONTINUED(w)	(((w) & 0xffff) == __W_CONTINUED)
>-#define WEXITSTATUS(w)	(((w) >> 8) & 0xff)
>-#define WTERMSIG(w)	((w) & 0x7f)
>+#define WIFEXITED(w)	((__wait_status_to_int(w) & 0xff) == 0)
>+#define WIFSIGNALED(w)	((__wait_status_to_int(w) & 0x7f) > 0 \
>+			 && ((__wait_status_to_int(w) & 0x7f) < 0x7f))
>+#define WIFSTOPPED(w)	((__wait_status_to_int(w) & 0xff) == 0x7f)
>+#define WIFCONTINUED(w)	((__wait_status_to_int(w) & 0xffff) == __W_CONTINUED)
>+#define WEXITSTATUS(w)	((__wait_status_to_int(w) >> 8) & 0xff)
>+#define WTERMSIG(w)	(__wait_status_to_int(w) & 0x7f)
> #define WSTOPSIG	WEXITSTATUS
>-#define WCOREDUMP(w)	(WIFSIGNALED(w) && (w & 0x80))
>+#define WCOREDUMP(w)	(WIFSIGNALED(w) && (__wait_status_to_int(w) & 0x80))
> 
> #endif /* _CYGWIN_WAIT_H */
>diff --git a/winsup/cygwin/include/sys/wait.h b/winsup/cygwin/include/sys/wait.h
>index 04bbae7..b355222 100644
>--- a/winsup/cygwin/include/sys/wait.h
>+++ b/winsup/cygwin/include/sys/wait.h
>@@ -1,6 +1,6 @@
> /* sys/wait.h
> 
>-   Copyright 1997, 1998, 2001, 2002, 2003, 2004, 2006 Red Hat, Inc.
>+   Copyright 1997, 1998, 2001, 2002, 2003, 2004, 2006, 2011 Red Hat, Inc.
> 
> This file is part of Cygwin.
> 
>@@ -19,10 +19,25 @@ details. */
> extern "C" {
> #endif
> 
>-pid_t wait (int *);
>-pid_t waitpid (pid_t, int *, int);
>-pid_t wait3 (int *__status, int __options, struct rusage *__rusage);
>-pid_t wait4 (pid_t __pid, int *__status, int __options, struct rusage *__rusage);
>+#if defined(__cplusplus) || defined(__INSIDE_CYGWIN__)
>+
>+typedef int *__wait_status_ptr_t;
>+
>+#else
>+
>+/* Allow `int' and `union wait' for the status.  */
>+typedef union
>+  {
>+    int *__int_ptr;
>+    union wait *__union_wait_ptr;
>+  } __wait_status_ptr_t  __attribute__ ((__transparent_union__));
>+
>+#endif

Could you add a comment here and at the #else indicating what they refer to
like #else /* !(defined(__cplusplus) || defined(__INSIDE_CYGWIN__)) and
#endif (defined(__cplusplus) || defined(__INSIDE_CYGWIN__) ?

Also since Cygwin is C++ why do you need the __INSIDE_CYGWIN__ here?

cgf
