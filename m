Return-Path: <cygwin-patches-return-6320-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3073 invoked by alias); 20 Mar 2008 19:24:52 -0000
Received: (qmail 3063 invoked by uid 22791); 20 Mar 2008 19:24:52 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 20 Mar 2008 19:24:22 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JcQNB-0008FK-2R 	for cygwin-patches@cygwin.com; Thu, 20 Mar 2008 19:24:21 +0000
Message-ID: <47E2B9E6.CD5FF303@dessent.net>
Date: Thu, 20 Mar 2008 19:24:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: addr2line [ Was: better stackdumps ]
References: <47E05D34.FCC2E30A@dessent.net> <20080319030027.GC22446@ednor.casa.cgf.cx> <47E137C7.8AE02BC4@dessent.net> <20080320103532.GO19345@calimero.vinschen.de> <20080320142306.GB28241@ednor.casa.cgf.cx> <47E2AB89.3CC04D13@dessent.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00094.txt.bz2

Brian Dessent wrote:

> I think I see what's going on here though, the Cygwin fault handler took
> the first chance exception and wrote the stackdump file, and only then
> passed it on to the debugger, so that by the time gdb got notice of the
> fault the stack was all fubar.  This could be the reason why dumper is
> not working too.  I thought there was a IsBeingDebugged() check in the

Silly me, this is good old "set cygwin-exceptions" defaulting to off...
of course gdb was ignoring the fault and letting Cygwin handle it.  With
it set to on everything works as expected, and the issue of why the
process state that dumper records is so trashed is unrelated.

Brian
