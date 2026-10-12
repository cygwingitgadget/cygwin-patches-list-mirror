Return-Path: <SRS0=tr/S=IC=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id BC02B4BA79AD
	for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2026 19:55:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BC02B4BA79AD
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BC02B4BA79AD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791834910; cv=none;
	b=xnZIjMcllSR8SCJ8N1oUfmR1KzNM6tcWtj/KNshVHnDdBYcYnaeGQz+gZc+mp7lT350ygVE2hHux/40aLMwjMdCAR8iTUMRqdVyg/NsOZKeQvULFFrZJDvHSFSr7qslmxFNlpkokVz7M1ARaldrv67ykPVOfJ9Pqc1QVQxSOMF4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791834910; c=relaxed/simple;
	bh=MU01FG8SDTcT4ytVRzL1PPIeSDMAmhVn0IJe8PuQUvU=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=V05R14mh0RekmzP00UpXEw8gPmcgqWuLcsMYAN1TJfr1pAuwo/qqMe1NHHccsVhK6vzG5vxl6FsziISwugknFqCFl/e+9eKJ11m8XasIPyUiFc2YGStHNIQh82PEXeVyNk0/k+WwR41FHKozMuBXl7eAR+LoAZshzwl4bqRHWCU=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BC02B4BA79AD
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715D810D98D06B
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: dmFkZTFvZcT6iaDD7TzQ4ZSmlqkPLBlYXN+JfjNH/ZtP5zTY8lrtt+tBa54plbu9+RWvnaWeVvtlXORyHHPnrKUVmvy0tCIDJvpJMyplygwqfHNJ6aErFnyFEbCq8AUyzTcvih7ZwK+kWLz/x+cjLY9PRF1IBLh+VImMXKxgXS3tCriwsrXRcmy/YAtJKUQ7rkTMtEnqlFlLQnT2MMJKij3Lhb2m2ufrc24DjLp/K3TenwnShD0Z2U6E1EJm0DvisIjwTVbIt1uWmPrj6SX491ApiDKPS70A71cP5ukdDURRqN/fY5T9Qk3VFaI8WwlPUeYGZ1eptjoxNbgDXQdIJ7lAPL/ko8p/p4Or2BdbT0/wEVxQbc+/YiPQy1lev2gfPI915IxZ433GPyT0xRrb95W0hmw/NhrUE+oFKKNQETIoT3wVA0KVpr1jn6gbIECYdOdJ7GDk5uG+j17qnpaDaMjNcs/VzUTAddcn9hifg4BjzS5Ep73L4eDwCeDTNIhd0U8zNCQMVgCC1S5HfjkfvtTZb98VdU/4vECZ2gl063i05kJ6PINXbGlueUaeOCm99uk8HfjlWngtLjbLWg/Syep1/+Zqpi1UsO4hz3VSahq+xWJACRbpR5M710SlVr2H8zS9OVREMYPml0j/bjp289W6y5gMhVX4w7a/K66yX3TSZCtMmQ
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715D810D98D06B for cygwin-patches@cygwin.com; Mon, 12 Oct 2026 20:55:02 +0100
Message-ID: <8120d2e7-b3ef-4ca1-8b39-ee4cbe400945@dronecode.org.uk>
Date: Mon, 12 Oct 2026 20:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Rename orphan __progname variable
References: <20261012090437.1672-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20261012090437.1672-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/10/2026 10:04, Mark Geisert wrote:
> The last remaining occurrence of '__progname' in dcrt0.cc was missed
> when they were being renamed to 'program_invocation_short_name'.  I
> discovered this when doing my first "#define DEBUGGING" Cygwin build.
> 
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: b2476bc (Cygwin: globals: make __progname an alias of
> program_invocation_short_name)
> 
> ---
>   winsup/cygwin/dcrt0.cc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index e7a837673..7fe8f26ac 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -968,7 +968,7 @@ dll_crt0_1 (void *)
>     /* Disable case-insensitive globbing */
>     ignore_case_with_glob = false;
>   
> -  cygbench (__progname);
> +  cygbench (program_invocation_short_name);
>   
>     ld_preload ();
>     /* Per POSIX set the default application locale back to "C". */

Thanks! Please apply.

I noticed that __progname is also (still?) used in 
cygwin/libc/bsdlib.cc. Is there something wrong there, or is that 
expected to be independent?


