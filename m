Return-Path: <SRS0=1B9v=DV=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 4596D4B9DB5F
	for <cygwin-patches@cygwin.com>; Sun, 24 May 2026 09:05:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4596D4B9DB5F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4596D4B9DB5F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779613510; cv=none;
	b=PhfpgeOCN7Ynv9Duc7bpxWdv0cT26WGHEytEH/Fcp+3TPRc3s+bfScxssTqmgy2OrUuSIs8Otp4iEhLQsi+veWdjIMZuPNcEVnclqhFrLZ57AiL/0tKSBIDlMYdaWk0nQF2KMzpjrLv7HEBwd17glHbFSNzUAFGApMSrgN3dD4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779613510; c=relaxed/simple;
	bh=+Gou3pABa4fdFpJmIivK/pJwzF8A5nrf/q3aCCIj8Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=cyzbA5bJ5KNsfNnD1FwbgMCqbPDGyaq2szt/pcZJrrQBSSJlBKVNN+DQfAmFovAl22i9VGwuK5v5boNN0CwNRLkfTHfKlYrS3ukiOEdBOMd8YajVAupmyTg+ze4L1FuO4+jDGThKDTED4Nll3jOSmfGlgMWuOE1EW9ytbbEYvFw=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4596D4B9DB5F
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 64O9KX2p054157
	for <cygwin-patches@cygwin.com>; Sun, 24 May 2026 02:20:33 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdSNqwWd; Sun May 24 02:20:24 2026
Message-ID: <ffa9dedb-810e-4e45-a7f9-e50dbb3a1e72@maxrnd.com>
Date: Sun, 24 May 2026 02:04:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Implement 'reserved' marker in fdtable entries
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260522072913.574-1-mark@maxrnd.com>
 <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
 <d457a7fd-1eee-0dd0-b2f7-d46b84eeaa42@t-online.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <d457a7fd-1eee-0dd0-b2f7-d46b84eeaa42@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

Thank you for the review.  I've inlined answers below...

On 5/22/2026 7:21 AM, Christian Franke wrote:
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

That sounds great to me!

[...]
>>> @@ -595,7 +599,11 @@ class cygheap_fdnew : public cygheap_fdmanip
>>>       else
>>>         fd = cygheap->fdtab.find_unused_handle (seed_fd + 1);
>>>       if (fd >= 0)
>>> -      locked = lockit;
>>> +      {
>>> +        locked = lockit;
>>> +        /* mark as "reserved" for open(), or other syscall, in 
>>> progress */
>>> +        cygheap->fdtab[fd] = (fhandler_base *)(int64_t) fd;
>>
>> So, we're already relying on "a small integer cast to pointer can't 
>> collide with an actual pointer value we might get" (which is fine).
>>
>> But then there's no reason why we can't use a distinct constant (like 
>> 1 or -1), to indicate a reserved slow throughout, which would make 
>> this easier to understand?
> 
> If the current method is kept, I would suggest to change the cast to:
>    (fhandler_base *)(intptr_t) fd

That looks good; I'm thinking of a #define defining the expression that 
we decide on to lessen code clutter.

>>
>>> ...
>>> @@ -607,7 +615,18 @@ class cygheap_fdnew : public cygheap_fdmanip
>>>     ~cygheap_fdnew ()
>>>     {
>>>       if (cygheap->fdtab[fd])
>>> -      cygheap->fdtab[fd]->inc_refcnt ();
>>> +      {
>>> +        /* check if fdtab entry is a "reserved" marker */
>>> +        if (cygheap->fdtab[fd] == (fhandler_base *)(int64_t) fd)
>>> +          {
>>> +            /* remove "reserved" marker */
>>> +            cygheap->fdtab.lock ();
>>> +            cygheap->fdtab[fd] = NULL;
>>> +            cygheap->fdtab.unlock ();
>>> +          }
>>> +        else
>>> +          cygheap->fdtab[fd]->inc_refcnt ();
>>> +      }
> 
> Are the fdtab.lock()/unlock() calls really needed here?
> 
> If yes, this variant prevents nested lock()ing and leaves the unlock() 
> for the base class dtor:
> 
>            {
>              /* remove "reserved" marker */
>             if (!locked)
>                {
>                  cygheap->fdtab.lock ();
>                  locked = true;
>                }
>              cygheap->fdtab[fd] = NULL;
>            }

I'm glad you raised this question!  I do like your variant better.
I would update my patch to have this coding.

But your mentioning the lock being unlocked in the dtor made me look at 
the classes again (in cygheap.h).  The default on cygheap_fdnew() is to 
lock the fdtable lock in the ctor.  And now I see the lock is unlocked 
in the dtor.  SMH that means the fdtable is locked for the same duration 
of time that my proposed "reserved" flag covers!

This shows us (me especially) that we don't currently have concurrent 
open()s between threads as I assumed we did.  Something like my scheme 
could allow them, maybe, but the fdtable locking would have to be given 
up to achieve it.  Maybe this is something for the future...

The upshot is that only the patch to syscalls.cc is needed to fix the 
issue you reported.  The other changes are subject to withdrawal...

Comments welcome from anybody reading this.
Sheepishly,

..mark

