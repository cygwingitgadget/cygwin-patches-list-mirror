Return-Path: <SRS0=cZ2+=S3=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id EC48D3858C31
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 18:53:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC48D3858C31
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EC48D3858C31
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733165607; cv=none;
	b=iD0Jr3hTRjpjtg91x9nN6t/gN649JgjIc4TVFCeGL/NSDQJ8Jo/Jp5Q1GJGorUcolJQU5bdBeqHnD/slV/AlK2GCFbvUVx1B9AkTFgTfNgFcQwSW39LKgus5U9tMb89m4d1qYLVxK4/ozKXBygXh7xEnbNsRy4HrZtz7b7B5cxk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733165607; c=relaxed/simple;
	bh=eFPb+s7QIylBGlIZvmvis3sO/L9ieIrhXIm+wI2S6ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:DKIM-Signature; b=AdgelaOpv3hnmJn+eVttzAnPg3QbOWT38H/FHOd2IZvTTdcfaZSDAD2orKyFCscE9lPAwXxERBjlVNeYcu3FhQ+yRQyH9JcMX4nx1E9QW1/X5KS1SPkHhcORzVJzyuE0YBLA1Vkz/OfdpVJWuKmqsjr+ORFBFahrx51t3ZWIqDw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EC48D3858C31
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=XbMDbAL6
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 895521C598F
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 18:53:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf06.hostedemail.com (Postfix) with ESMTPA id 931E520012
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 18:53:13 +0000 (UTC)
Message-ID: <b666a71c-2c45-4343-ab3c-acc2344bb738@SystematicSW.ab.ca>
Date: Mon, 2 Dec 2024 11:53:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
 <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
Content-Language: en-CA
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Autocrypt: addr=Brian.Inglis@Shaw.ca; keydata=
 xjMEXopx9BYJKwYBBAHaRw8BAQdAPq8FIaW+Bz7xnfyJ1gHQyf2EZo5sAwSPy/bRAcLeWl/N
 I0JyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFNoYXcuY2E+wpYEExYIAD4WIQTG63sbl+cr
 2nyOuZiKvQKcH1E27wUCXopx9AIbAwUJCWYBgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
 CRCKvQKcH1E276DmAP91Bt8kfJhKHYb9b2sao2fxwJFsl1GlRi516WKI0OkphQEA+ULITsPs
 blfzSq+GgI7q4LPfRfTLy4Oo3gorlnhnfgnOOAReinH0EgorBgEEAZdVAQUBAQdAepgIsLwm
 GQicfoIBaB9xHp63MQJqVCPbgPzESTg7EEwDAQgHwn0EGBYIACYWIQTG63sbl+cr2nyOuZiK
 vQKcH1E27wUCXopx9AIbDAUJCWYBgAAKCRCKvQKcH1E27+zoAP4u2ivMQBAqaMeLOilqRWgy
 nV2ATImz1p2v1H5P4kBiDwD3caPK1cxU5lijzuSDCjgtIpgF/avHbjA32fxJdIRwAA==
Organization: Systematic Software
In-Reply-To: <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: bjttzuyo5bxpkpiq9gutu4o471wb57e3
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 931E520012
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1888rILCWPAxJvO2n35wJ2TMXbGyGp3SBc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:subject:to:references:from:in-reply-to:content-type:content-transfer-encoding; s=he; bh=/J+CWOxYMWcsuum5E14Bjl8MrklgEXZ09ALH6AjNMXM=; b=XbMDbAL6XvxE8cH9K6hjBnUnifjZ/995HUrNPOXY6WxxndmEyA4OV9DGGj2Ho9OElt9lIyGi13HRgY1BJc3HOI2y5/XsurvRRdawqQqratqMRGZdAmMB4sIBIvjwhdXTHsvJLIMbEdErkMVbhWWdAF4vAAYJ7c+2hzyTytPWp2xTcfcV8vOdva5MkcMjcl1CPDrcWXExY3peMoGoVfVUt1GSs5xYOY/q5VnrsqGP3hoKfQrXLmyDdt1Dr9OiJ/W4B9fXS9emXS1mri0eGWHM29rsGgS6qhcYj6z4YIZdLJsMWSC8CSE6s7gyhyWQDxbIKrhQSQrCwwJIcrT5I3/QIQ==
X-HE-Tag: 1733165593-680529
X-HE-Meta: U2FsdGVkX1+dvbdyFrWRtXUhQoC4jgxrwevMF9L6MnUJ+XcuoiUZRgrNjc83ztt1995bRDa1SWO0ZrN/nFjkgnWnnqwNcMQjnkQAgIze7TSojuVpdRr9EXaqXjsltsOTTT00xTRhN9OdcXwz3Zybelh60NTQezV/gYkSd0vcxE6+BSJafowJ2GfXK6+PHX9icuJFMv3eMszvUGO5otZIpxNYE0kvYu6SV2Zln9Pg8/eQNBXqXI1Xc1SRnB6vKL8tl628/FDsTh5Od7cAzhMWaLvAZ02wDO6JGFBCcbwvHeKAWARsMd3OyP7D085+1++nkV7HI20IGpEKzsx6stxs8ctOFXkzu+3c
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2024-12-02 10:33, Christian Franke wrote:
> Corinna Vinschen wrote:
>> On Nov 29 18:48, Christian Franke wrote:
>>> A very first attempt to let sched_setscheduler() do something possibly
>>> useful.
>>>
>>> This patch is on top of
>>> Cygwin: setpriority, sched_setparam: add missing process access right
>>
>> Looks quite nice.  If you're confident this is ready for the main
>> branch, just give the word!
> 
> Yes, initial tests look good. Related documentation update attached.

ISTR those settings from that priority mapping documented somewhere -
winsup/doc/specialnames.xml pathnames-proc "The /proc filesystem" proc(5) 
/proc/PID/stat (18) priority and (19) nice - which are generated as proc.5 and 
cygwin-ug-net/proc.html for cygwin-doc package.

Package man-pages-linux also has /usr/share/man/linux/man5/proc_pid_stat.5.gz 
which it would be good to compare set see if there were conflicts?

It would be good to state in a release note what has changed in the mapping or 
effect e.g. SCHED_OTHER now uses only NICE and SCHED_FIFO/RR use only PRIORITY?

I will have to search my Cygwin docs and code to see where things are mentioned 
or used.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
