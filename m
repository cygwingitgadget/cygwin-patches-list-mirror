Return-Path: <cygwin@hamishmb.com>
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
	by sourceware.org (Postfix) with ESMTPS id B2F623851512
	for <cygwin-patches@cygwin.com>; Thu, 27 Oct 2022 13:21:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B2F623851512
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hamishmb.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hamishmb.com
ARC-Seal: i=1; a=rsa-sha256; t=1666876892; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=DS8dLmxo5sUxX3RlSQbTR7TyxeaXo9VBDS4FXRNnYM4nO4fV0d2myhma9x2CSE4Ir1ajxLiCK6w/6mO/kJVDIb3akuEOfBMnOt+fTWAk6P1OKc+c+OJYjL23QF2aU8UfM2nWrwD3/Bg3cLzCgcZ6DLeZ05Q2MsBUheVONIBnzBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1666876892; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=JBDB1DuAHvUzRCs3+mM3ebkF4mCW4qIPD8ityr8t15E=; 
	b=Z1i9uf/SfTjotkf4IGxKOzjexxib/gfLV4AMYME/k3+vIujsvV+mWCYlBKfKDn303KRY7iYn+gajeLyatBFBqm2EtxljOIh13wr24ee8WH+W9TmfUjHDGBJe4NKUCxgX7r7Qlv3kl/y9n+NGj1ShhmPYLn5F3WuUbEnWvUFF8C8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=hamishmb.com;
	spf=pass  smtp.mailfrom=cygwin@hamishmb.com;
	dmarc=pass header.from=<cygwin@hamishmb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666876892;
	s=zmail; d=hamishmb.com; i=cygwin@hamishmb.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=JBDB1DuAHvUzRCs3+mM3ebkF4mCW4qIPD8ityr8t15E=;
	b=iPTLu+dZwed+fwHLBQf9KZMTmgYInjnLfrQBv/0h+a/iNAbrMknDsXLS9QvKihk6
	MwmgZiaxRiXNEdrk525AG4OMKWMx6WbiUbvFdzlKY3NhOfaqaismLKzW/858aqEwKYD
	nHKS1rR4vCksVKutuJwpORgIntp/d0wcm4yeaVZo=
Received: from [192.168.10.213] (host86-149-41-78.range86-149.btcentralplus.com [86.149.41.78]) by mx.zoho.eu
	with SMTPS id 1666876890105341.3047228546135; Thu, 27 Oct 2022 15:21:30 +0200 (CEST)
Message-ID: <2fb67d5d-0557-707b-4ee8-82e2bf90a5b8@hamishmb.com>
Date: Thu, 27 Oct 2022 14:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] Fix typo in faq-programming.xml
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20221026132616.280324-1-cygwin@hamishmb.com>
 <Y1psWqiNnWpDSGDs@calimero.vinschen.de>
From: Hamish McIntyre-Bhatty <cygwin@hamishmb.com>
In-Reply-To: <Y1psWqiNnWpDSGDs@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 27/10/2022 12:32, Corinna Vinschen wrote:
> On Oct 26 14:26, Hamish McIntyre-Bhatty wrote:
>> From: Hamish McIntyre-Bhatty <contact@hamishmb.com>
>>
>> ---
>>   winsup/doc/faq-programming.xml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
>> index c2c4004c1..7945b6b88 100644
>> --- a/winsup/doc/faq-programming.xml
>> +++ b/winsup/doc/faq-programming.xml
>> @@ -1051,7 +1051,7 @@ a Windows environment which Cygwin handles automatically.
>>   <question><para>How should I port my Unix GUI to Windows?</para></question>
>>   <answer>
>>   
>> -<para>Like other Unix-like platforms, the Cygwin distribtion includes many of
>> +<para>Like other Unix-like platforms, the Cygwin distribution includes many of
>>   the common GUI toolkits, including X11, X Athena widgets, Motif, Tk, GTK+,
>>   and Qt. Many programs which rely on these toolkits will work with little, if
>>   any, porting work if they are otherwise portable.  However, there are a few
>> -- 
>> 2.25.1
> Pushed.
>
> Thanks,
> Corinna

Cheers,

Hamish

