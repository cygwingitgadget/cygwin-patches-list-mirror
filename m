Return-Path: <SRS0=nZjl=VB=jdrake.com=jeremyd@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 01D9A3858D21
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 19:24:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 01D9A3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 01D9A3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739215451; cv=none;
	b=HHCFmNuCaOTVIpz7iCINlnJ1nMOEid5N4AfvsZxnPDPRZsoOIrYTcSbOlS2aIlsk3a+I29cYefOli9fKBr6OoqVASvfwHWABfbIL+/R12m9gTpHMtbc69Q8X4N3g1TBaXbMzqU+e05yfyWCSDTsSKngIJWujAb8z2Y6+zWt+aOE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739215451; c=relaxed/simple;
	bh=IOquiWD7jRtnsXp14Ts7vf/0tFvmdlpcvYJDuY2qHVQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=gq4HdFh1cLHoePIHHJcxizgdO1K84yKQW0OZL54SIqPl6F3jRc02iFm6CCcoaUX3CMXwi7yRlXQx6lKDxQ9ClJceGfongJf1LTEAEK3FlESlELzjZFlovG2vwPHYRq/S1HV4ewboJOsI/Y/Y8dPmOYW5KK42phF0C9T73U9aJU4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 01D9A3858D21
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=l4vFRCI2
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 6B0EF45C70
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 14:24:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=CmEWu8+5p/Rpz5euEzaQWc9DDk4=; b=l4vFR
	CI2CsiDai2iPl+ujRxmwpW84DiPED7k0Vdcdoeh6QAsXHS80wGhTaaiZFJ+Bw9nn
	n904MKXgUWCQtXmgA/YCLBBzEm91u7moV6zgPIkaHe/nPzmrbfB1uPM1khHfAQe9
	9/4uc2lLoRvf6qZE6yP0u77DgLeQByT69+Eh2s=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 3E9BE45C6E
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 14:24:10 -0500 (EST)
Date: Mon, 10 Feb 2025 11:24:10 -0800 (PST)
From: Jeremy Drake <jeremyd@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: expose all windows volume mount points.
In-Reply-To: <Z6nkSf7l7MOuQdBb@calimero.vinschen.de>
Message-ID: <dfab3625-f04f-0554-2379-44f86fcd0c53@jdrake.com>
References: <be64d541-a24d-b5ff-5a50-9aae577a48ae@jdrake.com> <Z6nkSf7l7MOuQdBb@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 10 Feb 2025, Corinna Vinschen wrote:

> Yes, dos_drive_mappings() is what I really meant, thanks for pointing
> it out.
>
> So I wonder why not include your additional requirements into the
> dos_drive_mappings class and just use it to iterate over the mount
> points.  AFAICS there are only two things missing in dos_drive_mappings:
>
> - looking for all mount points, not just the first one, and
> - bookkeeping over getmntent calls
>
> If you add a state pointer (pointing to the current mapping) to
> dos_drive_mappings, you only need a single slot in the TLS, holding a
> pointer to your dos_drive_mappings instance.

This would be much cleaner, I think.  I'll look at this.

> [...time passes...]
>
> Hang on, there might be a bug here...
>
> [...time passes...]
>
> Why do we keep the cygdrive state in cygtls anyway?  From history I see
> that this has been the case since at least 2003.
>
> Per definition, getmntent isn't thread-safe at all, and getmntent_r is
> only thread-safe in that it keeps the data in a buffer provided by the
> caller.
> However, the state information is process-wide: if you call getmntent
> alternating in two different threads, they don't see the same set of
> drives, but only every second drive.
>
> At least this is the case on Linux.  Don't we subvert expectations
> by handling getmentent thread-local?
>
> If I'm thinking to much outside the box, feel free to kick me.

That's well outside my scope ;).  I think 1) getmentent is pretty well
deprecated, and 2) if something isn't defined to be thread-safe, pretty
much anything it happens to do in the face of multiple threads using it is
fine (to me, we're in the realms of UB here).
