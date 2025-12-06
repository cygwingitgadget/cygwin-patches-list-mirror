Return-Path: <SRS0=R7Qm=6M=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id 4209B48F3CE6;
	Sat,  6 Dec 2025 11:56:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4209B48F3CE6
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4209B48F3CE6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765022186; cv=none;
	b=OeOeGRMzDwUeHs/B56VqbW7qi6TOUiHYZkaVJW5NeJzie1ZzzfDmW13j5e3jJ2wC77Q4zh09vHJBEcoJVece8DFGBcCjEH95lnGr8vK+usTEwLfweRjcPlsWa35x5xS5TekO5YO7hrW7Vg8/5rHXiMtfEOUvZCGIQyj1czvWO8I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765022186; c=relaxed/simple;
	bh=ov+s2Bk49g+deI7A5cmPUpTAjSVtkSes4y2timp9Jmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=g+UGI/GL/vC0fIod1ndeSO53Z0jsqpuWoneCGfgmXZZhPbParMQRyYMbIGUaNIoE/meFTUY2RdZpA5gDMurPOtc+4VX5UeJc2QSzzos11Gl5go5e2lhPoPsO+3wkSRNzfaYv42zMNAMJ3J8Klz8CV/ImQfLnX5uMGe0uQwDywm8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4209B48F3CE6
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1AB807FBD5F7
X-Originating-IP: [86.139.199.212]
X-OWM-Source-IP: 86.139.199.212
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudefledrudelledrvdduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddufeelrdduleelrddvuddvpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduleelqddvuddvrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttddvpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptghorhhinhhnrgdqtgihghifihhnsegthihgfihinhdrtghomhdprhgtphhtthhopegt
	hihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.139.199.212) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1AB807FBD5F7; Sat, 6 Dec 2025 11:56:24 +0000
Message-ID: <9f4ccea4-95c9-481d-93ca-9d1e5ae31de3@dronecode.org.uk>
Date: Sat, 6 Dec 2025 11:56:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Cygwin: newgrp(1): improve POSIX compatibility
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
References: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
 <20251205194200.4011206-2-corinna-cygwin@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20251205194200.4011206-2-corinna-cygwin@cygwin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 05/12/2025 19:41, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> - allow calling without argument
> - allow not only - but also -l to regenerate stock environment
> - allow numerical group IDs
> - do not advertise the ability to run an arbitrary command instead
>    of just starting a new shell
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>   winsup/utils/newgrp.c | 28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/winsup/utils/newgrp.c b/winsup/utils/newgrp.c
> index 414e8cdf8edc..da54637c57d2 100644
> --- a/winsup/utils/newgrp.c
> +++ b/winsup/utils/newgrp.c
> @@ -140,16 +140,16 @@ main (int argc, const char **argv)
>   
>     setlocale (LC_ALL, "");
>   
> -  if (argc < 2 || (argv[1][0] == '-' && argv[1][1]))
> -    {
> -      fprintf (stderr, "Usage: %s [-] [group] [command [args...]]\n",
> -	       program_invocation_short_name);
> -      return 1;
> -    }
> -
>     /* Check if we have to regenerate a stock environment */
> -  if (argv[1][0] == '-')
> +  if (argc > 1 && argv[1][0] == '-')
>       {
> +      if (argv[1][1] != '\0' && strcmp (argv[1], "-l") != 0)
> +	{
> +	  /* Do not advertise the ability to run an arbitrary command. */
> +	  fprintf (stderr, "Usage: %s [-] [group]\n",

Maybe '[-|-l]'?

> +		   program_invocation_short_name);
> +	  return 1;
> +	}
>         new_child_env = true;
>         --argc;
>         ++argv;
> @@ -165,8 +165,16 @@ main (int argc, const char **argv)
>       }
>     else
>       {
> -      gr = getgrnam (argv[1]);
> -      if (!gr)
> +      char *eptr;
> +
> +      if ((gr = getgrnam (argv[1])) != NULL)
> +	/*valid*/;
> +      else if (isdigit ((int) argv[1][0])
> +	       && (gid = strtoul (argv[1], &eptr, 10)) != ULONG_MAX
> +	       && *eptr == '\0'
> +	       && (gr = getgrgid (gid)) != NULL)

I spent a bit of time worrying how this handled edge cases like '' or 
'0', but I think it's all good!

> +	/*valid*/;
> +      else
>   	{
>   	  fprintf (stderr, "%s: group '%s' does not exist\n",
>   		   program_invocation_short_name, argv[1]);

