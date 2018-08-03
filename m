Return-Path: <cygwin-patches-return-9159-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126556 invoked by alias); 3 Aug 2018 09:27:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125963 invoked by uid 89); 3 Aug 2018 09:27:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=repair, ho, 0.4, ho!
X-HELO: lb2-smtp-cloud7.xs4all.net
Received: from lb2-smtp-cloud7.xs4all.net (HELO lb2-smtp-cloud7.xs4all.net) (194.109.24.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Aug 2018 09:27:24 +0000
Received: from webmail.xs4all.nl ([IPv6:2001:888:0:22:194:109:20:216])	by smtp-cloud7.xs4all.net with ESMTPA	id lWMkf6WIv6brUlWMkfCPyZ; Fri, 03 Aug 2018 11:27:22 +0200
Received: from a83-162-234-136.adsl.xs4all.nl ([83.162.234.136]) by webmail.xs4all.nl with HTTP (HTTP/1.1 POST); Fri, 03 Aug 2018 11:27:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Aug 2018 09:27:00 -0000
From: Houder <houder@xs4all.nl>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fegetenv() in winsup/cygwin/fenv.cc should not disable exceptions!
In-Reply-To: <20180803073647.GA6347@calimero.vinschen.de>
References: <1533253512-1717-1-git-send-email-houder@xs4all.nl> <20180803073647.GA6347@calimero.vinschen.de>
Message-ID: <213765cb4acd51f933201d759e2752a7@xs4all.nl>
X-Sender: houder@xs4all.nl
User-Agent: XS4ALL Webmail
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00054.txt.bz2

On 2018-08-03 09:36, Corinna Vinschen wrote:
> Hi J.H.,
> 
> Pushed with tweaks.  The string in __asm__ statements works a

Bah! Must be the heat! I did a compare (sdiff), but missed it. You
are correct: the '\n' is required.

> bit different and I made a slight change to the commit message.

No problem! (you could have gone even further; your command of the
English language is far better than mine).

> In terms of x86_64, do we have to change the fenv stuff completely
> to use only SSE opcodes?  Does that make sense at all?

Ho! I have to disappoint you here! I am not an expert at all.

Basically, it was Anton Lavrentiev (Cygwin ML, July 9 2018) who got
me interested.

I created my little STC:

feenableexcept()
fegetenv(&fpenv)
fegetenv(FE_DFL_ENV) // to be switched on and off
operation to provoke exception
fesetenv(&fpenv)

I could not make "head or tail" of what was happening; especially
when I expected to see the exception triggered.

On WoW, but also on x86_64.

The standard (and manual page) that describe "fenv" is a disaster.
(too me far too abstract).

That is why I started comparing Cywgin with glibc. Comparing the
implementation by Dave Korn (Cygwin, some 8 years ago), and that
by Andreas Jaeger (glibc).

Only then, I started studying the manuals written by Intel. But
only as far as was required to get a grasp of what was going on.

First "code-wise", next to understand the behaviour of my STC.

Meaning, my focus of interest have been:

fe{en,dis}ableexcept
fe{get,set)env

and after the repair of fegetenv(), _feinitialise(), as Dave Korn
defines FE_ALL_EXCEPT different from Andreas Jaeger.
(in my test environment I used Jaeger's definition, which required
  a slight modification of _feinitialise() )

ONLY after the above was "out of the way", I moved my attention to
WoW: why did exceptions get triggered here, while they were NOT on
x86_64 ?????

I discovered a difference in behaviour between the x87 FPU and SSE.

When an exception is masked, a "default action" is carried out when
an exception occurs. At the same time the associated status flag is
set.
(the manual speaks about a "reasonable" default action, an action
  that is "sufficient" most of the times)

When the exception is enabled again, SSE is not bothered. However
the next _FPU_ statement will notice the status flag set, and will
set the "Exception Summary Bit" (in the FPU's status register).

The next FPU statement after will trigger the exception! (Yes, the
triggering of the exception is "delayed", deferred).

You can read all this in Intel's manuals. Bottom-line, if the FPU
is used, and exceptions are enabled again, one must _first_ clear
all exceptions (again, not needed on SSE).

Returning to your question ...

 From "a logical point of view", Korn's implementation is more or
less the same as Jaeger's implementation.

Why is there "a preference for the x87 FPU" on WoW, I cannot tell.

Why does "using double d = 1.0; long l = d + 0.4" on WoW result
in code that is executed on the x87 FPU ????? (and why does the
reverse occur on x86_64)? (Yes, that is my hypothesis!)

I cannot tell.

Perhaps it is gcc ... I did not investigate any further.

Regards,

Henri
