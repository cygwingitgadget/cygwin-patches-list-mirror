Return-Path: <SRS0=kr8w=VE=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3071A3858D20
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 18:08:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3071A3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3071A3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739470140; cv=none;
	b=ABi6SscHz5SOQH+xHWlJ+gK1+Zj5ndsF+0+zgmX1e5W+SUIDjaQvjEV/Zrw68aloS6AzT6l3eoHdviexfKzSYAPXYLadjn7A4hKZ24i13CaVW/34tb+Cg3pmtNPlZVjXve876nvoTYS7AHlKuyWuMOK83XMxgu1KqjUp8/PErVg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739470140; c=relaxed/simple;
	bh=/TSOdBQncPYuXYXNdfAWLyOJ+omlAqzxxze3KbkJY2A=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=HHEQxTVRtUvOa5e8PvGixs0rkeR1nkUiL+AHW68FLN6/LRK1labRqqOIU/QCBZo8/0W0lbEKefx1df5xwLt3IKyPe114zlpd35GnnvRHurGvl1pZVe2fT+GEKRqkCFgBVTOF3mbS190x3ULTL61mx7MnJapSXbVNlghxJYV1Eo8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3071A3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=inwLoJvL
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CB35245B8A
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 13:08:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=T7yZVfGjDnOtFSBqoAp+pj2ae/4=; b=inwLo
	JvLwBAJniqjDmi0z7FdzuMmGTRrCDznTmVV7wHzY+hKN3/6xztkduVIv4ITz8+l0
	/gxw4sHTvIrzBE5qMIe2JDWSywcykLh3dr3SX85PNnqydVCOVpa+YOh2k8YPurp7
	21Bj2lNXC6YASBMzieMa4NueHu1JFpZIrwbdWQ=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C65C045B2C
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 13:08:58 -0500 (EST)
Date: Thu, 13 Feb 2025 10:08:58 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
In-Reply-To: <Z64Cm3wHdcgw__6U@calimero.vinschen.de>
Message-ID: <1ad8846b-2a13-b0d4-f70f-e1413bc48fcb@jdrake.com>
References: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com> <Z60QiLIEAvDzSs5k@calimero.vinschen.de> <9fd9ec5e-f9a5-d510-2792-3e0ca24e3f11@jdrake.com> <522175b6-08ed-9929-3705-aaadf30283ff@jdrake.com> <ed1a01aa-8908-47a2-70e2-b955c65962c0@jdrake.com>
 <Z63-eTxbCyo65Jlj@calimero.vinschen.de> <Z64Cm3wHdcgw__6U@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 13 Feb 2025, Corinna Vinschen wrote:

> On Feb 13 15:15, Corinna Vinschen wrote:
>
> > I think this looks good, including patch 3.
>
> To wit:
>
>   $ mount | grep drvmount
>   C:/drvmount on /mnt/c/drvmount type ntfs (binary,posix=0,noumount,auto)
>   $ mount C:/drvmount /home/corinna/drv
>   $ mount | grep drvmount
>   C:/drvmount on /home/corinna/drv type ntfs (binary,user)
>   C:/drvmount on /mnt/c/drvmount type ntfs (binary,posix=0,noumount,auto)
>   $ df /mnt/c/drvmount
>   Filesystem     1K-blocks  Used Available Use% Mounted on
>   C:/drvmount      4175868 56744   4119124   2% /mnt/c/drvmount
>   $ df /home/corinna/drv
>   Filesystem     1K-blocks  Used Available Use% Mounted on
>   C:/drvmount      4175868 56744   4119124   2% /home/corinna/drv
>
> > If you're fine with that,
> > I'll push all three patches.

Sounds good to me.  It's less code, and the code it calls
(cygdrive_posix_path) is more efficient because it doesn't have to loop
through all mounts.  As long as you're ok with the change in behavior
that:

mount C: /c
mount

will now show C: on both /c and /cygdrive/c, instead of just /c as before
(this is the behavior all of that de-duplication mess was trying to
replicate).
