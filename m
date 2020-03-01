Return-Path: <cygwin-patches-return-10150-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82662 invoked by alias); 1 Mar 2020 06:39:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82653 invoked by uid 89); 1 Mar 2020 06:39:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Hans, HContent-Transfer-Encoding:8bit
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 01 Mar 2020 06:39:03 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id 0216chrS006464	for <cygwin-patches@cygwin.com>; Sun, 1 Mar 2020 15:38:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 0216chrS006464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583044723;	bh=n66XYSKwz9LQrwyfnipSIsqTAfudxTzRGjQJJNJKcZ4=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=Xu1TQi7ngNGeUpQCzDZ/nXdk3xxAy5LjZ2vioRO7toOwgCt4ctpDEsavh9fhYqkmW	 8BoLaHiHR7FoDMYZ0PyZml/eh5rTs+IfSDXQVkKVHtirEheJO3tLI1F6H/cK0O31OY	 gAApXjLfBn3PgQ+Joap5UyDxF3cH6qsvEx2sBJCyV5Gn25czNcDbynDWOLmVVDgeeg	 f0rF2PnvhgbGSSYK7KJ5+LfNr5QkL37Lj/sFWVjJWmg7ckoWey3hJau+BnakZupLZt	 sbqk1sNh06UgApC0GRKF9wAqfrb1hTjdNsN3rjL0wxOA6BYmvXmZYkB2/CPAjmfa0K	 TahRm8zZvk4TA==
Date: Sun, 01 Mar 2020 06:39:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-Id: <20200301153849.4fcaaaf2a6ae8fe723339174@nifty.ne.jp>
In-Reply-To: <ea1bcf99-d945-d06e-9be6-8a17d8fb166f@t-online.de>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp>	<20200226153302.584-2-takashi.yano@nifty.ne.jp>	<05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk>	<20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp>	<20200228133122.GG4045@calimero.vinschen.de>	<cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de>	<ea1bcf99-d945-d06e-9be6-8a17d8fb166f@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00256.txt

Hi Hans,

On Sat, 29 Feb 2020 19:10:02 +0100
Hans-Bernhard Bröker wrote:
> One more important note: the current implementation has a potential 
> buffer overrun issue, because it writes first, and only then checks 
> whether that may have overrun the buffer.  And the check itself is off 
> by one, too:
> 
> >    wpbuf[wpixput++] = x; \
> >    if (wpixput > WPBUF_LEN) \
> >     wpixput--; \
> 
> That's why my latest code snippet does it differently:
> 
>  >      if (ixput < WPBUF_LEN)
>  >        {
>  >          buf[ixput++] = x;
>  >        }

Indeed. You are right. Thanks for pointing out that.
Another similar problem exists in console code of escape
sequence handling, so I will submit a patch for that.

As for wpbuf, please continue to fix.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
