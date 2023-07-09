Return-Path: <SRS0=qBl3=C3=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id A34043858D28
	for <cygwin-patches@cygwin.com>; Sun,  9 Jul 2023 04:28:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A34043858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTP
	id I8msqUpuqLAoIIM1fq8GIK; Sun, 09 Jul 2023 04:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1688876879; bh=nhyUlmiKcqQ4/ZJMexSxO7ademX10cwremkvR3j9SFY=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=TNZpMxNIdV2Vv7ftUb5j8HwLK3JqLRqyYlqFXzns5+RY+2pjr/F0u/3NIFWSjdXhX
	 BFLstR1tPpXjdl5M5R3r96QokZHs9VVseQWY4eIrpdvf6wPRK21pnXvGId49fm5KnS
	 S3LqCrnckwV55PNSDoG98oqlKNcd/MPxQ5l6i9MJ7hi4zprCdXdd4wi5aODQsNRD6L
	 ceCCsUTxu/3pD1sqe/S1P3R5Bc9pLGIeYx0XlhKAkZb5o56T6VSLxLzs9JzPmGWD8S
	 p23vjDdwzcyNn0zCNUJiMSZnGE3XpVNfYqRH6ENJ/hj5DpCbVFcFMOqOYmMz6m1/FG
	 peUFtghKrKYeA==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id IM1eqFTtEyAOeIM1eqjLNX; Sun, 09 Jul 2023 04:27:59 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=64aa374f
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=Q4xn-lpTJxkgqSwza48A:9 a=QEXdDO2ut3YA:10
Message-ID: <e2c6b3f7-3493-90a2-e8c4-a8370a4336d2@Shaw.ca>
Date: Sat, 8 Jul 2023 22:27:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20230707074121.7880-1-mark@maxrnd.com>
 <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
 <073cd700-c727-ee29-017e-df8d86a1db59@Shaw.ca>
 <1f7d3254-234e-378f-a852-63ca5d7ca01f@Shaw.ca>
 <589a2704-d690-60f4-4818-687233699c4c@maxrnd.com>
 <ff935edc-154a-eb3b-600e-cea46dfc3d4f@maxrnd.com>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <ff935edc-154a-eb3b-600e-cea46dfc3d4f@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDVu45Pp88TwLkzQ75Rbnp7rH1pCniB7kvwlTAIJskzOUaS6FFB+EQhZ3+FaYeTGWzOFypnPXsK+wFCcZgbB9gUGEzoz4YgpINk4k2sN0Wi9SJYIq4Wf
 6Kq3lzPWBAlC0bR/NQiBq8gY0y9BWQeseT53E9b5II2Hm+i2oMWf9vJfvbskVglkcLFjt6QMSy5Y3z9mte1K1B37xMn7Wt9WZps=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-07-08 15:53, Mark Geisert wrote:
> Mark Geisert wrote:
> I got tripped up by misspelling and not being able to link clang{,++} programs 
> on my test system.  I checked the .o files with objdump: Clang and clang++ both 
> support __builtin_popcountl, but they emit code for the Hackers Delight 
> algorithm rather than using the single-instruction popcnt.  Sorry for the 
> confustion [sic].

That's what I meant - clang 8 "identifies as" gcc 4, and builtin and intrinsic 
function support are almost the same (and fairly close to gcc 11) builtin and 
intrinsic function support.

And as you mentioned, any support for builtins is better than what we can whip 
up off the top of our heads (unless you use HD/2!)

For our purposes, the main differences between clang 8 and current are latest 
language, library, and processor support, but it also supports useful tools like 
the analyzer and formatter, which gcc does not provide.

And it is convenient to be able to run another compiler side by side for 
comparisons without copying files and remoting to another system.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
