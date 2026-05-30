Return-Path: <SRS0=pqsL=D3=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 931404BA23E2
	for <cygwin-patches@cygwin.com>; Sat, 30 May 2026 16:03:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 931404BA23E2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 931404BA23E2
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780157003; cv=none;
	b=GLffFAtIK00yV+Yvc172m3SAqH+nYTZpzcOxz86FzFJH8zRgnwF2OrVrHdI04qGQSZDrC10k2JugyYPlNkQG5Piq2boqkx9D3Sj8Hp47HTvq1yXQKZ0u6arlbs5dgZ5okDAZnIfYdt17kHERjL4XwF46TDgKlx57xs27urt997o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780157003; c=relaxed/simple;
	bh=vmYjjRd/xDSZRNL+ljCAGIeefMVqxbP//zwyEoqOim4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:DKIM-Signature; b=QkJtnGr/2+FHb6wxlGLe7p8GPgbqwlcVNzyOAmhfkrSM/zKdjtk+ogu2A6lZkjGe0skVeHmYMmfL3QUDBMC9u9u24XkAVjmV03tSAbPWWXzGgXGcLnSBtqejEHqOuaQRP7CynTQp5k5fjd4YFOUbBj8nwmAckebescT23B8DsB0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=TUCMU4AR
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 931404BA23E2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=TUCMU4AR
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 30122161A86
	for <cygwin-patches@cygwin.com>; Sat, 30 May 2026 16:03:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id B589820028
	for <cygwin-patches@cygwin.com>; Sat, 30 May 2026 16:03:18 +0000 (UTC)
Message-ID: <f3d9fd85-7055-436e-b78f-12a925320043@SystematicSW.ab.ca>
Date: Sat, 30 May 2026 10:03:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Cygwin core component patch submission and discussion
 <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: cpuid: add AArch64 build stubs
To: Cygwin core component patch submission and discussion
 <cygwin-patches@cygwin.com>
References: <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <54c93ea8-3e7a-4045-b1d0-2671c8ebef2f@dronecode.org.uk>
Content-Language: en-CA
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <54c93ea8-3e7a-4045-b1d0-2671c8ebef2f@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: ehxip7skdfzxzwmwpx95p4zwor1nqyge
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: B589820028
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18a2NpUlpuSQosq388b8J/w8o6b1tzfRUQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:subject:to:references:from:in-reply-to:content-type:content-transfer-encoding; s=he; bh=2gGMstMZ2w8owLaFTpynEoX2Ybc/EPGTs4XgLZqbpCk=; b=TUCMU4ARmN1ng2S4Aua7PfQu/dSnvvOXWJlN24RCW5B8b9bjANNTYp/iYDHCID45A7vcFyco9EaSEWDy3EH/pZ5sOPb3OJiNXsJX+bxANN2261j+j9VqrFaIM1Jl6y5s4uIuiAi6KimmBe6BKP+L3R+841J+3HpM2tcu0MCmBnpEpPXu2w/YXB8L3JXjSrPC91hmwx5p5VnG7uMzLpTNSWpfuxJXlSdDtgcKqgG3DfmpfdFlckrbW5RHmXgHMOjB/g3EXa3JQqdIp6A8FoVlkGzHcG61fpy/fX6LsgTKG74i+/HulFSwka66fKUTBUnqljEAIDDSjaXda4CFLPivHw==
X-HE-Tag: 1780156998-88422
X-HE-Meta: U2FsdGVkX1+AwCWYhxAxWQNWFD3KXzrprFQK/utRghQlZi+e+PtIAv2QuJzrX4q/5dEgJ1GUyyxCq+klZcEoYk+cpuWNH1TkMAd8fuND8Dc+6fc9MG6NLoJRIcyDY9KAW7I9bv9GyoocZ6qQ7RCEL4VbLik5N8k+IdfwjfaFcaukiQJ5rje6cvIczsE94xKWxpELLsrxwaf6mvYg5T3AD7LNN9r+anyE30vIO6NrYosMybI55EBAUNXZGXkusb6t6F6Xd4d3Q5vSfPbHdanrL3emI5FKYrnjPMmCbVOehJuKCtm6AzP/WAUGMv5dSlwnxeFDK9ILXRntWanOetGAbig7Ii1LhNdm
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-05-28 06:33, Jon Turney wrote:
> On 07/05/2026 11:45, Chandru Kumaresan wrote:
>> Hi Corinna,
>>
>> This patch adds ARM64 support for CPU information and cache detection used 
>> by /proc/cpuinfo and sysconf cache queries.
>> Thanks & regards,
>> K Chandru
>> In-lined patch:
>>
>> ---
>>   winsup/cygwin/fhandler/proc.cc       | 242 +++++++++++++++++++++++++++
>>   winsup/cygwin/local_includes/cpuid.h |  21 ++-
>>   winsup/cygwin/sysconf.cc             | 148 ++++++++++++++++
>>   3 files changed, 408 insertions(+), 3 deletions(-)
> 
> Thanks.
> 
> I don't have any substantive comments (apart from "oh, you're supposed to grovel 
> over a registry key to get the cpu information, nice :(").
> 
> Brian,
> 
> I think you're much more familiar with this area of the code than me. Please 
> chime in if you have any comments!

Thanks Jon,

Never received the original patches in my email, so imported all from p-i, and 
will have a look soon, comparing against x86_64 and Linux-next x86 and arm64 
cpufeature enumeration and cpuinfo output.

It would be easier if MS Windows also exposed elevated CPU and MSR info to 
regular user space.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

