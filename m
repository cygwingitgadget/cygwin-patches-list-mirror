Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C57AE3858CD1; Wed, 16 Jul 2025 08:46:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C57AE3858CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752655583;
	bh=p1waVka1MD0cDtYroYnyRCvX6B9Dg7U4espRpfyb4Js=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=HuPMgRT8tmq95EpyQXqIyoD2uBDMHzanTfH4vf+JvHbzkExnJJVXkg2W4ORSLSN6w
	 FWereoxhnHJQEtkjaabYQGl43AU8ZuKPnQTcd37a3vlhEhbmvfINXvae1Y9FomPKFT
	 4qPZ5J06EByekRbohsFjaXAcJCVZwMSBsyQWRMwI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C8D08A80B9E; Wed, 16 Jul 2025 10:46:21 +0200 (CEST)
Date: Wed, 16 Jul 2025 10:46:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: testsuite: link cygload with
 --disable-high-entropy-va
Message-ID: <aHdm3ctDlIHayPiN@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <e997b36d-d166-8bee-4eff-fea7ebbdd7fb@jdrake.com>
 <04c19697-8144-2b3d-ca7f-bd06e9ffe600@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04c19697-8144-2b3d-ca7f-bd06e9ffe600@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 15 17:45, Jeremy Drake via Cygwin-patches wrote:
> Is this OK to push?

Yes, sure!

Thanks,
Corinna
