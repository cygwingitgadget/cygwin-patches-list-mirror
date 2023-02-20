Return-Path: <SRS0=TASg=6Q=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id EE8BD3858D1E
	for <cygwin-patches@cygwin.com>; Mon, 20 Feb 2023 22:57:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE8BD3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTP
	id U9fKpUgDNuZMSUF5jplV8J; Mon, 20 Feb 2023 22:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1676933823; bh=0RYw1NaZcrdmQMG8oq2hbYtFl5iBX+5ul4kHi2LigJE=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=Epc1g/hI8diKfMZvtL2OWynGZEmXbLM5IIHvK6we3KCdmKvwoBW/fdZwPXMjmveCb
	 4POnTdFhmHzzaD0vj9mvJV4sE92lBV4sfxvkCbN9/ZSab5ycBJtHqAivGYXYdOaFhe
	 R7N8Ao7WLNca4jkoTegUt4lEVgTDOVcQ3taCgVRTtHpgX9nv55okOz/YCXDDp6NaMm
	 1Jo4i2XnmJZ7oGOEbezGi7SJGdCqRaVzVvA7eQLQj+Oc8uU/P11seshFODaT4oQ7Li
	 46Jv93c5LkrFakwEuniIzEKmWEO/YjYu72bIBzYqUDMmOS4GFn0ED8jG9r9dPPGCG9
	 lGo7+XRrWeP4Q==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id UF5ipCbcE3fOSUF5ipoK0M; Mon, 20 Feb 2023 22:57:03 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=63f3fabf
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=InbDg0OHH5r3FFW21z8A:9 a=QEXdDO2ut3YA:10
 a=OCWz5_UTjG4A:10 a=9c8rtzwoRDUA:10 a=yipANtDfiQYA:10
 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <790a2571-2bb8-bc37-ac16-d6bd27798311@Shaw.ca>
Date: Mon, 20 Feb 2023 15:57:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: Copyright outdated? in Cygwin/X FAQ 12.6 and not addressed in
 Cygwin FAQ 7.1 link
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <6b01a995-96e5-7b46-3323-1cf348d25252@Shaw.ca>
 <c22f1341-217c-3a61-c075-6f86bb812385@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <c22f1341-217c-3a61-c075-6f86bb812385@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfO3vIqS5YPFyaPkxy3YDUxFq0znjPnDB1p8g5+GgIV9eLaYo9ZuyZAPgFgR93G2lQWpgzEKo44PP3GF+CD/6X4sH7MUxGJhRymruJ5LeXXmf1XvZCfgP
 UbKOVxDcr94m/lqwjElSl6QPqQx3dmfhR6FqVzH4dhFrRhaDK6qr1xUvR7OUgVtnsCZXBxtrzSfYgsxH+FLOvDCi0czfQ3oXpeg=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-02-20 15:00, Jon Turney wrote:
> On 20/02/2023 20:20, Brian Inglis wrote:
>> Hi folks,
>> [Addressing to patches as that's where we'll fix it, and not a general issue.]
>>
>> Noticed that:
>>
>> https://x.cygwin.com/docs/faq/cygwin-x-faq.html#q-copyright-cygwin
>>
>> "12.6. Who holds the copyright on the Cygwin source code?
>>
>> Red Hat owns the copyright on the Cygwin source code. Red Hat requires that 
>> copyright be assigned to Red Hat for non-trivial changes to Cygwin. You must 
>> fill out a copyright transfer form if you are going to contribute substantial 
>> changes to Cygwin."
>>
>> Has that not been assigned to the project?
>>
>> And also:
>>
>> https://cygwin.com/faq/faq.html#faq.what.copyright
>>
>> "7.1. What are the copyrights?
>> 7.1.
>> What are the copyrights?
>> Please see https://cygwin.com/licensing.html for more information about Cygwin 
>> copyright and licensing."
>>
>> ->
>>
>> "Cygwin™ Linking Exception
>> As a special exception, the copyright holders of the Cygwin library"
>>
>> Is that the project?
>>
>> Or does it belong to the authors individually and/or the project or the 
>> "Cygwin authors" collectively?
>>
>> Could we please be as current and explicit as possible in the FAQs once 
>> current situation is clear and wording is agreed?

Please note above statement - I have no idea who owns the copyrights - X says RH 
- Cygwin waffles about copyright holders - nothing says who they are - I 
suggested alternatives - someone needs to tell me!

>> Thinking that Cygwin/X FAQ 12.6 should defer to Cygwin FAQ 7.1.
> 
> Yes.
> 
> 12.3 and 12.6 should just be links to places where correct information can be 
> found.
> 
>> Willing to submit FAQ patches ;^>
> 
> Please do so.
> 
> Note that the source for this FAQ is docbook in [1]
> 
> [1] https://cygwin.com/git/cygwin-apps/xorg-doc.git

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

