Return-Path: <cygwin-patches-return-7050-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20240 invoked by alias); 3 Aug 2010 00:37:18 -0000
Received: (qmail 20229 invoked by uid 22791); 3 Aug 2010 00:37:17 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-4.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.4)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 03 Aug 2010 00:37:12 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 747DB13C061	for <cygwin-patches@cygwin.com>; Mon,  2 Aug 2010 20:37:10 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 6B8302B352; Mon,  2 Aug 2010 20:37:10 -0400 (EDT)
Date: Tue, 03 Aug 2010 00:37:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] POSIX monotonic clock
Message-ID: <20100803003710.GA18943@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1280782148.6756.81.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1280782148.6756.81.camel@YAAKOV04>
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
X-SW-Source: 2010-q3/txt/msg00010.txt.bz2

On Mon, Aug 02, 2010 at 03:49:08PM -0500, Yaakov (Cygwin/X) wrote:
>Here is an attempt to implement POSIX.1-2004+ Monotonic Clock:
>
>http://www.opengroup.org/onlinepubs/9699919799/functions/clock_getres.html
>
>In summary, I took hires_us and changed the resolution to nanoseconds. I
>dropped systime() because the only place hires_us was being used is in
>strace.cc which ignored it, and WRT POSIX monotonic clocks the absolute
>value of the clock is meaningless.  Since systime() has only 100ns
>precision, using it would either force a loss in resolution or (if
>multiplied by 100 to get ns) an early overflow.  I also switched from
>ENOSYS to EINVAL, as POSIX.1-2004 and 2008 dropped references to the
>former (as noted in Change History).

But that changes the sense of the errno.  EINVAL would indicate an unsupported
argument.  At least some of the cases fail because of an unimplemented NT
function call, e.g., ENOSYS.  Regardless of what POSIX says, I think that ENOSYS
is ok, in at least some cases, for Cygwin since I believe QueryPerformanceCounter
doesn't work on NT3.5 and NT4.

Other than that this looks ok.

cgf
