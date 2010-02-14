Return-Path: <cygwin-patches-return-6960-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2457 invoked by alias); 14 Feb 2010 10:18:51 -0000
Received: (qmail 2446 invoked by uid 22791); 14 Feb 2010 10:18:50 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 14 Feb 2010 10:18:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 31E0A6D42F5; Sun, 14 Feb 2010 11:18:34 +0100 (CET)
Date: Sun, 14 Feb 2010 10:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100214101834.GO5683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100213210122.GA20649@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q1/txt/msg00076.txt.bz2

On Feb 13 16:01, Christopher Faylor wrote:
> On Sat, Feb 13, 2010 at 10:20:20AM -0500, Charles Wilson wrote:
> >Corinna Vinschen wrote:
> >>On Feb 13 01:43, Charles Wilson wrote:
> >>>The attached patch(es) add XDR support to cygwin
> >>
> >>Cool.
> 
> I didn't get Corinna's response in email and it isn't in the archive.
> I assume that was unintentional?

Yes, sorry about that.  Apparently I hit the r button accidentally,
rather than the l button(*).

> Also, follow-up question: Should this go into a different library
> entirely?  Is it time to think about not just making cygwin1.dll the
> monolithic one-stop-for-all-of-your-posix-api shared library?

Ideally libcygwin.a provides all the API which is expected in libc
on other targets.

I don't know if that works, but it would be really cool if a single
DLL import lib like libcygwin.a could export symbols from different
DLLs.  That way we could create a cygxdr1.dll which contains the XDR
functions, but which could be linked against by just the default linking
against libcygwin.a.

However, that would be link stage magic which has nothing to do with
availability in source.  I have no problems with it being in newlib
(though I doubt I had the idea in the first place).  This way other
targets would get this OS-agnostic functionality as well.


Corinna


(*) Mutt users know what I mean.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
