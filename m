Return-Path: <cygwin-patches-return-6956-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4793 invoked by alias); 13 Feb 2010 21:01:38 -0000
Received: (qmail 4355 invoked by uid 22791); 13 Feb 2010 21:01:37 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-83.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.83)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 13 Feb 2010 21:01:32 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 8EFB013C0C6 	for <cygwin-patches@cygwin.com>; Sat, 13 Feb 2010 16:01:22 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 857C42B35A; Sat, 13 Feb 2010 16:01:22 -0500 (EST)
Date: Sat, 13 Feb 2010 21:01:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100213210122.GA20649@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B76C334.8080101@cwilson.fastmail.fm>
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
X-SW-Source: 2010-q1/txt/msg00072.txt.bz2

On Sat, Feb 13, 2010 at 10:20:20AM -0500, Charles Wilson wrote:
>Corinna Vinschen wrote:
>>On Feb 13 01:43, Charles Wilson wrote:
>>>The attached patch(es) add XDR support to cygwin
>>
>>Cool.

I didn't get Corinna's response in email and it isn't in the archive.
I assume that was unintentional?

>>>The cygwin components are basically just adding the new exports, and
>>>providing a callback function for the error reporting framework in the
>>>xdr implementation, that uses (in effect) debug_printf().
>>
>>Is it really necessary to do that in init.cc?  Shouldn't it be
>>sufficient to set it in dll_crt0_1?
>
>Yes, I just wasn't sure /where/ it should be done.  It needs to be
>early, before anything would try to use XDR.  If you think dll_crt0_1
>is more appropriate, that's fine with me.

The benefit of putting this in init.cc, or something called from
init.cc, is that it will work better if cygwin is dynamically loaded.  I
don't really care too much if that case works though.  If that was the
intent then the function should be called from dll_crt0_0 rather than
init.cc.

However, I probably agree with Corinna that it should go in dll_crt0_1.

>Alternatively, the newlib code could be changed so that the error
>reports go /nowhere/ until a caller sets up a reporting mechanism.
>Then, I suppose, it's much less important how early cygwin does that.
>Right now, the newlib code defaults to using stderr.
>
>I'd have to make the 'set up error reporting' function public, in that
>case. (Right now, it is sorta hidden: that's why cygxdr.h has to declare
>the setter function itself).

I have to wonder if these really belong in newlib.  I have an anti-newlib
bias (not to be confused with the ficitious other biases that I've been
accused of) so maybe it's that talking but it seems like you've gone to
some effort to ensure that things work for the non-cygwin case.  Would
it have been easier if you just imported everything into Cygwin?

Also, follow-up question: Should this go into a different library
entirely?  Is it time to think about not just making cygwin1.dll the
monolithic one-stop-for-all-of-your-posix-api shared library?

cgf
