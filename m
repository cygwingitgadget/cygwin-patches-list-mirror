Return-Path: <cygwin-patches-return-8757-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72150 invoked by alias); 22 Apr 2017 14:34:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71109 invoked by uid 89); 22 Apr 2017 14:34:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=no version=3.3.2 spammy=H*Ad:D*t-online.de, explorer, emphasis, HTo:U*cygwin-patches
X-HELO: mailout09.t-online.de
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 22 Apr 2017 14:34:26 +0000
Received: from fwd20.aul.t-online.de (fwd20.aul.t-online.de [172.20.26.140])	by mailout09.t-online.de (Postfix) with SMTP id 1B2CF4239428	for <cygwin-patches@cygwin.com>; Sat, 22 Apr 2017 16:34:26 +0200 (CEST)
Received: from [192.168.2.101] (bVAMK0ZXYhQVFuAUmgx2Hojqu-286cWYS3r8y0gJz6WnfejkgldlA11xzG1tRw5ZN4@[79.224.126.58]) by fwd20.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)	esmtp id 1d1w76-0rRGHg0; Sat, 22 Apr 2017 16:34:16 +0200
Subject: Re: [PATCH] Fix stat.st_blocks for files compressed with CompactOS method
To: cygwin-patches@cygwin.com
References: <81896c1a-a5c8-1f96-c478-5e24f7c1eb56@t-online.de> <20170422135909.GC26402@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <511c97f0-6f05-3ecc-7b12-018480027d42@t-online.de>
Date: Sat, 22 Apr 2017 14:34:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0 SeaMonkey/2.49
MIME-Version: 1.0
In-Reply-To: <20170422135909.GC26402@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00028.txt.bz2

Corinna Vinschen wrote:
> Hi Christian,
>
> On Apr 22 14:50, Christian Franke wrote:
>> Cygwin 2.8.0 returns stat.st_blocks = 0 if a file is compressed with
>> CompactOS method (at least on Win10 1607):
>> [...]
>> This is because StandardInformation.AllocationSize is always 0 for theses
>> files. CompressedFileSize returns the correct value.
>>
>> This is likely related to the interesting method how these files are encoded
>> in the MFT:
>> The default $DATA stream is a sparse stream with original size but no
>> allocated blocks.
>> An alternate $DATA stream WofCompressedData contains the compressed data.
>> An additional $REPARSE_POINT possibly marks this file a special and lets
>> accesses fail on older Windows releases (and on Linux, most current forensic
>> tools, ...).
>>
>> With the attached patch, stat.st_blocks work as expected:
>> [...]
>> -  else if (::has_attribute (attributes, FILE_ATTRIBUTE_COMPRESSED
>> -					| FILE_ATTRIBUTE_SPARSE_FILE)
>> +  else if ((pfai->StandardInformation.AllocationSize.QuadPart == 0LL
>> +	    || ::has_attribute (attributes, FILE_ATTRIBUTE_COMPRESSED
>> +					  | FILE_ATTRIBUTE_SPARSE_FILE))
> Are you saying these files actually have no FILE_ATTRIBUTE_COMPRESSED
> bit set???
>

Yes. The only evidence is the CompressedSize.
There is also no visual emphasis in explorer listings.

Christian
