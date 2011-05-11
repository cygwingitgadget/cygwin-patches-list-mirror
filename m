Return-Path: <cygwin-patches-return-7331-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10603 invoked by alias); 11 May 2011 13:21:37 -0000
Received: (qmail 9509 invoked by uid 22791); 11 May 2011 13:20:57 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 11 May 2011 13:20:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DB0CA2C0577; Wed, 11 May 2011 15:20:38 +0200 (CEST)
Date: Wed, 11 May 2011 13:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110511132038.GD11041@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511103149.GA11041@calimero.vinschen.de> <4DCA86C5.7070207@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCA86C5.7070207@cs.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00097.txt.bz2

On May 11 08:53, Ryan Johnson wrote:
> On 11/05/2011 6:31 AM, Corinna Vinschen wrote:
> >- I replaced the call to GetMappedFileNameEx with a call to
> >   NtQueryVirtualMemory (MemorySectionName).  This avoids to add another
> >   dependency to psapi.  I intend to get rid of them entirely, if
> >   possible.
> Nice. One issue: I tried backporting your change to my local tree,
> and the compiler complains that PMEMORY_SECTION_NAME isn't defined;
> the changelog says you updated ntdll.h to add it, but the online
> definition in w32api was last updated 9 months ago by 'duda.' Did it
> perhaps slip past the commit?

The compiler shouldn't complain because we only use the definitions
from ntdll.h and nothing else from w32api/include/ddk (except in rare
cases, see fhandler_tape.cc, fhandler_serial.cc).

Sometimes I apply new stuff to w32api as well on an "as it comes along"
base, but usually it's not the Cygwin project which maintains these
files.

> >>NOTE 1: I do not attempt to identify PEB, TEB, or thread stacks. The
> >>first could be done easily enough, but the second and third require
> >>venturing into undocumented/private Windows APIs.
> >Go ahead!  We certainly don't shy away from calls to
> >NtQueryInformationProcess or NtQueryInformationThread.
> Ah. I didn't realize this sort of thing was encouraged. The MSDN
> docs about them are pretty gloomy.

Gary Nebbett, "Windows NT/2000 Native API Reference".  It's a bit
rusty as far as new stuff is concerned, but it contains the important
stuff we can rely upon.

> The other things that discouraged me before were:
> - the only obvious way to enumerate the threads in a process is to
> create a snapshot using TH32CS_SNAPTHREAD, which enumerates all
> threads in the system. This sounds expensive.
> - it's not clear whether GetThreadContext returns a reasonable stack
> pointer if the target thread is active at the time.

Per MSDN the thread context is only valid if the thread is not running
at the time.   However, we could carefully inspect some of the values
and see how stable they are.

> However, assuming the above do not bother folks, they should be
> pretty straightforward to use. I won't have time to code this up in
> the immediate future, though. My real goal was to make fork bearable
> on my machine and that ended up sucking away all the time I had and
> then some...

Well, it's not high enough on my agenda to dive into it.  Feel free
to do that whenever you find a free time slot.

> >Sorry if I'm dense, but isn't that exactly what GetMappedFileNameEx or
> >NtQueryVirtualMemory (MemorySectionName) do?  I also don't see any extra
> >information for .so files in the Linux maps output.  What detail am I
> >missing?
> Interesting... the machine I used for reference a couple weeks ago
> was running a really old debian, and for each allocation entry of a
> mapped image it gave the corresponding section name (.text, .bss,
> .rdata, etc):
> 3463600000-346362c000 r-xp 00000000 08:01 2097238
> /lib64/libpcre.so.0.0.1 .text
> 346362c000-346382b000 ---p 0002c000 08:01 2097238
> /lib64/libpcre.so.0.0.1
> 346382b000-346382c000 rw-p 0002b000 08:01 2097238
> /lib64/libpcre.so.0.0.1 .bss
> 
> However, the machine was upgraded to a newer kernel this week and
> the extra information no longer appears.

Indeed, this information is not available on my 2.6.35 kernel.

> In any case, should somebody want to report section names within a
> mapped image, that information can be had easily enough using the
> pefile struct from my fork patches.

Right.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
