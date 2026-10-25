Return-Path: <SRS0=V1wT=IP=SystematicSw.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 476A04BA2E13
	for <cygwin-patches@cygwin.com>; Sun, 25 Oct 2026 15:09:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 476A04BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSw.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 476A04BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792940978; cv=none;
	b=I0SywgkxayUuitbbKBzNbZV2SPE219CkJ4pPo+Xy51jqxjoWKltTpgEr++5ByLsMCExK9XCubVC6CETo+33KiFvBloZFg/BouIluc6xDWe/z+7EcMOFM2gwSNXD7/3lx44/dl4eu5nqnzeyGZ5Pz91aHQdLVoc7e5Bq9kOCDz1s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792940978; c=relaxed/simple;
	bh=ZyD/S7w/GWKLH6+gaSbYdOUAh5l9AQzqQmZXRlRZrlY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=O1Seaznt3MQSO+lsq/vPr6GYyKX59h5RNX4Ib7x5AdRUKzBgfChs3EYU+S4r1TC89C0euISF6+M8JCdUjnIOyEzs1EK9BWqTuj+YDrdFwHJ3Vz3olDXxBcw9BbeDITn67MmQaT6cFO1wUOMa5gw/NnqwNclbAgovs/djdzE241A=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSw.ab.ca header.i=@SystematicSw.ab.ca header.a=rsa-sha256 header.s=he header.b=XoAMHaOi
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 476A04BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSw.ab.ca header.i=@SystematicSw.ab.ca header.a=rsa-sha256 header.s=he header.b=XoAMHaOi
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D0241401C5
	for <cygwin-patches@cygwin.com>; Sun, 25 Oct 2026 15:09:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf08.hostedemail.com (Postfix) with ESMTPA id 4E80D20025
	for <cygwin-patches@cygwin.com>; Sun, 25 Oct 2026 15:09:36 +0000 (UTC)
Message-ID: <a7024578-70bb-411d-b130-d38cdb359c34@SystematicSw.ab.ca>
Date: Sun, 25 Oct 2026 09:09:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: Cygwin tzset: CLDR 49 Western Canadian time zones changes
 different from TZ DB
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <c9f12c06-5609-4034-8fd7-5fc9ec433197@SystematicSW.ab.ca>
 <5e085618-e363-4a2f-bded-267bfd3d3997@SystematicSW.ab.ca>
 <e65187e2-28c2-4d48-b5a1-6bf2b4510afa@dronecode.org.uk>
 <62c9c4dd-8c43-462b-8b7f-4d95b85447e1@systematicsw.ab.ca>
 <782b506e-290e-4d10-9f67-ee4d59f338aa@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <782b506e-290e-4d10-9f67-ee4d59f338aa@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 4E80D20025
