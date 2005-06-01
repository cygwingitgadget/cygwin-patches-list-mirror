Return-Path: <cygwin-patches-return-5501-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1786 invoked by alias); 1 Jun 2005 00:02:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1760 invoked by uid 22791); 1 Jun 2005 00:02:03 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 01 Jun 2005 00:02:03 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id 539D61A3393
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 02:02:01 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13542-07 for <cygwin-patches@cygwin.com>;
	Wed, 1 Jun 2005 02:02:00 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id 814F31A3333
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 02:02:00 +0200 (CEST)
Received: from logout (logout [147.32.127.203])
	by logout.sh.cvut.cz (Postfix) with ESMTP id E22773C306
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 02:01:56 +0200 (CEST)
Date: Wed, 01 Jun 2005 00:02:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: winbase.h (ilockexch)
In-Reply-To: <20050531230512.GH9864@trixie.casa.cgf.cx>
Message-ID: <20050601012438.L56374@logout.sh.cvut.cz>
References: <20050601004223.I56374@logout.sh.cvut.cz> <20050531230512.GH9864@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00097.txt.bz2

I should have googled a bit more before I sent the patch. It seems that even
though xchg could be used it is not being used becasue it is slower than
cmpxchg imlementation of InterlockedExchange. I thus withdraw the patch.

VH.


On Tue, 31 May 2005, Christopher Faylor wrote:

> On Wed, Jun 01, 2005 at 12:52:26AM +0200, Vaclav Haisman wrote:
> >I think that ilockexch() in winbase.h should look like what is in my
> >patch.  Explicit lock prefix is not needed because xchg instruction
> >sets LOCK# signal implicitly.
>
> A similar implementation in the linux kernel seems to disagree with you.
>
> cgf
>
