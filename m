Return-Path: <SRS0=P5gk=UF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 0570A3857B8C
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 20:55:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0570A3857B8C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0570A3857B8C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736801714; cv=none;
	b=UFGmPKFMvKIquBLqnoGzQzgX8MBRRFla5tgs1Zx3IYph5clJeRzAxg/2buYbx9ukLhT2kHAbZGchVZCo/Dfg7LR2ciRxXsRzcWv81l2zpfa3SkPbNY26V8wJ3xWAEqOqGOKznzk98AFhRcJXH5sBNDIDKDDkTQutSPrzl69LygM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736801714; c=relaxed/simple;
	bh=IBbRah4zz+Lojn53HtKSsjghrAGC17OzgTkKzRAIW0Q=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=T9UL+BvSFvTM/4za+QLUUc3kcvXYpYtWB4DTCYD3ZSGSfJGGz6Dj02L9YDEN98nw+k2aUVoe/MOIjfoQsVQqkXlhbGlzBzoLXd+tXNlP9IDMg53V4Aork0lWqp4a7vSjl9oQxCwkiqExJ6tgkCQXWapA9k/troUNvLa7mHZBHOg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0570A3857B8C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901EE04DF0DAA
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgudegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhepkfffgggfufhfhfevjggtgfesthekredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepjeduffetfeeiteefgfetiedtheffhedukefhgfevteeggeeiheeludelkedttdfhnecuffhomhgrihhnpeiffedrohhrghdpohhpvghnghhrohhuphdrohhrghenucfkphepkeeirddugedtrdduleefrdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdefgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdehpdhnsggprhgtphht
	thhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901EE04DF0DAA for cygwin-patches@cygwin.com; Mon, 13 Jan 2025 20:55:09 +0000
Message-ID: <f53bd5c3-6f05-4e67-a4a9-e552d84cdecc@dronecode.org.uk>
Date: Mon, 13 Jan 2025 20:55:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 TOG Issue 8 ISO 9945 move new
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <ce4fb1f0bb4390758b48d56bf635de71b5809b42.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4T1-rjrkks8j57g@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Z4T1-rjrkks8j57g@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_SHORT,MISSING_HEADERS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/01/2025 11:16, Corinna Vinschen wrote:
> Hi Brian,
> 
> On Jan 10 17:01, Brian Inglis wrote:
>> Update anchor id and description to current version, year, issue, etc.
>> Move new POSIX entries in other sections to the SUS/POSIX section.
>>
>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> ---
>>   winsup/doc/posix.xml | 140 ++++++++++++++++++++++---------------------
>>   1 file changed, 73 insertions(+), 67 deletions(-)
>>
>> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
>> index 2782beb86547..1b893e9e19ae 100644
>> --- a/winsup/doc/posix.xml
>> +++ b/winsup/doc/posix.xml
>> @@ -5,10 +5,16 @@
>>   <chapter id="compatibility" xmlns:xi="http://www.w3.org/2001/XInclude">
>>   <title>Compatibility</title>
>>   
>> -<sect1 id="std-susv4"><title>System interfaces compatible with the Single Unix Specification, Version 7:</title>
>> +<sect1 id="std-susv5"><title>System interfaces compatible with the Single UNIX® Specification Version 5:</title>
>>   
>> -<para>Note that the core of the Single Unix Specification, Version 7 is
>> -also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>> +<para>Note that the core of the Single UNIX® Specification Version 5 is
>> +POSIX®.1-2024 also simultaneously IEEE Std 1003.1™-2024 Edition,
>> +The Open Group Base Specifications Issue 8
>> +(see https://pubs.opengroup.org/onlinepubs/9799919799/), and
>> +ISO/IEC DIS 9945 Information technology
>> +- Portable Operating System Interface (POSIX®) base specifications
>> +- Issue 8 (expected to replace ISO/IEC/IEEE 9945:2009 - Issue 7 in the coming months
> 
> This hint is outdating itself.  It might be a good idea to
> phrase it time-independent...

That seems impossible, unless you happen to have access to all future 
revisions of the SUS.
  Less is more here, I think.

If you are working to POSIX.1-2024, then that's what you should use and 
mention. Speculations about the future aren't germane or relevant to the 
purpose of this documentation.

