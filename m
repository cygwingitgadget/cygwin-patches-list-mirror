Return-Path: <SRS0=mYwE=XT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.146])
	by sourceware.org (Postfix) with ESMTP id 3741F3858D21
	for <cygwin-patches@cygwin.com>; Sat,  3 May 2025 11:09:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3741F3858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3741F3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.146
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746270563; cv=none;
	b=frRB/KGx/cPS1xWzDMHhah1ifTicXRidRRqkXrU6xwt8Af3km6/6WJHBefWynnON+tjqOVrNa7e6UcIKjEijb4AdnDoy50lDGwrcMEbGe2ZKcRls6/QGSDIRJ7p5mSCZtRTvzf8sjSobdD0ZQBCBVsc9sszp7ZKBbdaLjeDPEGk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746270563; c=relaxed/simple;
	bh=b+YPxWbfDg6T8xMt0S8l9lg+2Wu8wcVcW31Jiicu+1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=oYSRIXZ0TVzfZFs/pYaYGpSgk0ZCoEnmf3DLKrTl5Di27Qr9MKxCpH/I+mevD4p/4kgriAyRyoq07J/5vHpWUKn7i9a2lGr1h2ZXSix82FPrZVTJBZjD0RIXdU7cwG4H59ZUb+Kzom9ZUas5uBxBZCO2A/ZjpuazvbPDKl1237w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3741F3858D21
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89C38056637EB
X-Originating-IP: [86.140.194.111]
X-OWM-Source-IP: 86.140.194.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeehudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleegrdduuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelgedrudduuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelgedqudduuddrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtvddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohep
	tgihghifihhnsehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.194.111) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89C38056637EB; Sat, 3 May 2025 12:09:19 +0100
Message-ID: <4c633aaa-eb33-42ed-a1e5-f75f58af85be@dronecode.org.uk>
Date: Sat, 3 May 2025 12:09:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: docs: flesh out docs for cygwin_conv_path.
To: Jeremy Drake <cygwin@jdrake.com>
References: <cb20f137-46cb-eab9-27e9-ca098d1364e5@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <cb20f137-46cb-eab9-27e9-ca098d1364e5@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 01/05/2025 20:28, Jeremy Drake via Cygwin-patches wrote:
> Explicitly specify that `from` and `to` are NUL-terminated strings, that
> NULL is permitted in `to` when `size` is 0, and that `to` is not
> written to in the event of an error (unless it was a fault while writing
> to `to`).

That's great, thanks.

Please apply.

