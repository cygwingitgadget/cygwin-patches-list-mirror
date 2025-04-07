Return-Path: <SRS0=YwmG=WZ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo009.btinternet.com (btprdrgo009.btinternet.com [65.20.50.46])
	by sourceware.org (Postfix) with ESMTP id CABD53858CDA
	for <cygwin-patches@cygwin.com>; Mon,  7 Apr 2025 19:06:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CABD53858CDA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CABD53858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.46
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744052806; cv=none;
	b=wSPeQuv+QlpvHbvG0xFZAZTKcM+GAgv/l3A0jsY6n983S0GHhqtlgz9GXA85PFpNw1ZtccabgCRY2ysUOIfw6FTp/JWRwgAgypNaRQj1llic7pUpQIjPs7AagTEViF4WcDwrarnMq/9fiT+xs+/wxOHcCI6nPsvIqyxDKMmcH9g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744052806; c=relaxed/simple;
	bh=He7e6eK6qaVnFX1Ir5FAXZO3rBgOaKmUkbN4znOdARY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Glpsw83MDcpi4NiCnsE5Pcu5Mt1PIdU+5ZD1XU20uFxE+9H1G1BG5i0C/UFtl4Rmp0jX3TgAEilecP4a+4j/RdqbGHg6/56M9cASMerP4rl+n0PTu7iiT88oEQ4ZR8w2iAfWN/9LfX5E0HaX4TtDRuO8icsnfHiiDX5UQ7YoLBc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CABD53858CDA
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89DC9028A159E
X-Originating-IP: [81.129.146.194]
X-OWM-Source-IP: 81.129.146.194
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieejiedtteehheelteehgfegffekueekfeekhefgveelhefgfeevudffiedtjeenucffohhmrghinheptgihghifihhnrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepkedurdduvdelrddugeeirdduleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekuddruddvledrudegiedrudelgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudelgedrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtledpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihg
	fihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtoheptgihghifihhnsehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.129.146.194) by btprdrgo009.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89DC9028A159E; Mon, 7 Apr 2025 20:06:43 +0100
Message-ID: <2bdcdd25-2de8-44a9-b2df-0a99da500367@dronecode.org.uk>
Date: Mon, 7 Apr 2025 20:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Don't increment DLL reference count in dladdr.
To: Jeremy Drake <cygwin@jdrake.com>
References: <e1ea4725-bac4-d351-5bfd-d7e2d9a85acf@jdrake.com>
 <fc464fbd-3038-0248-1a75-b7f80b1046be@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <fc464fbd-3038-0248-1a75-b7f80b1046be@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/04/2025 18:22, Jeremy Drake via Cygwin-patches wrote:
> On Sat, 5 Apr 2025, Jeremy Drake via Cygwin-patches wrote:
> 
>> Unlike GetModuleHandle, GetModuleHandleEx increments the reference count
>> by default unless the GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT flag
>> is passed.
>>
>> Fixes: c8432a01c840 ("Implement dladdr() (partially)")
>> Addresses: https://cygwin.com/pipermail/cygwin/2025-April/257864.html
>> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
>> ---
>>   winsup/cygwin/dlfcn.cc      | 3 ++-
>>   winsup/cygwin/release/3.6.1 | 3 +++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
>> index f029ebbf2c..10bd0ac1f4 100644
>> --- a/winsup/cygwin/dlfcn.cc
>> +++ b/winsup/cygwin/dlfcn.cc
>> @@ -408,7 +408,8 @@ extern "C" int
>>   dladdr (const void *addr, Dl_info *info)
>>   {
>>     HMODULE hModule;
>> -  BOOL ret = GetModuleHandleEx (GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
>> +  BOOL ret = GetModuleHandleEx (GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT|
>> +				GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
>>   				(LPCSTR) addr,
>>   				&hModule);
>>     if (!ret)
>> diff --git a/winsup/cygwin/release/3.6.1 b/winsup/cygwin/release/3.6.1
>> index c09a23376e..280952c91a 100644
>> --- a/winsup/cygwin/release/3.6.1
>> +++ b/winsup/cygwin/release/3.6.1
>> @@ -36,3 +36,6 @@ Fixes:
>>     subprocess failure in cmake (>= 3.29.x).
>>     Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257800.html
>>     Addresses: https://github.com/msys2/msys2-runtime/issues/272
>> +
>> +- Don't increment DLL reference count in dladdr.
>> +  Addresses: https://cygwin.com/pipermail/cygwin/2025-April/257862.html
>>
> 
> Is this OK for me to push (to main and cygwin-3_6-branch)?

Yes, please go ahead.
