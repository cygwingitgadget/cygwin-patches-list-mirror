Return-Path: <cygwin-patches-return-5494-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10292 invoked by alias); 30 May 2005 18:57:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10271 invoked by uid 22791); 30 May 2005 18:57:29 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 30 May 2005 18:57:29 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id 677481A33A2
	for <cygwin-patches@cygwin.com>; Mon, 30 May 2005 20:57:27 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00964-05 for <cygwin-patches@cygwin.com>;
	Mon, 30 May 2005 20:57:25 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id A7FFF1A32F6
	for <cygwin-patches@cygwin.com>; Mon, 30 May 2005 20:57:25 +0200 (CEST)
Received: from logout (logout [147.32.127.203])
	by logout.sh.cvut.cz (Postfix) with ESMTP id F03DC3C306
	for <cygwin-patches@cygwin.com>; Mon, 30 May 2005 20:57:28 +0200 (CEST)
Date: Mon, 30 May 2005 18:57:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Probably unnecessary InterlockedCompareExchangePointer in
 List_remove in thread.h
In-Reply-To: <20050530183330.GA15421@trixie.casa.cgf.cx>
Message-ID: <20050530203705.G19887@logout.sh.cvut.cz>
References: <20050529165435.H81503@logout.sh.cvut.cz>
 <20050530105312.GA9933@calimero.vinschen.de> <20050530193427.C19887@logout.sh.cvut.cz>
 <20050530183330.GA15421@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00090.txt.bz2


For example this post:
http://lists.freebsd.org/pipermail/freebsd-current/2004-May/026871.html

VH


On Mon, 30 May 2005, Christopher Faylor wrote:

> On Mon, May 30, 2005 at 08:00:52PM +0200, Vaclav Haisman wrote:
> >I am not sure, that is why I wrote "probably". But from what I see there is
> >already exclusive access guaranteed by the mx.lock() call, unless of course I
> >am completely misunderstanding something.
>
> I don't think you are.  I missed this too when I saw your patch and had
> the same reaction that Corinna did.
>
> I think this patch should be ok to apply.
>
> >I can tell you that "lock; cmpxchg" pair of instruction is really not as cheap
> >as it looks. Especially on SMP systems. It takes above 100 of cycles on
> >contemporary CPUs.
>
> Do you have a reference which states this?  100s of cycles sounds like an
> incredible amount of overhead.
>
> cgf
>
