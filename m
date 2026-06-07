Return-Path: <SRS0=wMYq=ED=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo009.btinternet.com (btprdrgo009.btinternet.com [65.20.50.46])
	by sourceware.org (Postfix) with ESMTP id 14F404BA5439
	for <cygwin-patches@cygwin.com>; Sun,  7 Jun 2026 18:29:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 14F404BA5439
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 14F404BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.46
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780856964; cv=none;
	b=foKb21o6t5ZmKFhqEdpYOGofXgQDOS0iePR0YH3Xh7bGf06tvP3xOFWWgq614TBfd7y33nnCRYlp2TmCET+lygyzsXRfrPG1LVZaW0I/oXj4aRZ1uj+5Fgh+VsbmUxAuPfQxyTJqlXSBeCOESsxY1UkvB8RjOiYXxiCP3CUwjXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780856964; c=relaxed/simple;
	bh=H8RV1Ic93Dksj3FKx5I0B0iAlLBfmd7T0XPUKwKCD6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=QWbqTBa26gz+0yNJrvUu6aDr81B7SiLpkTbKgCRBsDUCmRE880wW/POo/PrpSRd+yG/l2d4gQ3BmMgMtli27r0Dxzqid0jONSmMagbb5KJdM/FUOSUceu93FBVpsx06Ph6nCmapj7UggdcgHImq8UZfElxGy/tY5Rtv/sj1znWI=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 14F404BA5439
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A00E00B023F78BA
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTE39+0Xuf9XFo6DKT7jU3lY3VP00QTV5GEYVlo39Ym3lxQjBCOLvu+qZ+FrNB7jYjgFQSAAIoyv/wQ8YAi2rF1mZWfxR9PCGoslOwGjwohAw+vfcjDOk+xvG5HW1hW1vEWGmh+pCx9VBqxpZ6b2I1XVyhIbGijx0T2P3Wjnb7YuCjfdRevKTdvMZYmgqBYSU49d8hnAaWQ8MATm/W0xYppuqWwBdweI88yYZzEX12wXOpuTaKFTxJ27WXAjjVzf8g1xJCvAClA6/oymR0opVsMg7jIvDGQQy511hlBsKa38+vITUSyMtVBNhAM5j693oyRmrritZl9y7Z7cRf3NF/xLgTEY1fEXbfJrKPkPXs8yC7Jn7jOaU66QfkaF7cqaeV2BCeCAIc/Z36PD2/IoRC5BajFjihWJLrQWVhonXzwz4Nne9ToezpDmu8UkI2TEsD8Z/XZkxH60uKe+4ciaERKrqK8ELHhoAZtDA9uUG9X1rTNmm2lbXcAFiyRoL21WxHUSDar+BtfxQcGsny2XsvNR3noAr9/deqjAG5HrCKo5enFh9KbmDxuZS3OE6YdMG0qZTb5r7alL45YO1wQNYuQkVvAwQmwnKcCrpsLjBr670XpAFXNlt/XaWTr6uVZ9AaIWV39AGuS6o9xuieLtb4Zw+evRmIyw/IWB94Zf7T/CwA
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo009.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A00E00B023F78BA; Sun, 7 Jun 2026 19:29:10 +0100
Message-ID: <aa0ac383-4e4f-4d05-b5f2-a98262403eb3@dronecode.org.uk>
Date: Sun, 7 Jun 2026 19:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Ensure unused fd available for open()
To: Mark Geisert <mark@maxrnd.com>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260528054307.16582-1-mark@maxrnd.com>
 <19ae30b8-610c-465f-94aa-4599b03c2363@dronecode.org.uk>
 <f907bb7e-8817-43e2-a384-6b848f184151@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <f907bb7e-8817-43e2-a384-6b848f184151@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/06/2026 08:54, Mark Geisert wrote:
> Hi Jon,
> 
> On 6/1/2026 6:30 AM, Jon Turney wrote:
>> On 28/05/2026 06:42, Mark Geisert wrote:
>>> The existing logic for open() assumes an fd is always available in
>>> the fdtable for a created file.  This leads to a situation where, if
>>> there is no fd available due to the OPEN_MAX limit being hit, the
>>> file is created but cannot be referenced by a Cygwin fd.
>>>
>>> Move the fd reservation code to an earlier location within open().
>>
>> Hmm... the more I stare at cygheap_fdnew, the less sure I am I 
>> understand what's going on.
>>
>> I'm sure you considered this, but just so I can tell myself I've done 
>> due diligence, perhaps you can briefly explain why this doesn't create 
>> the opposite leak? (i.e. the reserved fd is released if actually 
>> opening the file fails).
> 
> Sure.  What happens is that cygheap_fdnew doesn't mark the chosen fd 
> reserved (i.e. the fdtable is not updated at all, yet), it's that the 
> calling thread has locked the fdtable and knows where the first unused 
> fd in fdtable is.
> 
> All the validations of open() parameters are done and eventually a file, 
> pipe, device, socket, whatever open attempt at Windows level is done. If 
> that succeeds, fdtable[fd] is updated with a pointer to the fhandler_XXX 
> stuff being carried along in variable fh.  The fdtable is unlocked at 
> the end of the __try block by a dtor (see below).
> 
> If that Windows-level open attempt fails, a __leave is performed to exit 
> the enclosing __try block.  The destructor for cygheap_fdmanip, 
> superclass of cygheap_fdnew, unlocks the fdtable.  fdtable[fd] is left 
> as it was, NULL.
> 
> That's my story and I'm sticking to it, but I'm at the limits of my C++ 
> knowledge.  The overloading of "fd" really makes it difficult to follow 
> things.. but I have to admit this seems like tight code to me.  H/T to 
> CGF warranted.

Thanks. Yes, that all makes sense.

Thanks for looking into this. I pushed the patch.

Is this a candidate for 3.6 branch as well?

