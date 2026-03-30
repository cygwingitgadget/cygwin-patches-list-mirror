Return-Path: <SRS0=6n7K=B6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.48])
	by sourceware.org (Postfix) with ESMTP id 74E9C4BA2E0A;
	Mon, 30 Mar 2026 20:29:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 74E9C4BA2E0A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 74E9C4BA2E0A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.48
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774902549; cv=none;
	b=DEXV1P8qXrvK5PMVUMwCeFkc5SryYIV0Cggk1PzelOpVyirJwMlsVx+UxY13bpN/OdTpyD2FZrZ+OFewJ4KPZxi3Tk1VQKeTK+rtV05dfNdgkTYL1Of/mXWQG0fOSGDS2R18Np7zhVheoiG3jOzTrvC3CPQDZHsHib468qjHm5w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774902549; c=relaxed/simple;
	bh=h+oNt6Jq8Ex1ZmTQaFPwKDNcs/i1mLEDT+sY4a0uedE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=F9Ff1LbxubYR0Ve4iRDvBM/sMcQOwsjVbHR7SGSarbOkcwBqQCCFv/w7ToLBQvCmOocoyv7ujuuioWXUGhfehbpJnAUefEVHXFIrrv5ZXqwi36PkJwdBRKdun9sE/lt0RXjMN2iZkLh8pUs7bIxsQXip2JIqxaBsUM+di4yfYCk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 74E9C4BA2E0A
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69AF652F01FCF2E5
X-Originating-IP: [62.49.245.144]
X-OWM-Source-IP: 62.49.245.144
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFvHhhX12zzbU1dWQgpLqYb/FCM4UECWqnLfnNl3QHAXtMT0TyOwUR96XIjYaaeW0hVwVKmCSr6hH4yXdob6IUtsYvy8yC5/MR0HUJ6QZaNkqOC9gFGKtS3qNNUlclgMIUoANpUcPZb+H7ifr7na0MppY7LqmXz5Xd8rlaw1CgFEgCWcEmg6IZpqmJKx89ksBpR+9nIF8IqPrQIYqCmXt77U0NYS7fwKl1OLCeJeYPK8MQ0nm+CTQtXKGs4aAe8pFSnDExjSwaR6CRsz8lyY89CMaHSZUKlsCG7qn/UvXjvYcetA91TlO4Q0NNPY+oxrSp/Ue7a5LqHh5h0JU4Zob4Gczw+FfgietK0it6gy2d0SqbUdtIE/FobC6eT9FSERybs2j+AGCX3F1xIU3a+AFrLLP1CXv8p50NQpZ7Rpq4B0KWw5C1YuhTDakwFoH+cEn9JW4F8DRfVwyePFuaMmJA0uS/QSGoKg5I4cKJmp19Vim4Lk36x+51+I4biy7zHNoyypGSM9S5h6i5iI5JbqjHZq85nK+wOYOMRzeIL+xex2n/wcRcJxhdX/rq2evGfXjmS9ZmvPdI2lDsDc3YR3/BxoH/gapvG7KOayTK6yHbDphfnfbod+vN9BFo+J9QcoL/pxk7roAp/xdkX7+Z7Kka3tq4WCB+Stw6bukGicHQ8eA
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.245.144) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69AF652F01FCF2E5; Mon, 30 Mar 2026 21:29:03 +0100
Message-ID: <bd7fc7cf-ac28-44b4-b1e8-bb22641f1962@dronecode.org.uk>
Date: Mon, 30 Mar 2026 21:29:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: add _Fork() system call per POSIX.1-2024
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
References: <20260330144113.1636278-1-corinna-cygwin@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260330144113.1636278-1-corinna-cygwin@cygwin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 30/03/2026 15:41, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> The _Fork() function shall be equivalent to fork(), except that fork
> handlers established by means of the pthread_atfork() function shall
> not be called and _Fork() shall be async-signal-safe.  Our fork()
> already is async-signal-safe, so just make sure the pthread_atfork()
> handlers are not called.

Nice.

[...]
> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> index 48e8b7557d00..82ad3aaf0899 100644
> --- a/winsup/cygwin/fork.cc
> +++ b/winsup/cygwin/fork.cc
> @@ -31,7 +31,7 @@ details. */
>   /* FIXME: Once things stabilize, bump up to a few minutes.  */
>   #define FORK_WAIT_TIMEOUT (300 * 1000)     /* 300 seconds */
>   
> -static int dofork (void **proc, bool *with_forkables);
> +static int dofork (void **proc, bool is__Fork, bool *with_forkables);

This looks fine.

Maybe the new parameter should be named to indicate what extra step it 
enables, rather than what API we're executing? (So, like, 
do_atfork_handlers or something? Or maybe that's less clear)


If you have a STC you used to test this you want to share, maybe I can 
look at adding that to testsuite.

