Return-Path: <SRS0=mYwE=XT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.168])
	by sourceware.org (Postfix) with ESMTP id E72F53858D21
	for <cygwin-patches@cygwin.com>; Sat,  3 May 2025 11:20:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E72F53858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E72F53858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.168
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746271232; cv=none;
	b=XWIsK0BN1A6JGYp0k9yGVUru+s0OMT8JBDEMQU7lB2zBXUTkAOW/YTKs7J7qSRbHocK1TIP7verOuAlNEoOvU9LlIcwisj3V7FzddchlHUA0cMEyH6NBcitziyNLejnUpgj1/ZRYDRW8ktJaXv6oy2pNLw00sAg/GAvTw03EpN0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746271232; c=relaxed/simple;
	bh=LBSGdX9QI+63jEylzUfkX2rri9Vk4mWiEIp67DwdIy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=WwRLUAOjEqyURNIS3vujK5FZ4rI6uk+wf4BUGQmAV7z7fMHN+Z/qUSuaU011IVSK2s5E9507On9pmK3cyR5q+pfFrx9ZESSOuzXnx83gL+a2VFikOxzUuElRgYXM0qrQFq5uk07P78xUBNtLI8Vx1HEfoQn8kiSnCnfGjApCkTs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E72F53858D21
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89D5C0561648B
X-Originating-IP: [86.140.194.111]
X-OWM-Source-IP: 86.140.194.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeehvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleegrdduuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelgedrudduuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelgedqudduuddrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtjedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohep
	tgihghifihhnsehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.194.111) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89D5C0561648B; Sat, 3 May 2025 12:20:29 +0100
Message-ID: <132c2355-a302-45df-8b12-a6da8bb99b10@dronecode.org.uk>
Date: Sat, 3 May 2025 12:20:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: CI: Add running on arm64 to stress test matrix
To: Jeremy Drake <cygwin@jdrake.com>
References: <20250427210504.1962-1-jon.turney@dronecode.org.uk>
 <2fd01fbc-e56a-e01d-a93e-6872bbe4a9ea@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <2fd01fbc-e56a-e01d-a93e-6872bbe4a9ea@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 27/04/2025 22:20, Jeremy Drake via Cygwin-patches wrote:
> On Sun, 27 Apr 2025, Jon Turney wrote:
> 
>> Use an output variable from cygwin-install-action to inform where we
>> unpack the just-built cygwin artifact, because apparently the Windows
>> ARM64 runners have a different configuration (no D: drive).
> 
> There's actually an issue open about that - apparently the VMs do have the
> faster drive virtual hardware used as D: on the other Windows runners, but
> it's not formatted or mounted on these new runners.

Good to know.

Well, not hard coding it here seems like the right thing in any case. :)

cygwin-install-action falls back to C: if D: doesn't seem to exist, so 
this should all start doing the "right thing" when it does...

