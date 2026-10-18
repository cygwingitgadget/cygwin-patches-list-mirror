Return-Path: <SRS0=oWFo=II=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id 3E68A4BA23C4;
	Sun, 18 Oct 2026 20:52:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E68A4BA23C4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E68A4BA23C4
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792356759; cv=none;
	b=WvCfWrSN8i4fNUbVCo/0zAXv+ZOkNarZeHn7yB7YOkA29F08ut3/2atROFd/UNvnagxygB4zxR6ZITe1pypYoY1u+f3M1M03nN2MqxOMlcEvN/gsk2Llk1QVCOReQVsuI9MTNnn6VhIEmw8NOO5B/y2iv0N3sP6LsWg1xOWUwKo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792356759; c=relaxed/simple;
	bh=6WX9h6sgvIG38L7NXWCyDXgRRtrK236/hvuPi39GjF8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=r228KlIHpymsylXDJNEZBebTlKH/1oyJAppZpjtoQdvGGd5n19fTuLZda3qf25QS1p+D6isD6e7l62Ug1YpFPZrUIAnKW7ThS2S2AAfYFvzcc5JM8cY6P2gzAnckYe4oyFDc0L2ZH3zaV1u74u8rOhBPAXQIrKIPOKZlZqINIO4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=JK7fi48C
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E68A4BA23C4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=JK7fi48C
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B1E30120188;
	Sun, 18 Oct 2026 20:52:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 0F98720025;
	Sun, 18 Oct 2026 20:52:36 +0000 (UTC)
Message-ID: <f3181f7b-0494-4b2b-a527-b5dbea62ddf4@SystematicSW.ab.ca>
Date: Sun, 18 Oct 2026 14:52:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] tgid reported incorrectly in /proc/<pid>/status
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <87wlreyhxi.fsf@Gerda.invalid>
Cc: cygwin-developers@cygwin.com
Organization: Systematic Software
In-Reply-To: <87wlreyhxi.fsf@Gerda.invalid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 0F98720025
X-Stat-Signature: k7pban55rxk73x3ikgpo4jk83wn99aob
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/5PIQiYiICv3V2QI/xiuTchdjOYtO0Ciw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:cc:in-reply-to:content-type:content-transfer-encoding; s=he; bh=r49+/IuhkE2ZVFROoctTt8wv1/q24FWdTbrQYP+MRl8=; b=JK7fi48CqY7AkvKL1mGk6fF0dKE8L4wuE/SnVdSKBOWFi2eTkhkkvJGA+ek6k4lIn9LlM4uwmOniax1eGyJ2eVNxhxvwcNtL9C4bLaWVOp1JH01ZhPhy4L/zvOzg6jBHEu4R6Bhi99OaMiAdkRVOv9+rcq1mQlGsGgWkrYo+3owSiMl7e322MtaoH5UADygDXMhJhuKcWYrD7FEZqkjaHroqH1yLsWrm6HhOwapJ5g63JIjtXtzakKFkgmAMY0F6F65wWqklqYiKiU26Q7KQIbnP8iGzB3Akusf0OYO9+pv3CVZRNEMLEoda4bdnTy2kQ3K46VBnJjcbQI6JfrlfeA==
X-HE-Tag: 1792356756-181136
X-HE-Meta: U2FsdGVkX1+1M4oOWkvsAFFIK54OpyQnqDyU4AV15ki77DKiHWJbPXQqyKM1ONfwymVKjbj5vdRFAKfB5Bj6zc9l8hgKrRIaaWRyQYt5tv3gqRviGpKkYM9udCvqXGWneFuQ/H9aJeDkgjjRw6hi1lg9stq/2/BiUQ2bz8qHQVQQdIAU9C0z4KbBDba3RVL/o+HhRSfr9yq9JeAqVb2E2H2yh31AhSB908b3euQKKqEqpLS6X9e6RkwaFuvyeblu7zwEBVJRk8cF27W48rkJjdJ8d9/jNoV+yTj1FF8eFLaKFwVsqdQpy96iCFGsPQVCArbdSJQ9+0hwhwxOuRwqOB6ee7zK0utyI6XnzpvFx3QicV75qY3mk6Coal0oryU+GFEl+ROoqt9MFIHLpnw5og==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi folks,

