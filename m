Return-Path: <SRS0=TXtc=XR=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.92])
	by sourceware.org (Postfix) with ESMTP id 55C9F3858405
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 11:48:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 55C9F3858405
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 55C9F3858405
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.92
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746100124; cv=none;
	b=ShSi5hdNbHYKMrkxCX0iVvBA/TyQMPzpEmLXM3+MZqj3RrXhWadia/t0kGBGtnvPOOSa9XWmdxOSrpw7RGakGRBjfIyz7QT7FDpA2lELFjHo+JCOLeOXo/u3wAY+G2xBbxxKKYq1ilXve/f+tob3aXXNgUMtJEA1mcv+Kp5Rhow=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746100124; c=relaxed/simple;
	bh=91bgcly6uofoHOtwA0GfGNHdBmpkBkNk3Nt1krSY2QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=nm3GURALy8P2i1T1bOc1Mq3TBkgC9r9Pd8cUupMvdt7C/WwW6jv9QnZyCGlpcF41rYEV49Oje3k/lhPUNcJww8+3nZ3a8J/4aZPHEwaPNPXVHdYbZVOSXmFcM4ixPsxY1WLhAuuuRQOVGp4dogs+LqPgNeXEK8cNKTkCTEfV0KQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 55C9F3858405
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E4E0533A825
X-Originating-IP: [86.140.194.111]
X-OWM-Source-IP: 86.140.194.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieelhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthekredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheegjeektddutdelvdegjeetfefgueetfffgkefggeejffejteegueejiedvhedunecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucfkphepkeeirddugedtrdduleegrdduuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelgedrudduuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelgedqudduuddrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotdduuddpnhgspghrtghpthhtohep
	vddprhgtphhtthhopeevhhhrihhsthhirghnrdfhrhgrnhhkvgesthdqohhnlhhinhgvrdguvgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.194.111) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E4E0533A825; Thu, 1 May 2025 12:48:42 +0100
Message-ID: <916eb947-c497-4485-b230-50a67c4e8b91@dronecode.org.uk>
Date: Thu, 1 May 2025 12:48:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: clock_settime: fail with EINVAL if tv_nsec is
 negative
To: Christian Franke <Christian.Franke@t-online.de>
References: <f21927b5-defe-529d-3095-0c1f51e23eb7@t-online.de>
 <274da5b5-b94c-4ccc-8b58-713965a62e93@dronecode.org.uk>
 <09edeb3e-6c0c-74bb-75df-a7dd2bde2e5e@t-online.de>
 <9e95644c-c152-00ed-14d1-725252066fa6@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <9e95644c-c152-00ed-14d1-725252066fa6@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 30/04/2025 12:33, Christian Franke wrote:
> Christian Franke wrote:
>> Jon Turney wrote:
>>> On 28/04/2025 16:43, Christian Franke wrote:
>>>> A followup to:
>>>> https://sourceware.org/pipermail/cygwin-patches/2025q2/013678.html
>>>
>>> Thanks!
>>>
>>> The SUS page for clock_settime() contains the following text:
>>>
>>>> [EINVAL]
>>>>     The tp argument specified a nanosecond value less than zero or 
>>>> greater than or equal to 1000 million. 
>>>
>>> ... so if we're going to validate tv_nsec, it seems that's the range 
>>> to use
>>>
>>>
>>
>> Yes. The patch only checks the lower bound because the upper bound is 
>> already correctly checked later in settimeofday().

This is just prompts me to further questions: Is settimeofday() 
specified to permit some kinds of non-normalized values?

> ... and pushed.

Thanks!

