Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 19BF03858CD9; Tue,  8 Apr 2025 18:14:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 19BF03858CD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1744136069;
	bh=4rMr0QZ/htuV1OTOI78hCKrGPG3lt5WCtNkLBxx3Iuw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=wFeLFToMDuJIlhvpK2Uwh6IirKMj4ID98aydQghxW98KDQIEnnQTpBVDxrF+Dh/Jt
	 8cU1XFPd75PkWKvzLx3ay4XL+10w1N2fMnWIRiRCz6gnSEOGRyXOrj4PjE8pdQc0BY
	 +SRrXCAvChQOMwkoXD8wq1TpKFTSaCbtCtAGkwHk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CBDB6A809C7; Tue, 08 Apr 2025 20:14:26 +0200 (CEST)
Date: Tue, 8 Apr 2025 20:14:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired multiple
 times.
Message-ID: <Z_VngpFxvD_0rsew@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
 <Z-E6groYVnQAh-kj@calimero.vinschen.de>
 <20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
 <Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
 <20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
 <Z-PJ_IvVeekUwYAA@calimero.vinschen.de>
 <20250404214943.5215476f96d46cf15587dd1b@nifty.ne.jp>
 <20250406195754.86176712205af9b956301697@nifty.ne.jp>
 <92ac7d14-4e71-14cf-91e0-080ca7a461f8@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92ac7d14-4e71-14cf-91e0-080ca7a461f8@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Apr  8 10:26, Jeremy Drake via Cygwin-patches wrote:
> On Sun, 6 Apr 2025, Takashi Yano wrote:
> 
> > Revised.
> 
> Sorry to be late to the party (I didn't open the attachment before, and
> only saw the commit):
> 
> > +  static class keys_list {
> > +    LONG64 seq;
> > +    LONG64 busy_cnt;
> 
> Should these be `volatile`?  busy_cnt is probably OK, it only seems to be
> dealt with via Interlocked functions, but seq is tested directly in some
> cases and via Interlocked in others.

One could think so, but...

...GLibc uses (basically) the same mechanism.  It reads seq in
pthread_key_create and pthread_key_delete without atomic access, and
neither the global array keeping the key info, nor the seq struct member
in there are marked volatile.

Is there anything which makes our version different?


Thanks,
Corinna


