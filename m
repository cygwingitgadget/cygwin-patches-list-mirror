Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 01D844BA2E26; Tue, 16 Dec 2025 12:05:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 01D844BA2E26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765886810;
	bh=cX1Me2vVmxhDj3V+YGAT7euHUy2SLhdx6u9+IUC90m4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=qJJUeLubrUTjEI3C0jV4ZH254yjofG1DGyPyVAbRKpR4odqTrLt3L132PQecTOYCI
	 qIxfDNbgQeEKOYcgLCScjkR070jXk/gYkQnrcz//ta5FDS+TYdiFQtELPoC6qJJ4r8
	 fRY97vc9UVP4fUUiDdLe/n7pv+etxb5pUYcCBQ7E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CC1FBA804CD; Tue, 16 Dec 2025 13:05:46 +0100 (CET)
Date: Tue, 16 Dec 2025 13:05:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: termios: Follow symlink in is_console_app()
Message-ID: <aUFLGvjfv_PtqWe9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251216083945.235-1-takashi.yano@nifty.ne.jp>
 <ebc2c64d-55c4-98f5-573f-bebadf3e3979@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebc2c64d-55c4-98f5-573f-bebadf3e3979@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec 16 10:17, Johannes Schindelin wrote:
> It would probably make more sense to collaborate and try to combine the
> best of your patch with the best of my patch series.

Collaboration is great!


Corinna


(if only somebody would review my patches as well... ;))
