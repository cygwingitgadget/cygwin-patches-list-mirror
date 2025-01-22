Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BA8CC3858C5F; Wed, 22 Jan 2025 11:23:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA8CC3858C5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737545001;
	bh=qnqPczeWCX4IA/7XBf86pvIl4j5ySYJs687fphG2/iU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=NTtpj0eDyZeZXxsmUHjoFOLqlp9ioJfrp/KgTvAx6rl97GkCkYBTFQF5UVoH39sIP
	 clmwxgq8oX7GGSd/5LT8XEX9QA4qUZlh7NmGMDmjGEx39a115ael84+TxYGcHqRIX2
	 3uJnFcKN2jkCH4HM2bMNSjCOVcHt/Cz/DqZgyYmE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 17CB0A80D1D; Wed, 22 Jan 2025 12:23:20 +0100 (CET)
Date: Wed, 22 Jan 2025 12:23:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 4/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
Message-ID: <Z5DVKOrVtnXunSvK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <7c1df0773801655e35abbfb28c4428df9b4854ee.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c1df0773801655e35abbfb28c4428df9b4854ee.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 17 10:01, Brian Inglis wrote:
> Move entries no longer in POSIX from the SUS/POSIX section to
> Deprecated Interfaces section and mark with (SUSv4).
> Remove entries no longer in POSIX from the NOT Implemented section.

This looks good, but I just realized that a bunch of functions are
missing.

> -<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
> +<sect1 id="std-deprec"><title>Other UNIX® system interfaces, not in POSIX.1-2024, or deprecated:</title>

When I introduced the ACL functions from the abandoned POSIX.1e draft,
I missed to add them to the docs.

Well, fortunately I'm now noticing this a mere 8 years later... *facepalm*

Sigh.  I'll create a patch to add them on top of your patches later on.


Thanks,
Corinna
