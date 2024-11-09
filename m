Return-Path: <SRS0=f0um=SE=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 614693858D21
	for <cygwin-patches@cygwin.com>; Sat,  9 Nov 2024 01:26:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 614693858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 614693858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731115612; cv=none;
	b=DCJ+SAHBpjgXnHCKwpjG8jA5PSLuD1fvekBN2wlwmoc2gSjnhw7ACIfhOfqItOVEHYv9enSb/ngYettzULzSyfZmfjqkDF2m2uROhpA/dE3VGx35rytB0bl7fbcZ+wfSWZffhRJ4ccV3ojZ/1U3RvMiiK0yLFOb42ClrNXxpBks=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731115612; c=relaxed/simple;
	bh=BL1ILUZ+vhbnw7ea7Pw8MCoodb8kI3DxhbF1gNHtdh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:DKIM-Signature; b=JQ3OHplz+BD8SVTRwCKstzpaY2O72q/2FXdMdE3NcQLNyGAQcBpNkSS/kJ7zze5xrhOjUOt/s9yB4OoLjsQtSR8Z5gB01UxKKEyBoCY7hFWEhabgP+/UattdmCI4zvZ2ZRGE4fP0bCKd4aQUZi4ud6ozyZCNJL0QjmSlVE8bUmU=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id E0198A1052
	for <cygwin-patches@cygwin.com>; Sat,  9 Nov 2024 01:26:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf19.hostedemail.com (Postfix) with ESMTPA id D108E20026
	for <cygwin-patches@cygwin.com>; Sat,  9 Nov 2024 01:26:44 +0000 (UTC)
Message-ID: <a18fbf5a-ba01-45e7-b734-6be340837060@SystematicSW.ab.ca>
Date: Fri, 8 Nov 2024 18:26:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix clean up conditions in close()
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20241108114309.1718-1-takashi.yano@nifty.ne.jp>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <20241108114309.1718-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: fyi1tgxshdwweekdyn1ioq3u8hrcc4dt
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: D108E20026
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+fKuR0ZUv6EOakTNE5kq2UPIu7EQZ8C+8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:subject:to:references:from:in-reply-to:content-type:content-transfer-encoding; s=he; bh=8utQMlf+mX0Lvi20k16KH0hZWlW0Y9ZyJPbPI7aTOzs=; b=ckbK/LpRf6CnyTlo4wA4WLoUZCWyw87bZwNXYYHYOY7KOgbQsA+wEq4yBrH1AaI8zCNVe/DUnPUucT8abpZcYRBNOGelLabmsipzNKciWNPz5oaQqAMKRxtolvM810qQ/sZvhyLizTdXfmrJDuXc79Wx2CliqAqG6lJtZks0Rawx4UNcSQkT9Lse3utN6g7Pu4yghieUh2/r9Lw7mpgzCzpqfidlk57LGU7QdWIBGMevPfZ9b2srHFGGp4Q1zN3Lqy1gyr0dvQ63J2sbDmqaDNNkkOzwb/OugUu1LuU51A+TTXW+LxojUy9WEc4TeZpYMSJSOdg88JlmKYFURd6ofA==
X-HE-Tag: 1731115604-742462
X-HE-Meta: U2FsdGVkX18mjt8/ucC9QT6JVwC3Cf3+ZpAkDeTqHfkU97ypnOIgKtXCxLqsu/fkJZ9cVOWkvI8oiF4MWmprYqy2ByWRquysK9w4OPVS47va9PqxCq+pZtn46sx0TPojHH8rmycnIKLd4tW9RmEOQWBRQ7L9LCHDulPCLFawVxEgbn8DYbZIxuYgG/76crw3tQhdbf6luqwvH3gA6Eed1Jb+AJuL06i/ErcGK5cuoMF03ZDhxYZtDvzB8AhZBvn/1R6Gpj4eFeXDJ9uqq3eyH7YDQo/3Dam4Ci16Z8a1rU2if56zezHfaGGhDUF4Q9J4Cr4BzCo0/2ghWb8OUa0eAPg+IN9x1r5e
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

It might be better if you could please document the wrong premise, as well as 
the right premise, and the reason for choosing the latter over the former, as in 
your other console patches?

In the comparison vs handle count, the reason for hard coding those magic 
numbers would perhaps be better expressed by defining meaningful symbolic names 
for those numbers, maybe also a named macro for picking the magic number to use, 
and some explanation of what those numbers, comparisons, and settings represent.


On 2024-11-08 04:43, Takashi Yano wrote:
> Previously, the condition to clean up input/output mode was based
> on wrong premise. This patch fixes that.
> 
> Fixes: 8ee8b0c974d7 ("Cygwin: console: Use GetCurrentProcessId() instead of myself->dwProcessId")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>   winsup/cygwin/fhandler/console.cc | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 4efba61e2..2651e49a6 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1976,7 +1976,8 @@ fhandler_console::close ()
>   
>     acquire_output_mutex (mutex_timeout);
>   
> -  if (shared_console_info[unit])
> +  if (shared_console_info[unit] && !myself->cygstarted
> +      && (dev_t) myself->ctty == get_device ())
>       {
>         /* Restore console mode if this is the last closure. */
>         OBJECT_BASIC_INFORMATION obi;
> @@ -1984,8 +1985,7 @@ fhandler_console::close ()
>         status = NtQueryObject (get_handle (), ObjectBasicInformation,
>   			      &obi, sizeof obi, NULL);
>         if (NT_SUCCESS (status)
> -	  && obi.HandleCount <= (myself->cygstarted ? 2 : 3)
> -	  && (dev_t) myself->ctty == get_device ())
> +	  && obi.HandleCount == (con.owner == GetCurrentProcessId () ? 2 : 3))
>   	{
>   	  /* Cleaning-up console mode for cygwin apps. */
>   	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
