Return-Path: <cygwin-patches-return-5491-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32220 invoked by alias); 30 May 2005 18:00:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32186 invoked by uid 22791); 30 May 2005 18:00:55 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 30 May 2005 18:00:55 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id E81781A339C
	for <cygwin-patches@cygwin.com>; Mon, 30 May 2005 20:00:53 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31265-03 for <cygwin-patches@cygwin.com>;
	Mon, 30 May 2005 20:00:52 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id 3EA741A3301
	for <cygwin-patches@cygwin.com>; Mon, 30 May 2005 20:00:52 +0200 (CEST)
Received: from logout (logout [147.32.127.203])
	by logout.sh.cvut.cz (Postfix) with ESMTP id 3352E3C306
	for <cygwin-patches@cygwin.com>; Mon, 30 May 2005 20:00:52 +0200 (CEST)
Date: Mon, 30 May 2005 18:00:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Probably unnecessary InterlockedCompareExchangePointer in
 List_remove in thread.h
In-Reply-To: <20050530105312.GA9933@calimero.vinschen.de>
Message-ID: <20050530193427.C19887@logout.sh.cvut.cz>
References: <20050529165435.H81503@logout.sh.cvut.cz>
 <20050530105312.GA9933@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00087.txt.bz2


I am not sure, that is why I wrote "probably". But from what I see there is
already exclusive access guaranteed by the mx.lock() call, unless of course I
am completely misunderstanding something.

I can tell you that "lock; cmpxchg" pair of instruction is really not as cheap
as it looks. Especially on SMP systems. It takes above 100 of cycles on
contemporary CPUs.


VH



On Mon, 30 May 2005, Corinna Vinschen wrote:

> On May 29 17:03, Vaclav Haisman wrote:
> >
> > I think that the call to InterlockedCompareExchangePointer() can and should be
> > replaced by ordinary if and assignment. The synchronization it provides doesn't
> > seem to be necessary.
>
> Are you sure the synchronization isn't necessary?  You just say you think
> it isn't, but there's not much of a proof.  In any case, the call to
> InterlockedCompareExchangePointer is looking quite expensive, but it isn't.
> Did you notive there's a local file called winbase.h in the cygwin directory?
> If you have a look, you'll see that InterlockedCompareExchangePointer
> boils down to exactly one assembler instruction, so it doesn't seem to
> be worth the effort, does it?
>
>
> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
> Red Hat, Inc.
>
