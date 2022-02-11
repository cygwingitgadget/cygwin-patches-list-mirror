Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 1F0EE3858D1E
 for <cygwin-patches@cygwin.com>; Fri, 11 Feb 2022 00:12:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1F0EE3858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 21B0BtDt032649
 for <cygwin-patches@cygwin.com>; Fri, 11 Feb 2022 09:11:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 21B0BtDt032649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644538315;
 bh=hZwA+C5QvOTV1CfoyzVkDscW/V+cmXJiQgI07EGgcY4=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=1SE2y/ZW7b5SK3tEjtKnKhXh6h8VVQwj9lJ36MaU+8Evku7aj1c9NeDyFKikbwWIJ
 RP061M2zZ5bF3fkr2ZLUEHbiUQP8wAZSbzONyve2tfGE3gh82V6Wh3jXwXsegyB2di
 nM2OjnQ6zCP5j87mkoMFUilcqsBhTkOjhnMcIwaGK7+HdVwBGHF1Xg3Qsekn0BCYOB
 5b8lYQ9Pghq8k4uczqk/MwgquF8Y2xZ8S7jzbA3+ZXVDTz3uGtjtP9Xj/judE/KzmB
 vNDFkanrNfg9dDjFwNYRjUn1rpEHkiZEADE9xTsY9QeEHayCHgdv6l0Q8u8n9Entri
 pA8aaylja0mDQ==
X-Nifty-SrcIP: [119.150.36.16]
Date: Fri, 11 Feb 2022 09:12:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: console: Maintain EXTENDED_FLAGS state
Message-Id: <20220211091204.409213793d1c2e4b961299eb@nifty.ne.jp>
In-Reply-To: <CAAvot8-BObo_X1d1E3x8o+qpZYFQO0qicYpz9G0dB3bkEtgvsA@mail.gmail.com>
References: <20220210170756.a2efb012fdc916e3873b1b55@nifty.ne.jp>
 <20220210153808.2655-1-mhentges@mozilla.com>
 <CAAvot8-BObo_X1d1E3x8o+qpZYFQO0qicYpz9G0dB3bkEtgvsA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 11 Feb 2022 00:12:18 -0000

On Thu, 10 Feb 2022 10:40:36 -0500
Mitchell Hentges wrote:
> Thanks, I appreciate it.
> The initial send was via GMail, but I've wired up git-send-email to msmtp,
> and I'm hoping that it's happy now - at least, it looks like tabs are being
> preserved now, which is a good sign.

Pushed along with modifying the commit message.

Thansk!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
