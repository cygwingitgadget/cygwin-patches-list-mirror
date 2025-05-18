Return-Path: <SRS0=2Jel=YC=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id B70DB3858D20
	for <cygwin-patches@cygwin.com>; Sun, 18 May 2025 15:33:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B70DB3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B70DB3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747582415; cv=none;
	b=ITiIKLKsMN0zUttUxxpF3UKZXcS+44RTpwm/hcUfHS0aL6UCellttn7fOeGeEmawdmvJASrp64ONjtNmd7QEF764nvkjxIAG1p+a3HIkmONsgifN0bur2bVUC7R5wbZcNHwwlBRaSndCCZhFBRbR25l957RhY5yshgOh/MiqXdQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747582415; c=relaxed/simple;
	bh=8kqgu+ye/a/pGtZiR6bcR5lxOy3aSSlbKGbOBf58RlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=JEk0nQz6OuzcBES/M+eJ/HqyAdIzCH2MhCNBaHrQT1bERLWncgmlNdKXjwVf6HWR/wC33SaWbjUBE4WVv/yy2oV5nBr+VbcDeHa5DH5IGIC6BiyzrMLL/P6rRzkGCslLga27sx8sxcjbT1JC2H3hrUZsc7o6rKMZjfwhWtDq744=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B70DB3858D20
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CDB06F27172
X-Originating-IP: [81.129.146.154]
X-OWM-Source-IP: 81.129.146.154
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudekkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkedurdduvdelrddugeeirdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekuddruddvledrudegiedrudehgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudehgedrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddthedpnhgspghrtghpthhtohepvddprhgt
	phhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepthgrkhgrshhhihdrhigrnhhosehnihhfthihrdhnvgdrjhhp
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.129.146.154) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CDB06F27172; Sun, 18 May 2025 16:33:26 +0100
Message-ID: <86b5c051-1c23-44a6-9a57-5cf552b2b2b2@dronecode.org.uk>
Date: Sun, 18 May 2025 16:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Only return true from try_to_debug() if we
 launched a JIT debugger
To: Takashi Yano <takashi.yano@nifty.ne.jp>
References: <20250517140054.1826-1-jon.turney@dronecode.org.uk>
 <20250518151159.cb5a58b59f66bf90efa93826@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20250518151159.cb5a58b59f66bf90efa93826@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 18/05/2025 07:11, Takashi Yano wrote:
> On Sat, 17 May 2025 15:00:53 +0100
> Jon Turney wrote:
> 
>> This fixes constantly replaying the exception if we have a segfault
>> while a debugger is already attached, e.g. stracing a segv, see:
>>
>> https://cygwin.com/pipermail/cygwin/2025-May/258144.html
>>
>> (I'm tempted to remove the 'debugging' static from exception::handle()
>> and everything associated with it, since replaying the exception the
>> next half a million times it's hit seems really weird)

I adjusted the wording of this.

>> (This would seem to make try_to_debug() less useful, as it then does
>> nothing if you're just run under gdb, but it's what the code used to
>> do...)

This is me struggling to articulate that the first chunk is overkill.

When call stack looks like:

api_fatal
api_fatal_debug
try_to_debug

We probably want to break_here() when we were started under a debugger 
(e.g. gdb)

(This is something I added in an attempt to be helpful in aa822482).

> I don't understand what the sentences in ()s mean.

Clarified, hopefully.

>> Fixes: 91457377d6c9 ("Cygwin: Make 'ulimit -c' control writing a coredump")
> 
> Please add "Signed-off-by:". I also think it is better to add
> "Reported-by:".

Done.

[...]
> Otherwise, LGTM. Please push.
Thanks.

I dropped the first chunk for the reasons above.

I also updated 3.6.2 release note.

