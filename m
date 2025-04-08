Return-Path: <SRS0=7wyj=W2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 94C823857B8C
	for <cygwin-patches@cygwin.com>; Tue,  8 Apr 2025 10:37:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 94C823857B8C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 94C823857B8C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744108642; cv=none;
	b=gw7djsgg3YPSlpaF4y0q0GUCiGI6SiXvibICw6DMSNSnn6W53p7UZAvQMXkRk0i3awns8ozny/ukbyNw0eI6SjTMzYvp78JtbOpQB3VZDGV0z4U+qXINyz0sPhKl+HFD5cE4C3NM2BbPv99wGY2+uSZ+f5yht6JzP9+qCT6EPjc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744108642; c=relaxed/simple;
	bh=93dmS79VhbzwMXPZclJq1orAKm+lYN82uUvXq4ESo24=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LiYjOnONwa7eZgwa1VxL9driPe1eLEtJUPviCRRcvgNgne8TBA3xsIyczPfSnHXXKAmuo1zcZ9Kvq+8u34aHbthht2/M/0t2JPC6gBpV5Ef/ArIdkVIdI4hzWOc8foUxd1ERtOcNuy6MT3FOkWBUAuwe7EkP+sTJwn+C44EX8sY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 94C823857B8C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=epSh5sp/
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20250408103719480.TXND.37742.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 8 Apr 2025 19:37:19 +0900
Date: Tue, 8 Apr 2025 19:37:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired
 multiple times.
Message-Id: <20250408193719.4f284c100be21957dc29cc03@nifty.ne.jp>
In-Reply-To: <Z_T5HMWYU6nYsyTz@calimero.vinschen.de>
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
	<Z-E6groYVnQAh-kj@calimero.vinschen.de>
	<20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
	<Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
	<20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
	<Z-PJ_IvVeekUwYAA@calimero.vinschen.de>
	<20250404214943.5215476f96d46cf15587dd1b@nifty.ne.jp>
	<20250406195754.86176712205af9b956301697@nifty.ne.jp>
	<Z_T5HMWYU6nYsyTz@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1744108639;
 bh=k6tOxejpcTDDGXgGNMSy1otTBlk+KK96HGrW1cuYyYU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=epSh5sp/zL8aLRrSuCvFt0N/EHwOCUFG2ZfXNQ4b3zrhZFQJ6vVo5hkPymalxM41yBfylvbA
 N3NeBCu7lbZf3lYYCLMOMG0xWhTp9y4YrPRhi4F0vCkVBQyyMZcggAC3LA6sNogMpqRAStvHmP
 qTwl9/qZHJ2DnptNx4z86wnLJsCyHKeEZm/PaOGZ1D0rjbJ5j9u6et+yhNogl4k9ZRw7sZzBqq
 TEXpw8r8vlTZSjKCr+fsCrM6ivFL2vPa5ldY7GhDzU52vr1aAGcLI/xkr0WETqrEIY9f2Gwvdf
 ludFek8e2v6IO8opw05WIeTHzmFsYcxwzad9Jwxkn7Rg59Gw==
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 8 Apr 2025 12:23:24 +0200
Corinna Vinschen wrote:
> looks good, but...
> 
> On Apr  6 19:57, Takashi Yano wrote:
> > @@ -1685,7 +1700,15 @@ pthread_key::~pthread_key ()
> >     */
> >    if (magic != 0)
> >      {
> > -      keys.remove (this);
> > +      LONG64 seq = keys[key_idx].seq;
> > +      assert (pthread_key::keys_list::ready (seq)
> > +	      && InterlockedCompareExchange64 (&keys[key_idx].seq,
> > +					       seq + 1, seq) == seq);
> 
> ...do we really want to assert here?  Shouldn't this better just skip
> the rest of the function?

Sounds reasonable. Skipping before TlsFree (tls_index), right?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