X-Stat-Signature: uadmnj453q6rhzdj3ok66j8ppqkoam4a
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/DpXxzTiY7lXRvJso02TlFXrtwGdms5K8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSw.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=vybKS1zqpXAp1ALKzSb7D+f1uW+VFga+ug15xnH3B08=; b=XoAMHaOi3AVzcKX7sSd+E1U+Db9Q9lOtruhWB9G8/QDPX7i2jGH2I8tu0TuZgEJWGuaBWW0J3MPvPPwU+i1wxxo/TiEaENVx0G851eAxBzrrHvlDPckrAh8LeMx5T9CO9MoZkGfQps/76CtOm0EwSYRtRE6k/QL9Qfd4yvWMfTnUAM1Szy5fBD1xi6eh2sKKqX9UabLIb8myE3Q09avQvOhSlFRMjdNgriZxXU4JDwffmqvsfOxcUTVnu3/Fn4xkC6+sqczviiR0AZ6RdsdW9H/Jj3o59OSfBHY+qEaETCc7gqWCD9PI+ehD90tqiMUPBpUxDHB1CPfAPAwahOb/uQ==
X-HE-Tag: 1792940976-201477
X-HE-Meta: U2FsdGVkX1+VBjJTtvPKkeUVKm8sZFS9U5HavDxcuLlU/ECvjhrQ1qjgqkQnakTiLOP1Q7I2ZHUUOKlCm1RGnsNMf7g+bBXzXP9+JQsUOJdjBsA3HhnXwe4y/rBP7qFl/hNzKO7Xr7v+zj2KbnuuW+X37ACP1bDeNY1HWGzama5xq2WcKwnlgTEwUPFXKhMZsq5/paRcF9FpEiRQFop68MUwElWIEarkKKiGhrIyF/Kspbdu0IypgTFlH4Ju9iYQQbB/TvUN9BaGK0rSEnTke6HbbrdFMjXFdz1T/OCNGcFzbmc4w8MowKABS+MF/y5bQUBE9jnOgnV2ULVdzV7TtwVOzxLl1bxA7nSkfPnLvkXQQGUAbRFgx7y1A/HLtdrbBSe9E1XOEECYLHZzqN0MMiNvL2Z7SavN
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-10-25 05:47, Jon Turney wrote:
> On 25/10/2026 00:33, Brian Inglis wrote:
>> On 2026-10-24 13:55, Jon Turney wrote:
>>> On 23/10/2026 02:44, Brian Inglis wrote:
>>>> On 2026-10-13 10:48, Brian Inglis wrote:
>>>>> The latest word about the ICU 79/CLDR 49 support of Western Canadian time 
>>>>> zones changes is that they will be maintaining the DST fiction year round 
>>>>> from release, starting 2026-11-01: using PDT, MDT, CDT for BC, AB, MB, year 
>>>>> round, rather than TZ DB's use of normal STD times using MST, CST, EST year 
>>>>> round; presumably YT stays on MST and SK on CST even under CLDR, so they 
>>>>> will appear to be on different time zones, and NT(/NWT) will follow AB, 
>>>>> although NU regions still appear undecided but likely to follow other 
>>>>> adjacent regions.
>>>>>
>>>>> Do some tweaks need made to accommodate the changes coming in a few weeks, 
>>>>> just before the TZ and TZ DB change already updated?
>>>>
>>>> I downloaded the CLDR 49 file with windowsZones.xml and an issue explained 
>>>> in CLDR-19872.txt based on win32tzlist.out which has not been applied to the 
>>>> released CLDR, updated windowsZones-cldr-49.xml to get windowsZones- 
>>>> cldr-19872.xml, and ran an adapted tzmap- windowsZones script to produce 
>>>> respectively tzmap-cldr-49.h and tzmap-cldr-19872.h and produced the 
>>>> included diffs showing the minor different output and fairly different inputs.
>>>
>>> I had to read the source of tzset to understand how this all works, but the 
>>> changes to tzmap.h seem technically correct.
>>>
>>> It seems like tzset always uses the first POSIX tzid in the matched record, 
>>> so tzmap-cldr-49-19872.h.diff doesn't actually functionally change anything?
>>
>> CLDR-10982 generated tzmap.h doesn't change much over the new CLDR 49 download 
>> of windowsZones.xml Supplemental data generated tzmap.h - which you have just 
>> been applied - just adding GL America/Nuuk to Greenland rules, but does add 11 
>> Windows zones changes and 7 TZ DB zone corrections to the previous tzmap.h.
> 
> Uh, I don't understand. It only adds Nuuk to tzmap.h, but it also does "11 
> Windows zones changes and 7 TZ DB zone corrections"?
> 
> Is there something else needed here?

Sorry Jon,

I should know better than to assume that others understand that only changes to 
windowsZones.xml assignments and offsets actually affect the mappings from 
Windows zones to TZ DB zones.
For CLDR 49, dropping old POSIX zones dropped by TZ DB: PST8PDT, MST7MDT, 
CST6CDT, EST5EDT.
Adding 3 new Windows zones for BC CA, AB CA, MB CA, and mapping them to Western 
CA TZ DB zones America/Vancouver, America/Inuivik (NWT NT), America/Edmonton, 
and America/Winnipeg, moving them out of the North American DST observing 
Pacific, Mountain, Central, and Eastern (US & Canada) Windows and TZ DB zones, 
which in the Windows western zones, should probably have the "& Canada" removed, 
except leaving it maintains backward compatibility:

	https://en.wikipedia.org/wiki/Central_Time_Zone#Canada

Plus a couple of changes to CL and MN Windows zones and TZ DB zone mappings.

There are 11 changes made to CLDR 49 windowsZones.xml including 7 TZ DB offset 
fixes by CLDR-19872 updates, but the only net difference made by CLDR-19872 
updates to the generated tzmap.h compared to the CLDR 49 generated tzmap.h is GL 
ST is also mapped to America/Nuuk as well as America/Godthab, as the other zone 
mappings from Windows to TZ DB do not change with CLDR-19872, once the CLDR 49 
changes are applied, as those changes affect mainly Windows zone offsets not yet 
reflecting TZ DB changes in zone Display strings shown in comments and location 
in windowsZones.xml grouping by UTC offset.

>>>> It would be good if someone other than myself could review these sources, 
>>>> changes, and products, before thay are built into Cygwin tzset by Nov 1, so 
>>>> Cygwin works properly in Western Canada and other recently changed Windows 
>>>> time zones.
>>
>>> I ran 'make tzset' to update tzset.h, and then applied your patch to it.
>>> A 3.7.0-0.635 test package has been built with these changes.
>>> If these are the changes you wanted, I can make a 3.6.12 release tomorrow.
>>
>> Thanks Jon,
>>
>> That would be useful for Doug Henderson, who already posted about the problem, 
>> myself holding off on my patch reboot, and anyone else in Western Canada 
>> applying Windows patches soon, hoping for correct Windows time zones and 
>> mappings.
> Not really an unequivocal answer, but I guess this means "yes".

Indeed, thanks!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
