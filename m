From: Egor Duda <deo@logos-m.ru>
To: Christopher Faylor <cgf@redhat.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: pthread_cond*
Date: Sat, 17 Mar 2001 04:53:00 -0000
Message-id: <8888709136.20010317155009@logos-m.ru>
References: <05e401c0ae24$e8194600$0200a8c0@lifelesswks> <20010316102348.D11518@redhat.com> <007701c0ae6c$f174ab70$0200a8c0@lifelesswks> <20010316202404.A2512@redhat.com>
X-SW-Source: 2001-q1/msg00194.html

Hi!

Saturday, 17 March, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> On Sat, Mar 17, 2001 at 10:00:47AM +1100, Robert Collins wrote:
>>Take two - return value for TimedWait function.

CF> I've checked this in.

hmm. does anybody tested this patch under  w9x?  msdn  states  that
SignalObjectAndWait() API requires NT 4.0 or later.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

