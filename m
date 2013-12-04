Return-Path: <cygwin-patches-return-7917-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30317 invoked by alias); 4 Dec 2013 17:51:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30303 invoked by uid 89); 4 Dec 2013 17:51:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.3 required=5.0 tests=AWL,BAYES_50,RDNS_NONE autolearn=no version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from Unknown (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 04 Dec 2013 17:51:17 +0000
Received: from pool-71-126-240-25.bstnma.fios.verizon.net ([71.126.240.25] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1VoGbN-000FCN-Ky	for cygwin-patches@cygwin.com; Wed, 04 Dec 2013 17:51:09 +0000
Received: from cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id F0CE260125	for <cygwin-patches@cygwin.com>; Wed,  4 Dec 2013 12:51:08 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/q9/Ze13OYxPuU8gZO1MpO
Date: Wed, 04 Dec 2013 17:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
Message-ID: <20131204175108.GB2590@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52437121.1070507@redhat.com> <20131204093238.GA28314@calimero.vinschen.de> <20131204113626.GB29444@calimero.vinschen.de> <20131204120408.GC29444@calimero.vinschen.de> <20131204170028.GA2590@ednor.casa.cgf.cx> <20131204172324.GA13448@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131204172324.GA13448@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q4/txt/msg00013.txt.bz2

On Wed, Dec 04, 2013 at 06:23:24PM +0100, Corinna Vinschen wrote:
>On Dec  4 12:00, Christopher Faylor wrote:
>> On Wed, Dec 04, 2013 at 01:04:08PM +0100, Corinna Vinschen wrote:
>> >On Dec  4 12:36, Corinna Vinschen wrote:
>> >> On Dec  4 10:32, Corinna Vinschen wrote:
>> >> > Hi guys,
>> >> > [...etc...]
>> >> > The problem is still present in the current sources.
>> >> > [...]
>> >
>> >Ouch, ouch, ouch!  I tested the wrong DLL.  Actually current CVS fixes
>> >this problem.  Duh.  Sorry for the confusion.
>> >
>> >One question, though.  Assuming start is == size, then the current code
>> >in CVS extends the fd table by only 1.  If that happens often, the
>> >current code would have to call ccalloc/memcpy/cfree a lot.  Wouldn't
>> >it in fact be better to extend always by at least NOFILE_INCR, and to
>> >extend by (1 + start - size) only if start is > size + NOFILE_INCR?
>> >Something like
>> >
>> >  size_t extendby = (start >= size + NOFILE_INCR) ? 1 + start - size : NOFILE_INCR;
>> >
>> >?
>> >
>> >Sorry again.  Fortunately it's my WJM week...
>> 
>> I don't think it is a common occurrence for start >= size.  It is
>> usually done when something like bash dup2's stdin/stdout/stderr to a
>> high fd.  Howeer, I'll check in something which guarantees that there is
>> always a NOFILE_INCR entries free after start.
>
>That might be helpful.  Tcsh, for instance, always dup's it's std
>descriptors to the new fds 15-19.  If it does so in this order, it would
>have to call extend 5 times.

dtable.h:#define NOFILE_INCR    32

It shouldn't extend in that scenario.  The table starts with 32
elements.

cgf
