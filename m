Return-Path: <SRS0=7rK+=FC=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id A17414BA2E11
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 21:04:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A17414BA2E11
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A17414BA2E11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783544699; cv=none;
	b=Ayc3OeX0l7SwPJ/vXBFgwagspS+hVD2BaVThJAfUhEmjAoQb38Gjp8/VQMDBcI8z40tCJCBEzHzHeCcypp2HqnU37HOCzLDmr/7nkNNtPkxBilUZVuxuS7WS/hkH0AAOLW85qxOjmV3tN2QowgMm1P/QSX+8R+EPSrqi2EDtNWA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783544699; c=relaxed/simple;
	bh=rKuTpKUKKfOAGPuoCaZ1tPdh+kBO4SdnAuKqFj0KqAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=eOXdRixllfRYCiw+r9g9I0oN9U7q3FyxTdj/ckUASdly4LEC+P6+UUmtnS7HF56qGJlobm+jGTDmxYJQSQ03OpApTZ20QosgpUGAcydjHAqfwgdVBx5JZYVN9Hr51/YzmW5pv+ew+FbZTI6a+3P+X8RYOhhf0AD3SzAcd+z4+1o=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A17414BA2E11
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 668LJmI5061375
	for <cygwin-patches@cygwin.com>; Wed, 8 Jul 2026 14:19:48 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdSwf0Ac; Wed Jul  8 14:19:42 2026
Message-ID: <77c47130-8a2f-4de0-ac6d-d80480bdbf20@maxrnd.com>
Date: Wed, 8 Jul 2026 14:04:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Fix error return for madvise()
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q3/015163.html>
 <20260708080349.570-1-mark@maxrnd.com>
 <dbe2155d-198f-76a8-13ae-924001cdf1b1@t-online.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <dbe2155d-198f-76a8-13ae-924001cdf1b1@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On 7/8/2026 7:58 AM, Christian Franke wrote:
> Mark Geisert wrote:
>> Currently madvise() and posix_madvise() are wired together as one
>> function: the latter.  But their error returns should be different.
>> Make madvise a first-class export in cygwin.din.
>>
>> v2: Create madvise_worker() and have madvise() and posix_madvise()
>>      call it, then handling their error returns compliant to POSIX.
>>      Add a release note for 3.7.0.
> 
> LGTM, thanks!
> 
> 
>> ...
>> -extern "C" int
>> -posix_madvise (void *addr, size_t len, int advice)
>> +static int
>> +madvise_worker (void *addr, size_t len, int advice)
>>   {
>>     int ret = 0;
>>     /* Check parameters. */
>> @@ -1514,6 +1514,26 @@ posix_madvise (void *addr, size_t len, int advice)
>>         break;
>>       }
>>   out:
>> +  return ret;
>> +}
> 
> PS: The 'goto out' could now be replaced by 'return ref'.

I prefer to keep both 'goto out' so there's just one exit from the 
function to aid future debugging. Perhaps that's an old-school habit.
Cheers,

..mark
