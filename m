Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AC3BE38757C7; Mon, 23 Jun 2025 08:38:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AC3BE38757C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750667904;
	bh=2tKDievNd82qmeoU6Ge0JDnLOXWjkBprCLZhsKGjFrk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ojNXUxyXD4aMvr7bhXhVbTpwqSPGoBhIfx3jDR441iEca8d4WMFZjdkPtNNwEeJzF
	 vcdDr9pemFc8lxtR59tAbVLIqLgqluhSx/YeHY97Y+zzFj+YQ75Aa4DPcqwRoafgVQ
	 jAzkyMgxXruxSn8wyDEmwTxWry9y0RVsCEvh0oyg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8E27BA80D72; Mon, 23 Jun 2025 10:38:22 +0200 (CEST)
Date: Mon, 23 Jun 2025 10:38:22 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] symlink_native: allow linking to `..`
Message-ID: <aFkSfmQq7boNv0K6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6058889e2ae8c9c827a8d6678f09b3b1741e2fcf.1750413578.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6058889e2ae8c9c827a8d6678f09b3b1741e2fcf.1750413578.git.johannes.schindelin@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Jun 20 12:03, Johannes Schindelin wrote:
> When running
> 
> 	CYGWIN=winsymlinks:nativestrict ln -s .. abc
> 
> the counter-intuitive result is _not_ a symbolic link to `..`, but
> instead to `../../$(basename "$PWD")`.
> 
> The reason for this is that the search for the longest common prefix
> assumes that the link target is not a strict prefix of the parent
> directory of the link itself.
> 
> Let's fix that.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Pushed.

Can you please create a followup patch adding a release text to the
release/3.6.4 file?

Also, please add a Cygwin: prefix to the git log message summary next
time.  I just noticed I forgot to add that to the pervious patch
*facepalm*


Thanks,
Corinna
