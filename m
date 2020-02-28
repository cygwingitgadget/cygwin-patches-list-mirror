Return-Path: <cygwin-patches-return-10144-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62812 invoked by alias); 28 Feb 2020 17:06:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62755 invoked by uid 89); 28 Feb 2020 17:06:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 17:06:25 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id 01SH64hi007170;	Sat, 29 Feb 2020 02:06:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01SH64hi007170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582909564;	bh=5UWGCqNDiaKxbvFfUnCmD3pHwpT20WUNuAgwCtyZTRs=;	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;	b=P16qIA5fqcrEyhomyejLyxkBlqh5yFkmAsdNepvzb48paDzPFOqsCgZFy+BzpEvVj	 KGLEeij1RMJTOHfXBmw/mMMbqPX28/6z7iydoGfgbbWMZ21ViRZnapXJiKUVa7j7Hd	 SfSyKGJbGmPECqwoDgxdGIAvtVq+md1QIGpG/Euk/i8Dtxn/8EF12nTRo6an40kEnc	 5MJc6msoNxS9oHOG1liYCaChU25YQu3aMgsal+YBFyjqIotFky+F7spthSN50MFLHm	 sprIMyoGQBWt32F1A1+kuxCL7ef8Hsaxizl7XJbe+LqBHSB/lYInjbPzcP8wakev0K	 c5+xiaMZPLF0A==
Date: Fri, 28 Feb 2020 17:06:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Hans-Bernhard =?UTF-8?B?QnLDtmtlcg==?= <HBBroeker@t-online.de>
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-Id: <20200229020604.6e1e7f204349b4b84e813dae@nifty.ne.jp>
In-Reply-To: <20200228144905.GK4045@calimero.vinschen.de>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp>	<20200226153302.584-2-takashi.yano@nifty.ne.jp>	<05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk>	<20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp>	<20200228133122.GG4045@calimero.vinschen.de>	<20200228144459.GI4045@calimero.vinschen.de>	<20200228144905.GK4045@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00250.txt

On Fri, 28 Feb 2020 15:49:05 +0100
Corinna Vinschen wrote:
> Also, on second thought, given wpbuf is global inside this file, doesn't
> this require guarding against multi-threaded access?

wpbuf_put() is used in write(), and almost whole of write()
code is guarded by output_mutex. So, I think it is already
thread-safe.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
