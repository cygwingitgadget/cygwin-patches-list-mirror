Return-Path: <SRS0=2Jel=YC=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id 4419F3858D20
	for <cygwin-patches@cygwin.com>; Sun, 18 May 2025 15:36:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4419F3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4419F3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747582581; cv=none;
	b=a9RRDrX3cWzYKY13QbsOlsKSeEoR4TwaIvxmG+dXDfBnvXrUThvvWm6Spe9DDsBb/Ht4/PVXmKWSSR54XxkU2uGSngneicGAPVUyiY/JfAtXsdbqtZ5aIIMjG6VjPCfKSnM+YGPkTMRDb9Y90k7xfD84QInnnC7MIxRB1BOlroE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747582581; c=relaxed/simple;
	bh=DDsxrBtElacRvDAQ6Xvkdul9RS3ytVS7vs5lVaIidDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=RjqUZMfoNUCF0Br7vE5Abkue7Gq8GA6XkGdpKKFn/DwCiwWfCx8y/+Eh0ijgr0A2PeefPUDTIOJr6Gh2JVZr4yJ/rA2u3L+no0uz7L1uARcNq4Cv944ZMiSITSiMmZIbTGk3njg01p4p14r0O07phki8I3FqN4OwK/X0tQQiZL4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4419F3858D20
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CAE06F19F29
X-Originating-IP: [81.129.146.154]
X-OWM-Source-IP: 81.129.146.154
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudekkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkedurdduvdelrddugeeirdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekuddruddvledrudegiedrudehgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudehgedrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtgedpnhgspghrtghpthhtohepvddprhgt
	phhtthhopeevhhhrihhsthhirghnrdfhrhgrnhhkvgesthdqohhnlhhinhgvrdguvgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.129.146.154) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE06F19F29; Sun, 18 May 2025 16:36:19 +0100
Message-ID: <a8d4f37b-0ad4-4b7d-af6b-31c3b02e97de@dronecode.org.uk>
Date: Sun, 18 May 2025 16:36:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Only return true from try_to_debug() if we
 launched a JIT debugger
To: Christian Franke <Christian.Franke@t-online.de>
References: <20250517140054.1826-1-jon.turney@dronecode.org.uk>
 <20250518151159.cb5a58b59f66bf90efa93826@nifty.ne.jp>
 <72825f8a-1e48-6647-d1a9-c1bc09b79a52@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <72825f8a-1e48-6647-d1a9-c1bc09b79a52@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 18/05/2025 14:32, Christian Franke wrote:
> Takashi Yano wrote:
>> On Sat, 17 May 2025 15:00:53 +0100
>> Jon Turney wrote:
>>
>>> This fixes constantly replaying the exception if we have a segfault
>>> while a debugger is already attached, e.g. stracing a segv, see:
>>>
>>> https://cygwin.com/pipermail/cygwin/2025-May/258144.html
>>>
>>> (I'm tempted to remove the 'debugging' static from exception::handle()
>>> and everything associated with it, since replaying the exception the
>>> next half a million times it's hit seems really weird)
>>>
>>> (This would seem to make try_to_debug() less useful, as it then does
>>> nothing if you're just run under gdb, but it's what the code used to
>>> do...)
>> ...
>>
>> Otherwise, LGTM. Please push.
>>
> 
> The patch fixes the problem. The infinite loop does not longer occur. If 
> a signal handler is present, it works again if run from strace. Same if 
> run from gdb.

Thanks very much for testing!

