Return-Path: <cygwin-patches-return-6759-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3888 invoked by alias); 12 Oct 2009 15:02:56 -0000
Received: (qmail 3535 invoked by uid 22791); 12 Oct 2009 15:02:54 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 12 Oct 2009 15:02:48 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 376AC3B0002 	for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2009 11:02:38 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 381AC2B352; Mon, 12 Oct 2009 11:02:38 -0400 (EDT)
Date: Mon, 12 Oct 2009 15:02:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: utimensat UTIME_NOW granularity bug
Message-ID: <20091012150237.GA29109@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20091008T221131-292@post.gmane.org>  <20091008212425.GB2068@ednor.casa.cgf.cx>  <4ACEACBA.4030904@byu.net>  <20091009045800.GA17335@ednor.casa.cgf.cx>  <4ACF307F.1040604@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACF307F.1040604@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00090.txt.bz2

On Fri, Oct 09, 2009 at 06:45:51AM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>According to Christopher Faylor on 10/8/2009 10:58 PM:
>> 
>> I don't like "MILLION" or "BILLION".  I think a real number is clearer
>> for that.  Maybe it's jsut me but when I see million I can't help myself
>> from checking to see if it's 1000000 or 1024*1024.  And, if you're going
>> to assign constants to 1 with a bunch of zeros where do you draw the
>> line?
>
>OK, here's the respin without the churn.
>
>> 
>> It looks like you either don't need the systime() call or it should
>> call systime_ns.
>
>Done.  hires_us still uses systime().
>
>> 
>>>       long long x = time_in->tv_sec * NSPERSEC +
>>> -			    time_in->tv_nsec / (NSPERSEC/100000) + FACTOR;
>>> +			    time_in->tv_nsec / (BILLION / NSPERSEC) + FACTOR;
>> 
>> I'm too tired now to figure out why you switched these but it seems
>> odd that you switched the numerator and denominator  here but
>> 
>>>   long long x = time_in->tv_sec * NSPERSEC +
>>> -			time_in->tv_usec * (NSPERSEC/1000000) + FACTOR;
>>> +			time_in->tv_usec * (NSPERSEC / MILLION) + FACTOR;
>
>Because the number 100000 is unrelated to anything else in this file; just
>because NSPERSEC/1000000 gives the right answer doesn't mean it expresses
>the right equation.  We are really calculating these two values:
>
>tv_nsec / 100 (nsecs) - scaling down
>tv_nsec * 10 (usecs) - scaling up
>
>so that x will be in terms of 100ns ticks.  The relations should be:
>
>/ 100 = 1000000000/NSPERSEC = 1000000000/10000000
>*  10 =   NSPERSEC/1000000  =   10000000/1000000
>
>since NSPERSEC falls in between nanoseconds and microseconds.


I'm still not convinced that this switch makes anything clearer but, that's ok.

Please check in.

Thanks.

cgf
