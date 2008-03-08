Return-Path: <cygwin-patches-return-6253-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11228 invoked by alias); 8 Mar 2008 03:16:41 -0000
Received: (qmail 11215 invoked by uid 22791); 8 Mar 2008 03:16:40 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 08 Mar 2008 03:16:24 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id DB19C6B400B; Fri,  7 Mar 2008 22:16:22 -0500 (EST)
Date: Sat, 08 Mar 2008 03:16:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] handle_to_fn: null terminate
Message-ID: <20080308031622.GA9681@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D1EE32.72610760@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D1EE32.72610760@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00027.txt.bz2

On Fri, Mar 07, 2008 at 05:38:58PM -0800, Brian Dessent wrote:
>
>I noticed in strace some lines like:
>
>fhandler_base::close: closing
>'/Device/NamedPipe/Win32Pipes.000008e0.00000002<several junk bytes>'
>handle 0x740
>
>This was caused by handle_to_fn simply forgetting to add a \0 when
>converting, as in the attached patch.
>
>Brian
>2008-03-07  Brian Dessent  <brian@dessent.net>
>
>	* dtable.cc (handle_to_fn): Null-terminate posix_fn in the case
>	of justslash = true.
>
>Index: dtable.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
>retrieving revision 1.182
>diff -u -p -r1.182 dtable.cc
>--- dtable.cc	15 Feb 2008 17:53:10 -0000	1.182
>+++ dtable.cc	8 Mar 2008 01:33:52 -0000
>@@ -952,6 +952,7 @@ handle_to_fn (HANDLE h, char *posix_fn)
> 	  *d = '/';
> 	else
> 	  *d = *s;
>+      *d = 0;
>     }
> 
>   debug_printf ("derived path '%s', posix '%s'", w32, posix_fn);

Huh.  I had the same fix sitting in my sandbox and never checked it in.
Please check this in.

cgf
