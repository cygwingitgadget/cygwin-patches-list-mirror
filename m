Return-Path: <cygwin-patches-return-6969-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 429 invoked by alias); 15 Feb 2010 09:21:11 -0000
Received: (qmail 413 invoked by uid 22791); 15 Feb 2010 09:21:09 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 15 Feb 2010 09:21:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E395A6D42F5; Mon, 15 Feb 2010 10:20:53 +0100 (CET)
Date: Mon, 15 Feb 2010 09:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100215092053.GU5683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx>  <20100214101834.GO5683@calimero.vinschen.de>  <4B7833D4.5090301@gmail.com>  <20100214191225.GC19242@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100214191225.GC19242@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00085.txt.bz2

On Feb 14 14:12, Christopher Faylor wrote:
> On Sun, Feb 14, 2010 at 05:33:08PM +0000, Dave Korn wrote:
> >On 14/02/2010 10:18, Corinna Vinschen wrote:
> >>I don't know if that works, but it would be really cool if a single DLL
> >>import lib like libcygwin.a could export symbols from different DLLs.
> >>That way we could create a cygxdr1.dll which contains the XDR
> >>functions, but which could be linked against by just the default
> >>linking against libcygwin.a.
> >
> >Why would we do that?
> 
> Yeah, ditto.  It's an interesting idea but I was more thinking that this
> would be something that was added to the command-line specifically, like,
> e.g., a -lxdr .

I was thinking along the lines of having rather not-so-often used
functionality implemented in secondary DLLs, while maintaining the libc
link interface.  In the end this application:

   gcc foo-not-using-xdr.c (-lcygwin)

would be linked against cygwin1.dll and this one:

   gcc foo-using-xdr.c (-lcygwin)

would be linked against cygwin1.dll and cygxdr1.dll.  That only makes
limited sense as long as just XDR is affected, but the end result would
be that you could keep the size of cygwin1.dll smaller and to load
seldom stuff only on demand without any tradeoff at build time.

Well, it was just some random idea.  Don't worry.

> It would be kind of cool if we could keep, say, the pthread library in
> a separate dll but, unfortunately, that boat has already sailed.

Perhaps not.  I'm not saying we should or even can do the same, but with
W7 MSFT has splitted their DLLs into multiple sub-DLLs, as you can
easily see when calling cygcheck.  However, application still link
against the default DLL, for instance kernel32.dll.  It provides shims
to the other DLLs.
So, in theory, we could create a new cygpthread.dll and a cygpthread.a
which links against cygpthread.dll.  cygwin1.dll would only contain the
same functions for backward compatibility, which actually load the same
functions from cygpthread.dll.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
