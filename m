Return-Path: <SRS0=PY97=EJ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.227])
	by sourceware.org (Postfix) with ESMTP id 5DE3D4BA2E0C
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 17:53:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5DE3D4BA2E0C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5DE3D4BA2E0C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.227
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781373199; cv=none;
	b=D8OtEr8HT/k3r65rqlrC5SMV5epgD9cOEHvrbvu/1qSz4yFZH8cVTiQAA92L5g5LP0wWTAZBueyvE5XvEuqDL/cw0fTBQ4z/wvPmo2YqI52oVG2vs+BHr8Ka5AR2Fc0oa3uOdtwKCc0tDRZjCr8ApxaaUYvkDLJS0rzjI7yhufM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781373199; c=relaxed/simple;
	bh=Bsqt7bhFij1OkyyrDeRSZX9E2UT281CNjeV86sDPy9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=DfrvGui66jOz60Rb3kGMekY4wMj2Pg9MasxkdQtTuPrhG8+hbPrmqSb4wvC0TDPjqcG3L1NDVreNXlIYO3yteJCOOPMTDXm1i6xFrvLDWncbW4mX8iV4W6ee8uo3eqz3IotDmWh6d5tmVjSWoiyNictZ8EUDCLJXpGUE62Tg2VA=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5DE3D4BA2E0C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A02527902A4FB6B
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTGpVP5hWzekuG+PxH5eQk2ghDWdQ4Vktqdk4ZE+kxiihx5ffmAsSAOxA7N99movu82zJ1qEhyVRnpJgntqcZOxTmMSyMpPwi7M/0QiNoVIkfeHnjLryICUMzH5jtGDbf6KHAK/veOcDdkL1aZvsOkTFwCev1GqnNknh7SlJauO/2Nn54tyr0w5M7WU19Gq+OVtn2LA26e0k1EyFIfb1ghRisXIOms5QoQQUsIclEf6C//LvzichsTNHrvgwU8Z7w+fsQydc06s2dPlC5FwDZG+fe3c2JtxJ4sqqAkLRO7Azx73iLRpGo/la9pB33MeHCNAwZtmM9wC0wb1lQnRYe/3xgCYa5IyxrLWVjSoBvwdspJkZRjsqFtAwChIiUyGMUVe36mluKHrxJnaeUp3WnakePSbCXFylHPaA9k9nlSNGaMLhLnYRzNwFWeywNDsLXYcNFFMIdnOPY9gmfIfpGvI3AmjLMJyRLkmKoVDM6gtBlCrLb7qtXR2Q2YKjkDlBM0/tvkkAW0Ky0jKsJ69lwMBNROHaofx2oquboU34wh+5Z/64zM/WY7dQM+SlyRHpu0bcaE8luD8c+uIKOAGmcm5Ya6HvSvA4tkDqRVUTRfvAaw6FVg3qmkxpJRpVcDGE3C8uDAtE1timgZG3pjNk5xCh9Vi07Vt5VXVkovyyHFUo3Q
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A02527902A4FB6B; Sat, 13 Jun 2026 18:53:11 +0100
Message-ID: <99590c72-bc88-4466-95c2-ae540a11c031@dronecode.org.uk>
Date: Sat, 13 Jun 2026 18:53:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: autoload: Add AArch64 implementation
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
References: <PN0P287MB0295342E2109C2CB8EECCE6B92062@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <ag8IvAkqoNVM-AH2@arm.com>
 <PN0P287MB02951A11C49A1208A9BA66F392102@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN0P287MB02951A11C49A1208A9BA66F392102@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 04/06/2026 08:35, Chandru Kumaresan wrote:
> Hi Evgeny,
> 
>> LoadDLLprime contains only data. It might make sense to keep only
>> one version for x86_64 and aarch64, and use WORD64 for .quad/.xword.
> 
> In v2, we introduced a WORD64 macro:
> 
> #if defined(__x86_64__)
> # define WORD64 ".quad"
> #elif defined(__aarch64__)
> # define WORD64 ".xword"
> #else
> # error unimplemented for this target
> #endif
> 
> And unified LoadDLLprime into a single shared definition using WORD64,
> removing the duplicate x86_64/aarch64 versions.
> Also added inline comments throughout AArch64 assembly blocks
> documenting execution flow.
> 
> Please let me know if anything needs further clarification.

Thanks very much!

(and thanks for adding copious comments on the assembly! that really helps!)

I've applied this patch.

I did a little burnishing to update the introductory comments (dropping 
the obsolete 32-bit sizings for the fields), but this is all 
sufficiently convoluted I'm not 100% sure I've got it all right! :)

I have to say, I'm not 100% convinced that the "elide the call to 
LoadLibrary() for subsequent symbols in the same DLL" functionality 
alluded to in the comment is actually there, but perhaps I need to do a 
bit more staring at the code...


Just so I'm doing my due diligence, I'd like you confirm that you are 
submitting this under an open source license as per [1], and you and 
your colleagues at multicoreware are authorized to do so.

[1] https://cygwin.com/contrib/dll.html



Some notes on possible future work I made in the course of my review, 
saved here:

* Looking at the git history, the comment on the problem the 
no_resolve_on_fork flag is working around has disappeared, but the 
functionality is still there.  Is it still needed?

* Since it's just data, it seems to me that the initializations of the 
various instances of struct dll_info could actually all be written in C.

