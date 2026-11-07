Return-Path: <SRS0=jrW8=I4=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 517344BA2E13
	for <cygwin-patches@cygwin.com>; Sat,  7 Nov 2026 05:20:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 517344BA2E13
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 517344BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794028819; cv=none;
	b=Zbon52Wy8Q4yVZIRFD9d55LH5ERa7/xlzRhuUOvSTzRWEUOvDfin/bPK7ejlq6guilJBB4effOILV07n60uMm7nBCjhq+XQBi5mtD6awvdnDFInvGCUSP7cTyEiRSY3cIyZojF4aJJoRN2MErrY/LC1inczAWMzrOgQE1i4Vers=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794028819; c=relaxed/simple;
	bh=1Fc056WPNbrJNaTV/4sSUND00eQ+RHWehEv2vnKcaqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=GkdlSa/jJmJjogsQL/TLUE8gVWn1FehiabmbLk2Z3siJwqstuWaD/tNxIk66etwBk7X3lWlS7h4PfsYlA4oeqtCqVLDD1hE3MGaxqMl9O1yGlHQljlKUWkHgBzTTlYuPt5U+5+ZWWfWbsbyTDsDAGzmV149qr0y85GjfdK3XTJ4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 517344BA2E13
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6A75XTp6037067
	for <cygwin-patches@cygwin.com>; Fri, 6 Nov 2026 21:33:29 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-253-193.fiber.dynamic.sonic.net(50.1.253.193), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdljwBwa; Fri Nov  6 21:33:21 2026
Message-ID: <02a8901e-648d-40c1-8f96-2e792336af5b@maxrnd.com>
Date: Fri, 6 Nov 2026 21:20:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: spawn: Create winpid symlink for spawned
 processes as well
To: cygwin-patches@cygwin.com
References: <20261106113122.315-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20261106113122.315-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 11/6/2026 3:31 AM, Takashi Yano wrote:
> Since commit 1b86dd7d8c19 ("Cygwin: make sure exec'ed process exists
> early in process list"), spawned processes have been missing from the
> process list (e.g. the output of `ps`). This is because that commit
> should also have maintained the winpid symlink for spawned cygwin
> processes, but did not.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2026-October/260185.html
> Fixes: 1b86dd7d8c19 ("Cygwin: make sure exec'ed process exists early in process list")
> Reported-by: Daniyar Oshakbayev <daniyar29@gmail.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/spawn.cc | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 6d736888a..87865ddf3 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -794,16 +794,14 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>   	     not available. */
>   	  DuplicateHandle (GetCurrentProcess (), child.shared_handle (),
>   			   pi.hProcess, NULL, 0, 0, DUPLICATE_SAME_ACCESS);
> +	  /* We have to create a new winpid symlink on behalf of the child
> +	     process. For Cygwin processes we also have to create a reference
> +	     in the child. */
> +	  child.create_winpid_symlink ();
>   	  if (!real_path.iscygexec ())
> -	    {
> -	      /* If the child process is not a Cygwin process, we have to
> -		 create a new winpid symlink and induce it into the child
> -		 process as well to keep it over the lifetime of the child. */
> -	      child.create_winpid_symlink ();
> -	      DuplicateHandle (GetCurrentProcess (),
> -			       child.shared_winpid_handle (),
> -			       pi.hProcess, NULL, 0, 0, DUPLICATE_SAME_ACCESS);
> -	    }
> +	    DuplicateHandle (GetCurrentProcess (),
> +			     child.shared_winpid_handle (),
> +			     pi.hProcess, NULL, 0, 0, DUPLICATE_SAME_ACCESS);
>   	  child->start_time = time (NULL); /* Register child's starting time. */
>   	  child->nice = myself->nice;
>   	  child->sched_policy = myself->sched_policy;

The patch LGTM.  Please apply at your convenience.

..mark
