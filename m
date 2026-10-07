Return-Path: <SRS0=cy+d=H5=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id A87684BA2E1C
	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2026 17:25:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A87684BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A87684BA2E1C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791393947; cv=none;
	b=BIm4NIS/F5EUi40IFy4dawONL+kMX72qhpIR6tgwyvnKOVVdUc0RkATm79JNV2wN9U5xRW6sMqwB5wrmryxAGRozDLfZGwml9Ets/pYfredo3l/BvNQhYRuT+URQ2kPfBKEYC6ivTBiUwNpHIal0gD0+1uZsr9diwYsXapc8hNI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791393947; c=relaxed/simple;
	bh=bvMuiIR998PgWn46mv1bCAwo1k1OYonl9OUFS9PYq3A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=TK/XY0Z+CrpJ4F/SkI8tXBwQOJf/NWnQO22JUb38CQThQ7sldwW7XhYmg6MkXlG082YGm8BGV15VJbI7DLnhpXSrjdW/Q64Y9XsUZm1tO3Ncq1Ui2GIILTWMx2ak5xHwJIiC23QRjLlxOPuslbiq8Uz34JSg5YeKApBEueXOU1E=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=SgXBhPWB
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A87684BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=SgXBhPWB
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 26B578030E
	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2026 17:25:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf17.hostedemail.com (Postfix) with ESMTPA id 81C831E
	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2026 17:25:44 +0000 (UTC)
Message-ID: <f2a0c0c8-6a47-4955-9add-eafc90cee1cf@SystematicSW.ab.ca>
Date: Wed, 7 Oct 2026 11:25:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: Cygwin core patch submission and discussion
 <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: devices: Fix the code for device number handling
Content-Language: en-CA
To: Cygwin core patch submission and discussion <cygwin-patches@cygwin.com>
References: <20261007000050.100799-1-takashi.yano@nifty.ne.jp>
 <4b5c229a-b527-4ffc-82a7-69cb3f5008e4@dronecode.org.uk>
 <20261008012541.6bbc7cb223cc8cf561c2e5ca@nifty.ne.jp>
Organization: Systematic Software
In-Reply-To: <20261008012541.6bbc7cb223cc8cf561c2e5ca@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 81C831E
X-Stat-Signature: jxarx669qj35fjfr6k1snc6s4s7zxt73
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1874dPOtufMWql/iCCv17da9MIh98bJIF8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=vlY9ZpOURlBFgP+Aam2lfFJbTXVW+RiyAJB0FWPhEos=; b=SgXBhPWBA7uXFfeeeRq3L9SzgVbncwQFpifFb4GE3oc5nSwoqK51jeixbiUnge3aAwz1Li/h+I1ne5kL6w6l2Eg9hHgHfaQCq9bXvDjckD7I6wt7Nx4cAFRrd8QFidLWAgLECPwY+KshG1aVwUmor0V5z4gLpnJDOTlhOIHEzQjhqaS1ms8bjBOTyKIgE1xNKdIlICpBBlxLJcb8a7Rc44Qf301ScGhvy0X36VUPSjA8IiLQAFw0G55B9q11KOCWmlrXkVUqYyvlmGYPudwhNwY1kpZF5zfzumiNrHXhmP6KaviKIQFiAm5Z0VCYs+kvxV2tg2cINXI69qIy4rHErw==
X-HE-Tag: 1791393944-114983
X-HE-Meta: U2FsdGVkX19WpSpG+0uZL6MfBWXmaMiITlczZoVsZfMXK8+Ke1BoJdfrQDB54aTsXZEfWcTHE/pv7dcOduh/V0rTzBqNSO3FnZNqk1qBJZaOU7rfx8GpEpSJdqM2XNKw0ufQdsz3Cqf9BzE4yvcLTH9hj7Nvqfu9kwzwWDmJN7jNpznOF6dkUjC/HO24+3YawUlXmo/U4mgTpULlzLa0Q/cFSnJBIYjJw5o68+AGZZc72q16+32D09+OZCq6IakE77fX3XWlw1WGWqUUq7IzYWiqjDlLPUxdggJx3VqE+KWAHgjQ5rQ8mycGep1rhVRiDpxPZ0Qim6cTdHBQTLhF982aM//vSASq
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-10-07 10:25, Takashi Yano wrote:
> On Wed, 7 Oct 2026 12:41:39 +0100
> Jon Turney wrote:
>> On 07/10/2026 01:00, Takashi Yano wrote:
>>> Currently, the code handling the device number is not match with
>>> the expected code intent. The shift width for the major device
>>> number should be the size of _minor_t, rather than that of
>>> _major_t.
>>>
>>> Fixes: 7ac6173643b1 ("* devices.h: Renumber devices based on more Linux-like major/minor numbers.")
>>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>>> ---
>>>    winsup/cygwin/local_includes/devices.h | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/winsup/cygwin/local_includes/devices.h b/winsup/cygwin/local_includes/devices.h
>>> index 10a46150e..8e02f60bc 100644
>>> --- a/winsup/cygwin/local_includes/devices.h
>>> +++ b/winsup/cygwin/local_includes/devices.h
>>> @@ -11,9 +11,9 @@ details. */
>>>    typedef unsigned short _major_t;
>>>    typedef unsigned short _minor_t;
>>>    
>>> -#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_major_t) * 8)) | (unsigned) (min))
>>> +#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_minor_t) * 8)) | (unsigned) (min))
>>>    #define _minor(dev) ((dev) & ((1 << (sizeof (_minor_t) * 8)) - 1))
>>> -#define _major(dev) ((dev) >> (sizeof (_major_t) * 8))
>>> +#define _major(dev) ((dev) >> (sizeof (_minor_t) * 8))
>>>    
>>>    #include <dirent.h>
>>>    #include "cygheap_malloc.h"
>>
>> Ha!
>>
>> Just so I'm understanding this correctly, this isn't a functional change
>> because sizeof(_minor_t) == sizeof(_major_t), it's just clarifying the
>> intent, right?
> 
> You are right. There is no practical problem.

To be strictly compliant, you should #include <limits.h> if not already done and 
replace explicit constants '8' by `CHAR_BIT`:

/usr/include/limits.h:#define CHAR_BIT __CHAR_BIT__

and could then define and use the conventional SHIFT and MASK constants:

+#define DEV_SHIFT	(sizeof (_minor_t) * CHAR_BIT))
+#define DEV_MASK	((1 << DEV_SHIFT) - 1)
+#define FHDEV(maj, min) ((((unsigned) (maj)) << DEV_SHIFT) | \
				(((unsigned) (min)) & DEV_MASK))
+#define _minor(dev)	((dev) &  DEV_MASK)
+#define _major(dev)	((dev) >> DEV_SHIFT)

which might have prevented the original issue.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
