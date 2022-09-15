Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id C38C43858419
	for <cygwin-patches@cygwin.com>; Thu, 15 Sep 2022 19:52:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C38C43858419
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTP
	id Yrh3o8xLdSp39YuuvoPTPk; Thu, 15 Sep 2022 19:52:57 +0000
Received: from [10.0.0.5] ([184.64.124.72])
	by cmsmtp with ESMTP
	id Yuuuol392GRNlYuuuoOYYB; Thu, 15 Sep 2022 19:52:57 +0000
X-Authority-Analysis: v=2.4 cv=Sfrky9du c=1 sm=1 tr=0 ts=63238299
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=IkcTkHD0fZMA:10 a=6yF655T6xPM82ebRBUIA:9 a=QEXdDO2ut3YA:10
Message-ID: <e36cf30f-8d5d-b1b8-6e31-79c8ee9fc096@SystematicSw.ab.ca>
Date: Thu, 15 Sep 2022 13:52:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH 0/3] strftime, strptime: add %i, %q, %v, tests; tweak %Z
 docs
Content-Language: en-CA
To: Jon Turney <jon.turney@dronecode.org.uk>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220914025236.54080-1-Brian.Inglis@SystematicSW.ab.ca>
 <90d51419-b247-848d-6754-8ffd24792d31@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <90d51419-b247-848d-6754-8ffd24792d31@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfA1lz23EEzC9RXcLw4vQ/hfig0mTm//xNOsUSnpUhkX1kPVp+aAvR6yopUHMFdLgTs+S0TyShNsoITvs/K45T5TEfk66bPOVTq+1tJZwkeQTsaGvaNpv
 pYrVEUAFAtvbfefZn2eq+8tmytbzXUNjzyR8x09lAHR6sy707LUrja4n0AE4kbM1J2bBox4m85C+0E16SEYyl2EuQ/naZAIxHHxH6QMsp1/B6QxlUhp1otb3
 hJaPiF612mUD6R3bq/jJ2A==
X-Spam-Status: No, score=-1164.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2022-09-15 11:45, Jon Turney wrote:
> On 14/09/2022 03:52, Brian Inglis wrote:
>> [Please Reply All due to email issues]
>>
>> newlib/libc/time/strftime.c(strftime): add %i, %q, %v, tests; tweak %Z 
>> docs
>> newlib/libc/time/strptime.c(strptime_l): add %i, %q, %v
>> winsup/cygwin/libc/strptime.cc(__strptime): add %i, %q, %v
>>
>> %i year in century [00..99] Synonym for "%y". Non-POSIX extension. 
>> [tm_year]
>> %q GNU quarter of the year (from `<<1>>' to `<<4>>') [tm_mon]
>> %v OSX/Ruby VMS/Oracle date "%d-%b-%Y". Non-POSIX extension. [tm_mday, 
>> tm_mon, tm_year]
>> add %i %q %v tests
>> %Z clarify current time zone *abbreviation* not "name" [tm_isdst]
> 
> The newlib patches should go to the newlib list.

Right - okay - should have remembered - will split and add xrefs.

> Do you have a reference for an OS supporting the %i extension?  I'm just 
> curious if it specifies the same pivot year for strptime() as POSIX does 
> for %y?

It was documented as a synonym for %y, so %i uses the code for %y.
Sources supporting POSIX pivot at <= 68 => 2000, >= 69 => 1900.

Sorry, I couldn't find the sources for "%i year" when I went looking 
back thru my str[fp]time sources searches for comments - too many repos 
visited, no case sensitive search engines or page find strings, and 
everything supports %I US 12 hour clock and various year formats!
It may have been a newer language library implementation.
I don't keep copies of sources or links to avoid possibilities of 
plagiarism or influence, making it easier to follow existing approaches 
in the source files being changed.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]

[For Y2K, two digit year formats were deprecated and upgraded, so I'm 
extremely disappointed, nay disgusted, that they still haven't been 
dropped, as they will continue to be ambiguous until 2031, as I flip 
between English language sites in various countries!
I'm in favour of promoting -Werror=format-y2k, similar to the common 
-Werror=format-security build option!
But given that few care to remember the issues, costs, solutions, and 
recommendations, I'll support adding the convenience format.]
