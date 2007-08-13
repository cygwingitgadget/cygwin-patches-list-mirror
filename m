Return-Path: <cygwin-patches-return-6135-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26764 invoked by alias); 13 Aug 2007 20:44:09 -0000
Received: (qmail 26676 invoked by uid 22791); 13 Aug 2007 20:44:08 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-70-61-242.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.70.61.242)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 13 Aug 2007 20:44:04 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id D29872B353; Mon, 13 Aug 2007 16:44:02 -0400 (EDT)
Date: Mon, 13 Aug 2007 20:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handler not executed
Message-ID: <20070813204402.GA16337@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <76087731258D2545B1016BB958F00ADA123A4B@STEELPO.steeleye.com> <20070809171911.GA9596@ednor.casa.cgf.cx> <9E96C9F8-A1C5-4EE5-A24C-68896AD82D6B@rehley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9E96C9F8-A1C5-4EE5-A24C-68896AD82D6B@rehley.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00010.txt.bz2

On Mon, Aug 13, 2007 at 12:25:49PM -0700, Peter Rehley wrote:
> On Aug 9, 2007, at 10:19 AM, Christopher Faylor wrote:
>>On Thu, Aug 09, 2007 at 01:09:48PM -0400, Ernie Coskrey wrote:
>>>There's a very small window of vulnerability in _sigbe, which can lead
>>>to signal handlers not being executed.  In _sigbe, the _cygtls lock is
>>>released before incyg is decremented.  If setup_handler acquires the
>>>lock just after _sigbe releases it, but before incyg is decremented,
>>>setup_handler will mistakenly believe that the thread is in Cygwin
>>>code, and will set up the interrupt using the tls stack.
>>>
>>>_sigbe should decrement incyg before releasing the lock.
>>
>>I'll apply this but are you saying that this actually fixes your
>>problem or that you think it fixes your problem?
>
>I noticed in the cvs log that at one point you changed from what the
>patch applied to releasing incyg later.  (version 1.22 to 1.23 of
>gendef).  Do you remember why you did this change?  and could this
>patch break what you tried fixing earlier?

No, I don't, unfortunately.  The fact that this has moved back and forth
in the code is one of the reasons I'm not handing out attaboys or
issuing gold stars.  Experience has shown that usually when someone
makes a change in the signal code or the cygwin startup code, I'll
usually have to go in and heavily tweak it later.

That's not a reflection on anybody's skill.  It's just very complicated
and error prone section of the code.  It is amazing that anyone can
understand it at all since I have to relearn it every time I make a
change.

cgf
