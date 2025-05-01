Return-Path: <SRS0=4Twd=XR=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 7A6B53858D20
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 19:06:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7A6B53858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7A6B53858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746126366; cv=none;
	b=LlIvsYNiycd2PK3w7cL96W98esNUV/7o28uXtdcJ4/h/afjT4AVrIhvOx8riuIinK4X0asOXlp/1weKspCP/RFjqaCsquhniFvoJxyXNOvHRcsjSxP9MuG7dX+rtpjQYDOCijE8P27v+fxyO/Oo3Mhj7lVMezFrIz2GanKoEt8w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746126366; c=relaxed/simple;
	bh=DW4tOOsa2FbJ5Vgq5gTR/qo9lR1Snj7cBpsevNY1IUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=jJdR6bXlFzPVLUSuCZU/FV7zh4xEn5uMxlyVFvf/MNhz23viYzKi0VrS683sZUjkAmsJ7cCBWpLEgsWHGSdYL4Ut5oJLK3yeBAunZv0sqpJpFF8VlPPtBOC0NXcK4jT2Ssb74PK9lN1+K8YTIWYl6PneQEf2JEMqyGfTI0oV3Us=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7A6B53858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=hr5sbn+x
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 230091CFADF
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 19:06:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf08.hostedemail.com (Postfix) with ESMTPA id A071920026
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 19:06:04 +0000 (UTC)
Message-ID: <ac8b305a-70c5-4cfa-bd6d-792dbede525e@SystematicSW.ab.ca>
Date: Thu, 1 May 2025 13:06:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: clock_settime: fail with EINVAL if tv_nsec is
 negative
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <f21927b5-defe-529d-3095-0c1f51e23eb7@t-online.de>
 <274da5b5-b94c-4ccc-8b58-713965a62e93@dronecode.org.uk>
 <09edeb3e-6c0c-74bb-75df-a7dd2bde2e5e@t-online.de>
 <9e95644c-c152-00ed-14d1-725252066fa6@t-online.de>
 <916eb947-c497-4485-b230-50a67c4e8b91@dronecode.org.uk>
 <77d581c2-88ee-3ae1-a6f0-69c2d6bd641b@t-online.de>
Organization: Systematic Software
In-Reply-To: <77d581c2-88ee-3ae1-a6f0-69c2d6bd641b@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: A071920026
X-Stat-Signature: m8kqrof7zyo5i8fcmrkbjwq7n78kagxh
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX188XUuFtR2TZ7ftk/QZFD8Tg5w658RlBeA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=KYbeoSGLd68LYzxkINHyTVifYq12a35ZZWy42aLskFE=; b=hr5sbn+xkq1x6yhs/CCwSSu1z+GhihN+yxQFHuD9Q2eYqp3kbJ5e0Sfbm4uOYDuVHP3k404DRmq97LY2+SwmU9pT+s2jP2my3iZffq1G/5I7YZqBnx8sDdZbLAlBnZCAElhlsoHkNXXuc0Y0lYIlEsk7kGkpj/DZGPdn3V0cCAzWsDRwdYWZtsjhL0+bqQbvO11PC8gCxvqL+CRAdFp96ZIBzII88Xg/g1twvzQRk6ctsgWJDyJ05jL28elSJofJtXwyDFtgHVcceJLNSRH+0FugEYPVvRZhT7lcDW9re8iJno8X8IkY3mmczUm54jZfQtTtjHFd2ow8/to1mxZk7A==
X-HE-Tag: 1746126364-166069
X-HE-Meta: U2FsdGVkX19yOaEFBxy6CPZlNCh1/8dm68PqvU5vWU02wkB4bNkllcB9wx00iM/OFaNKng327GBkUF7kARvwhY5+GmWhmaFAov2Mh3Uex+rpgigaY94l5009Qb5dS+W++AbkoaaynMkH+8d8g4elLN5YgqyTp/W6xin52ibQwfPVFGVwHMM8xQg8J5CvGx+lIt88lwHeGW4yu29nzCJ6c+YW6bQHI6BqvsIU0NYCaC2hAwrWmlweb+uHVceVJiPR8MYN57D/H7FEESbhYKhzfaSSKwyGFtmfmIid2AMUFPhM0tmtPVlC0Aqv1SV6YIp11/D/Rz+LZJIsdurnDDQfMGqew/iY8PAqYr1yuBStK629NGm8E4BoapARbauAbvsZ8DfzTlqeuYjGGXx21wUgv1aq2iNOGC+7F2AxYwgj8oYBnzy6AGnRKQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-05-01 06:29, Christian Franke wrote:
> Jon Turney wrote:
>> On 30/04/2025 12:33, Christian Franke wrote:
>>> Christian Franke wrote:
>>>> Jon Turney wrote:
>>>>> On 28/04/2025 16:43, Christian Franke wrote:
>>>>>> A followup to:
>>>>>> https://sourceware.org/pipermail/cygwin-patches/2025q2/013678.html
>>>>>
>>>>> Thanks!
>>>>>
>>>>> The SUS page for clock_settime() contains the following text:
>>>>>
>>>>>> [EINVAL]
>>>>>>     The tp argument specified a nanosecond value less than zero or greater 
>>>>>> than or equal to 1000 million. 
>>>>>
>>>>> ... so if we're going to validate tv_nsec, it seems that's the range to use
>>>>>
>>>>>
>>>>
>>>> Yes. The patch only checks the lower bound because the upper bound is 
>>>> already correctly checked later in settimeofday().
>>
>> This is just prompts me to further questions: Is settimeofday() specified to 
>> permit some kinds of non-normalized values?
> 
> settimeofday() is not part of POSIX, Linux settimeofday(2) only says:
> 
> "
> EINVAL
> Timezone (or something else) is invalid.
> "

Our std-...xml docs say BSD, and Free/NetBSD say BSD 4.2, with timezone ignored 
and set to zeros since 4.4.
They are also in SunOS/Solaris, HP-UX, Darwin, CentOS/RHEL, Debian, and likely 
AIX and OSF/1 aka Tru64.

Free/NetBSD [gs]ettimeofday(2) say:

RETURN VALUES
     Upon successful completion, the value 0 is returned; otherwise the value -1
  is returned and the global variable errno is set to indicate the error.
ERRORS
     The following error codes may be set in errno:
     [EINVAL]    The supplied timeval value is invalid.
     [EPERM]     A user other than the super‐user attempted to set the time.

--
RETURN VALUES
     A return value 0 indicates that the call succeeded. A return value -1 
indicates an error occurred, and in this case an error code is stored into the 
global variable errno.
ERRORS
        The following error codes may be set in errno:
        [EFAULT]    An argument address referenced invalid memory.
        [EPERM]     A  user  other  than the super user attempted to set the 
time, or the specified time was less than the current time, which was not 
permitted at the current security level.

These sys/time.h docs specify struct timeval since the Epoch, as do 
clock_[gs]ettime struct timespec, and imply only positive values, probably with 
us/ns value limits, as they are expected to be running system clock values.

> It is also usually missing in the docs that negative time_t values are accepted 
> by gmtime() etc. This works on Cygwin and Debian:

The TZ, C, and POSIX time.h docs with time_t/struct tm interfaces support a wide 
range of years defined in TZ to be +/-2^59s > Big Bang ~13.82Gyr.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
