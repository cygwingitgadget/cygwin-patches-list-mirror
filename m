Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B9BAF3857B98; Tue, 21 Jan 2025 13:47:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B9BAF3857B98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737467231;
	bh=1J8vqokU+cPEJC3k3947/sPcs6t2fdg1GSnEeM15PJ4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ykJ541Gzmwd4dw/7YCfpu3hfZ+Nmpw+I6p0GOkYfZrtimpPCOGPQS/R/lyVQPWv1n
	 dGFx/HE87D1XSnwzZcpKNS/ZGkTfUtDu0grbccBb7M/WZfcX01pgZMYfVN55sG+Efi
	 RddmyP2WTp93840Hx0figtWL9uC11YYxlUUIFGnQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C110BA80885; Tue, 21 Jan 2025 14:47:08 +0100 (CET)
Date: Tue, 21 Jan 2025 14:47:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Add fd validation where needed in mq_*
 functions
Message-ID: <Z4-lXPOKACX4bGz1@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013235.html>
 <20250120060009.345-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120060009.345-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Jan 19 21:59, Mark Geisert wrote:
> Validate the fd returned by cygheap_getfd operating on given mqd.
> A release note is provided for 3.5.6.
> 
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257090.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 46f3b0ce85a9 (Cygwin: POSIX msg queues: move all mq_* functionality into fhandler_mqueue)

LGTM.  I'll push it after Takshi pushed his signal patchset.


Thanks,
Corinna