Cygwin threads are dispatched on NT threads, as I see the expected thread count 
for cygserver under Task Mangler: 339 > 327 == 310 + 16 + 1 (main):

$ grep thread /etc/cygserver.conf
# kern.srv.cleanup_threads: No. of cygserver threads used for cleanup tasks.
# Default: 2, Min: 1, Max: 16, command line option -c, --cleanup-threads
#kern.srv.cleanup_threads 2
kern.srv.cleanup_threads 16
# kern.srv.request_threads: No. of cygserver threads used to serve
# Default: 10, Min: 1, Max: 310, command line option -r, --request-threads
#kern.srv.request_threads 10
kern.srv.request_threads 310

I referred the underlying issue to developers, because I know some have been 
working on dealing with with non-Cygwin process threads, and it would be good to 
see NT threads treated like Linux LWP Threads, and similar information made 
available about them under the hood.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry


On 2026-10-18 12:36, ASSI via Cygwin-patches wrote:
> From b9f66fe5a55ac39f0bbbcfe9d96cade9927f672d Mon Sep 17 00:00:00 2001
> From: Achim Gratz <Stromeko@Stromeko.DE>
> Date: Sun, 18 Oct 2026 19:56:13 +0200
> Subject: [PATCH] winsup/cygwin/fhandler/process.cc: correct tgid value
> 
> Cygwin has historically (and incorrectly) reported the pgid as the
> tgid in /proc/<pid>/status even though LWP don't exist on Cygwin.
> Since the Threads parameter was missing at the time, this latent bug
> was lying dormant as that signifies an invalid tgid on Linux (the same
> as for a Threads parameter of zero).  However, commit 9756b33 changed
> that to reporting a number of threads in the Threads parameter that is
> totally unrelated to LWP, which triggered the bug: procps now reports
> the tgid instead of the pid as it does on Linux and expects that only
> the leader process (tgid==pid) should get reported unless you ask for
> all LWP to be shown.  This either suppresses the output for that
> process completely or shows the wrong PID for many processes.  Regain
> some sanity by ensuring tgid==pid for all Cygwin processes as LWP
> don't exist.
> 
> This patch does not change the reporting of parameter Threads (which
> should probably always be 0 on Cygwin to conform to the expectations
> set by Linux), however it is currently unknown if that deviation is
> actually causing problems in existing programs.  Any program using
> this number should expect the number of threads to change between
> reading this parameter and actually getting to the point where it
> could enumerate them.  However, seeing a Thread value different from
> zero might reasonably enable code paths that try to open directory
> /proc/<pid>/task (which contains all threads in that thread group on
> Linux).  Cygwin doesn't have this unless someone whips up an LWP
> emulation for it, so for that reason it might be better to revert to
> reporting zero.
> 
> Signed-off-by: Achim Gratz <Stromeko@Stromeko.DE>
> Reported-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>   winsup/cygwin/fhandler/process.cc | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
> index 404668661..86ca05e5e 100644
> --- a/winsup/cygwin/fhandler/process.cc
> +++ b/winsup/cygwin/fhandler/process.cc
> @@ -1335,7 +1335,9 @@ format_process_status (void *data, char *&destbuf)
>   				   "SigIgn:\t%016lx\n",
>   			  cmd,
>   			  state, state_str,
> -			  p->pgid,
> +			  p->pid, /* this is the tgid on Linux, but
> +				     Cygwin doesn't have LWP -- treat
> +				     all processes as leaders */
>   			  p->pid,
>   			  p->ppid,
>   			  p->uid, p->uid, p->uid, p->uid,
> @@ -1343,7 +1345,11 @@ format_process_status (void *data, char *&destbuf)
>   			  vmsize * kb_per_page, 0UL, vmrss * kb_per_page,
>   			  vmdata * kb_per_page, 0UL, vmtext * kb_per_page,
>   			  vmlib * kb_per_page,
> -			  num_threads,
> +			  num_threads, /* should really be the number
> +					  of LWP in the same thread
> +					  group, not the number of NT
> +					  threads attached to this
> +					  process */
>   			  pnd, blk, ign
>   			  );
>   }

