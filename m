Return-Path: <SRS0=Gpw9=EE=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.80])
	by sourceware.org (Postfix) with ESMTP id CAA904B19719
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 13:30:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CAA904B19719
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CAA904B19719
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780925441; cv=none;
	b=LoBAmfwc6trKxhzxeDVjnGbucgvJqEy4cdRKMrKvEpGZI6nBkGY0uXQcQB0Ag97NHBXeRjoB7sNUY5gybldf53rtfeBoqEjj7eVKtez3FZgEbb1f8lXfi3YEsAd8Jm/7O9pufr81WJHwotwJcihzOv97StWTcB8g6jNyWhZ4Qbk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780925441; c=relaxed/simple;
	bh=iel4AKt8/C184EQe5M2av9nRNDa+MxQEvjuuH7Z618A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=TwYCOw0UIsIlqO8uFCBD6INQq93ztHRnNhdsTVk2PLfojCSGewwfnoQbDDbKNJENzJRCR6VlqqhEHzDiPIlFKHX8ycjnSAXOe7fbKPzfhEo4OJP0B1TJZBGn6SV2zHaUQYCdcME6aGjkj5cx9trZYdwwBMNuq6ycni1A8gu3e/Y=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CAA904B19719
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A03A62202212F50
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTFvPcZ4WhuMJvltRXM1vyRWHBWEdSXLDEh1vtBO5OUMNp2PCBSN7pgDAZTaw9VJFCpLRe6dP0ZctXm1tc0A6zXGcrnAgeCKR27+YUOLOiTS6NZLOjoB9BD6EO8fUaJGTbeM1Vz6vDVQjFNgHjub8MXF+klHTjB3YHDMIbqBQASerWgGGDtMzu0dcN+P0MtALZfFUwe6+M0AXr0+fJqQggG2AYTOBub2zxylTSAppqCMz0zmnPtCz9Mu7KGu2cjm/p2dpQWM2WlCb8a2VUFboQsBQeZGbuOQ9gR1w9AqOMiOThrvZF0PQ9H+V5LUzVUuCS6XRPzyp82CPPsQm3CiISCNtKL9SrEWTPw8yAjfLqni7HYEKylNSAquL6fd9nG2qsvlH/WfZiuCIPlRK/BoMvi2oLpiLQdeRpHuPaBn+7CuRqPEkHmAt8aeTCBbXvhcAbuQJEArTdnkNbW15n0pXe/pP5Li92uZsUv95ExKbtZeRK/y8uHalc2pwvx/tvxYDBs14qswrzbw7h6TrBk6HJ5PncfVBX8AsYaAJbbTQVMp+Wq0xxVvlbiZdeMKfn22D2mDPu3SV2ALMl/OEIxP6qm1nKvRYjXCbwyuiB0Q3/dWSgn37ETFEkG8EzYlCT7EYdVKcBIwQBcl8gXQcUn8+i6mjZ8CZE+jCFaypTa25HFwaQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A03A62202212F50; Mon, 8 Jun 2026 14:30:33 +0100
Message-ID: <a2f5c1a9-dd8a-4c7a-8b82-05188e5abc98@dronecode.org.uk>
Date: Mon, 8 Jun 2026 14:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Implement 'reserved' marker in fdtable entries
To: Christian Franke <Christian.Franke@t-online.de>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260522072913.574-1-mark@maxrnd.com>
 <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
 <d457a7fd-1eee-0dd0-b2f7-d46b84eeaa42@t-online.de>
 <743b62ce-feab-49bf-95d0-f958fd5dacde@dronecode.org.uk>
 <dd93e38a-84ff-8440-1b1d-fbea31fa6298@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <dd93e38a-84ff-8440-1b1d-fbea31fa6298@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 08/06/2026 13:10, Christian Franke wrote:
> On Sat, 30 May 2026 12:33, Jon Turney wrote:
>> On 22/05/2026 15:21, Christian Franke wrote:
>>> Jon Turney wrote:
>>>> On 22/05/2026 08:28, Mark Geisert wrote:
>>>>> ...
>>>>>
>>>>> The notion is that an fdtable entry provided by cygheap_fdnew is 
>>>>> marked
>>>>> so that another thread can't obtain it.  Care is taken to reset the
>>>>> marker when the entry is no longer needed.  Actually, in the usual 
>>>>> case
>>>>> the marker is overwritten with a pointer to an fhandler_base 
>>>>> structure,
>>>>> by the reserving thread, as the syscall completes.
>>>>>
>>>>> Reported-by: Christian Franke <Christian.Franke@t-online.de>
>>>>> Addresses: https://cygwin.com/pipermail/cygwin/2026-May/259664.html
>>>>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>>>>> Fixes: e859706578ba (* autoload.cc (NtCreateFile): Add.)
>>>>
>>>> Thanks!
>>>>
>>>> This all seems fine and reasonable, but I have a couple of small 
>>>> comments.
>>>
>>> A test with an enhanced version of the STC was successful.
>>> I could push this version (attached) to cygwin-apps/stc if desired.
>>
>> Yes, that would be great. Please do so.
> 
> Done.
> 
> 
>>
>> (I guess ideally after the fix is committed so it stays green, but 
>> it's red at the moment and I severely lack the time to investigate 
>> why...)
> 
> Some STC (e.g. trace-sigsegv) ocasionally fail when run as part of the 
> Cygwin CI workflow. Timing issues?
> 
> Could not reproduce this neither locally nor at GH.

That one seems to sporadically fail, but only on aarch64 runner.

> I would suggest to add this to stc.yml to allow manual tests independent 
> from push:
> https://github.com/chrfranke/cygwin-stc/commit/5c157ff6

Yes, that seems like a good idea.

Oh lol, it seems like I meant to have this run the x86_64 tests on an 
aarch64 runner as well as an x86_64 runner, but got distracted halfway 
through...

I've tweaked your change slightly so we just run on both always.

Thanks very much!
