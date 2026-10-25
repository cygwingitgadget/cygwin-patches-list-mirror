Return-Path: <SRS0=/rEu=IP=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id 4619B4BA5434
	for <cygwin-patches@cygwin.com>; Sun, 25 Oct 2026 11:47:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4619B4BA5434
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4619B4BA5434
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792928848; cv=none;
	b=fsPfWRiAFdRqINntfPZvZTLKBsFAFg582UwfQU3ObDpZpNKl6DtTRir6HrKL3/aoSdjkTY8F1XlhD7bVnGcMs04Pnqu5zYEM/jr7MqYCtGt8W6X5UU9VoW8jJ4aQgiylBbA/t9zMnyJhQ0TZldng4m6rU8B14kK32kXQvRoLk0E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792928848; c=relaxed/simple;
	bh=Q9ugf5Xe6PZgLxacf8JMtcfn75gWe1SRXcrb1179q4A=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=dbF9FkNGalhAaLD4VYL91UCfp1q9Y/ahEzmiPMG5lZqgICAKqohRMzahrjtOq/dOCBjq8H/p6puvhu0U6/TFbZSS34ZEIQU0DQB0bhc8zJ2YRBGhnMhGSPrnslkcZR7ty7Wqhb1Wrw36OMipjqph1OV8/9qoFqLyYOrxpD+Y/Rc=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4619B4BA5434
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6AB2D6E50713A7AE
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEOKQOFqGpgv/BFXseqhVBxeGwD/TtJbQvOgrtMgFEXkF9GY3bGaS9OWgj86pNLNVGfgdDQghCIoYnge/GHA1oc3PKBtw7p7Uwx20nf7wC0vuJsS2l7DwbXQRU9gmv1z2eGvRssSyPIubFr11wvsS4w4+dg7XbKsqLcsnXvQcJEn3/GIk9M0UeNfYSAU5iAf+xAwhL4vr9sJjuEo0rGhi1frNykMLhKnhcS/Q6+B+5eL26U3zjaFta5ovDQURYhUk0GLdyl+3rnQtch8YYiYUzttRBQjzbR1lvmdsdTpf+qrUBvyMsRNPQ0k8alkSAtcS4F6hzClMU+GBt6MShOitr9A/Cl47s7KlOghkxs/orskbC5S8YdNWHaNqq9+Qrs2IzHiOT/TiSLHmNx5RDXR1ChsLwP5SnDo7rmT+Ljh8Rz45QlPuzb44RhwYm8n+jtSx4fKWmwMvKNcXtVtNMr/O+A0tdkbpbq3LDMdvP4WfWGxnAVLXeCStQMnNYGhK3sTANeUwMHLCdhfFYx8kD9eEREYQswYHEsgH42u3d7kUqEYjOiHfwkYmtcbBb5iyDfAs1nZOJZaG+tEZxzH8tLB5knJfJlayRzNPV1797o7JbBwH5nzhesxYNosjcnOothT2XTw5YaxFGHiIjfZsLpNoseZM560jJqEwKkSp/dMfoURg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6AB2D6E50713A7AE; Sun, 25 Oct 2026 11:47:25 +0000
Message-ID: <782b506e-290e-4d10-9f67-ee4d59f338aa@dronecode.org.uk>
Date: Sun, 25 Oct 2026 11:47:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Cygwin tzset: CLDR 49 Western Canadian time zones changes
 different from TZ DB
References: <c9f12c06-5609-4034-8fd7-5fc9ec433197@SystematicSW.ab.ca>
 <5e085618-e363-4a2f-bded-267bfd3d3997@SystematicSW.ab.ca>
 <e65187e2-28c2-4d48-b5a1-6bf2b4510afa@dronecode.org.uk>
 <62c9c4dd-8c43-462b-8b7f-4d95b85447e1@systematicsw.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
In-Reply-To: <62c9c4dd-8c43-462b-8b7f-4d95b85447e1@systematicsw.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 25/10/2026 00:33, Brian Inglis wrote:
> On 2026-10-24 13:55, Jon Turney wrote:
>> On 23/10/2026 02:44, Brian Inglis wrote:
>>> On 2026-10-13 10:48, Brian Inglis wrote:
>>>> The latest word about the ICU 79/CLDR 49 support of Western Canadian 
>>>> time zones changes is that they will be maintaining the DST fiction 
>>>> year round from release, starting 2026-11-01: using PDT, MDT, CDT 
>>>> for BC, AB, MB, year round, rather than TZ DB's use of normal STD 
>>>> times using MST, CST, EST year round; presumably YT stays on MST and 
>>>> SK on CST even under CLDR, so they will appear to be on different 
>>>> time zones, and NT(/NWT) will follow AB, although NU regions still 
>>>> appear undecided but likely to follow other adjacent regions.
>>>>
>>>> Do some tweaks need made to accommodate the changes coming in a few 
>>>> weeks, just before the TZ and TZ DB change already updated?
>>>
>>> I downloaded the CLDR 49 file with windowsZones.xml and an issue 
>>> explained in CLDR-19872.txt based on win32tzlist.out which has not 
>>> been applied to the released CLDR, updated windowsZones-cldr-49.xml 
>>> to get windowsZones- cldr-19872.xml, and ran an adapted tzmap- 
>>> windowsZones script to produce respectively tzmap-cldr-49.h and 
>>> tzmap-cldr-19872.h and produced the included diffs showing the minor 
>>> different output and fairly different inputs.
>>
>> I had to read the source of tzset to understand how this all works, 
>> but the changes to tzmap.h seem technically correct.
>>
>> It seems like tzset always uses the first POSIX tzid in the matched 
>> record, so tzmap-cldr-49-19872.h.diff doesn't actually functionally 
>> change anything?
> 
> CLDR-10982 generated tzmap.h doesn't change much over the new CLDR 49 
> download of windowsZones.xml Supplemental data generated tzmap.h - which 
> you have just been applied - just adding GL America/Nuuk to Greenland 
> rules, but does add 11 Windows zones changes and 7 TZ DB zone 
> corrections to the previous tzmap.h.

Uh, I don't understand. It only adds Nuuk to tzmap.h, but it also does 
"11 Windows zones changes and 7 TZ DB zone corrections"?

Is there something else needed here?

>>> It would be good if someone other than myself could review these 
>>> sources, changes, and products, before thay are built into Cygwin 
>>> tzset by Nov 1, so Cygwin works properly in Western Canada and other 
>>> recently changed Windows time zones.
> 
>> I ran 'make tzset' to update tzset.h, and then applied your patch to it.
>> A 3.7.0-0.635 test package has been built with these changes.
>> If these are the changes you wanted, I can make a 3.6.12 release 
>> tomorrow.
> 
> Thanks Jon,
> 
> That would be useful for Doug Henderson, who already posted about the 
> problem, myself holding off on my patch reboot, and anyone else in 
> Western Canada applying Windows patches soon, hoping for correct Windows 
> time zones and mappings.
Not really an unequivocal answer, but I guess this means "yes".

