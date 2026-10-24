Return-Path: <SRS0=rrDE=IO=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.240])
	by sourceware.org (Postfix) with ESMTP id 595474BA2E0D
	for <cygwin-patches@cygwin.com>; Sat, 24 Oct 2026 19:55:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 595474BA2E0D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 595474BA2E0D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.240
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792871745; cv=none;
	b=Q6IhnPrIUkt7j9KYzLR9QNrZIxLZGiGO4CsSrqq+usfeiYdqQvfpSen69a1A8jbnwhXIyvDfJ8tt8GIXjvyT9Sdl7nWwyWY3o/1yft15jyxBq0oUDrMMncWJRUC24/9LYzm9Z9OMeiK11dfDel65b6f566vUbMe53DV8jsF4J/o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792871745; c=relaxed/simple;
	bh=WanQR8R2BDWl9XaTCRbw/XU7inX+DndUWQW8Z0VGMZw=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=UD1IyLG05OVrbTdjG8eawFo+QhrFfDskTJs3tXWDXJRWkIOsR5kYhUmsG1CrRgh1X7UgPFdTf/MLJ4sYKyjZV0iWj1Ww3xBIMcVTxPsakpKH3vqr3SkCUqvTk77H0YhthFEIAfHAvZQSi2j/LIwHSiWJ6KBayLBqfcgD8lFwnD0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 595474BA2E0D
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7159F4106B07FF
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTECo53ALs5kaOK5QUuxhcqkWSrSBTO0Z4RHYSRFc2Oy54XPTfSqOAqL6EspJ6LVteEAx0PsMwHPWvXOngpFO8TnVzNKSjt+kp+P2JifnrBDQ+PdlgA2urUqd4uOiESk4zwQY6+U8GhrtUNpQPMiD6q5MjOjDfZcHoAlU+53tIjt65Dmfs5gP3r6BXeKW2wifsWI8awETH1WJDtFi25g3bsPIGJCgAjVSG1GCJ4uDF2CZU60j+UHgpXwzhf2HzC7V29wGkuoJoJcUwBnCbFDMAZn7wdTPRDHBmms5HzG5LkVGIMclWe2MUcsAFoSl4GQN/4jBlJvqUleAE0Op5v6DfCSn0wZjzxpz0OgnUyuiCxCoWzs3/HwGp4oo9s0Co0PpkvzqwC51+Iq5+gI/ZFyti5UvJf/ITpmbESqEgeOBHOFwafxSjQaR0U6aNimW114oNgSt+0dv6OAJP9IOnJPv6OWcbLhXYJ/Hdy04JwqkxV/OKwOHJqSePqRNNX3Ao7Aay3MBo3koDC7fHWP2V+p+hruTxNJcPTudkUHszYlGYZ7n9lhvfXbxry0jPzVe2/qqS9L3t3BoV4krMt/fhf0cgM4sHU5/bpOilfmtsbgYuFL50ezhC7l3JYdhMq/kZsLI1QF84hb+3EqpDR2Pz2zHnv0ycNUu5qRXdIrJ27LpDHjmw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7159F4106B07FF; Sat, 24 Oct 2026 20:55:39 +0100
Message-ID: <e65187e2-28c2-4d48-b5a1-6bf2b4510afa@dronecode.org.uk>
Date: Sat, 24 Oct 2026 20:55:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Cygwin tzset: CLDR 49 Western Canadian time zones changes
 different from TZ DB
References: <c9f12c06-5609-4034-8fd7-5fc9ec433197@SystematicSW.ab.ca>
 <5e085618-e363-4a2f-bded-267bfd3d3997@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
In-Reply-To: <5e085618-e363-4a2f-bded-267bfd3d3997@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 23/10/2026 02:44, Brian Inglis wrote:
> On 2026-10-13 10:48, Brian Inglis wrote:
>> The latest word about the ICU 79/CLDR 49 support of Western Canadian 
>> time zones changes is that they will be maintaining the DST fiction 
>> year round from release, starting 2026-11-01: using PDT, MDT, CDT for 
>> BC, AB, MB, year round, rather than TZ DB's use of normal STD times 
>> using MST, CST, EST year round; presumably YT stays on MST and SK on 
>> CST even under CLDR, so they will appear to be on different time 
>> zones, and NT(/NWT) will follow AB, although NU regions still appear 
>> undecided but likely to follow other adjacent regions.
>>
>> Do some tweaks need made to accommodate the changes coming in a few 
>> weeks, just before the TZ and TZ DB change already updated?
> 
> I downloaded the CLDR 49 file with windowsZones.xml and an issue 
> explained in CLDR-19872.txt based on win32tzlist.out which has not been 
> applied to the released CLDR, updated windowsZones-cldr-49.xml to get 
> windowsZones-cldr-19872.xml, and ran an adapted tzmap-windowsZones 
> script to produce respectively tzmap-cldr-49.h and tzmap-cldr-19872.h 
> and produced the included diffs showing the minor different output and 
> fairly different inputs.

I had to read the source of tzset to understand how this all works, but 
the changes to tzmap.h seem technically correct.

It seems like tzset always uses the first POSIX tzid in the matched 
record, so tzmap-cldr-49-19872.h.diff doesn't actually functionally 
change anything?

> It would be good if someone other than myself could review these 
> sources, changes, and products, before thay are built into Cygwin tzset 
> by Nov 1, so Cygwin works properly in Western Canada and other recently 
> changed Windows time zones.

Brian,

I ran 'make tzset' to update tzset.h, and then applied your patch to it.

A 3.7.0-0.635 test package has been built with these changes.

If these are the changes you wanted, I can make a 3.6.12 release tomorrow.

