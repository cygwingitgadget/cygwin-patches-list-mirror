Return-Path: <cygwin-patches-return-8120-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31826 invoked by alias); 4 Apr 2015 16:07:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31798 invoked by uid 89); 4 Apr 2015 16:07:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Sat, 04 Apr 2015 16:07:45 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id A174B204D7	for <cygwin-patches@cygwin.com>; Sat,  4 Apr 2015 12:07:40 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute6.internal (MEProxy); Sat, 04 Apr 2015 12:07:44 -0400
Received: from [192.168.1.102] (unknown [31.51.205.126])	by mail.messagingengine.com (Postfix) with ESMTPA id DBF5FC00013	for <cygwin-patches@cygwin.com>; Sat,  4 Apr 2015 12:07:43 -0400 (EDT)
Message-ID: <55200C4C.1010909@dronecode.org.uk>
Date: Sat, 04 Apr 2015 16:07:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Only construct ucontext for SA_SIGINFO signal handlers
References: <1428003041-14404-1-git-send-email-jon.turney@dronecode.org.uk> <20150403111806.GO13285@calimero.vinschen.de> <20150403121707.GT13285@calimero.vinschen.de> <551E8CBB.4020306@dronecode.org.uk> <20150403140807.GV13285@calimero.vinschen.de>
In-Reply-To: <20150403140807.GV13285@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00021.txt.bz2

On 03/04/2015 15:08, Corinna Vinschen wrote:
> On Apr  3 13:51, Jon TURNEY wrote:
>> On 03/04/2015 13:17, Corinna Vinschen wrote:
>>> On Apr  3 13:18, Corinna Vinschen wrote:
>>>> On Apr  2 20:30, Jon TURNEY wrote:
>>>>
>>>>>         sigset_t this_oldmask = set_process_mask_delta ();
>>>>> -      thiscontext.uc_sigmask = this_oldmask;
>>>>> +      context.uc_sigmask = this_oldmask;
>>>>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>
>>>> This call to set_process_mask_delta() should occur before constructing
>>>> the context, so that filling in uc_sigmask can be moved into the above
>>>> `'if' branch.
>>
>> Ok, I will move it.
>>
>>>> On second thought, isn't this slightly wrong anyway?  Shouldn't that be
>>>>
>>>>           context.uc_sigmask = _my_tls.sigmask;
>>>> 	 context.uc_mcontext.oldmask = this_oldmask;
>>
>> As I wrote elsewhere:  You'll have to help me understand what the difference
>> in meaning between ucontext_t.uc_sigmask and ucontext_t.uc_mcontext.oldmask
>> is.
>>
>> I don't see how the value of _my_tls.sigmask has any meaning at that point
>> in the code.
>
> Ok, I had a look into the Linux source and searched the web, and here's
> the problem.
>
> One is that sigset_t on Linux is not just a 32 or 64 bit bitmask anymore,
> but an array of ulong's used as a rather big sigmask.
>
> OTOH, mcontext_t::oldmask is only the size of "unsigned long".  In fact,
> as it turns out by inspecting the Linux kernel, oldmask is nothing else
> than the first bits of uc_sigmask which fit into an unsigned long.  And
> in the net I found that oldmask is just the old representation of
> sigset_t, before the Linux kernel allowed more signals than fit into
> a bitmask of unsigned long size.  In fact, it's only for backward compat,
> but unused these days.
>
> Given that, setting context.uc_sigmask to this_oldmask is apparently
> the right thing to do.  For emulating backward compat (which we don't
> need, but it also doesn't hurt), we could set oldmask to the same
> value:
>
>    context.uc_sigmask = context.uc_mcontext.oldmask = this_oldmask;
>

Thank you very much for researching this.  I tried but wasn't able to 
discover anything much.

What you suggest seems right, so I'll make an updated patch including that.
