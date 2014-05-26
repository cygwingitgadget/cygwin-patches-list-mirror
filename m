Return-Path: <cygwin-patches-return-7994-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11541 invoked by alias); 26 May 2014 21:46:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11529 invoked by uid 89); 26 May 2014 21:46:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Mon, 26 May 2014 21:46:13 +0000
Received: from pool-98-110-183-166.bstnma.fios.verizon.net ([98.110.183.166] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1Wp2ih-00061I-LB	for cygwin-patches@cygwin.com; Mon, 26 May 2014 21:46:11 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 4F9BA600E3	for <cygwin-patches@cygwin.com>; Mon, 26 May 2014 17:46:10 -0400 (EDT)
Received: by ednor (sSMTP sendmail emulation); Mon, 26 May 2014 17:46:10 -0400
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19MR1AVaSbEP90W3E7sFSz+
Date: Mon, 26 May 2014 21:46:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_rexec() returns pointer to deallocated memory
Message-ID: <20140526214610.GA6786@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53811668.5010208@tiscali.co.uk> <5382E760.7@lysator.liu.se> <538312E4.1040201@tiscali.co.uk> <5383434B.8070508@lysator.liu.se> <53835D4E.9040603@tiscali.co.uk> <20140526163505.GA7018@ednor.casa.cgf.cx> <5383A667.9070407@lysator.liu.se> <20140526214049.GB4754@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140526214049.GB4754@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q2/txt/msg00017.txt.bz2

On Mon, May 26, 2014 at 05:40:49PM -0400, Christopher Faylor wrote:
>On Mon, May 26, 2014 at 10:39:03PM +0200, Peter Rosin wrote:
>>On 2014-05-26 18:35, Christopher Faylor wrote:
>>> On Mon, May 26, 2014 at 04:27:10PM +0100, David Stacey wrote:
>>>> On 26/05/14 14:36, Peter Rosin wrote:
>>>>> I believe the comment refers to if "static" is the right answer to the
>>>>> problem. Is there a need to handle concurrent calls?
>>>>
>>>> I can't really comment on that. As the code stands, neither of the two 
>>>> functions that we are discussing are reentrant. As long as the author 
>>>> and the user(s) of the routines are both aware of that then it isn't a 
>>>> problem.
>>>>
>>>> I was just trying to fix a coding error that was picked up by Coverity 
>>>> Scan; it wasn't my intention to question the design.
>>> 
>>> But that is the usual problem with Coverity.  Making the simple, obvious
>>> fix to correct a Coverity warning isn't necessarily the right way to
>>> deal with the issue.
>>> 
>>> In this case, the linux man page says:
>>> 
>>>   ATTRIBUTES
>>>      Multithreading (see pthreads(7))
>>> 	 The rexec() and rexec_af() functions are not thread-safe.
>>> 
>>> so static is appropriate.
>>
>>"Not thread-safe" doesn't automatically mean that a following call may mess
>>with what was returned from a prior call (by the same thread). But since
>>it (IMHO) is a poor interface with no description of how to free any
>>possibly allocated memory, I agree that static is the only viable option.
>
>The question was about reentrancy.  AFAIK, "reentrant" doesn't mean that
>the buffer passed back from a call can't be subsequently modified by the
>thread.  I'm not aware of any interface which enforces that behavior.

Btw, the latest version of freebsd can't have this particular problem
since ahostbuf is now gone.  We probably should pull in the latest version
into Cygwin's tree.

cgf
