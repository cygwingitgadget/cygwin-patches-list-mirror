Return-Path: <cygwin-patches-return-6895-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21156 invoked by alias); 10 Jan 2010 11:12:56 -0000
Received: (qmail 21050 invoked by uid 22791); 10 Jan 2010 11:12:54 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 10 Jan 2010 11:12:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 12FFC6D417D; Sun, 10 Jan 2010 12:12:40 +0100 (CET)
Date: Sun, 10 Jan 2010 11:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix misc aliasing warnings.
Message-ID: <20100110111240.GA28315@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B486906.4000600@gmail.com>  <20100109133348.GO23992@calimero.vinschen.de>  <4B48DD4E.1080701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B48DD4E.1080701@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00011.txt.bz2

On Jan  9 19:47, Dave Korn wrote:
> Corinna Vinschen wrote:
> 
> > Concerning fstat_helper, I don't like to slip another layer into these
> > calls to pamper an anal-retentive compiler.  I would rather like to fix
> > this by removing the FILETIME type from the affected places and use
> > LARGE_INTEGER throughout.  It's not overly tricky, given that FILETIME
> > time == LARGE_INTEGER kernel time.
> 
>   I'll give that patch you posted a test.

Thanks!  In the meantime I'll apply it as is since it's better than
the old code anyway.

> > Wouldn't temporary pointers
> > avoid the memcpy?
> 
>   Probably, but I was expecting the compiler to thoroughly optimize those
> memcpys anyway.  I'll double-check with this and the previous one how the
> generated code looks.

Still, it looks bad since it seems so superfluous.  I don't think we
should rely so heavily on the compiler optimization.

> >>  #define IN6_ARE_ADDR_EQUAL(a, b) \
> >> -	(((const uint32_t *)(a))[0] == ((const uint32_t *)(b))[0] \
> >> -	 && ((const uint32_t *)(a))[1] == ((const uint32_t *)(b))[1] \
> >> -	 && ((const uint32_t *)(a))[2] == ((const uint32_t *)(b))[2] \
> >> -	 && ((const uint32_t *)(a))[3] == ((const uint32_t *)(b))[3])
> >> +	(!memcmp ((a), (b), 4 * sizeof (uint32_t)))
> > 
> > Hang on.  That's almost exactly the definition of IN6_ARE_ADDR_EQUAL as
> > on Linux and on other systems.  If that doesn't work anymore, not only
> > this one has to be changed, but all the equivalent expressions
> > throughout netinet/in.h.  The gcc guys aren';t serious about that,
> > are they?
> 
>   I'll ask upstream about this one, and perhaps the disk geometry thing as
> well.  It's not like any of this is urgent, 4.5 is still a little ways off
> release so I'm just trying to lay some groundwork in advance.
> 
>   So, I'll test your version of the fhandler patch, and consult upstream about
> a couple of the others, and we'll come back to this shortly.  Thanks for the
> reviews.

Thanks for looking into this,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
