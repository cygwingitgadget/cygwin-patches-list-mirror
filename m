Return-Path: <cygwin-patches-return-8762-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32194 invoked by alias); 24 Apr 2017 23:09:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32181 invoked by uid 89); 24 Apr 2017 23:09:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=wondering
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp1.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Apr 2017 23:09:35 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E0F088D14	for <cygwin-patches@cygwin.com>; Mon, 24 Apr 2017 19:09:36 -0400 (EDT)
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2760788D13	for <cygwin-patches@cygwin.com>; Mon, 24 Apr 2017 19:09:36 -0400 (EDT)
Received: from [192.168.1.4] (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80C3488D12	for <cygwin-patches@cygwin.com>; Mon, 24 Apr 2017 19:09:35 -0400 (EDT)
Subject: Re: [PATCH] Possibly correct fix to strace phantom process entry
To: cygwin-patches@cygwin.com
References: <20170424093754.536-1-daniel.santos@pobox.com> <20170424121922.GA5622@calimero.vinschen.de>
From: Daniel Santos <daniel.santos@pobox.com>
Message-ID: <58cd89a9-4efe-ce8c-320e-a843839e59a7@pobox.com>
Date: Mon, 24 Apr 2017 23:09:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170424121922.GA5622@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 155C82C0-2943-11E7-AB3C-E680B56B9B0B-06139138!pb-smtp1.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00033.txt.bz2

On 04/24/2017 07:19 AM, Corinna Vinschen wrote:
> Hi Daniel,
>
> On Apr 24 04:37, Daniel Santos wrote:
>> The root cause of problem with strace causing long delays when any
>> process enumerates the process database appears to be calling
>> myself.thisproc () from child_info_spawn::handle_spawn() when we've
>> dynamically loaded cygwin1.dll.  It definately fixes the problem, but I
>> don't konw what other processes dynamically load cygwin1.dll and, thus,
>> what other side-effects that this may have.  Please verify correctness.
>>
>> Please see discussion here: https://cygwin.com/ml/cygwin/2017-04/msg00240.html
>>
>> Daniel
>>
>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
>> ---
> I was just looking into this myself, but I was looking into the weird
> Sleep loop itself and was wondering if that makes any sense at all.
>
> Assuming pinfo::init is called from process enumeration (winpids::add)
> then there's no good reason to handle this procinfo block at all.  It
> doesn't resolve into an existing "real" Cygwin process.  And that's
> exactly the case that hangs.

Yeah, and it doesn't represent a unique windows process either.

> So my curent fix would have been this:
>
> diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
> index e43082d..090fcb9 100644
> --- a/winsup/cygwin/pinfo.cc
> +++ b/winsup/cygwin/pinfo.cc
> @@ -314,12 +314,18 @@ pinfo::init (pid_t n, DWORD flag, HANDLE h0)
>         /* Detect situation where a transitional memory block is being retrieved.
>   	 If the block has been allocated with PINFO_REDIR_SIZE but not yet
>   	 updated with a PID_EXECED state then we'll retry.  */
> -      if (!created && !(flag & PID_NEW))
> -	/* If not populated, wait 2 seconds for procinfo to become populated.
> -	   Would like to wait with finer granularity but that is not easily
> -	   doable.  */
> -	for (int i = 0; i < 200 && !procinfo->ppid; i++)
> -	  Sleep (10);
> +      if (!created && !(flag & PID_NEW) && !procinfo->ppid)
> +	{
> +	  /* We're fetching process info for /proc or ps so we can just
> +	     ignore this procinfo. */
> +	  if (flag & PID_NOREDIR)
> +	    break;
> +	  /* If not populated, wait 2 seconds for procinfo to become populated.
> +	     Would like to wait with finer granularity but that is not easily
> +	     doable.  */
> +	  for (int i = 0; i < 200 && !procinfo->ppid; i++)
> +	    Sleep (10);
> +	}

Yeah, I hacked this loop up many times, mostly to diagnose the problem.  
I presume that it was originally added for a reason, but as I said 
before, I know that on x86 procinfo->ppid is almost certain to compile 
into a mov that will be atomic, but when I expect another thread to 
change something larger than one byte, I prefer to use a macro or 
function that is always atomic and conveys the intention.

>>   winsup/cygwin/dcrt0.cc | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
>> index ea6adcbbd..bbab08725 100644
>> --- a/winsup/cygwin/dcrt0.cc
>> +++ b/winsup/cygwin/dcrt0.cc
>> @@ -664,7 +664,8 @@ child_info_spawn::handle_spawn ()
>>     my_wr_proc_pipe = wr_proc_pipe;
>>     rd_proc_pipe = wr_proc_pipe = NULL;
>>   
>> -  myself.thisproc (h);
>> +  if (!dynamically_loaded)
>> +    myself.thisproc (h);
>>     __argc = moreinfo->argc;
>>     __argv = moreinfo->argv;
>>     envp = moreinfo->envp;
>> -- 
>> 2.11.0
> Your patch looks simple and elegant.  I'm just not sure about the side
> effects it may have if a process is missing its procinfo.  No problem
> for strace and ldd, apparently, but other processes...?

This makes me curious if ld produces this problem as well, only that 
it's very brief in execution.

> We could try it for a while.  I'm off all of May anyway and I could
> create a test build for that time...
>
> Btw., would you mind to send a BSD waiver per
> https://cygwin.com/contrib.html and
> https://cygwin.com/git/?p=newlib-cygwin.git;f=winsup/CONTRIBUTORS;hb=HEAD
> Your patches are covered by the "trivial patch" rule yet, but if you
> look into providing more patches you don't have to care anymore.

Thanks, I had overlooked that.  Is this sufficient?

I am providing my patches to the Cygwin sources under the 2-clause BSD 
license.

Daniel
