Return-Path: <SRS0=i6AP=CT=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id A7CFE3858D35
	for <cygwin-patches@cygwin.com>; Sat,  1 Jul 2023 15:21:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A7CFE3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id FYoxqO9K5LAoIFcPFqpMkM; Sat, 01 Jul 2023 15:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1688224861; bh=qReEHh3uTqqlFxXNRdddS0+2Imue26+7CyJEwODZ600=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=XoCpjHbYXz0f7UZdNTSK2qlwDreIJizMSwREQ1rbCDgE9XQ7wyjyijWN1gFXBqjgR
	 UA4Mf45+cILZZKwGRDfyMpMERFeFbCMHzGxYhK5U3nM8802jeiCTsHAU/RniwAO5Ju
	 iBNCh7i751OD6F+2/sXHxNcLQeitDBLSEmxg5OwIBX2Z5Lro5ToN2sLLwas0COAnDa
	 YrNan1a9biCOmP31GSg5ttBrJ2tcLknpSy6SJuUGzI0shH3gBMEIlemLh6PP92oWwI
	 USf281/fS3Xs6JgupvxH5luYKaNXtb8OezmV3IJqjV1pDwzvVkH1eLLeewk3k/+i5c
	 uqTvWZfdocG7g==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id FcPFq4fCscyvuFcPFqvpcx; Sat, 01 Jul 2023 15:21:01 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=64a0445d
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=NEAV23lmAAAA:8 a=vckqNxS0mAts8Cg6LIYA:9
 a=QEXdDO2ut3YA:10 a=0ae8JCfWjo4A:10 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <8a69d717-64a0-dd79-77b1-7c95947b45ab@Shaw.ca>
Date: Sat, 1 Jul 2023 09:21:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Fix type mismatch on sys/cpuset.h
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20230314085601.18635-1-mark@maxrnd.com>
 <1cf85bfc-9865-e4f7-5c2e-5acc89c3e77f@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <1cf85bfc-9865-e4f7-5c2e-5acc89c3e77f@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCxGCM6yc26/G3qUl3HHwou8+Uohiz+oXAzSxmT5mMqKzlcJ8h24MKWGYLOunWW+l2YZ9OoK6y730A9ke2Y1cQF0syMutrIkX0XdozLpaZ5wOvamenYe
 BSf5aMvqLJdFEZASjY8v7Qf/a5whao9MEHzZRF2G86PeJzLO7mXtC7jafLlJ0cVneQ3cqA8ij/JfYXkOsshw74Us4QMX+9LXKJI=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-07-01 08:20, Jon Turney wrote:
> On 14/03/2023 08:56, Mark Geisert wrote:
>> Addresses https://cygwin.com/pipermail/cygwin/2023-March/253220.html
>>
>> Take the opportunity to follow FreeBSD's and Linux's lead in recasting
>> macro inline code as calls to static inline functions.  This allows the
>> macros to be type-safe.  In addition, added a lower bound check to the
>> functions that use a cpu number to avoid a potential buffer underrun on
>> a bad argument.  h/t to Corinna for the advice on recasting.
>>
>> Fixes: 362b98b49af5 ("Cygwin: Implement CPU_SET(3) macros")

> There's been a couple of reports that this leads to compilation failures when 
> this header is included in -std=c89 mode.
> Solutions are probably something like:
> * Use __inline__ rather than inline
> * Don't use initial declaration inside the for loop's init-statement
> e.g. https://github.com/tinyproxy/tinyproxy/issues/499

/usr/include/sys/cdefs.h appears to support using __inline instead of __inline__ 
or inline, and is included many places __inline is used: it appears to be 
necessary, but may not be sufficient.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
