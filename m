Return-Path: <cygwin-patches-return-7989-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21206 invoked by alias); 26 May 2014 13:36:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21191 invoked by uid 89); 26 May 2014 13:36:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,SPF_PASS autolearn=no version=3.3.2
X-HELO: mail.lysator.liu.se
Received: from mail.lysator.liu.se (HELO mail.lysator.liu.se) (130.236.254.3) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Mon, 26 May 2014 13:36:15 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])	by mail.lysator.liu.se (Postfix) with ESMTP id 60B0F4002C	for <cygwin-patches@cygwin.com>; Mon, 26 May 2014 15:36:12 +0200 (CEST)
Received: from [192.168.0.68] (90-227-119-221-no95.business.telia.com [90.227.119.221])	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))	(No client certificate requested)	by mail.lysator.liu.se (Postfix) with ESMTPSA id 3DE5A40011	for <cygwin-patches@cygwin.com>; Mon, 26 May 2014 15:36:12 +0200 (CEST)
Message-ID: <5383434B.8070508@lysator.liu.se>
Date: Mon, 26 May 2014 13:36:00 -0000
From: Peter Rosin <peda@lysator.liu.se>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_rexec() returns pointer to deallocated memory
References: <53811668.5010208@tiscali.co.uk> <5382E760.7@lysator.liu.se> <538312E4.1040201@tiscali.co.uk>
In-Reply-To: <538312E4.1040201@tiscali.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00012.txt.bz2

On 2014-05-26 12:09, David Stacey wrote:
> On 26/05/14 08:04, Peter Rosin wrote:
>> On 2014-05-25 00:00, David Stacey wrote:
>>> In function cygwin_rexec(), a pointer to local buffer 'ahostbuf' is returned through 'ahost'. However, the buffer will have been deallocated at the end of the function, and so the contents of 'ahost' will be undefined. A trivial patch (attached) fixes the problem by making 'ahostbuf' static.
>>>   This patch fixes Coverity bug ID #60028.
>>>   Change Log:
>>> 2014-05-24  David Stacey<drstacey@tiscali.co.uk>
>>>            * libc/rexec.cc (cygwin_rexec):
>>>          Corrected returning a pointer to a buffer that will have gone out of
>>>          scope.
>> I'm comparing with [1] and the same comment is applicable here (reading "it"
>> as "static").
>>
>> [1]https://cygwin.com/viewvc/src/winsup/cygwin/libc/rcmd.cc?revision=1.8&view=markup#l134
> 
> The two functions behave in a similar fashion. In both cases, an out parameter called 'ahost' is assigned to a buffer that is local to the function. The case of cygwin_rcmd_af() is correct in that the buffer is created statically (and so the buffer will not be destroyed at the end of the function). This means that the contents of the buffer will be available to the calling function.
> 
> However, in the case of cygwin_rexec(), the buffer is not static and is allocated on the stack. Hence after the function, if the stack were to be used (e.g. for local variables or function parameters) the contents of the buffer could easily become corrupted.
> 
> So yes, I would argue that 'static' is appropriate in both cases.

I believe the comment refers to if "static" is the right answer to the
problem. Is there a need to handle concurrent calls?

Cheers,
Peter
