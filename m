Return-Path: <SRS0=Q8LB=6N=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 876BA385781F
	for <cygwin-patches@cygwin.com>; Fri, 17 Feb 2023 17:35:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 876BA385781F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTP
	id T4RqpEhnBl2xST4dsp7CiO; Fri, 17 Feb 2023 17:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1676655328; bh=SeCaUhG3RJCOI1NtbTtNRiMbQYF0j5SEjah3+65zwEk=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=QEtKSrL7dyFmrrdW5fbh+UsaNdoUZ4/Fckq/klrwFdQGUNFjyMN3w+TnFh+PsGmjp
	 0ue0G/Q6UzfiqBGTCBR4wqpjD2i5vTiW3HGjHCc8yP2DwMQa8j29TFj8mm3+LyHX1g
	 qgUYPIgdaZtvFqTfHAdLSnX1MI1GG7+fmnc1E636u4SFsKm/kUNBsKKiXcfSyF1CtL
	 VHyN/YZZPYIfiyRK55/yuhv15mN2m+ev5wjOqxS7Z20Mjm4kYK3Pc/+p3w7a6SdY82
	 7c98+1t4ajL1p4ZEZwVLZ0Z571xO6h6z0yywDruifZf7AEqgPU/KKoGvOi5qXfajcf
	 AykigJwFu5pkA==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id T4drpCGRfyAOeT4dspgoq0; Fri, 17 Feb 2023 17:35:28 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=63efbae0
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=kE3qPM3sFhkr_6mp_J4A:9 a=QEXdDO2ut3YA:10
 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <c3d45391-cbfe-3939-f990-0a127651693c@Shaw.ca>
Date: Fri, 17 Feb 2023 10:35:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: Cygwin build utils dumper fails - new prereqs required?
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <545a5149-0470-6541-9a27-5cdb74f646c6@Shaw.ca>
 <cf7530d5-2b99-b6b1-1b14-42c2707ac10c@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <cf7530d5-2b99-b6b1-1b14-42c2707ac10c@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCsM0oToG3UznVEM931sF6jfjG5nwyfNDVnepgrSAy8KbRVQGk6AvH9AhDOGraNXulr/6sP0K8ACt6/bULgCDujppC4osy/p+994halty+l9JUk/ECT3
 MyamdKfGV2f+ubGETNyFOQ5Ffc47P/x7njAL+wHRy2JNNf6cYSqM9kcVt9nCOFIyI/XYaQyaD7Wri6IHyE02HMkvEKcVtOxB+TU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-02-17 06:14, Jon Turney wrote:
> On 16/02/2023 23:02, Brian Inglis wrote:
>> Hi folks,
>>
>> Building Cygwin from latest repo testing some unrelated doc patches and 
>> updated Unicode tables.
>> Cygwin utils fails to build dumper.
>> References to elf and binutils debuginfo, and undefined references to 
>> sframe_de-/encode ZSTD_de-/compress/_isError in attached log - config and 
>> normal processing suppressed and paths sanitized!
>> Are new prereqs required to be installed to satisfy, or something changed to 
>> suppress these references?
> 
> Yes, to build dumper with libbfd from binutils 2.40, you need libzstd-devel and
> 
> https://cygwin.com/git/?p=newlib-cygwin.git;a=commit;h=1387ea9f984d5a7aa096a66b67d61dc2cc565d21

Thanks Jon,

I saw that after I emailed, and both zstd and -devel, like lzip/-devel, have 
been in my Cygwin build install for a while.
I have since rebuilt without any issues.
Weird!
Could I have got a messed up git pull --ff without error messages?

-- 
Take care. Thanks, Brian Inglis			Calgary, Alberta, Canada

La perfection est atteinte			Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter	not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer	but when there is no more to cut
			-- Antoine de Saint-Exupéry
