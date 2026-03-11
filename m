Return-Path: <SRS0=8SjE=BL=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 0CE784BB5894
	for <cygwin-patches@cygwin.com>; Wed, 11 Mar 2026 17:11:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0CE784BB5894
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0CE784BB5894
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773249070; cv=none;
	b=EtcCfkGNRHyY9LGYHjHHEHQj96KDSkLOS0sA6GdW9iOEu8ZTKWHVidv7RxJU7Pq3CO9rEsPL3FTIdOvnLF4MKTBirp3iuHVQiZ0eX+zooY+Q9zQzbh7fuepaNJfXFBf3Jx0Y1qYs1M4Xx1qxWJXQZX/sYbZfGVtI8w2TMyq6AoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773249070; c=relaxed/simple;
	bh=0BL/6yJJ0BJXX1yiyLNK2JCpn6tdfW6fi2y+aB2th64=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=NJkc8F7wPYFzi9mTOjQ1ql1UeMXsC2Paw42Il3HrDlCka69Y+krnU2+cgVkiupwUmwezWP3ZFC2GCqLn61bznjBnBVLlabTJhzQtCfbUgv0Z4SR0o3IyinmeAn4/OG6q1fbybtCaDzaP+ACxNBAfJGvwQSrOpjVWWRHOxmKveZQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0CE784BB5894
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=FSf2hHsJ
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8C8021B748D
	for <cygwin-patches@cygwin.com>; Wed, 11 Mar 2026 17:11:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf18.hostedemail.com (Postfix) with ESMTPA id 27E6F33
	for <cygwin-patches@cygwin.com>; Wed, 11 Mar 2026 17:11:08 +0000 (UTC)
Message-ID: <be24eeb3-bf47-4636-ae7f-f1a8d6ec0417@SystematicSW.ab.ca>
Date: Wed, 11 Mar 2026 11:11:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: Cygwin core component patch submission and discussion
 <cygwin-patches@cygwin.com>
Subject: Re: HYPER-V VMs: Cygwin /bin/getent group 'Virtual Machines' cannot
 find the group
Content-Language: en-CA
To: Cygwin core component patch submission and discussion
 <cygwin-patches@cygwin.com>
References: <CANH4o6P07DG5XcSooXkAE5ShWkkz1hVBSMn6k2iaLycSEEA_0A@mail.gmail.com>
 <CA+1jF5oHw71rv-OH893R+DdNpnRUQAtp=WS_fXvxe1WBsC0H6w@mail.gmail.com>
 <abGHUBD2oHK6bo5K@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <abGHUBD2oHK6bo5K@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 27E6F33
X-Stat-Signature: jkpgwij8q7iqt9t19d5zcmo9x9x637yn
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/Foqjl4FHC3MZX4a26SfD+SoploAInNnQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=3iTalDhGD/u42fZLINLSZM4dRYR+BP4i/RwmUb1QwjM=; b=FSf2hHsJDAYYbZ3FPaAYJLkMNR2LI+Dfn9DvHEJstCbNeGIg05zb4rICbjL9ALpimKy3aP3WLnhCXjXzCEL+F1/yCSy9b9sVj4gBfCbZmmHohnKprDYoeTuH/JGP7ZyMQtpgj7E8aVIBvwidIB2TFUSzF3imsvh/iWXRcoUA29l0GhVrlq2guS9RAXM5yuuBghmRmqpemvPvIaXTiL6WoBMrALibKbK/Q81DBxUK4rnnuz2kh3jInR0pWCtZi2dJCzEKgpT3BRrvDCghYCf9hRWInRmtpw6bB4Ycs0SzhaCyYWGQqG/orfJcnZSBPYs8unyUK+eQDg5ZBiv06RON0g==
X-HE-Tag: 1773249068-477826
X-HE-Meta: U2FsdGVkX19ar8JrWEXjEriQo06bK7KP+mgZOcMT96K74cUQdsZPA3T7tAWaK4MZej5/xwrlec/tbLDCzQN2uFkiKaxVcXFMVDrLsecu9QnIbMC/KStrjPiF/1JZSj3gC3uOA6EFLB1bVbxNDFTj118oxknXpq7jlLjOQpoIvswlRwfpql0AW9y3Lkc3NiBzg8B4yRiT8ZBVpbI5ckgxV8zA6xPlfEkYqsSF7Yy/A5LMaS9BxmgorepU83gyboz5cxXSkPiHAFb45dGlWatshqL1t5IFHQ7ulM/8q/qG7QwWnUWdx1JhNtP2vfSu79i5cJZMzw1bQI1J3X5VMIkfOuz/JEQ6ccF0CGgrv5NpUfmhuvEsRjTe+4Xp7n2lK4oFpTjE/1Fu9Vfat/U1wSnzPUUbcefkO+IZmueZq4T5ZO0Rco2HkCot/w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-03-11 09:16, Corinna Vinschen via Cygwin wrote:
> On Mar  3 09:26, Aurélien Couderc via Cygwin wrote:
>> On Mon, Mar 2, 2026 at 8:19 PM Martin Wege via Cygwin wrote:
>>> we use HYPER-V virtual machines on Windows 10 and Windows 11. It seems
>>> they use a "special" kind of group called 'Virtual Machines', which
>>> Cygwin (3.6.5) /bin/getent cannot lookup:
>>>
>>> getent group 'Virtual Machines'
>>> <nothing>
>>>
>>> Does anyone have ideas or clues how to get getent group to work with
>>> this kind of Windows group?
>>>
>>> We want the Cygwin gid for that group, and use Cygwin commands to work
>>> with those files...
>>
>> Déjà vu
>>
>> 1. Please read https://cygwin.com/pipermail/cygwin/2025-July/258505.html
>>
>> 2. Try this:
>> getent group "NT VIRTUAL MACHINE+Virtual Machines"
>> For me, with default (empty, except comments) /etc/nsswitch.conf, it
>> does not work. Which I consider a bug.
> 
> It's not a bug, it's a feature.  Truly so.  Keep in mind that there's
> no easy translation from arbitrary SIDs to 32 bit uid/gid values and
> vice versa.  So every time, Microsoft adds YA arbitrary SID not following
> the already implemented and supported schemes, the bijective mapping
> has to be implemented manually.
> 
> Done in the main branch.

Are these default behaviour with other builtin symbols, or do they need enabled 
with a db_enum value?
It also looks as if nsswitch files and docs need updated in that case?

Why not also use the ..._ID_BASE_RID symbols rather than unobvious arg.id hex 
value comparisons, to tie the comparisons together consistently?
The other arg.id hex value comparisons could also do with similar treatment; are 
there any missing value symbols, do you know?

So are PTC with any advice if SHTDI?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
