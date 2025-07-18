Return-Path: <SRS0=pLV8=Z7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.133])
	by sourceware.org (Postfix) with ESMTP id E5397385840D
	for <cygwin-patches@cygwin.com>; Fri, 18 Jul 2025 10:17:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E5397385840D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E5397385840D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.133
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752833838; cv=none;
	b=VpOKendSL+8iBorJauFgDHdrlwRrQbYjVYjELFkq3TTMHc0qUXycW759icjUTAlVkqrxNvZQYhgnBFUN+uibiOE483SDSdfjRLwEoj8/Pl+ElPBp96rij6bz7+fc8eH37D/cRP0c+DjrQzgz7a53nf09Iag6QmaTgjPGmxUHaks=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752833838; c=relaxed/simple;
	bh=FX7SqIIvDhYZoojmPBWktNX9wgJqJ1uGRmNLsQ+KVZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=j6bIorNvfL4nK2ZwvtF9zWzy1a7qKWAb5bHmUWayEIV0MCxpRD4dMB28Ll2WVU1kYrA48tqmuEFNwiBNGoQLpRFFh3wZdsGuxqXz2xfcoVwDxQ4Br/bTGEr2UaXAV58VWn8ziH8FtVCoqay9sYSxfjBJ0sVWyPUJUKrB1/6SmRA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6864BE8A01B86446
X-Originating-IP: [86.139.156.85]
X-OWM-Source-IP: 86.139.156.85
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifedvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefggefhvddvieejtedtgfelteffteeftdeugfefveehtdehgfffleeftefhvdelffenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudefledrudehiedrkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudefledrudehiedrkeehpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheeiqdekhedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddutddpnhgspghrtghpthhtohepvddprhgtphhtthho
	pegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtoheprhgruggvkhdrsggrrhhtohhnsehmihgtrhhoshhofhhtrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.139.156.85) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6864BE8A01B86446; Fri, 18 Jul 2025 11:17:13 +0100
Message-ID: <6c146f2e-9479-409c-a538-e35c49a20a45@dronecode.org.uk>
Date: Fri, 18 Jul 2025 11:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: configure: add possibility to skip build of
 cygserver and utils
To: Radek Barton <radek.barton@microsoft.com>
References: <DB9PR83MB09232A0A1E4EC3D43BBAFA089242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923C35FB2253C8C2A21927C9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <52fd7877-6abc-4e01-8f3c-405cf075b1ff@dronecode.org.uk>
 <DB9PR83MB09237AD6BA4BFE16B03AEBD99256A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <DB9PR83MB09237AD6BA4BFE16B03AEBD99256A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 16/07/2025 20:37, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> I was going to submit `--disable-utils` as a separate patch but in the context adding the FAQ, it makes sense to include it to a single patch together.

Ah, I see.

This all seems good to me.

> ---
>  From f0240097f681335c6b2373f4a04685ee687bdeef Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Sat, 21 Jun 2025 22:56:58 +0200
> Subject: [PATCH v3] Cygwin: configure: add possibility to skip build of
>   cygserver and utils
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch adds configure options allowing to disable build of cygserver
> and Cygwin utilities. This is useful when one needs to build only
> cygwin1.dll and crt0.o with stage1 compiler that is not yet capable of
> linking executables as it is missing cygwin1.dll and crt0.o.
> 
[...]
>   
> +<para>
> +Build of <literal>cygserver</literal> can be skipped with
> +<literal>--disable-cygserver</literal> and build of other Cygwin utilities with
> +<literal>--disable-utils</literal>. This is particularly useful (together
> +with <literal>--without-cross-bootstrap</literal> and
> +<literal>--disable-dumper</literal> options) when only
> +<literal>cygwin1.dll</literal> and <literal>crt0.o</literal> are needed for
> +stage2 compiler when being built with stage1 compiler which does not support
> +linking executables yet (because of missing <literal>cygwin1.dll</literal> and
> +<literal>crt0.o</literal>).
> +</para>
> +
So, if it was me, I'd make the last sentence here a separate paragraph, 
which describes the result, not the change, e.g.

<para>
In combination, <literal>--disable-cygserver</literal>, 
<literal>--disable-dumper</literal>, <literal>--disable-utils</literal> 
and  <literal>--without-cross-bootstrap</literal> allow building of
just <literal>cygwin1.dll</literal> and <literal>crt0.o</literal> for
a stage2 compiler, when being built with stage1 compiler which does not 
support linking executables yet (because those files are missing).
</para>


Unrelated, but maybe the name of "--without-cross-bootstrap" should be 
changed? It's difficult to parse what it's saying "boostrapping, so 
without cross tools"?  And then there was that report that the logic was 
upside down or something?

[1] https://cygwin.com/pipermail/cygwin/2024-November/256763.html

