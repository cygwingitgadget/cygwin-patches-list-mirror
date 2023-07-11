Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 854033858CDA; Tue, 11 Jul 2023 08:21:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 854033858CDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689063680;
	bh=P3E4+TkX8UmYBAbkYdpv3g9fWEtI9PfoElAg/873ZyY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cSQxydZTGK5Sl6gdeumZbBdbF4fMF6tBBhMX4WSRxBuB/mVE0vrILJwq7rDnuFZ7u
	 IWKFdfPDPRQlpCy2PypPW/N6SoE8+D1/enuixjs2NnZzWP+uHmkviCdwAjR2bM8Vek
	 A+3c/t93s9Q816qX1DRSF11B1H7gB8tad6UjZBAQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 62555A80CC3; Tue, 11 Jul 2023 10:21:18 +0200 (CEST)
Date: Tue, 11 Jul 2023 10:21:18 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Where should relnote updates for Cygwin DLL patches be going?
Message-ID: <ZK0Q/o0zIKHWCJtK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.BSF.4.63.2307110101090.79963@m0.truegem.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.2307110101090.79963@m0.truegem.net>
List-Id: <cygwin-patches.cygwin.com>

On Jul 11 01:05, Mark Geisert wrote:
> AIUI for cygwin-3_4-branch they currently go to release/3.4.8.
> For the main|master branch they currently go where?

release/3.5.0

An entry there is only necessary if it doesn't get picked for 3.4
anyway.

> I hope to get it right the first time ;-).

Is the release model confusing?  If so, can you explain why?


Thanks,
Corinna
