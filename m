Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D87EC3858C54; Mon,  2 Dec 2024 15:35:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D87EC3858C54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733153742;
	bh=+4ASpan+D6DlvghIZQlpCneK1g5yX2pXWdM/KYDWjos=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=QiSLpPuVEWS9m9+gJT0BiDlhg9PqlNmK5ZGz1NvDlVTFBcNuNf+fAA46yUdjAs76b
	 9Wiqw6eaQmc99I/FhdWWewo73EUpop0DEfTbjvOvh8/jexR7XDxH/CTPh8RqZyv9or
	 5kwEa5heNk39iQUFcvEqXb1HMmpreuw6KcEKrkJs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1B19EA80BC2; Mon,  2 Dec 2024 16:35:40 +0100 (CET)
Date: Mon, 2 Dec 2024 16:35:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: setpriority, sched_setparam: add missing process
 access right
Message-ID: <Z03TzKxAV5DZD6_T@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0f9951bf-ddfd-4545-a678-d697d2c974bb@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f9951bf-ddfd-4545-a678-d697d2c974bb@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 29 17:12, Christian Franke wrote:
> Regression, sorry!

Shit happens *shrug*

> Subject: [PATCH] Cygwin: setpriority, sched_setparam: add missing process
>  access right
> 
> set_and_check_winprio() also requires PROCESS_QUERY_LIMITED_INFORMATION.
> 
> Fixes: 153b51ee08ef ("Cygwin: setpriority, sched_setparam: fail if Windows sets a lower priority")
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/miscfuncs.cc | 2 ++
>  winsup/cygwin/sched.cc     | 4 +++-
>  winsup/cygwin/syscalls.cc  | 5 +++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
> index e3bf35cf7..ebe401b93 100644
> --- a/winsup/cygwin/miscfuncs.cc
> +++ b/winsup/cygwin/miscfuncs.cc
> @@ -190,6 +190,8 @@ bool
>  set_and_check_winprio (HANDLE proc, DWORD prio)
>  {
>    DWORD prev_prio = GetPriorityClass (proc);
> +  if (!prev_prio)
> +    return false;

The commit message doesn't explain this part of the patch.  What does it
fix?


Thanks,
Corinna
