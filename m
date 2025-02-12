Return-Path: <SRS0=dz9W=VD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by sourceware.org (Postfix) with ESMTPS id 14D7E3858420
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 17:43:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 14D7E3858420
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 14D7E3858420
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739382195; cv=none;
	b=p//kt+tfp2Xw34jMzSEA9EUIqZMtY/pYUOqbFrTQjlTVY0EyZmCXzrCZMOv1hxBFAA8C3qDXZcyR30YsZjO0xus8X8tDoipeTFOcQwIExzfQJ6m0DP7DtP8wqAzzn3V801c24x55oQ6DkMCmym4URC+XDKoA2Gw2R9glpd4EFsY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739382195; c=relaxed/simple;
	bh=Lzl3clJOvt+7g6XrZ0uQ/L3QrttFp2fYcBHhRdOvECA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=I9oSesKrDscuSIUsN04vA0bYNOzHa6ykSDLg3c7ZfK6sooPV+zj16paL8XIW62vDrQyHWkjoJK6R6y1cYMWUz+gJc30I3bZviu4B9b3RYoi2PPrW83F6h9oiC8Te2ezEWrG+FdF+NNBwoB8NA27OCHfpd8IweVcRRdO0sY62VvA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 14D7E3858420
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=Hm2VyCbC
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C2B641C69C8
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 17:43:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf01.hostedemail.com (Postfix) with ESMTPA id 5409F6000F
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 17:43:13 +0000 (UTC)
Message-ID: <06ffd3ff-65ec-4ff2-8279-9a6ce494b790@SystematicSW.ab.ca>
Date: Wed, 12 Feb 2025 10:43:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: make list of mounts for a volume in
 dos_drive_mappings
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <827294fb-0391-197f-6b53-52ea0f5e11e7@jdrake.com>
 <Z6soHzMvH9hcJMRY@calimero.vinschen.de>
 <b724a9a2-3882-298c-f0f0-58563cc5c863@jdrake.com>
 <Z6yU__7mYxK7htjw@calimero.vinschen.de>
Autocrypt: addr=Brian.Inglis@SystematicSW.ab.ca; keydata=
 xjMEXopx8xYJKwYBBAHaRw8BAQdAnCK0qv/xwUCCZQoA9BHRYpstERrspfT0NkUWQVuoePbN
 LkJyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFN5c3RlbWF0aWNTdy5hYi5jYT7ClgQTFggA
 PhYhBMM5/lbU970GBS2bZB62lxu92I8YBQJeinHzAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAAAoJEB62lxu92I8Y0ioBAI8xrggNxziAVmr+Xm6nnyjoujMqWcq3oEhlYGAO
 WacZAQDFtdDx2koSVSoOmfaOyRTbIWSf9/Cjai29060fsmdsDM44BF6KcfMSCisGAQQBl1UB
 BQEBB0Awv8kHI2PaEgViDqzbnoe8B9KMHoBZLS92HdC7ZPh8HQMBCAfCfgQYFggAJhYhBMM5
 /lbU970GBS2bZB62lxu92I8YBQJeinHzAhsMBQkJZgGAAAoJEB62lxu92I8YZwUBAJw/74rF
 IyaSsGI7ewCdCy88Lce/kdwX7zGwid+f8NZ3AQC/ezTFFi5obXnyMxZJN464nPXiggtT9gN5
 RSyTY8X+AQ==
Organization: Systematic Software
In-Reply-To: <Z6yU__7mYxK7htjw@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5409F6000F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: szpumabi8nyroj7k1jkgr7kigqsm6k3j
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19S9AvatBsHU9hHDfPulpGG8ay/KZeDCEo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=01KRhIz9fJnsLIBaTE1bHd4HGV9iY6DDUBNlidDf+rw=; b=Hm2VyCbCqqTXfMQYK0iK3+QlM1s1Js6NIO2DaktqM5mMUW6iOXMmItvv9qM0WStJGapc3aWUXr0WfqRcbmov65+c69i44NWDSK3RASFEN87V17ufFQBLTNf0aQ/fglCLg6DNLyH4TO4HRgZP+dHR8xLUgEeim8QZQTQX5jb7T4R2y9Wee8QagM1tovfdjV9W3AG31V8ziNWM/YBTdd07LV7nWOyV/UMhyF0MROMnDX2ePSEArtoEZZK59C4WtB47ZuwWb83n3mFGJUNirGwaoWxty1KleULYXOHH6LpgXV7G1M114kiHzXiB4VQasCuMnjCHsPs+f95dmCw7qsj2pg==
X-HE-Tag: 1739382193-398927
X-HE-Meta: U2FsdGVkX1+vUqvJIk75AQ8tPUUM5KHMpbCR3Nw0bZhKXk1SiFNErYFkj6M/O13Ny394RSfrIyVQCzPO8ujrRiLm0T70+xs/zUQhCoJTJRpX6y6Do6td0M1S4Z2K7j8pzgNnlhm1tMNyIbD28vFil585jxvGJOzpCLMSx1fd8J3MsoPXEJpFsb8oo/IM3BLQqoYKvVAZtXJ/sk2fUt+SpY0tjs9tWgwMMowdyt3xT4If8rcigvtw9jdBWEoOq0AvFjG6q/EvHErjsj4aqWcej42fa3mE1SyNNtcVJZNef2MnzB24X4UPgCNHLuKSDoFSEnWGcbCORAJ0ukGobXhoBE84m9oH96r6GKfOEXqYxXg87V3gUwIxbQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-02-12 05:33, Corinna Vinschen wrote:
> On Feb 11 16:13, Jeremy Drake via Cygwin-patches wrote:
>> On Tue, 11 Feb 2025, Corinna Vinschen wrote:
>>> On Feb 10 17:13, Jeremy Drake via Cygwin-patches wrote:
>>>> make mappings linked list in order rather than reverse order.
>>> Why?  I'm not asking for myself, but for the commit message.
>>> It may profit a lot from explaining what the change is supposed
>>> to accomplish. :)
>> That's two good points: 1) I didn't write a proper commit message, I'll
>> do that for v3.  but 2), why does the order of the list matter?
> It doesn't. Or rather, it shouldn't. The drive letters were in order in /
> cygdrive just because of the algorithm evaluating available_drives. That's
> nice, but not essential.
>> On my system, the order returned by the functions matches my "expected"
>> order (my C: comes before my D:), but I don't think there's any guarantee
>> that that will always be the case. I don't think it matters other than
>> for aesthetics though,
> The order in /proc/self/mounts on Linux is the order in which the
> drives got mounted. You don't get them sorted unless you pipe it
> through sort. That's ok with me.
>> but I don't know the motivation behind returning the
>> explicit mount entries in native_sorted order. Is there any reason why I
>> might need to sort the cygdrive mount entries? I could see that getting
>> complicated.
> No sorting necessary.  I'm actually really only talking about the commit
> message. It should explain what you're doing and, especially, why.

Sorting could be achieved by inserting entries into the list in any required 
order, or by similarly populating an auxiliary array of list entry pointers in 
any required order.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
