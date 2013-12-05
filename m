Return-Path: <cygwin-patches-return-7920-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1045 invoked by alias); 5 Dec 2013 19:56:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 985 invoked by uid 89); 5 Dec 2013 19:56:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from Unknown (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 05 Dec 2013 19:56:04 +0000
Received: from pool-71-126-240-25.bstnma.fios.verizon.net ([71.126.240.25] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1Vof1g-000Je1-4q	for cygwin-patches@cygwin.com; Thu, 05 Dec 2013 19:55:56 +0000
Received: from cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 5C2F06011D	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2013 14:55:55 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19bX0XIgsMknZtMXDXQEkFA
Date: Thu, 05 Dec 2013 19:56:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
Message-ID: <20131205195555.GA4938@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52437121.1070507@redhat.com> <20131204093238.GA28314@calimero.vinschen.de> <20131204113626.GB29444@calimero.vinschen.de> <20131204120408.GC29444@calimero.vinschen.de> <20131204170028.GA2590@ednor.casa.cgf.cx> <20131204172324.GA13448@calimero.vinschen.de> <20131204175108.GB2590@ednor.casa.cgf.cx> <52A08372.7080402@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52A08372.7080402@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q4/txt/msg00016.txt.bz2

On Thu, Dec 05, 2013 at 06:45:22AM -0700, Eric Blake wrote:
>On 12/04/2013 10:51 AM, Christopher Faylor wrote:
>
>>>>> One question, though.  Assuming start is == size, then the current code
>>>>> in CVS extends the fd table by only 1.  If that happens often, the
>>>>> current code would have to call ccalloc/memcpy/cfree a lot.  Wouldn't
>>>>> it in fact be better to extend always by at least NOFILE_INCR, and to
>>>>> extend by (1 + start - size) only if start is > size + NOFILE_INCR?
>>>>> Something like
>>>>>
>>>>>  size_t extendby = (start >= size + NOFILE_INCR) ? 1 + start - size : NOFILE_INCR;
>>>>>
>
>Always increasing by a minimum of NOFILE_INCR is wrong in one case - we
>should never increase beyond OPEN_MAX_MAX (currently 3200).  dup2(0,
>3199) should succeed (unless it fails with EMFILE due to rlimit, but we
>already know that our handling of setrlimit(RLIMIT_NOFILE) is still a
>bit awkward); but dup2(0, 3200) must always fail with EBADF.  I think
>the code in CVS is still wrong: we want to increase to the larger of the
>value specified by the user or NOFILE_INCR to minimize repeated calloc,
>but we also need to cap the increase to be at most OPEN_MAX_MAX
>descriptors, to avoid having a table larger than what the rest of our
>code base will support.

I made some more changes to CVS.  Incidentally did you catch the fact
that you broke how this worked in 1.7.26?  You were taking a MAX of a
signed and unsigned quantity so the signed quantity was promoted to a
huge positive number.

>Not having NOFILE_INCR free slots after a user allocation is not fatal;

No one implied it was.

>it means that the first allocation to a large number will not have tail
>padding, but the next allocation to fd+1 will allocate NOFILE_INCR slots
>rather than just one.  My original idea of MAX(NOFILE_INCR, start -
>size) expresses that.

That wasn't Corinna's concern.  My replacement code would have called
calloc for every one of:

dup2(0, 32);
dup2(1, 33);
dup2(2, 34);

Obviously there are different ways to avoid this and I chose to extend
the table after the "start" location.

>>> That might be helpful.  Tcsh, for instance, always dup's it's std
>>> descriptors to the new fds 15-19.  If it does so in this order, it would
>>> have to call extend 5 times.
>> 
>> dtable.h:#define NOFILE_INCR    32
>> 
>> It shouldn't extend in that scenario.  The table starts with 32
>> elements.
>
>Rather, the table starts with 256 elements; which is why dup2 wouldn't
>crash until dup'ing to 256 or greater before I started touching this.

The table is initialized in dtable_init() with 32 elements.  When it
enters main, it is still 32 elements, at least according to
cygheap->fdtab.size.  I just checked this with gdb.

cgf
