Return-Path: <SRS0=rwI6=SP=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.146])
	by sourceware.org (Postfix) with ESMTP id 0E0393858D20
	for <cygwin-patches@cygwin.com>; Wed, 20 Nov 2024 16:03:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0E0393858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0E0393858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.146
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732118611; cv=none;
	b=Yk2v5Cv4bw/j0VrOC1RrxPIfCkjzawb4w7qK1kmgfkPXqLbtNvYbc9zChmoxqpoQlZBk61LGyTkAADhu9Ha9x8tk3+cBHwz/p3he9cRdheALFJgNJpxq9tP1YkF2U9qXK9zJfRHe6c/7Ma3uIhzdJPIeeIexL+DEH2qzYA1uxVE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732118611; c=relaxed/simple;
	bh=qIsPoM6pWXTdRDO2W/VSmU/ZA3j3L3N5l0ZKp4zWC8s=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=WOXbiyP5Mojy7q3COKb1mcSIkuY+tDBUKZJDkVWl+1hza9/Hm/mMqHqKCbmny0ptSrHJLbnjCAT9TUSbnTRMlsMGRcC4XWXDjMmQN6RG+Gs4BFtSeI4DYmA5RsyOsC6apP/XcNbzZXUFzVtTwXskg0YxJk7LKokYS5wRwiBWsHE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0E0393858D20
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6722AD9C026E8EF3
X-Originating-IP: [81.152.101.74]
X-OWM-Source-IP: 81.152.101.74
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhepkfffgggfufhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvddtgfduudeuheevffdvjefgieeluefgieevvdfgheeuleffffegjeduudfhgedtnecukfhppeekuddrudehvddruddtuddrjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekuddrudehvddruddtuddrjeegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduhedvqddutdduqdejgedrrhgrnhhgvgekuddqudehvddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtvddpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghif
	ihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (81.152.101.74) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6722AD9C026E8EF3 for cygwin-patches@cygwin.com; Wed, 20 Nov 2024 16:03:30 +0000
Message-ID: <7c30c3b7-0747-4076-936f-bfd74a321366@dronecode.org.uk>
Date: Wed, 20 Nov 2024 16:03:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: SetThreadName: avoid spurious debug message
References: <20241120152630.1617419-1-corinna-cygwin@cygwin.com>
 <Zz4BUR5C7It3xNTs@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Zz4BUR5C7It3xNTs@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 20/11/2024 15:33, Corinna Vinschen wrote:
> On Nov 20 16:26, Corinna Vinschen wrote:
>> From: Corinna Vinschen <corinna@vinschen.de>
>>
>> The following debug message occassionally shows up in strace output:
>>
>>    SetThreadName: SetThreadDescription() failed. 00000000 10000000
>>
>> The HRESULT of 0x10000000 is not an error, rather the set bit just
>> indicates that this HRESULT has been created from an NTSTATUS value.

Thanks.

Sorry for not writing this correctly in the first place.

>> Use the IS_ERROR() macro instead of just checking for S_OK.
>>
> 
> I missed this line:
> 
>    Fixes: d4689b99c686 ("Cygwin: Set threadnames with SetThreadDescription()")
> 
> Treat it as already added, please...
> 
>> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
>> ---
>>   winsup/cygwin/miscfuncs.cc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
>> index 767384faa9ae..4220f6275785 100644
>> --- a/winsup/cygwin/miscfuncs.cc
>> +++ b/winsup/cygwin/miscfuncs.cc
>> @@ -353,7 +353,7 @@ SetThreadName (DWORD dwThreadID, const char* threadName)
>>         WCHAR buf[bufsize];
>>         bufsize = MultiByteToWideChar (CP_UTF8, 0, threadName, -1, buf, bufsize);
>>         HRESULT hr = SetThreadDescription (hThread, buf);
>> -      if (hr != S_OK)
>> +      if (IS_ERROR (hr))
>>   	{
>>   	  debug_printf ("SetThreadDescription() failed. %08x %08x\n",
>>   			GetLastError (), hr);
>> -- 
>> 2.47.0

