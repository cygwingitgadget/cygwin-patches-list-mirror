Return-Path: <SRS0=k2H2=HJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 2972B4BA79B1
	for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2026 05:42:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2972B4BA79B1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2972B4BA79B1
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789623753; cv=none;
	b=b5dIRnNekNE8Gb3B4Ov/y0lrgE8VDiUv1RTjrMCUpoEsBXhu1fLqCidd9Hqt181N4k/em4y1sbOIcGdRwib8qo4PJiZCO6QrCckkd/m/oLlkO03wDggiHi3z6CH5Z7W6UKOZrWvIItumh0Upm6MA9Jq9hMFKWb0vQAXaCuAcQDY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789623753; c=relaxed/simple;
	bh=q13H8synYmILuaITGLtDuPmF2Pq3PIQv84CvmRGqUlY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=oar3gdmn499wcHLxkavGO4x+bbpmlKpPkepah/Bpa9FZxK3VGOiwGtqSSCbeLmXdmtNIWeeCKoUDWAqnBLI4mfhqnZBc5YQdd75cB0OVMDkvjkzQ8ccVtKMOuWayRS/9NEV2nF7nNKxGbNgd0+oWw8yKKyXZdEsB79fY5cyibhs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mkM0+cfQ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2972B4BA79B1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mkM0+cfQ
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260917054231268.SLPA.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2026 14:42:31 +0900
Date: Thu, 17 Sep 2026 14:42:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v16] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260917144229.d4715409bb6343e685c27511@nifty.ne.jp>
In-Reply-To: <20260917142834.122418c7121e4d13ea4c5719@nifty.ne.jp>
References: <20260915075713.726-1-takashi.yano@nifty.ne.jp>
	<b5cc7615-8db1-6f65-cd2b-88095d491667@gmx.de>
	<20260917142834.122418c7121e4d13ea4c5719@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789623751;
 bh=axg/huUvN0OcnG4+WdDJYFOwnHiayYfRBk6iySWZztc=;
 h=Date:From:To:Subject:In-Reply-To;
 b=mkM0+cfQpqqB2QzBPizp2kpOjghII7BH/AjE96ZYVfDNed+9ADg9qbsyFlKis6pfE0reoyWU
 W3+K/3xp4Dt0ydpNx5Sj2QsUeVZ0fu+i9lMVcy56+yEsJkF6htsohSc4TmDsiFx6Ros7ttsJdw
 xeBV0P/779LtW+w5Rr6RF79Rdfj51jcBrhmT5A44U0sIvCArBw8pa+8uFzknAhSgnUrYZ7WCcF
 lna6NxS+TkTLnClotaCAgdYKcl+2Rbo/yNcAQa44F6fAScHhm95MQbT5xjRLTX7CNtxvLibrfP
 UmXVbtJN4B0s3EjfJDUEfiIeljzGq0A2R3r1K9CzIe1THIGA==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 17 Sep 2026 14:28:34 +0900
Takashi Yano wrote:
> I also would like to include this part into NOT this patch, but into:
> [PATCH v2] Cygwin: console: Abort setting disable_master_thread when no con.owner
         ^^ v3

> bacause the patch above attempt to fix the closely related problem.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
