Return-Path: <SRS0=41cp=IK=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 242E348FEF6F
	for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2026 05:58:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 242E348FEF6F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 242E348FEF6F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792475886; cv=none;
	b=n57wFfC/fRr+RBhB5BdJGi2yD5GElAr+esZ0YFWdCYIoo8vEINClIhb+uqNkGZ3smsQpwm9Ndc9UdZnc3MNTr4RKR8h+M31Qe4B+d07gIaYcgiPS2yae7DAC8VNraexXSBSeFNnwfTJObXWSsyqrpDJmwMgQAdxKhqCAgods6mA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792475886; c=relaxed/simple;
	bh=63kf/NH6YA9B+pjg76iu6eWtmxB92RbyELxp8FL36jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=aL47L5E2avFC/X5GBCv1SDJtim5uui8sgX06nYJPpBniX5qJfPFmYcQkUamg4fKYCeKF8XXzgCuL8pN7EENq8QoGTM3kIVUiqR9e74LDSuiqh0ymb3AheqHJ5iu73mfk+zhKOxD0hz0FY6W0JSnBk3v/HYWIqSVAQn6Nw7vKt6g=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 242E348FEF6F
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 69K6BWdU035340
	for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2026 23:11:32 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-253-193.fiber.dynamic.sonic.net(50.1.253.193), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdEHDRaB; Mon Oct 19 23:11:24 2026
Message-ID: <4ea10e55-303c-41d6-b180-eb3e7fdcc537@maxrnd.com>
Date: Mon, 19 Oct 2026 22:58:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pthread_once: Use acquire semantics to load state
To: cygwin-patches@cygwin.com
References: <AS4PR02MB79026AB40766FA0DF695E28D83982@AS4PR02MB7902.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <AS4PR02MB79026AB40766FA0DF695E28D83982@AS4PR02MB7902.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello Luca,

On 10/19/2026 10:32 AM, luca.bacci@outlook.com wrote:
> This ensures proper ordering.
> ---
>   winsup/cygwin/thread.cc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index 4df13221e..96a84596b 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -2104,7 +2104,8 @@ pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
>     const int32_t  DESTROYED = 0x40000000;
>     static_assert (sizeof (once_control->state) >= sizeof (int32_t));
>     static_assert (sizeof (once_control->state) == sizeof (LONG));
> -  if (once_control->state & DONE)
> +
> +  if (__atomic_load_n (&once_control->state, __ATOMIC_ACQUIRE) & DONE)
>       return 0;
>   
>     /* The type of &once_control->state is int *, which is compatible with

Thanks for the patch.  Is this to solve a particular error that you've 
run into, or is it the result of code inspection?  Either is OK, but the 
answer helps us decide what priority to give the report, and whether 
more code needs to be audited to find similar issues.

..mark
