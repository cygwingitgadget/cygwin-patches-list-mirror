Return-Path: <SRS0=ZSvf=XG=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.237])
	by sourceware.org (Postfix) with ESMTP id AA83F3858417
	for <cygwin-patches@cygwin.com>; Sun, 20 Apr 2025 19:27:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA83F3858417
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA83F3858417
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.237
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745177245; cv=none;
	b=cNjcMH69+tFOE8qOPOkmFjAtSnuyWUEB2QFSgyRbVWoSqnsbo/L6TJ/Vvvzcc0yOWpoybu5WMbWW1VpFGaM4Io+FGeweiA1wi8l1rxOTau1c9H8Bj6/9TrDf6+qzwuAL0hidKVP0wKBUJKYh7HJtyDrnctgq0j9AccUpXtb3A/8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745177245; c=relaxed/simple;
	bh=rE1Wktr7kYLuci5vKI8Ks9cjN8oO+PcAvUBoUNszQj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=w6B2NMASESulgNc5ee6Ax0ar/f5gAbeQTPmCpM2k2ctEs8nUtRcUhZ8H3pc6UUqbp8O3k9+4bqqycC5iGP1j9m3LmFZfxt2FJZY+7kMFsnywCSBUBVEFyumQeH8Q4Kge7J3WvVQgxh4NgwGjFD5IzSzvAzSglWIEJ2FO/apkxQo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA83F3858417
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E7C041A71C0
X-Originating-IP: [86.140.112.112]
X-OWM-Source-IP: 86.140.112.112
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthekredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepteegtefgheeiudekjeelkeegffejvdegvdduffdvfedtvdekhedtffevfeegkeehnecukfhppeekiedrudegtddrudduvddrudduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduuddvrdduuddvpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduuddvqdduuddvrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddvpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepvehhrhhishhtihgrnhdrhfhrrghn
	khgvsehtqdhonhhlihhnvgdruggvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.112.112) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E7C041A71C0; Sun, 20 Apr 2025 20:27:24 +0100
Message-ID: <10d021f6-fdbe-429b-bc71-076c4a5accf2@dronecode.org.uk>
Date: Sun, 20 Apr 2025 20:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] Cygwin: CI: Make stress test terser
To: Christian Franke <Christian.Franke@t-online.de>
References: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
 <20250411130846.3355-4-jon.turney@dronecode.org.uk>
 <a4ea9b93-222e-f679-48bb-c8459bd797f8@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <a4ea9b93-222e-f679-48bb-c8459bd797f8@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,BODY_8BITS,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/04/2025 17:08, Christian Franke wrote:
> Jon Turney wrote:
>> Don't echo the command being run
> 
> OK, but this breaks -n option which is occasionally useful, see below.

Yeah, that was dumb of me.

Posted a v2 of this series, with your updates as well.

>> Capture stress-ng output to file
>> Only show test output if it fails
>>
>> Capture all test output in an artifact
> 
> Are messages cygwin prints itself also captured? See below.
> 
> 
>> ---
>>   .github/workflows/cygwin.yml      | 10 ++++++++++
>>   winsup/testsuite/stress/cygstress | 13 ++++++++-----
>>   2 files changed, 18 insertions(+), 5 deletions(-)
>>
>> ...
>> -  echo '$' "${cmd[@]}"
>>     ! $dryrun || return 0
> 
> Possibly better:
> 
> if $dryrun; then
>    echo '$' "${cmd[@]}"
>    return 0
> fi
> 

This is, of course, the right way.

>>     (
>> @@ -520,7 +523,7 @@ stress()
>>     mkdir "$td"
>>     local rc=0
>> -  "${cmd[@]}" || rc=$?
>> +  "${cmd[@]}" >/dev/null || rc=$?
> 
> Redirect stderr to capture Cygwin's "panic" messages ?

Yeah, that seems better.

I was desperately trying make use of the '--log-file' option, but it 
doesn't seem to actually be useful here.

