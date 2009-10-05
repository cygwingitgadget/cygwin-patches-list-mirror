Return-Path: <cygwin-patches-return-6694-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 626 invoked by alias); 5 Oct 2009 08:38:15 -0000
Received: (qmail 611 invoked by uid 22791); 5 Oct 2009 08:38:14 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 08:38:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 723EE6D5598; Mon,  5 Oct 2009 10:37:59 +0200 (CEST)
Date: Mon, 05 Oct 2009 08:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] --std=c89 error in sys/signal.h
Message-ID: <20091005083759.GA12170@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC2732D.5090304@users.sourceforge.net> <20090929223320.GA8901@ednor.casa.cgf.cx> <4AC2A7B5.3070105@users.sourceforge.net> <4AC2B02E.7010805@users.sourceforge.net> <4AC94F6F.60308@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC94F6F.60308@users.sourceforge.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00025.txt.bz2

On Oct  4 20:44, Yaakov S wrote:
> On 29/09/2009 20:11, Yaakov (Cygwin/X) wrote:
>> On 29/09/2009 19:35, Yaakov (Cygwin/X) wrote:
>>> Anyway, to answer the question, AFAICS in glibc, <signal.h> #include
>>> <bits/types.h> unconditionally[1]. (<sys/signal.h> is just one line:
>>> #include <signal.h> [2])
>>>
>>> So should I take the first route, patching newlib instead?

Newlib, methinks.

>> int _EXFUN(kill, (int, int));
>> int _EXFUN(killpg, (pid_t, int));
>>
>> Is that supposed to mean that we don't want to use pid_t here at all,
>> and the intended solution would be to change killpg to (int, int), as
>> ugly as that is, leaving only <cygwin/signal.h> needing the #include
>> <sys/types.h>?
>
> Ping?

I think the newlib kill declaration should be changed to pid_t, since
that's simply correct per POSIX.

I can;t believe the RTEMS people have a problem with that.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
