Return-Path: <SRS0=P5gk=UF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.92])
	by sourceware.org (Postfix) with ESMTP id D8EE2385782C
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 17:22:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D8EE2385782C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D8EE2385782C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.92
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736788928; cv=none;
	b=g/uPuohXqqiMgjdw65wDOPKyyg1xd57jZupXXm3nDhLg17wkQ9MbHbpusrIaEYJPRb00/DFaUte42/BkzbPkNn/tCUZr8RXl+YEk6tNZB4pxErEpeTaASviiSlZDrAH05XG91uayqmTQ1DRAM11FQyE1vQJ3KjkIaAXmIKdRbek=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736788928; c=relaxed/simple;
	bh=lmg9PmV5jcUbsaPqrH5ND22UN3+0QWPMQ4KKED78gfY=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=CLiesnca5pPRKdx0HslEfjdEQzPsPrvbiBMFeU0c/HXS07pGwnzI5ObYwSjXty76E6Ag6Vc8NG8+WCou/UXKs3vSW70Gvu7LzfnYpBoZ6hKuPv6D0Dxpx3qr5QUYWD6qfHWYjcCJUWwCNew/yhJM9+4ZtfF3iG3znZWGCfcOC8s=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D8EE2385782C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6749021804D8EC08
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddugedtrdduleefrdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdefgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddupdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihg
	fihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6749021804D8EC08 for cygwin-patches@cygwin.com; Mon, 13 Jan 2025 17:22:06 +0000
Message-ID: <6115072e-ca00-4f51-b7c6-fcafa9b0a8c4@dronecode.org.uk>
Date: Mon, 13 Jan 2025 17:22:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 merge function variants on one line
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <39517f2a7fdd36a043c2029e0a24e16e8e7f3bee.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4UXaKQmj2s22H3B@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Z4UXaKQmj2s22H3B@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/01/2025 13:38, Corinna Vinschen wrote:
> On Jan 10 17:01, Brian Inglis wrote:
>> Move circular F/Ff/Fl and similar functions to put
>> base entries and -f -l variants on the same line.
>>
>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> ---
>>   winsup/doc/posix.xml | 336 +++++++++++--------------------------------
>>   1 file changed, 84 insertions(+), 252 deletions(-)
> 
> Hmm.  This makes more sense than the previous patch.
> 
> However, it doesn't make sense if only the math functions are affected
> If you want to do this systematically, you'd have to group them
> following the Open Group Base Spec Issue 8.
> 
> That would also imply merging stuff like
> 
>    iswalnum/iswalnum_l		-- page 1280
>    le16toh/le32toh/le64toh	-- page 1327
>    localtime/localtime_r		-- page 1354
>    mlock/munlock			-- pages 1433, 1488
>    sig2str/str2sig		-- page 2040
> 
> etc. etc.
> 
> Nevertheless, while this has a certain charm and I don't see
> a disadvantage, I'd like to get Jon's input to this as well.

Well, I'd just go for one function per line, in alphabetical order, 
because it's unambiguous if we've done that correctly.

Otherwise, it devolves into arguments about "I think it looks nicer this 
way", which... well, "de gustibus non est disputandum".

