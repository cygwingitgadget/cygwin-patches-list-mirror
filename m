Return-Path: <SRS0=mYwE=XT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.131])
	by sourceware.org (Postfix) with ESMTP id E47193858C78
	for <cygwin-patches@cygwin.com>; Sat,  3 May 2025 15:53:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E47193858C78
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E47193858C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746287598; cv=none;
	b=IHjudIxGXoUk5TJWGkYKi32sJlsIZgXLilRwdLSRtbsECmT+eyfZ7C/OU3k9bWSQgbUHwBkFn21A4PlbSQ0sgSDpu6l3o3O2V10fv0NZ3Ek1n9z8QifIxXamaf5eshbdb3LjSuIyNHalhyEL5RH9SanyJ4xHWqyxswXf6jxjOxA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746287598; c=relaxed/simple;
	bh=3dynd99N8qMSOjGO+hQU6V8Vj+A7AvG59M4suBolYJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=lhDklETAZDmJqlLnifi061mZD3RnT+l8doztUJjFoeVqtSHRi9WgzlXHfFMUHt+4XPhMKldZcwWqfBffyT/dVcABfxSJEINcKa1wY4SGBMtFso2UBFOiz9IB1y5fgRXOTLv6jREFAKmUZ3iplCQTPEIlQ7+Lg2fYyefp9TDJxW8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E47193858C78
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89BE205730EEF
X-Originating-IP: [86.140.194.111]
X-OWM-Source-IP: 86.140.194.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeehjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleegrdduuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelgedrudduuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelgedqudduuddrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtuddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohep
	tgihghifihhnsehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.194.111) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89BE205730EEF; Sat, 3 May 2025 16:53:15 +0100
Message-ID: <b4b2785c-8463-4d96-98ef-cc868cf728ba@dronecode.org.uk>
Date: Sat, 3 May 2025 16:53:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: docs: flesh out docs for cygwin_conv_path.
To: Jeremy Drake <cygwin@jdrake.com>
References: <cb20f137-46cb-eab9-27e9-ca098d1364e5@jdrake.com>
 <4c633aaa-eb33-42ed-a1e5-f75f58af85be@dronecode.org.uk>
 <25dc048f-7e3a-a02c-35e9-29acf19bb68a@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <25dc048f-7e3a-a02c-35e9-29acf19bb68a@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 03/05/2025 16:39, Jeremy Drake via Cygwin-patches wrote:
> On Sat, 3 May 2025, Jon Turney wrote:
> 
>> On 01/05/2025 20:28, Jeremy Drake via Cygwin-patches wrote:
>>> Explicitly specify that `from` and `to` are NUL-terminated strings, that
>>> NULL is permitted in `to` when `size` is 0, and that `to` is not
>>> written to in the event of an error (unless it was a fault while writing
>>> to `to`).
>>
>> That's great, thanks.
>>
>> Please apply.
> 
> Oops, I missed a close tag that the GHA caught.  I applied this quick fix
> without pre-approval, hope that's ok.

That's fine.

I did think about applying your patch and trying to build the doc, but I 
decided to trust you :)

