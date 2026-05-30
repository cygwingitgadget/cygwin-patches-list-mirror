Return-Path: <SRS0=t1ok=D3=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.244])
	by sourceware.org (Postfix) with ESMTP id 7F6EE4BA7988
	for <cygwin-patches@cygwin.com>; Sat, 30 May 2026 11:33:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7F6EE4BA7988
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7F6EE4BA7988
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.244
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780140816; cv=none;
	b=FO2kZEXdwGyfh8+li1OS6UGUyeJIjCFgBp+uXn2hP+V4djtOPNufDMa/giqqTop0nxXuwSn9aoEAKcCRAeXPfrUY7EmiUeK6UspNnaO/Ogn8AAhwz/x7dhEOvEgoIwns2zd3h5ZzPJ2OsP6f6DbAzxT1OIPR2l6gIN1++NbguEc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780140816; c=relaxed/simple;
	bh=AN0OH4G0tsfmxUSVn9jsFUXS6ONtWDAe6tDdOUZdvyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Y4HLjnD+o4DEB3BBvkve2675LZivkRtcVVhNpznNm0mH+msTKT/Hu0pVKfTiUcBvn772TvYu4hUD5Pc4DU2KirMqBRTascZoivB0f7taZ1temncvShrxLOi578CndlFP8oiMz7qFYK+z3/Bd+TLbUgPjJ/b+d6QUle1RYbA5Bak=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F6EE4BA7988
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69FE539D01BE839F
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTGuzH+E0S1ntaQhuIDohLhJVANiF8olArOdMz2IaVuPc0sHP/BBjcdskDTpD3TG1wL4IuwpvlPMjgqM3Hx1/mDQj9TFATo0HI9iuRQJ6RyJYm3W1B7eeFCU6uuPjPaPsiiietAunP7gUdIfi1pERDf91+UWMHiXg6otMic1hwEFD3SO92msjiePDOCLNz+OuPVhAmGRXRDdAdxpQt0qJdMSl8qrOxQQc/aVpH30iZJDE+gZlMlN04C/bzTIb8uE5mOpkG6Zzf24sxjN2V2ur1r8dyULoPdxyB6GQfcXr1692uKrsEV51EpraQ3h9quJ/2BAjHUs3/Zb5E836cUrlGi3WvZVgwhW3V1w2BAdBRPb89HaK+tdrvauWSXmAVSECQK4Den0AZeGdlT0nx+xYyA7OkgREV6RD0l9dmhniaAQ3uMu2xEZMhocxkVjGJtyhqZP3pc4Jn4aoVmKLKSGM1cIrzpkDmpW0QWkDVieNjgPMW+Iq6hSv1g5VMW9PkJGh1kkNF2gbcVR8UemImgrNh8lsrbM1iw01SbWGYPtIw20ydITMgze9IPGC1OM/KeAWWv1wHUoj9FiTB7TD8VnDNGugBLrHRZRojP+ySdVBgDfaekjqNrYl3lvFyrGcmt2yTY9blCne4nb/Z4qMbrn2bitDVkRufFGPBIscKdeoG924Q
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69FE539D01BE839F; Sat, 30 May 2026 12:33:32 +0100
Message-ID: <743b62ce-feab-49bf-95d0-f958fd5dacde@dronecode.org.uk>
Date: Sat, 30 May 2026 12:33:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Implement 'reserved' marker in fdtable entries
To: Christian Franke <Christian.Franke@t-online.de>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260522072913.574-1-mark@maxrnd.com>
 <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
 <d457a7fd-1eee-0dd0-b2f7-d46b84eeaa42@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <d457a7fd-1eee-0dd0-b2f7-d46b84eeaa42@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/05/2026 15:21, Christian Franke wrote:
> Jon Turney wrote:
>> On 22/05/2026 08:28, Mark Geisert wrote:
>>> ...
>>>
>>> The notion is that an fdtable entry provided by cygheap_fdnew is marked
>>> so that another thread can't obtain it.  Care is taken to reset the
>>> marker when the entry is no longer needed.  Actually, in the usual case
>>> the marker is overwritten with a pointer to an fhandler_base structure,
>>> by the reserving thread, as the syscall completes.
>>>
>>> Reported-by: Christian Franke <Christian.Franke@t-online.de>
>>> Addresses: https://cygwin.com/pipermail/cygwin/2026-May/259664.html
>>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>>> Fixes: e859706578ba (* autoload.cc (NtCreateFile): Add.)
>>
>> Thanks!
>>
>> This all seems fine and reasonable, but I have a couple of small 
>> comments.
> 
> A test with an enhanced version of the STC was successful.
> I could push this version (attached) to cygwin-apps/stc if desired.

Yes, that would be great. Please do so.

(I guess ideally after the fix is committed so it stays green, but it's 
red at the moment and I severely lack the time to investigate why...)

