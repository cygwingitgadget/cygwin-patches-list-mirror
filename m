Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 203563858D28
 for <cygwin-patches@cygwin.com>; Sat,  5 Feb 2022 09:55:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 203563858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 2159tIpF022389
 for <cygwin-patches@cygwin.com>; Sat, 5 Feb 2022 18:55:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2159tIpF022389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644054918;
 bh=Wd9BG1T6IXJQzFf5KUtDpZNxQvnbQ68dpt1oLVYFky4=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=Akp4ORv8mo8dJYNhpqlJ0a8Fm/S5Cyb15I2Ku9WitH9cSPkblGCmbEiZbni+sEH1u
 O+jp5/2oyQvOe8r72ya98hgMA7Ni6U5zZbfDZ6PUYq0gKutr1syLUqTu/cd+7a18C2
 +/jXxcyGn7LxBH2avFI98yF3RHDeKY2GAI1zYp7kSrKL7TMe+PXJ2oBp7GIygnsUA2
 nWmpvyApIq2rhEdJogE8OcitGE9BxYQZH1Dy1YKOTfF4AJE0Ed7sxVfMDvpZEo4VsU
 djinE9TCl6JwviTuP3Yk2AhM3EteQHZEe3DII1Ij3Gw0qOyfTce3FmwN3ZEkMI9kh+
 qI48MnDzRlodA==
X-Nifty-SrcIP: [119.150.36.16]
Date: Sat, 5 Feb 2022 18:55:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: wincap: Add capabilities for Windows 10 2004
 and newer.
Message-Id: <20220205185519.ee6239a14697d360a902e666@nifty.ne.jp>
In-Reply-To: <Yf5H+DgpvRIGa9ys@calimero.vinschen.de>
References: <20220205080719.928-1-takashi.yano@nifty.ne.jp>
 <Yf5H+DgpvRIGa9ys@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 05 Feb 2022 09:55:37 -0000

On Sat, 5 Feb 2022 10:48:40 +0100
Corinna Vinschen wrote:
> On Feb  5 17:07, Takashi Yano wrote:
> > - The capability changes since Windows 10 2004 have been reflected
> >   in wincap.cc. (has_con_broken_il_dl has been changed to false.)
> > ---
> >  winsup/cygwin/wincap.cc | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> Sure thing, please push.

Is this should be for both master and cygwin-3_3-branch?
Or only for master?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
