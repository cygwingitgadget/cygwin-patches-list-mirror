Return-Path: <SRS0=41cp=IK=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 806FE48FEF75
	for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2026 05:57:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 806FE48FEF75
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 806FE48FEF75
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792475846; cv=none;
	b=Yv1c1UvTisrWwRRQtlJo3/5AAqcQCsRtzxqlc0dlkxAw+BQH+DVrrqKSFkA76e4rH24myVnlqydHywmvFsOVuY24O+HFJ+bIJFmcnpkTyub9Y6Wq93nLbJ4jTJUPti2q6dtEd8qtLPWvN1odXGjjhtlJta+FiyQZH4VYDusc64c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792475846; c=relaxed/simple;
	bh=vddxFjV/E8cms0zcxaLwevhljaVh6DRCRXaHvofnakE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=W/ByhqqvdZMw8az99mv+40jwv68W2I0tZNXTcJRkXWO+VVhp/o/D6+Oq9J9+JlCgyBca4cz2oe7zViMB17m9hOfAI9th6p5hz3nTaZQX/ldNV5Fi0qb5mubrDtYQfiKdR57l0zl+tmZnIbbCU9aFo/EJvHdYJ+dQIh8L8L324Ns=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 806FE48FEF75
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 69K6Aqo1035319
	for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2026 23:10:52 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-253-193.fiber.dynamic.sonic.net(50.1.253.193), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdZtYU3O; Mon Oct 19 23:10:42 2026
Message-ID: <0a07ca07-5fa5-49bd-bec0-175cba6c7f61@maxrnd.com>
Date: Mon, 19 Oct 2026 22:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pthread_spinlock: Attempt exchange only when
 lock_counter is 0
To: cygwin-patches@cygwin.com
References: <20261019173209.2894-1-luca.bacci@outlook.com>
 <AS4PR02MB7902AB280F79F6D37805514D83982@AS4PR02MB7902.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <AS4PR02MB7902AB280F79F6D37805514D83982@AS4PR02MB7902.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_NUMSUBJECT,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello Luca,

On 10/19/2026 10:32 AM, luca.bacci@outlook.com wrote:
> Of course the value can change at any time, however the
> added check avoids continuous invalidation of cache lines.
> ---
>   winsup/cygwin/thread.cc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index 96a84596b..424fcc468 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -1984,7 +1984,8 @@ pthread_spinlock::lock ()
>   
>     do
>       {
> -      if (InterlockedExchange (&lock_counter, 1) == 0)
> +      LONG value = __atomic_load_n (&lock_counter, __ATOMIC_RELAXED);
> +      if (value == 0 && InterlockedExchange (&lock_counter, 1) == 0)
>   	{
>   	  set_owner (self);
>   	  result = 0;

Thanks for the patch.  Is this to solve a particular error that you've 
run into, or is it the result of code inspection?  Either is OK, but the 
answer helps us decide what priority to give the report, and whether 
more code needs to be audited to find similar issues.

..mark
