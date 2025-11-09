Return-Path: <SRS0=n1w5=5R=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id A74063858D33
	for <cygwin-patches@cygwin.com>; Sun,  9 Nov 2025 16:30:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A74063858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A74063858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762705825; cv=none;
	b=GPTlmvNLygF/twwnyxhBu2p2alHqoCarRmVGqPgeqZ2Sqmn/jWiQcflxwdTGIgP67eNLyTqWAYUWJ+ssaE51/A45y/9VbdQbnZuhWxyVWiH2c3eC4K7FC8HsN5Hal+ZiDfzfybpgEtWfII1HeCnNrSuOqKsmIgovgUEfeFoLioI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762705825; c=relaxed/simple;
	bh=yfjsTGnRJFVlEhe2IJ2qXniMXk3e8o+kmagzbG5j2aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=k6f260vEDUC5SaCKdrPrQ0NWPu4xTHGfDMCblEUeIi1bDjPgD1YczF4smF9S+DvO2jkirbPnMTgMstu+pBUdk1/kBEmb7wlEn20Zifj/u717aXQTK3e2J/TsrcVL+z8/IKcFK+u/QvPPNFmw3b48ZgY5XjhW9snDCiCoAmG24Mk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A74063858D33
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1C95053EECDF
X-Originating-IP: [81.158.20.254]
X-OWM-Source-IP: 81.158.20.254
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleehleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkedurdduheekrddvtddrvdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduheekrddvtddrvdehgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehkedqvddtqddvheegrdhrrghnghgvkeduqdduheekrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdehpdhnsggprhgtphhtthhopedvpdhrtghpthht
	oheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehtrghkrghshhhirdihrghnohesnhhifhhthidrnhgvrdhjph
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.158.20.254) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1C95053EECDF; Sun, 9 Nov 2025 16:30:18 +0000
Message-ID: <5187ab5f-3d7b-451e-ab73-b2d0d1c0dffd@dronecode.org.uk>
Date: Sun, 9 Nov 2025 16:30:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fixes for dll_init.cc
To: Takashi Yano <takashi.yano@nifty.ne.jp>
References: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
 <20251105135842.e9c501e7cce6ec6603acc124@nifty.ne.jp>
 <1034b8d0-4de7-407c-a9f1-6c2ba7744380@maxrnd.com>
 <20251109180214.06d195f84ddb678ca1a0ca27@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20251109180214.06d195f84ddb678ca1a0ca27@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 09/11/2025 09:02, Takashi Yano wrote:
> Hi Mark,
> 
> On Sun, 9 Nov 2025 00:09:07 -0800
> Mark Geisert wrote:
>> Hi Takashi,
>>
>> On 11/4/2025 8:58 PM, Takashi Yano wrote:
>>> On Tue, 28 Oct 2025 20:48:40 +0900
>>> Takashi Yano wrote:
>>>> Takashi Yano (2):
>>>>     Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD even in
>>>>       exit_state
>>>>     Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.
>>>>
>>>>    winsup/cygwin/dll_init.cc | 8 +++++---
>>>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> -- 
>>>> 2.51.0
>>>>
>>>
>>> Could anyone please review if these patches make sense?
>>
>> The patches look fine to me.  Do you happen to have an STC that
>> demonstrates to you the issue is fixed with your patch?
> 
> Thanks for reviewing. The STC is the attachment files in
> https://cygwin.com/pipermail/cygwin/2025-October/258919.html

I'm finding it pretty hard to reason about what the possible 
combinations that should be considered are.

Like, what is the spanning set? I guess we have:

1. A single DLL X, directly linked with by executable
2. A single DLL X, dlopened and dlclosed (subcases where it does this 
during constructor/destructors and otherwise?)
3. As above, but X is directly linked with Y
4. As above, but X is dlopens/dlcloses Y
5. more???

If I understood all that, then maybe I'd have some suggestions about how 
the comments can be written to explain why what it's doing is the right 
thing in the various situations.

I guess it's possible to extend that STC to cover all those?

