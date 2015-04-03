Return-Path: <cygwin-patches-return-8115-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80097 invoked by alias); 3 Apr 2015 12:51:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80083 invoked by uid 89); 3 Apr 2015 12:51:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out2-smtp.messagingengine.com
Received: from out2-smtp.messagingengine.com (HELO out2-smtp.messagingengine.com) (66.111.4.26) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 03 Apr 2015 12:51:12 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])	by mailout.nyi.internal (Postfix) with ESMTP id 5FF4920A81	for <cygwin-patches@cygwin.com>; Fri,  3 Apr 2015 08:51:06 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute4.internal (MEProxy); Fri, 03 Apr 2015 08:51:09 -0400
Received: from [192.168.1.102] (unknown [31.51.205.126])	by mail.messagingengine.com (Postfix) with ESMTPA id 3D26C680110	for <cygwin-patches@cygwin.com>; Fri,  3 Apr 2015 08:51:09 -0400 (EDT)
Message-ID: <551E8CBB.4020306@dronecode.org.uk>
Date: Fri, 03 Apr 2015 12:51:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Only construct ucontext for SA_SIGINFO signal handlers
References: <1428003041-14404-1-git-send-email-jon.turney@dronecode.org.uk> <20150403111806.GO13285@calimero.vinschen.de> <20150403121707.GT13285@calimero.vinschen.de>
In-Reply-To: <20150403121707.GT13285@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00016.txt.bz2

On 03/04/2015 13:17, Corinna Vinschen wrote:
> On Apr  3 13:18, Corinna Vinschen wrote:
>> On Apr  2 20:30, Jon TURNEY wrote:
>>
>>>         sigset_t this_oldmask = set_process_mask_delta ();
>>> -      thiscontext.uc_sigmask = this_oldmask;
>>> +      context.uc_sigmask = this_oldmask;
>>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> This call to set_process_mask_delta() should occur before constructing
>> the context, so that filling in uc_sigmask can be moved into the above
>> `'if' branch.

Ok, I will move it.

>> On second thought, isn't this slightly wrong anyway?  Shouldn't that be
>>
>>           context.uc_sigmask = _my_tls.sigmask;
>> 	 context.uc_mcontext.oldmask = this_oldmask;

As I wrote elsewhere:  You'll have to help me understand what the 
difference in meaning between ucontext_t.uc_sigmask and 
ucontext_t.uc_mcontext.oldmask is.

I don't see how the value of _my_tls.sigmask has any meaning at that 
point in the code.

> Oh, btw., what about cr2?  Right now, with the above code, it contains
> a random value.  It should at least be zero'ed out.  Alternatively:
>
>    context.uc_mcontext.cr2 = (thissi.si_signo == SIGSEGV
> 			     || thissi.si_signo == SIGBUS)
> 			    ? (uintptr_t) thissi.si_addr : 0;
>

Sure, but can we deal with that as a separate patch?
