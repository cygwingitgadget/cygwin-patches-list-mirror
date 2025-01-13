Return-Path: <SRS0=P5gk=UF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id BA9D93858D21
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 17:21:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BA9D93858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BA9D93858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736788900; cv=none;
	b=ngSjYQrlUcwx8rT0gjq1RzTfF9Dp9OnfsnanvW3QApNCPgQqVqtb8T1RbkMovL30gsa8EE8XRqPx9dkvjaBMEbnI7Qj+52K1tNdK2vWVMO2hLNA0A5BAIdHJ1uA3v87Q3G0xX3Lwu/qJpfPXzO0pj6Av7Wqn2IORT/oA7D+f3lg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736788900; c=relaxed/simple;
	bh=P0wge4mQK90d5fu0kaCuGQZf2KfCWQFxWskLr3FkG20=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=ao50rDgW8eRK7p1VgCMYgEzpF4OHQQ6kThtOsOdeImZNs4O/BG1ghN6MWliUo52ul7jjfYwWLPZfbOozdgMRTWiM3K5dKPb5fs0gNm94qg2xm8KHjNDqmMcoUaAFaWwX1zzmaNZZFjPHCww7cxQ6ff4v9cc9mRmdkNeTe719VSU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA9D93858D21
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901EE04D96354
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudegtddrudelfedrfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelfedrfeegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqdefgedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddthedpnhgspghrtghpthhtohepvddprhgtphhtthhopeeurhhirghnrdfknhhglhhishesufihshhtvghm
	rghtihgtufghrdgrsgdrtggrpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901EE04D96354; Mon, 13 Jan 2025 17:21:32 +0000
Message-ID: <eca99827-0dd7-433d-8a9a-44df54049d20@dronecode.org.uk>
Date: Mon, 13 Jan 2025 17:21:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <1a354471c155501dd2d0abfbc195e8be3e9c0fa2.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <5bde1928-7d96-482e-88ac-0cbb081f5a54@dronecode.org.uk>
 <e75a46b8-3f7e-4049-83c1-89a21b00fef1@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <e75a46b8-3f7e-4049-83c1-89a21b00fef1@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/01/2025 19:56, Brian Inglis wrote:
> On 2025-01-12 10:58, Jon Turney wrote:
>> On 11/01/2025 00:01, Brian Inglis wrote:
>>> Add POSIX new additions available with din entries
>>> or interfaces in headers and packages.
>>
>> What does 'din' mean in this context?
> 
> POSIX entries which exist as exported symbols in cygwin.din but not 
> mentioned elsewhere in posix.xml, so supported but not yet documented as 
> any Unix interface.

Uh? what?

How are these different to any of the existing interfaces (which aren't 
annotated in any way)?

