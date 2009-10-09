Return-Path: <cygwin-patches-return-6752-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7249 invoked by alias); 9 Oct 2009 09:17:38 -0000
Received: (qmail 7238 invoked by uid 22791); 9 Oct 2009 09:17:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 09 Oct 2009 09:17:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 16A316D5598; Fri,  9 Oct 2009 11:17:22 +0200 (CEST)
Date: Fri, 09 Oct 2009 09:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: utimensat UTIME_NOW granularity bug
Message-ID: <20091009091722.GA8983@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20091008T221131-292@post.gmane.org> <20091008212425.GB2068@ednor.casa.cgf.cx> <4ACEACBA.4030904@byu.net> <20091009045800.GA17335@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091009045800.GA17335@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00083.txt.bz2

On Oct  9 00:58, Christopher Faylor wrote:
> On Thu, Oct 08, 2009 at 09:23:38PM -0600, Eric Blake wrote:
> >Sorry about the wrong list.  At any rate, what about this patch?
> >
> >2009-10-08  Eric Blake  <ebb9@byu.net>
> >
> >	* hires.h (hires_ms): Change initime_us to initime_ns, with 10x
> >	more resolution.
> >	(hires_ms::nsecs): New prototype.
> >	(hires_ms::usecs, hires_ms::msecs, hires_ms::uptime): Adjust.
> >	* times.cc (NSPERMS, MILLION, BILLION): New helper macros; use
> >	throughout to avoid long runs of 0.
> >	(systime_ns): New helper function.
> >	(hires_ms::prime): Use it for more resolution.
> >	(hires_ms::usecs): Change to...
> >	(hires_ms::nsecs): ...with more resolution.
> >	(clock_gettime): Use more resolution.
> >	* fhandler_disk_file.cc (utimens_fs): Get current time before
> >	opening handle, using higher resolution.
> 
> I don't like "MILLION" or "BILLION".  I think a real number is clearer
> for that.  Maybe it's jsut me but when I see million I can't help myself
> from checking to see if it's 1000000 or 1024*1024.  And, if you're going
> to assign constants to 1 with a bunch of zeros where do you draw the
> line?

I agree for another reason as well.  In the English language area it's
common to call the value 1*10^9 a "billion", while in other, non-english
areas, that's a "milliard", and a "billion" is actually 1*10^12.

http://en.wikipedia.org/wiki/Long_and_short_scales

That's too ambiguous for my taste.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
