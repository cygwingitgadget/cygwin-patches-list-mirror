Return-Path: <cygwin-patches-return-5587-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30828 invoked by alias); 22 Jul 2005 10:28:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30777 invoked by uid 22791); 22 Jul 2005 10:28:13 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 22 Jul 2005 10:28:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id 2E8FA1A335A
	for <cygwin-patches@cygwin.com>; Fri, 22 Jul 2005 12:28:11 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13491-08 for <cygwin-patches@cygwin.com>;
	Fri, 22 Jul 2005 12:28:10 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id 578F51A334D
	for <cygwin-patches@cygwin.com>; Fri, 22 Jul 2005 12:28:10 +0200 (CEST)
Received: from logout (logout [147.32.127.203])
	by logout.sh.cvut.cz (Postfix) with ESMTP id 6146C3C306
	for <cygwin-patches@cygwin.com>; Fri, 22 Jul 2005 12:28:08 +0200 (CEST)
Date: Fri, 22 Jul 2005 10:28:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Set FILE_ATTRIBUTE_TEMPORARY on files opened by mkstemp()
 on WinNT
In-Reply-To: <20050722020329.GA2430@trixie.casa.cgf.cx>
Message-ID: <20050722121047.U55258@logout.sh.cvut.cz>
References: <20050722011722.L38147@logout.sh.cvut.cz>
 <20050721234356.GB24848@trixie.casa.cgf.cx> <20050722030953.N49904@logout.sh.cvut.cz>
 <20050722020329.GA2430@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q3/txt/msg00042.txt.bz2

On Thu, 21 Jul 2005, Christopher Faylor wrote:

> On Fri, Jul 22, 2005 at 03:17:33AM +0200, Vaclav Haisman wrote:
> >On Thu, 21 Jul 2005, Christopher Faylor wrote:
> >>On Fri, Jul 22, 2005 at 01:32:50AM +0200, Vaclav Haisman wrote:
> >>>the attached patch sets FILE_ATTRIBUTE_TEMPORARY on files opened by
> >>>mkstemp() on WinNT class systems.  Theoretically the OS should then be
> >>>less eager to write such files onto the physical storage and use cache
> >>>instead.
> >>
> >>Thank you for the patch but unless you can demonstrate some obvious
> >>performance improvements I don't think we'll be applying it.  You've
> >>slowed down (slightly) the common case of calling open for the uncommon
> >>case of calling mk?temp.
> >
> >I am not sure what kind of slow down do you mean.  Is it the one extra
> >call?
>
> It was more than one extra call, but yes.
>
> >In that case the attached modified patch should fix it.  The call to
> >open_with_attributes() in open() gets inlined, I have checked the
> >resulting .s file.
>
> Can you demonstrate some obvious performance improvements?  Does it
> speed up configure, make bash start up faster, make the rxvt window
> faster to show up?
>
> cgf
>


I don't think that any of the extra ifs and assignments could cause any
measurable slowdown. I also do not think that there are any _obvious_ speed
ups. It is merely a hint to the cache subsystem, not a silver bullet.

VH
