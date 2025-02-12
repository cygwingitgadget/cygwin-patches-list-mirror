Return-Path: <SRS0=/5EK=VD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 987C03858C35
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 21:39:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 987C03858C35
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 987C03858C35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739396356; cv=none;
	b=lW7+N6PTgJ2T51v9lmBGvGI5pa0JEW3H2z3/X/F9tX9DQuR4IcYivop1JG+BE8CCtTxl9gh+lm4HFNNqDiyMVZsbB2ukFq507mpYaRni4DXj1tcAZ9Vr2PibflV1zLKzpziUr4SHOYz5jDkOfzPHLnmZI2CsyeuxZIJdJoesdZ8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739396356; c=relaxed/simple;
	bh=QAa97dDzNTrG3qUT+7SyOkMiPtkK01J5kCowFHz4g4Q=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ejsvhlB5aC2u/2fZNu2Df07otChhsvudseM+5QD1sruR42WeAHeC+n7qCBo1UJ6dtSuIJF9boWmzkRGF3H0rfNPMumjQr3Uedkm30p8hc15LWRdl2YNWUsUPkF/w3JcAEHWKRrFnbsIVNrLlJv+5O6aInxKF3fFkiKrw8eANA7M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 987C03858C35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ZI4MEUF5
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 30D6045C1D
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 16:39:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=BuRM33ncqbpLa3IQpnbb/aw79nc=; b=ZI4ME
	UF5d20CdmDwP3+ieItl77icKW6wjag6ccmrJQwiIAqi/a5sbzYnylOornVDo4GeK
	7tP41ynQWTnLAh7a6GC++0fLedGNb0a3wr4aTqByGHJVroCyROV0xod6OTa1xtQT
	18aSuvdPk75osbvvnASC0OljlCSV+8fNISC75Y=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id F21AD45BF6
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 16:39:15 -0500 (EST)
Date: Wed, 12 Feb 2025 13:39:15 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
In-Reply-To: <Z60QiLIEAvDzSs5k@calimero.vinschen.de>
Message-ID: <9fd9ec5e-f9a5-d510-2792-3e0ca24e3f11@jdrake.com>
References: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com> <Z60QiLIEAvDzSs5k@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 12 Feb 2025, Corinna Vinschen wrote:

> Hi Jeremy,
>
> your patch is basically fine, and I was about to push it, when I
> realized that I don't quite understand this:
>
> What exactly is de-duplicated here?
>
> I have a drive mounted under C:\drvmount.
> I create an additional mount entry:
>
>   $ mount C:/drvmount /home/corinna/drv
>
> If I call mount, I see two mount entries, both pointing to the
> /home/corinna/drv dir:
>
>   $ mount | grep drvmount
>   C:/drvmount on /home/corinna/drv type ntfs (binary,user)
>   C:/drvmount on /home/corinna/drv type ntfs (binary,posix=0,noumount,auto)
>
> The first is the explicit mount, the second is the cygdrive entry.
> If I disable the above de-dup code, the result is the same.

It was *supposed* to not return the second one.  Maybe I broke it when
trying to break out of the loop early...  I will test this scenario and
see why it doesn't work as expected.

> However, either way, both point to the explicit mount point.
> Wouldn't it be helpful to see /cygdrive/c/drvmount?
>
>   C:/drvmount on /home/corinna/drv type ntfs (binary,user)
>   C:/drvmount on /cygdrive/c/drvmount type ntfs (binary,posix=0,noumount,auto)

The existing code masked off of available_drives if it saw an explicit
mount entry to the root of that drive letter.  I assumed it was desired
not to show a cygdrive mount entry in that case.  If it is, maybe it could
use cygdrive_posix_path instead of conv_to_posix_path?  I'm kind of
concerned that it could get confusing though... consider:

drive mounted under C:\drvmount
mount C: /something
mount would show
 C: on /something
 C: on /cygdrive/c
 C:/drvmount on /cygdrive/c/drvmount

and say nothing about /something/drvmount.  Of course, the existing
behavior I was trying to replicate is to say nothing about /cygdrive/c...

