Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3F86A385828B; Tue,  8 Apr 2025 11:52:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3F86A385828B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1744113171;
	bh=9Tm9LQNYkLiayjWj6BK77KEKFjSMh/9vM7ii5U1FGhM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=XKZWd/MYmlMzJufRzvmCUFa42LMAzYUGCvNi1nfFCkqr5j2LhIbKiUILC3Ck74aLN
	 vjmHtoZ1UM9B8aYRliZWYS/tsbVSqSuj+pVbbfZ8WuVDeMefs/1iIOw/Wl0VfGuFyQ
	 QljhNSV2W9mrtOOl/nzlRIWo98jDnRCHH9cpIGBM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 26265A809C7; Tue, 08 Apr 2025 13:52:49 +0200 (CEST)
Date: Tue, 8 Apr 2025 13:52:49 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired multiple
 times.
Message-ID: <Z_UOEZilfKBff2rP@calimero.vinschen.de>
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
 <Z_T5HMWYU6nYsyTz@calimero.vinschen.de>
 <20250408193719.4f284c100be21957dc29cc03@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408193719.4f284c100be21957dc29cc03@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Apr  8 19:37, Takashi Yano wrote:
> On Tue, 8 Apr 2025 12:23:24 +0200
> Corinna Vinschen wrote:
> > looks good, but...
> > 
> > On Apr  6 19:57, Takashi Yano wrote:
> > > @@ -1685,7 +1700,15 @@ pthread_key::~pthread_key ()
> > >     */
> > >    if (magic != 0)
> > >      {
> > > -      keys.remove (this);
> > > +      LONG64 seq = keys[key_idx].seq;
> > > +      assert (pthread_key::keys_list::ready (seq)
> > > +	      && InterlockedCompareExchange64 (&keys[key_idx].seq,
> > > +					       seq + 1, seq) == seq);
> > 
> > ...do we really want to assert here?  Shouldn't this better just skip
> > the rest of the function?
> 
> Sounds reasonable. Skipping before TlsFree (tls_index), right?

If seq is wrong, the code should just leave, I think, not touching
anything.


Corinna
