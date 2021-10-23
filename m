Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 3F3603858D28
 for <cygwin-patches@cygwin.com>; Sat, 23 Oct 2021 23:58:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3F3603858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 19NNwEMW007654
 for <cygwin-patches@cygwin.com>; Sun, 24 Oct 2021 08:58:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 19NNwEMW007654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1635033495;
 bh=Yk06SlkyjuHppK+a8nkAXM2vwiCZic6LMgEH3CGJAwU=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=UaF0o/rXehPqAuHDawe4DZErpFZ5D3OZsh2FsGIvIt9knsreWeP3GnsW0kOndmWb2
 Cac/Bbkksh26L1hpKsGFLw+QZDKRwNkSawbkz2JQ8NzWbhCCq8o1W0i9i6v+dlqfrJ
 t+05USuMVNa3pkgPIdBFlEgLHNf+blFljoe2BlOw6yznPDEQSz9tFZ/60wdR1Jaw/E
 JK6comQoJebWO3mJNF0ps6kCP/ROu6aVnaFQO72acBhQDNXSqI4ozvmQd9tQGcDNon
 d3Z+VJC74Jsk0Pcfn/DITX6vetcnzEfy4nJ/1hMMqTb2PbFJEyIb++RzGdpUIUwv71
 As7FEfHXwaE0g==
X-Nifty-SrcIP: [110.4.221.123]
Date: Sun, 24 Oct 2021 08:58:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
Message-Id: <20211024085823.909b894a0ae6c604f0216582@nifty.ne.jp>
In-Reply-To: <YXLUkU6Nc3qAXLyp@calimero.vinschen.de>
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
 <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
 <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
 <037a8027-8969-df1e-ccb5-6a736578cec5@cornell.edu>
 <6de24f8c-bd21-cd4f-18ff-ece3fef85b89@maxrnd.com>
 <ee8b46bd-f8f4-85da-be25-233c3cb60c71@cornell.edu>
 <YXLUkU6Nc3qAXLyp@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 23 Oct 2021 23:58:38 -0000

Hi Corinna,

On Fri, 22 Oct 2021 17:11:13 +0200
Corinna Vinschen wrote:
> Just to close this up prior to the 3.3.0 release...
> 
> Given we never actually strived for 32<->64 bit interoperability, it's
> hard to argue why this should be different for the clipboard stuff.
> 
> Running 32 and 64 bit Cygwin versions in parallel doesn't actually make
> much sense for most people anyway, unless they explicitely develop for
> 32 and 64 bit systems under Cygwin.  From a productivity point of view
> there's no good reason to run more than one arch.
> 
> So I agree with Ken here.  It's probably not worth the trouble.

Current code below in fhandler_clipboard.cc causes access violation
if clipboard is accessed between 32 and 64 bit cygwin.

      cygcb_t *clipbuf = (cygcb_t *) cb_data;

      if (pos < (off_t) clipbuf->len)
        {
          ret = ((len > (clipbuf->len - pos)) ? (clipbuf->len - pos) : len);
          memcpy (ptr, clipbuf->data + pos , ret);
          pos += ret;
        }

Don't you think this should be fixed?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
