Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id E24EE3858D37
 for <cygwin-patches@cygwin.com>; Thu,  3 Feb 2022 11:00:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E24EE3858D37
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (v036249.dynamic.ppp.asahi-net.or.jp
 [124.155.36.249]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 213Axleb002588
 for <cygwin-patches@cygwin.com>; Thu, 3 Feb 2022 19:59:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 213Axleb002588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1643885988;
 bh=mWuKuftS+x0BtZs5xBToTG0ibcAkCxRqb9drLEPA8XQ=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=YvAdtRwTkelcWXedUXa00vHb6s7JCoFDBxIXcA67/feqCnrfSX02m5+DP9Nb9wIUi
 B0PaGJolMEQniQ1ja659JokEtwEVGGl8bmM+56TG3bsjZQiHnNhNJeOuyE90quW2lb
 zHEKAHVZwITGAU/N2fHodm2KaERBEkIy7Mm/qfBc58PNJdi/WIHfcPjyW7DITFZVXh
 r50RCG8p5ke4VpLqps4mIAAQd5aSevERpvGf6iVVJ0CBRnM88XQlX0ZBJ3nrhhvMZI
 3YrTOewdXESj3Al/QyojarYtT0SXc4oyAkW2wwUVCWvS879i6SZD4ZAVZnwVUCg1Pj
 jAoNSRrBjlpyQ==
X-Nifty-SrcIP: [124.155.36.249]
Date: Thu, 3 Feb 2022 19:59:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: path: Fix UNC path handling for SMB3 mounted to
 a drive.
Message-Id: <20220203195949.5842fb4ab2ab901fe4a6f789@nifty.ne.jp>
In-Reply-To: <20220203182832.3f0613375ce8eadd2cd27b05@nifty.ne.jp>
References: <20220203084026.1934-1-takashi.yano@nifty.ne.jp>
 <YfuZK5lTopYPSwwZ@calimero.vinschen.de>
 <20220203182832.3f0613375ce8eadd2cd27b05@nifty.ne.jp>
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
X-List-Received-Date: Thu, 03 Feb 2022 11:00:08 -0000

On Thu, 3 Feb 2022 18:28:32 +0900
Takashi Yano wrote:
> On Thu, 3 Feb 2022 09:58:19 +0100
> Corinna Vinschen wrote:
> > On Feb  3 17:40, Takashi Yano wrote:
> > > - If an UNC path is mounted to a drive using SMB3.11, accessing to
> > >   the drive fails with error "Too many levels of symbolic links."
> > >   This patch fixes the issue.
> > I'm curious.  I'm using Samba as well and never saw this problem.
> > Can you describe how to reproduce?
> 
> I used samba under debian stretch last December, and
> confirmed current code worked without the problem.
> 
> Recently, I have upgraded the server OS from stretch
> to bullseye, and noticed this problem.
> 
> Perhaps, samba version and its protocol version may be
> related.
> 
> My samba version is: Version 4.13.13-Debian

I have just reconfirmed that this problem does not occur
if samba under debian stretch is used even with SMB3.11.

Samba version of stretch is: Version 4.5.16-Debian.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
