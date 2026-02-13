Return-Path: <SRS0=Ilg4=AR=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.133])
	by sourceware.org (Postfix) with ESMTP id 609C64B9DB66;
	Fri, 13 Feb 2026 13:32:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 609C64B9DB66
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 609C64B9DB66
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.133
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1770989550; cv=none;
	b=U5N2HsEbgh53Hw6/m+GNc00aErn9Gw+T1P3mxx0yg9IaOgDUZ/KwwoJw33Th8slq+mvLNMa6Namf0mbjPX26ZSkIB4USBV72Sz/beDMDDu3fPiaJiZRYJVtX3kOU82nl3FonwD9KOlzNUld4JZPvqrf1I/TEHSJ6jKz4S7L7cjc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770989550; c=relaxed/simple;
	bh=zXBE4t0d0QANjdHw3b+ml7ZPNFHbLa1mISQgweha5Us=;
	h=Message-ID:Date:MIME-Version:From:Subject:To; b=Jspii2cbV5CG0eHIKmU5j1w++l3pFRBI8BMcB8MTKlNJodNB15gk1OhbuSehYj1bwMY6D0pwJSvi0aq+BfjW+cu+C0jZyDe1UTxZsjOM1yz226T/hJBQZYUOp3Xa6moAnlMoZn5MKfwXV9j0bAEDQ5kQcKOcWtqhEORHfWB+gHE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 609C64B9DB66
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1DF70E96945B
X-Originating-IP: [86.143.43.90]
X-OWM-Source-IP: 86.143.43.90
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFjYuS3P8/t8Upyv6kJ5A6mFJFWMtHMq0n+XzT4ro4bIp4YhE0qQ4YyQc1YSBfPLx7UYTzN1cIzL1klSV0PgSYsFu90Ck4czp8NRChst0CBjTnHIW7fGaduMxKJ6dmqUdTuWkjFHPBgSdg6mPfkcc3B8FthG2J/lVKrVEKORbh+95Qyvw7jaMjJgde2SrOCk1YqPdfrZNggyprhz57wyytrcjK64oXv9foB1xvTAiIYeUnE98qtIFDwzo/Ik2E7QOigHvKysdR32E7Tj/Pr/C2g63HqSCY262ZUvFNlEa17UnWCiC9zF/7KqaJbJWrZeatkieuxj0G7z1ACjtD3/6v/UvUjuqMaWiArbDHwwc2JQiXbAMOgS6cq8385Nmad9/fxQ5OYiHWfY8KXCoUjHFsFPF79SKC6rBHGY6SXhOqBgkR4Dw8oToHMcqWs6ujzE2b++5knI5q7ngotQQYfyhd+X0dT6LA7rM1VgELH14d0zqgcdUm8xg0uA90vZF7/qP7LRzg4+qgcRlVe+13yeWrWWOeJ/+43P04/LGL4leS4fFPOd7ESfw0wPJpU6yX4AIOePvK/27qtg7KWuCmCZSs/e297vwDRrL/eitmwrJE9IupR4QO//zSSlAIZTWAt3UXQyKM3R/aRsBK1Mb8M7kBTrJgysBr2C0Nwt5Qmlku3CA
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.143.43.90) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1DF70E96945B; Fri, 13 Feb 2026 13:32:24 +0000
Message-ID: <3eb9430b-2457-4179-a9ab-1376da7860e3@dronecode.org.uk>
Date: Fri, 13 Feb 2026 13:32:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: hookapi.cc: Fix some handles not being inherited
 when spawning
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
Cc: cygwin-patches@cygwin.com
References: <aY4Gibum9Q1gj9lp@arm.com> <aY45Re_bOuUxBUrz@calimero.vinschen.de>
Content-Language: en-GB
In-Reply-To: <aY45Re_bOuUxBUrz@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/02/2026 20:34, Corinna Vinschen wrote:
> On Feb 12 16:57, Igor Podgainoi wrote:
>> Under Windows on Arm (AArch64), the function hook_or_detect_cygwin will
>> return NULL early, which will cause the call to real_path.set_cygexec
>> in av::setup to accept false as a parameter instead of true.
>>
>> Afterwards, in child_info_spawn::worker the call to
>> child_info_spawn::set would eventually pass that false result of
>> real_path.iscygexec() to the child_info constructor as the boolean
>> variable need_subproc_ready, where the flag _CI_ISCYGWIN will be
>> erroneously not set.
>>
>> Later in child_info_spawn::worker the failed iscygwin() flag check will
>> cause the "parent" process handle to become non-inheritable. This patch
>> fixes the non-inheritability issue by introducing a new check for the
>> IMAGE_FILE_MACHINE_ARM64 constant in the function PEHeaderFromHModule.
>>
>> Tests fixed on AArch64:
>> winsup.api/signal-into-win32-api.exe
>> winsup.api/ltp/fcntl07.exe
>> winsup.api/ltp/fcntl07B.exe
>> winsup.api/posix_spawn/chdir.exe
>> winsup.api/posix_spawn/fds.exe
>> winsup.api/posix_spawn/signals.exe
>>
>> Signed-off-by: Igor Podgainoi <igor.podgainoi@arm.com>
>> ---
>>   winsup/cygwin/hookapi.cc | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/winsup/cygwin/hookapi.cc b/winsup/cygwin/hookapi.cc
>> index ee2edbafe..b0126ac04 100644
>> --- a/winsup/cygwin/hookapi.cc
>> +++ b/winsup/cygwin/hookapi.cc
>> @@ -45,6 +45,8 @@ PEHeaderFromHModule (HMODULE hModule)
>>       {
>>       case IMAGE_FILE_MACHINE_AMD64:
>>         break;
>> +    case IMAGE_FILE_MACHINE_ARM64:
>> +      break;
>>       default:
>>         return NULL;
>>       }
> 
> Pushed.


This whole switch statement looks like a wart left over from x86 times?

Either that or it should be properly checking that we're not trying to 
mix architectures somehow? (See the comment where PEHeaderFromHModule is 
used in hook_or_detect_cygwin).
