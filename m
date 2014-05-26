Return-Path: <cygwin-patches-return-7992-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7708 invoked by alias); 26 May 2014 20:39:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7692 invoked by uid 89); 26 May 2014 20:39:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,SPF_PASS autolearn=no version=3.3.2
X-HELO: mail.lysator.liu.se
Received: from mail.lysator.liu.se (HELO mail.lysator.liu.se) (130.236.254.3) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Mon, 26 May 2014 20:39:08 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])	by mail.lysator.liu.se (Postfix) with ESMTP id 4E24740022	for <cygwin-patches@cygwin.com>; Mon, 26 May 2014 22:39:04 +0200 (CEST)
Received: from [192.168.0.68] (90-227-119-221-no95.business.telia.com [90.227.119.221])	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))	(No client certificate requested)	by mail.lysator.liu.se (Postfix) with ESMTPSA id 275224001B	for <cygwin-patches@cygwin.com>; Mon, 26 May 2014 22:39:04 +0200 (CEST)
Message-ID: <5383A667.9070407@lysator.liu.se>
Date: Mon, 26 May 2014 20:39:00 -0000
From: Peter Rosin <peda@lysator.liu.se>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_rexec() returns pointer to deallocated memory
References: <53811668.5010208@tiscali.co.uk> <5382E760.7@lysator.liu.se> <538312E4.1040201@tiscali.co.uk> <5383434B.8070508@lysator.liu.se> <53835D4E.9040603@tiscali.co.uk> <20140526163505.GA7018@ednor.casa.cgf.cx>
In-Reply-To: <20140526163505.GA7018@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00015.txt.bz2

On 2014-05-26 18:35, Christopher Faylor wrote:
> On Mon, May 26, 2014 at 04:27:10PM +0100, David Stacey wrote:
>> On 26/05/14 14:36, Peter Rosin wrote:
>>> I believe the comment refers to if "static" is the right answer to the
>>> problem. Is there a need to handle concurrent calls?
>>
>> I can't really comment on that. As the code stands, neither of the two 
>> functions that we are discussing are reentrant. As long as the author 
>> and the user(s) of the routines are both aware of that then it isn't a 
>> problem.
>>
>> I was just trying to fix a coding error that was picked up by Coverity 
>> Scan; it wasn't my intention to question the design.
> 
> But that is the usual problem with Coverity.  Making the simple, obvious
> fix to correct a Coverity warning isn't necessarily the right way to
> deal with the issue.
> 
> In this case, the linux man page says:
> 
>   ATTRIBUTES
>      Multithreading (see pthreads(7))
> 	 The rexec() and rexec_af() functions are not thread-safe.
> 
> so static is appropriate.

"Not thread-safe" doesn't automatically mean that a following call may mess
with what was returned from a prior call (by the same thread). But since
it (IMHO) is a poor interface with no description of how to free any
possibly allocated memory, I agree that static is the only viable option.

Cheers,
Peter
