Return-Path: <SRS0=tdPk=6Q=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.0])
	by sourceware.org (Postfix) with ESMTP id 236AC4BA2E00
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 16:33:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 236AC4BA2E00
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 236AC4BA2E00
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.0
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765384436; cv=none;
	b=seSrcp232d19IIZG0IGw2v/9qzvzFx1zhRo3rI0uTS+RJh0T+/D/bHsFExqobsv1DtWOogt5sDF5xBjOThC6a16VwdoBpwvKnYeqb3GT1QZMecAUkh35CHS5dvFwopdvxe8PzySezO1/qXJajGUEEpy5dbjsc3mT1GlCKmx7RPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765384436; c=relaxed/simple;
	bh=BdupYTR5GTTybGOLU0vzqfUgv3m6IDjAjslFExa7hrE=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=imat+BbF/hhTrYMBAtFXz9MjxrYIk9Wr575Q0Qxm/twmoLIUze1knDiBy+JIE8tYWTtHi7ICzUd5RiRxcD+TiW9a02HwIETC+K3coVlX1BQI4n67KgnLHP7kO5BFB+xmjlXKcvdEmYqceMycTzcQ+E+0fLArJCdP7u2KaRjRcps=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 236AC4BA2E00
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1CA0086B5A29
X-Originating-IP: [81.158.20.216]
X-OWM-Source-IP: 81.158.20.216
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhepkfffgggfufhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepjeegjedttdfgueeuieffgeefhfeufffgieeuudekveeljeefheejtdetjeeigefgnecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecukfhppeekuddrudehkedrvddtrddvudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekuddrudehkedrvddtrddvudeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduheekqddvtddqvdduiedrrhgrnhhgvgekuddqudehkedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtiedpnhgspghrtghpthhtohepuddprhgt
	phhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (81.158.20.216) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1CA0086B5A29 for cygwin-patches@cygwin.com; Wed, 10 Dec 2025 16:33:54 +0000
Message-ID: <ef167d04-7b37-4c89-b0d9-c0264d2a9295@dronecode.org.uk>
Date: Wed, 10 Dec 2025 16:33:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Cygwin: newgrp(1): improve POSIX compatibility
References: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
 <20251205194200.4011206-2-corinna-cygwin@cygwin.com>
 <9f4ccea4-95c9-481d-93ca-9d1e5ae31de3@dronecode.org.uk>
 <aTf3BPKzr6ChHpdA@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <aTf3BPKzr6ChHpdA@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 09/12/2025 10:16, Corinna Vinschen wrote:
> On Dec  6 11:56, Jon Turney wrote:
>> On 05/12/2025 19:41, Corinna Vinschen wrote:
>>> +	  fprintf (stderr, "Usage: %s [-] [group]\n",
>>
>> Maybe '[-|-l]'?
> 
> The usage message is the same as used by the shadow-utils newgrp
> on Linux.  It supports -l, but doesn't print it for some reason.
> 
> If you think we should do it better, I can change our usage output
> and send a v2 patch, no worries.

I am ambivalent.

The most recent SUS text [1] actually redefines the behavior of '-' as 
"unspecified" so '-l' seems preferred.

(This seems to revolve around standardizing '-' to refer to stdin)

[1] https://pubs.opengroup.org/onlinepubs/9799919799/utilities/newgrp.html

> 
>>> +		   program_invocation_short_name);
>>> +	  return 1;
>>> +	}
>>>          new_child_env = true;
>>>          --argc;
>>>          ++argv;
>>> @@ -165,8 +165,16 @@ main (int argc, const char **argv)
>>>        }
>>>      else
>>>        {
>>> -      gr = getgrnam (argv[1]);
>>> -      if (!gr)
>>> +      char *eptr;
>>> +
>>> +      if ((gr = getgrnam (argv[1])) != NULL)
>>> +	/*valid*/;
>>> +      else if (isdigit ((int) argv[1][0])
>>> +	       && (gid = strtoul (argv[1], &eptr, 10)) != ULONG_MAX
>>> +	       && *eptr == '\0'
>>> +	       && (gr = getgrgid (gid)) != NULL)
>>
>> I spent a bit of time worrying how this handled edge cases like '' or '0',
>> but I think it's all good!
> 
> Thanks for checking!

No problem!

