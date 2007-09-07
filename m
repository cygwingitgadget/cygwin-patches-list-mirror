Return-Path: <cygwin-patches-return-6143-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2800 invoked by alias); 7 Sep 2007 00:15:33 -0000
Received: (qmail 2788 invoked by uid 22791); 7 Sep 2007 00:15:32 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-174-251-188.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (71.174.251.188)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Sep 2007 00:15:25 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 6175C2B35A; Thu,  6 Sep 2007 20:15:23 -0400 (EDT)
Date: Fri, 07 Sep 2007 00:15:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] inline __getreent in newlib
Message-ID: <20070907001523.GA27234@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <46E08F5C.D534F44E@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E08F5C.D534F44E@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00018.txt.bz2

On Thu, Sep 06, 2007 at 04:38:04PM -0700, Brian Dessent wrote:
>
>I noticed today that all instances of _REENT in newlib go through a
>function call to __getreent().  All this function does is get the value
>of %fs:4 and subtract a fixed offset from it, so this seems rather
>wasteful.  And we already have the required value of this offset
>computed for us in tlsoffsets.h, so we have everything we need to
>provide newlib with an inline version of this function, saving the
>overhead of a function call.  It would obviously be cleaner to be able
>to do:
>
>#define __getreent() (&_my_tls.local_clib)
>
>...however this would require dragging all kinds of internal Cygwin
>definitions into a newlib header and since we already have the required
>offset in tlsoffsets.h we might as well just use that.  The attached
>patch does this; the second part would obviously have to be approved by
>the newlib maintainers, but I thought I'd see if there's any interest in
>this idea first before bothering them.
>
>I don't pretend to claim that this is a very scientific benchmark at
>all, but there does seem to be a slight improvement especially in the
>getc column which represents reading the whole 16MB file one byte at a
>time, where this _REENT overhead would be most pronounced.
>
>So, valid optimization or just complication?
>
>Brian
>2007-09-06  Brian Dessent  <brian@dessent.net>
>
>	* include/cygwin/config.h (__getreent): Define inline version.

I've always meant to investigate some way to turn the reent stuff into
a macro in the newlib library after doing that for cygwin.  I'm not
wild about using offsets like this but I can't think of any other way
to do it which didn't have the problems that you describe.

So, I guess I'll come down on the side of speed over clarity.  I'm sure
that Jeff won't mind your checking in the undef in newlib.  So, please
check in everything but, again, document heavily what you're doing with
the reent macro.

Thanks.

cgf
