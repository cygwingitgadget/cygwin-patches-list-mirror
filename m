Return-Path: <SRS0=giYG=BO=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 895CD4B1A34D
	for <cygwin-patches@cygwin.com>; Sat, 14 Mar 2026 03:30:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 895CD4B1A34D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 895CD4B1A34D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773459013; cv=none;
	b=jyOnWhl7KLDMxU8qYu4VBYxzYGwTK3KPaDhOvJeJXI14/AHqs6C9ywRd5sycnoV7sqcQCyq50Pk8A0PCRN7+EdzQg6XkNboFNl5VomhbsdVzhZEnf9xA91s6Ijlw7eo1CyHYIrZ9W6INpUQsv3t2fL9B51TcWvt4Hp+PlavMmmg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773459013; c=relaxed/simple;
	bh=KGkPvr5L+Em5+QrAw36r3AUdMJgGSufX8FFieeeyzIM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version; b=IXz8GNBBppaltAINUOMXxuxZBk54X9dETJkf3laswTUhDiyTYrS8k23xr8jveehrCxzxjCGVj2EGdF3BCa6ilKtFmlwir5WqcYnxXh9w2sRlI2iaffq81EJdbLgAxnugw0nkW0h5pAcYmzMtXrT3obTem9oX5fY6RiauVoWzkmw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 895CD4B1A34D
Received: from localhost (mark@localhost)
	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 62E3kYPY007144
	for <cygwin-patches@cygwin.com>; Fri, 13 Mar 2026 20:46:34 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Fri, 13 Mar 2026 20:46:34 -0700 (PDT)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <CAHnbEGLjarFbKBA37b5medyqcFAMuVo-dQB0n_Gwu_zWoHL90A@mail.gmail.com>
Message-ID: <Pine.BSF.4.63.2603132030250.5777@m0.truegem.net>
References: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de> <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com> <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com>
 <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com> <aGulX_0Azb6GI-_C@calimero.vinschen.de>
 <aIJ2kbx6UOK6mAnG@calimero.vinschen.de> <b05a2798-ce6a-28cf-f8e2-3f0cd7bf165b@jdrake.com>
 <CAHnbEGJT8vKZjR8aXqB+aANZ8J9P8G5bnLO6gf860FzAeCCXMA@mail.gmail.com>
 <8fadabda-8d77-4751-86a2-c9741624b648@dronecode.org.uk>
 <CAHnbEGLjarFbKBA37b5medyqcFAMuVo-dQB0n_Gwu_zWoHL90A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 13 Mar 2026, Sebastian Feld wrote:

> On Thu, Mar 12, 2026 at 3:45 PM Jon Turney <jon.turney@dronecode.org.uk> 
wrote:
>>
>> On 09/03/2026 09:54, Sebastian Feld wrote:
>>> Was this work ever merged into Cygwin1.dll?
>>
>> Unfortunately, not.  And Jeremy seems to have moved on to other ways to
>> apply his talents.
>>
>> It would be ideal if someone else would pick up that work and get it
>> finished off.
>
> That would require a cygwin.dll expert beyond my skill set.
>
> What about adding the current work as build option?

If/when "someone" can be found for this work, it would be far better to 
finish the work so it can be tested and merged.

I can't imagine providing a build option for an unfinished, unsupported, 
branch of the Cygwin DLL to "release" a lightning-rod feature to users who 
won't know how to make use of the incomplete code.  That just sounds like 
more future work for us, to be honest.

You've reminded us of this unfinished work so it's again visible to us. 
Thank you for that.

..mark
