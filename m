Return-Path: <SRS0=8s3o=IO=systematicsw.ab.ca=brian.inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id C4A774BA2E0F
	for <cygwin-patches@cygwin.com>; Sat, 24 Oct 2026 23:33:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C4A774BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=systematicsw.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=systematicsw.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C4A774BA2E0F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792884828; cv=none;
	b=qWlRxPZBsdMh8nAXkdEjQvAsme0scBv6uGXzocX4OCtOWwzK5qjH1CLd0Zr0F+2uPDvmJQRZHUrUzF64fO4TgCMdRRcSRYSbyq87ubnfSYYc4AKJdB7XtmFM2gfLrBuuhUP0CfF/h2jCs4nzZBGkvPT79aZ0b2Sv5OqRrBZ0Q00=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792884828; c=relaxed/simple;
	bh=NFbQX/ONrnHP4ZgaIWunBlwuinjMUys/Cgr3PZNtyHc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=gJu4L79dpL1Tz164fUuO9riQDXRA3i/d7mjIGMPmv6SH5Y/jHLdaws9xmzgG3gd4l6gMe8ym7wz+uC/BgGHKDoumjVJPR0MbEJ5UAZmkzRAfVonh+u3ClFUBXXhcb6d5x/7V7r/QjUHKtSv+Kyd/w6N1ohFg9vB1iaunhEb9oDU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.a=rsa-sha256 header.s=he header.b=al4L4Et6
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C4A774BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.a=rsa-sha256 header.s=he header.b=al4L4Et6
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 6180AA7887
	for <cygwin-patches@cygwin.com>; Sat, 24 Oct 2026 23:33:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf03.hostedemail.com (Postfix) with ESMTPA id DA6616000A
	for <cygwin-patches@cygwin.com>; Sat, 24 Oct 2026 23:33:44 +0000 (UTC)
Message-ID: <62c9c4dd-8c43-462b-8b7f-4d95b85447e1@systematicsw.ab.ca>
Date: Sat, 24 Oct 2026 17:33:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <brian.inglis@systematicsw.ab.ca>
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: Cygwin tzset: CLDR 49 Western Canadian time zones changes
 different from TZ DB
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <c9f12c06-5609-4034-8fd7-5fc9ec433197@SystematicSW.ab.ca>
 <5e085618-e363-4a2f-bded-267bfd3d3997@SystematicSW.ab.ca>
 <e65187e2-28c2-4d48-b5a1-6bf2b4510afa@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <e65187e2-28c2-4d48-b5a1-6bf2b4510afa@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DA6616000A
X-Stat-Signature: ztkre4yqyjxwe9q9cd1dpyk98fofsnst
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19kDZCamcW4XU2uOghfNWtbRb2DOwZvcYM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systematicsw.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=jK1KvEAd1heU5TWV7tvb071HuOI5eN+yyhtcefOjOaA=; b=al4L4Et6vu9B3JIM3jDgdMp0ZASmxwi02KDIIeVkEAYc+aNGh/aaeGMC5DLvEmZ3k8DLfqsKaNo+h+Cnb4W9BqlPqMlMHCBrQpr1rA9h287TxVdxRNGBMlkGk8SRdOcyQGlnmOhMSBIA+GuD4dTUvmYsYHw1az8dw8ZffP+5yjk7t7G2ZrsUSpqlCkViI/vhcgh9gs3ZbXCptAaNyOivLxFqswwOx0UhLQdbpqIIqLd55VpKEnV2N08578/54JqEMFU0FrKDtMkH5tsofLyXDwUorVSD+JK0D7/CjH5fysPrwR36EijMFAbkWNR6jUBj36tRm+ldcfoDySzftW2iqA==
X-HE-Tag: 1792884824-983145
X-HE-Meta: U2FsdGVkX18JuMz43nLTHSjYnZEfJ5O+8j/Nr6Vz7XeX9juPl+a0BXuX6GCkuU12SXqnRBL4iN2S/2Z/108EqcNsqGDfSm9YN65bab14e+yFb88DXoFWRbB3vh3zvITD5R3USmiprbSUFEkMM80Gatq0hmNJ+cQiYwfNrGtjK98flfhDS53oxlVsolRZ5fmgeYCGl4qGQlTRYT3VpdQvy/luQGO/OOjEf26zNxcdwtEevmVxMJLu65y/tDkp9fdmvjui/ROw2tRa7IUGUhBnbi6BPNKrZhZNg4+MITvPNP8xZjRzGK9PtYu+fHrTxp9VrdnFS4RewaWNDY9kbVWFXvOAfBIce/Ihc8LJcM2HjN+RLeO8zoz6VOsDMTBUD5aFaevPwXwI/m8=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-10-24 13:55, Jon Turney wrote:
> On 23/10/2026 02:44, Brian Inglis wrote:
>> On 2026-10-13 10:48, Brian Inglis wrote:
>>> The latest word about the ICU 79/CLDR 49 support of Western Canadian time 
>>> zones changes is that they will be maintaining the DST fiction year round 
>>> from release, starting 2026-11-01: using PDT, MDT, CDT for BC, AB, MB, year 
>>> round, rather than TZ DB's use of normal STD times using MST, CST, EST year 
>>> round; presumably YT stays on MST and SK on CST even under CLDR, so they will 
>>> appear to be on different time zones, and NT(/NWT) will follow AB, although 
>>> NU regions still appear undecided but likely to follow other adjacent regions.
>>>
>>> Do some tweaks need made to accommodate the changes coming in a few weeks, 
>>> just before the TZ and TZ DB change already updated?
>>
>> I downloaded the CLDR 49 file with windowsZones.xml and an issue explained in 
>> CLDR-19872.txt based on win32tzlist.out which has not been applied to the 
>> released CLDR, updated windowsZones-cldr-49.xml to get windowsZones- 
>> cldr-19872.xml, and ran an adapted tzmap-windowsZones script to produce 
>> respectively tzmap-cldr-49.h and tzmap-cldr-19872.h and produced the included 
>> diffs showing the minor different output and fairly different inputs.
> 
> I had to read the source of tzset to understand how this all works, but the 
> changes to tzmap.h seem technically correct.
> 
> It seems like tzset always uses the first POSIX tzid in the matched record, so 
> tzmap-cldr-49-19872.h.diff doesn't actually functionally change anything?

CLDR-10982 generated tzmap.h doesn't change much over the new CLDR 49 download 
of windowsZones.xml Supplemental data generated tzmap.h - which you have just 
been applied - just adding GL America/Nuuk to Greenland rules, but does add 11 
Windows zones changes and 7 TZ DB zone corrections to the previous tzmap.h.

>> It would be good if someone other than myself could review these sources, 
>> changes, and products, before thay are built into Cygwin tzset by Nov 1, so 
>> Cygwin works properly in Western Canada and other recently changed Windows 
>> time zones.

> I ran 'make tzset' to update tzset.h, and then applied your patch to it.
> A 3.7.0-0.635 test package has been built with these changes.
> If these are the changes you wanted, I can make a 3.6.12 release tomorrow.

Thanks Jon,

That would be useful for Doug Henderson, who already posted about the problem, 
myself holding off on my patch reboot, and anyone else in Western Canada 
applying Windows patches soon, hoping for correct Windows time zones and mappings.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
