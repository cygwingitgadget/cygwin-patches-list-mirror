Return-Path: <SRS0=tBSv=37=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.133])
	by sourceware.org (Postfix) with ESMTP id 96F3C3858424
	for <cygwin-patches@cygwin.com>; Sat, 20 Sep 2025 16:19:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 96F3C3858424
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 96F3C3858424
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.133
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758385199; cv=none;
	b=KFHeh35FZ3hmTKhmvMkWogeLaWzkTYya8EIKDpkzctN/WXMXDG0ftrqKioK1N8WwMRtdSEP6GYee7dvCXMkyOkdqErV8mfYVe1KjLoCaWQgWzE6kX8/Azq4/my3e+Dyzb28c+X9EVaURIN03/Yo+mwKUpWKCZYYEEwMqcAt6TDo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758385199; c=relaxed/simple;
	bh=cMMuySG73TdoIDe4TPl/92StqrACdK97Hu/8JtSTJ2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=cdAf3fSJN9o5krQGFN60BYNFDVsO2P4OIEVaVFbn3T5QqnI6A52TLZ/8DIZs1HUOGbnryJZy6xFOqEU3tLq9dAF9DmrmFWGJQHU2UEizAlap95eqK2EolyD7QZNMf3AWMzEl0KsOgq5+UaEvcxRXubyuFFFlD0ppHOPBW/wNZnM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 96F3C3858424
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1DF700603039
X-Originating-IP: [86.144.41.51]
X-OWM-Source-IP: 86.144.41.51
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehvdehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefhffgveekveffjeffjeegteeigeehhfeigfelieegteeutdffheffleejheefudenucfkphepkeeirddugeegrdeguddrhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeggedrgedurdehuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeggedqgeduqdehuddrrhgrnhhgvgekiedqudeggedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddutddpnhgspghrtghpthhtohepfedprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhn
	rdgtohhmpdhrtghpthhtoheptgihghifihhnsehjughrrghkvgdrtghomhdprhgtphhtthhopehthhhirhhumhgrlhgrihdrnhgrghgrlhhinhhgrghmsehmuhhlthhitghorhgvfigrrhgvihhntgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.41.51) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1DF700603039; Sat, 20 Sep 2025 17:19:52 +0100
Message-ID: <040f4e8d-3fd8-4c61-b0bc-8a8d3683785f@dronecode.org.uk>
Date: Sat, 20 Sep 2025 17:19:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
To: Jeremy Drake <cygwin@jdrake.com>,
 Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Newsgroups: gmane.os.cygwin.patches
References: <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
In-Reply-To: <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/08/2025 18:33, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 5 Aug 2025, Thirumalai Nagalingam wrote:
> 
>> Hi all,
>>
>> This patch adds support for the `fsqrt` instruction on AArch64 platforms
>> in the `__FLT_ABI(sqrt)` implementation.
> 
> This looks OK as far as it goes, but I have a few thoughts.
> 
> From the comments, it appears this code originally came from mingw-w64.
> Their current version of this code has aarch64 implementations.  The
> difference with this one is they have a version for float as well as
> double.  The versions here seem to only be used for long double (which on
> aarch64 is the same as double).
> 
> Given that long double is the same as double on aarch64, might it make
> sense to redirect/alias the long double names to the double
> implementations in the def file (cygwin.din) on aarch64, rather than
> providing two different implementations (one in newlib for double and one
> in this cygwin/math directory for long double)?  It seems like that's
> asking for subtle discrepancies between the implementations.  I'm not
> seeing any obvious preprocesor-like operations in gendef (mingw-w64 uses
> cpp to preprocess .def.in => .def files for arch-specific #ifdefs) so
> maybe this would be more complicated.

Sorry about the long delay looking into this.

So, I was about to apply Thiru's v2 patch, since that all seems 
reasonable to me. But now I'm not so sure...

I think that a good goal is to keep this file aligned with the mingw-w64 
version, if possible.

If I'm understanding correctly, if we do that, this problem goes away, 
but at the cost that fsqrtd and fsqrtl are potentially different 
(although surely since it all boils down to a single instruction, that's 
never going to happen :) )?

