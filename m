Return-Path: <cygwin-patches-return-6751-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1691 invoked by alias); 9 Oct 2009 04:58:17 -0000
Received: (qmail 1680 invoked by uid 22791); 9 Oct 2009 04:58:15 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 09 Oct 2009 04:58:10 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 16B9F3B0002 	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2009 00:58:01 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 966B72B352; Fri,  9 Oct 2009 00:58:00 -0400 (EDT)
Date: Fri, 09 Oct 2009 04:58:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: utimensat UTIME_NOW granularity bug
Message-ID: <20091009045800.GA17335@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20091008T221131-292@post.gmane.org>  <20091008212425.GB2068@ednor.casa.cgf.cx>  <4ACEACBA.4030904@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACEACBA.4030904@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00082.txt.bz2

On Thu, Oct 08, 2009 at 09:23:38PM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>According to Christopher Faylor on 10/8/2009 3:24 PM:
>>> I think we need to implement a companion to systime(), which returns the system 
>>> time without any truncation, so that the function clock_gettime(CLOCK_REALTIME) 
>>> can report time with resolution to the 10th of a microsecond rather than to 
>>> plain microseconds.  Then utimensat needs to use clock_gettime rather than 
>>> gettimeofday, so that it is not needlessly truncating the 10th of microsecond 
>>> resolution available from Windows.
>> 
>> Why not send these type of musings to the cygwin-developers list?  It really
>> is more appropriate for this type of discussion.
>
>Sorry about the wrong list.  At any rate, what about this patch?
>
>2009-10-08  Eric Blake  <ebb9@byu.net>
>
>	* hires.h (hires_ms): Change initime_us to initime_ns, with 10x
>	more resolution.
>	(hires_ms::nsecs): New prototype.
>	(hires_ms::usecs, hires_ms::msecs, hires_ms::uptime): Adjust.
>	* times.cc (NSPERMS, MILLION, BILLION): New helper macros; use
>	throughout to avoid long runs of 0.
>	(systime_ns): New helper function.
>	(hires_ms::prime): Use it for more resolution.
>	(hires_ms::usecs): Change to...
>	(hires_ms::nsecs): ...with more resolution.
>	(clock_gettime): Use more resolution.
>	* fhandler_disk_file.cc (utimens_fs): Get current time before
>	opening handle, using higher resolution.

I don't like "MILLION" or "BILLION".  I think a real number is clearer
for that.  Maybe it's jsut me but when I see million I can't help myself
from checking to see if it's 1000000 or 1024*1024.  And, if you're going
to assign constants to 1 with a bunch of zeros where do you draw the
line?

It looks like you either don't need the systime() call or it should
call systime_ns.

>       long long x = time_in->tv_sec * NSPERSEC +
>-			    time_in->tv_nsec / (NSPERSEC/100000) + FACTOR;
>+			    time_in->tv_nsec / (BILLION / NSPERSEC) + FACTOR;

I'm too tired now to figure out why you switched these but it seems
odd that you switched the numerator and denominator  here but

>       out->dwHighDateTime = x >> 32;
>       out->dwLowDateTime = x;
>     }
>@@ -202,7 +217,7 @@ void __stdcall
> timeval_to_filetime (const struct timeval *time_in, FILETIME *out)
> {
>   long long x = time_in->tv_sec * NSPERSEC +
>-			time_in->tv_usec * (NSPERSEC/1000000) + FACTOR;
>+			time_in->tv_usec * (NSPERSEC / MILLION) + FACTOR;

not here.

cgf
