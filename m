Return-Path: <SRS0=vMV5=FB=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id AC0EB4BA2E05
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 07:58:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AC0EB4BA2E05
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AC0EB4BA2E05
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783411132; cv=none;
	b=KO45KyUCGcp7OWASDpShBAsGdmt4kd7kE+fl+90l+o7K8J46csMpnaXIOaBD9vdvG0HyCA1QJTyZYAWcmZNsdfMv9RWukV1F1YdpkpVdnRTaluImMMLIsWOGFwhL9d5/90ObWbSj8NELpMXWD9MhShaClZTX/juvRd5+hHlDaEU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783411132; c=relaxed/simple;
	bh=13FxnEiV8mA8ZnNvudrZBy/DetRWgjTNnvakFvNF/PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=oEGXRvXwdC+vy6S8n2KFiUSQlwKTh8mePWFnjA8hnHE1TmoYWirH2DV7jdP4iTvUVnLajDTd57SMIJd1vD2vCCpwVEuGRLSTCER4gNEx+XhppDIMuDvyCGj4CZJxcuenCIFcEnC5cr54lTBnq73DsRczzJhNMiat+O21sCOROhQ=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AC0EB4BA2E05
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6678DgLs072382
	for <cygwin-patches@cygwin.com>; Tue, 7 Jul 2026 01:13:42 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdKL7oAG; Tue Jul  7 01:13:39 2026
Message-ID: <646b21e0-df07-46c0-95c2-854405cc1d30@maxrnd.com>
Date: Tue, 7 Jul 2026 00:58:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Fix error return for madvise()
To: cygwin-patches@cygwin.com
References: <20260706234758.89659-1-mark@maxrnd.com>
 <20260707094551.c89e6c61a79c534f6c385d5a@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260707094551.c89e6c61a79c534f6c385d5a@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 7/6/2026 5:45 PM, Takashi Yano wrote:
> Hi Mark,
> 
> On Mon,  6 Jul 2026 16:47:43 -0700
> Mark Geisert wrote:
>> Currently madvise() and posix_madvise() are wired together as one
>> function: the latter.  But their error returns should be different.
>> Make madvise a first-class export in cygwin.din; code a new madvise()
>> that calls posix_madvise() and massages any error return.
>>
>> Reported-by: Christian Franke <Christian.Franke@t-online.de>
>> Addresses: https://cygwin.com/pipermail/cygwin/2026-July/259872.html
>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>> Fixes: 61522196c715 (* Merge in cygwin-64bit-branch.)
>>
>> ---
>>   winsup/cygwin/cygwin.din               |  2 +-
>>   winsup/cygwin/include/cygwin/version.h |  3 ++-
>>   winsup/cygwin/mm/mmap.cc               | 12 ++++++++++++
>>   3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
>> index 2e53bc819..937eacdaf 100644
>> --- a/winsup/cygwin/cygwin.din
>> +++ b/winsup/cygwin/cygwin.din
>> @@ -951,7 +951,7 @@ lseek SIGFE
>>   lsetxattr SIGFE
>>   lstat SIGFE
>>   lutimes SIGFE
>> -madvise = posix_madvise SIGFE
>> +madvise SIGFE
>>   makecontext NOSIGFE
>>   mallinfo SIGFE
>>   malloc SIGFE
>> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
>> index 71ac5282b..fc838e23e 100644
>> --- a/winsup/cygwin/include/cygwin/version.h
>> +++ b/winsup/cygwin/include/cygwin/version.h
>> @@ -502,12 +502,13 @@ details. */
>>     360: Add RLIMIT_NPROC.
>>     361: Export _Fork.
>>     362: Export C23 stdbit functions.
>> +  363: Export madvise separately from posix_madvise.
>>   
>>     Note that we forgot to bump the api for ualarm, strtoll, strtoull,
>>     sigaltstack, sethostname. */
>>   
>>   #define CYGWIN_VERSION_API_MAJOR 0
>> -#define CYGWIN_VERSION_API_MINOR 362
>> +#define CYGWIN_VERSION_API_MINOR 363
>>   
>>   /* There is also a compatibity version number associated with the shared memory
>>      regions.  It is incremented when incompatible changes are made to the shared
> 
> I don't think we should change CYGWIN_VERSION_API_MINOR value
> because the API itself is not changed. This patch fixes a bug
> in madvice() implementation.

I went back and forth internally on whether the minor version should be 
bumped.  One point was whether divorcing madvise() from posix_madvise() 
in cygwin.din warranted an API bump: without a bump won't existing 
programs be unable to access the new error return behavior?  Another 
point was that the error return behavior of madvise() is being changed; 
isn't that behavior part of the API?  I agree this is a bug fix but such 
fixes could cause API changes.

This is a case where I'd like to get input from other folks who might've 
made similar changes to Cygwin over its long history.  I am totally OK 
with removing the API bump in a v2 patch if that's the consensus opinion.
Thank you for the review!

..mark

