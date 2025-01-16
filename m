Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4FF4B384D19A; Thu, 16 Jan 2025 18:53:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4FF4B384D19A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737053602;
	bh=VLLx51UH5n/6kfPXVXHhdF5SoLUxWOWtV/fK3L803/w=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=MpfczrPQubf/Nxnj0F9PR/QpM2ryqvv0ceHxv4mISGOWk1IHmR2RrGTQrieTf474U
	 UlC5nwoms0/H++k+lHoCPqg94bpGV0/rD133Fj8hV0bABZ3qr3QRlr/nZejxS0N6LF
	 8/kFzmGqMUahpd8yL3Ka53EFOekXtocb3m1Y0NHY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 95FF2A8076D; Thu, 16 Jan 2025 19:53:20 +0100 (CET)
Date: Thu, 16 Jan 2025 19:53:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 6/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 group variants with base
Message-ID: <Z4lVoCAdsBSh_D2T@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <564775aa4f134c19f62fc376e2a8f9d773bd0295.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <564775aa4f134c19f62fc376e2a8f9d773bd0295.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 15 12:39, Brian Inglis wrote:
> Move circular Ff/Fl and similar functions before hyperbolic Fh? and
> similar entries to keep base entries together with their -f -l variants.

Patches 6 to 8 can go away.  We stick to ASCII order, one function
per line.


Thanks,
Corinna
