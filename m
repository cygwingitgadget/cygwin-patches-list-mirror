Return-Path: <SRS0=wa0U=VQ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 0065E3858D29
	for <cygwin-patches@cygwin.com>; Tue, 25 Feb 2025 01:51:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0065E3858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0065E3858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740448309; cv=none;
	b=Y4R025UupQP2u8t/cxvxgNvwdcYEzSIsgSQoMdnn3jRpi0vaXzU2XYMGpIbQ5dVBPmgHu+LUY0f3ol4mxbJFkkkdC/4jsJ06QjY2Ty6T1rhqMgzI5tiUQusXG+3EU+37v2xWYZ5Gvsu95QdqXXuHmfXTwfy0/1mUThxK8URgPDo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740448309; c=relaxed/simple;
	bh=sy41ex6YXmT1QBz01JZADkir6qszG/AklrAaRaw/Eos=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=haxzzmKdAmmlbDAoe3rw2EjVO9SxuD0/nYFqK8jZM88M2iAcu2ubx9F9wz6yf5k8JqaMOK67xthDIiVuXHkbsw3NZ//GC3jIPEPuAXjEcwFKaH8sYzqdYU7YElnNBYeToagPfIrk6gxFnePD7OBlhoVevO/xtYwYS6z+XnR6IOs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0065E3858D29
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 51P1vOWS022357
	for <cygwin-patches@cygwin.com>; Mon, 24 Feb 2025 17:57:24 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpd8a2yCY; Mon Feb 24 17:57:19 2025
Message-ID: <68dc561f-5a1e-420e-a667-e97a1947dbdb@maxrnd.com>
Date: Mon, 24 Feb 2025 17:51:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Add spawn family of functions to docs
To: cygwin-patches@cygwin.com
References: <20250216214657.2303-1-mark@maxrnd.com>
 <Z7MNyLzVvY_Mm_bH@calimero.vinschen.de>
 <Z7xe2UNaIBB3UFXu@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <Z7xe2UNaIBB3UFXu@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On 2/24/2025 3:58 AM, Corinna Vinschen wrote:
> On Feb 17 11:22, Corinna Vinschen wrote:
>> On Feb 16 13:46, Mark Geisert wrote:
>>> In the doc tree, change the title of section "Other UNIX system
>>> interfaces..." to "Other system interfaces...".  Add the spawn family of
>>> functions noting their origin as Windows.
[...]
> 
> Actually, Jon raised some reservations against adding historical
> msvcrt functions to the set of documented POSIX functions on the
> IRC channel.
> 
> We also have functions like _get_osfhandle and stuff like that.
> Do we really want them documented in the list of POSIXy functions?

I didn't see Jon's comments unless the "1999" reference covered them ;-).

I have no issue with the Windows-derived functions going on a separate 
list.  I only suggested the UNIX-* list because of the small number of 
Windows-derived functions being added.

BTW The MSDN documentation of the spawn family of functions has their 
names all starting with an underscore character.  Should we follow that 
or not?

On the question of documenting these funcs at all (was that being 
raised?), I don't feel very strongly about it.  Maybe it would save one 
out of ten posts asking why our POSIX environment doesn't do this 
Windows thing?  /s

If the final decision is to document in a separate list for the doc 
pages, I can submit a revised patch for that.
Cheers & Regards,

..mark
