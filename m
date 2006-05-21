Return-Path: <cygwin-patches-return-5857-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2562 invoked by alias); 21 May 2006 05:26:45 -0000
Received: (qmail 2550 invoked by uid 22791); 21 May 2006 05:26:45 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 21 May 2006 05:26:43 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 0830913C01F; Sun, 21 May 2006 01:26:42 -0400 (EDT)
Date: Sun, 21 May 2006 05:26:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Getting the pipe guard
Message-ID: <20060521052641.GA17087@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605201843g3ed55755ue3140fd2b1b66acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0605201843g3ed55755ue3140fd2b1b66acb@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00045.txt.bz2

On Sat, May 20, 2006 at 09:43:16PM -0400, Lev Bishop wrote:
>Index: select.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
>retrieving revision 1.123
>diff -u -p -d -r1.123 select.cc
>--- select.cc	24 Apr 2006 15:16:45 -0000	1.123
>+++ select.cc	21 May 2006 00:56:04 -0000
>@@ -689,14 +689,18 @@ pipe_cleanup (select_record *, select_st
> int
> fhandler_pipe::ready_for_read (int fd, DWORD howlong)
> {
>-  int res;
>+  int res = true;
>+  const HANDLE w4[2] = {signal_arrived, get_guard ()};
>   if (howlong)
>-    res = true;
>+    {
>+      if (w4[2] && WAIT_OBJECT_0 == WaitForMultipleObjects (2, w4, 0, INFINITE))
>+	{
>+	  set_sig_errno (EINTR);
>+	  return 0;
>+	}
>+    }
>   else
>     res = fhandler_base::ready_for_read (fd, howlong);
>-
>-  if (res)
>-    get_guard ();
>   return res;
> }

The above code seems to be needed but I can't see how it could affect the
non-blocking case since "howlong" is only set in the blocking case.

I've checked in a variation of the above plus some modifications to
pipe.cc which prevent some handle stomping and may make things work
better.

Thanks for the patch.

cgf
