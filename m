Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CBC5C385840F; Tue, 19 Nov 2024 09:17:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CBC5C385840F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732007836;
	bh=TR3AIQqwVeJfikVkD+Y1I5Du3fEbgZcDe27jzCbqrQ0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dsJrcs+cyD0IhRl5QlHxXUD9JsZaQlzZdNETNc+yOpGL9R0ywcT+LPiTHFMrBJq3U
	 n5f0jTSp1VTOLmrq4ZVK3NVXvInJY4hFIBh1Bh6JFcL27uUSdKe+IJjo9wtcFAud1r
	 bRKUiTH6Vw3EqW4OsJ52dZyiNy/eN7Hb05EWsK5g=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 638ACA80A6B; Tue, 19 Nov 2024 10:17:14 +0100 (CET)
Date: Tue, 19 Nov 2024 10:17:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: New tool loadavg to maintain load averages
Message-ID: <ZzxXmgVc3aAkfJVJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20241113062152.2225-1-mark@maxrnd.com>
 <3987e096-9510-4fc0-8121-ca32773c09e4@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3987e096-9510-4fc0-8121-ca32773c09e4@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Nov 18 20:58, Jon Turney wrote:
> On 13/11/2024 06:21, Mark Geisert wrote:
> > This program provides an up-to-the-moment load average measurement.  The
> > user can take 1 sample, or obtain the average of N samples by number or
> 
> Sorry about the inordinate time it's take for me to look at this.
> 
> 
> So, this seems like two separate things shoved together
> 
> * A daemon which calls getloadavg() every 5 seconds
> * A tool which exercises the loadavg estimation code
> 
> Does it really make sense to bundle them together?

The other question then is, why not just make it a standalone package?
As a Cywin-only package it could go into its own git repo under
https://sourceware.org/cygwin-apps/


Corinna
