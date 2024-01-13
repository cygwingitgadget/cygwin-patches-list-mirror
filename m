Return-Path: <SRS0=HHq1=IX=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-041.btinternet.com (mailomta4-sa.btinternet.com [213.120.69.10])
	by sourceware.org (Postfix) with ESMTPS id DCAB33858D1E
	for <cygwin-patches@cygwin.com>; Sat, 13 Jan 2024 13:40:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DCAB33858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DCAB33858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705153260; cv=none;
	b=aq4S0cFLiveEZET9TAmlzraQz3jsK7ZXcWBwAtaH/gJZi/LGEX9HdpJBCEAt90j3GOhORhqzURiic7FWZhx7fPuua486xFLBKGA1wjqZbgBcUtPTwy1ibX75lkdi+ieJUYxNyOZg8G4NBZ4VHZB981V2/f1y4qgNfZ/gXFj2uXk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705153260; c=relaxed/simple;
	bh=BiTw3yQ9W186PpeDtTyaccyMMbnKPCPO8IlvU5ApCcY=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=oMXpyB1E6u4h4+2G8h85k7njPL2nsCSHC8sFk51ptp8+XcebcH+u5RLxRCQO/rMafbRFYuJdyVVKfwMuN/PhgJFvWElwTU0SfROj2rubrnE9/bjK8CaUhOxRpsz3x5MUGwd+kFH1+ilsPEDy0F0NZ3cqAYopKzU1mbcP3tzZCkU=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20240113134056.JTEL7232.sa-prd-fep-041.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Sat, 13 Jan 2024 13:40:56 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6567CEC105D957B5
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeijedgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddufeelrdduheekrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdejngdpihhnvghtpeekiedrudefledrudehkedruddtfedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehs
	rgdqphhrugdqrhhgohhuthdqtddtge
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.107] (86.139.158.103) by sa-prd-rgout-004.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567CEC105D957B5 for cygwin-patches@cygwin.com; Sat, 13 Jan 2024 13:40:56 +0000
Message-ID: <55bbfe43-cb17-4d26-a600-7e462fa856ba@dronecode.org.uk>
Date: Sat, 13 Jan 2024 13:40:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] Cygwin: Update documentation for cygwin_stackdump
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-6-jon.turney@dronecode.org.uk>
 <ZaGIlGGizJxsC35M@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <ZaGIlGGizJxsC35M@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/01/2024 18:44, Corinna Vinschen wrote:
> On Jan 12 14:09, Jon Turney wrote:
>> ---
>>   winsup/doc/misc-funcs.xml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/winsup/doc/misc-funcs.xml b/winsup/doc/misc-funcs.xml
>> index 7463942e6..55c5cac94 100644
>> --- a/winsup/doc/misc-funcs.xml
>> +++ b/winsup/doc/misc-funcs.xml
>> @@ -106,6 +106,10 @@ enum.  The second is an optional pointer.</para>
>>     <refsect1 id="func-cygwin-stackdump-desc">
>>       <title>Description</title>
>>   <para> Outputs a stackdump to stderr from the called location.
>> +</para>
>> +<para> Note: This function is has an effect the first time it is called by a process.
>                                ^^^^^^
> This looks like a rephrasing attempt gone slightly wrong.
> 
> I'm also not quite sure what you're trying to say here. Maybe a bit more
> detailed would help me and other readers?

Sorry about that. It seems like I changed my mind about what I was 
writing halfway through the sentence. I guess I meant:

"This function only has an effect the first time it is called by a process."

