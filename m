Return-Path: <SRS0=J7QP=5H=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
	by sourceware.org (Postfix) with ESMTPS id E8D9C3858C20
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 13:37:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E8D9C3858C20
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-01.nifty.com with ESMTP id 30ADb6ME010591
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 22:37:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 30ADb6ME010591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1673357826;
	bh=63I4+23FFbPraDlg+iQjoz6nKdpJ4687P1CsNGy6iQo=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=nafj5rvNhrdSHjvgxrB13Hhyep2SZxWRlBiZvMvCBdEAq5pDk466V/k3CLfRJqk3e
	 SAJICWog9Y4LP12DPbydgqW1lbnQL8cIl5GnbPq9z+KHZc6nslOoWJcoeRst45CetR
	 wPzfbpSnBXaRnOpZmcZLckpLrDwEK+XUp+a1EnkDwfAxK/xkPbPdPEIszBnA+7ESm5
	 S33IB2l1rwJtGOmQSgmKbcsi7q41PhSK/eCIc912AK7ROw53sIqvkOvBJwOE858j1+
	 FOWZ176JeN5EJs4hNSVD6JF8Iu41yGFKvs03rdUmM3lDb/dBR1uMsbyWrIUABghvWl
	 7lqL+2JaoFt8A==
X-Nifty-SrcIP: [220.150.135.41]
Date: Tue, 10 Jan 2023 22:37:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pinfo: Additional fix for CTTY behavior.
Message-Id: <20230110223706.1d38233b6be7d03f512275dc@nifty.ne.jp>
In-Reply-To: <Y7vdjTREYWiLAJ9N@calimero.vinschen.de>
References: <20221228083516.1226-1-takashi.yano@nifty.ne.jp>
	<Y7vdjTREYWiLAJ9N@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 9 Jan 2023 10:25:33 +0100
Corinna Vinschen wrote:
> Also, given this was a "kludge" from 10 years ago, is it really still
> needed?

Ah, do you mean the "kludge":
winsup/cygwin/syscalls.cc: 1455:
      /* This is a temporary kludge until all utilities can catch up
	 with a change in behavior that implements linux functionality:
	 opening a tty should not automatically cause it to become the
	 controlling tty for the process.  */
      if (!(flags & O_NOCTTY) && fd > 2 && myself->ctty != -2)
	{
	  flags |= O_NOCTTY;
	  /* flag that, if opened, this fhandler could later be capable
	     of being a controlling terminal if /dev/tty is opened. */
	  opt |= PC_CTTY;
	}

and

winsup/cygwin/dtable.cc: 767:
  /* This is a temporary kludge until all utilities can catch up with
     a change in behavior that implements linux functionality:  opening
     a tty should not automatically cause it to become the controlling
     tty for the process.  */
  if (newfd > 2)
    flags |= O_NOCTTY;
?

These codes might be able to be deleted. I'll check if these
are not needed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
