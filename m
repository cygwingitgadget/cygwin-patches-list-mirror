Return-Path: <cygwin-patches-return-6324-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26566 invoked by alias); 23 Mar 2008 03:51:46 -0000
Received: (qmail 26556 invoked by uid 22791); 23 Mar 2008 03:51:45 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-32.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.32)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 23 Mar 2008 03:51:21 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id B57C43FFD9F; Sat, 22 Mar 2008 23:51:19 -0400 (EDT)
Date: Sun, 23 Mar 2008 03:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to 	unhandled exception
Message-ID: <20080323035119.GA2554@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D9D8D3.17BC1E3B@dessent.net> <47D9E70D.ED6C84CB@dessent.net> <20080314141331.GB20808@ednor.casa.cgf.cx> <47DB689F.8FC91752@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47DB689F.8FC91752@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00098.txt.bz2

On Fri, Mar 14, 2008 at 11:11:43PM -0700, Brian Dessent wrote:
>Christopher Faylor wrote:
>>That was going to be my first observation, actually.  I'm still trying
>>to digest the patch but it seems like it wouldn't work well with the
>>fork retry code.
>
>The patch doesn't change any behavior though: in current Cygwin if the
>thing we're exec()ing returns a Win32 exit code of C0000135 (or
>whatever) then we retry creating it 5 times.  With the patch, we still
>retry starting it 5 times but after the last one fails we recognise the
>situation and print a message.

After poking at this a little, I think it would be better to issue a
linux-like error message.

In my sandbox, I now have this:

bash-3.2$ ./libtest
/cygdrive/s/test/libtest.exe: error while loading shared libraries: liba.dll: cannot open shared object file: No such file or directory

I haven't done the work to report on missing symbols yet but I think
that's a much less common error condition.

So thanks for the patch and the concept but I think I'd rather go with a
more linux-like solution.

cgf
