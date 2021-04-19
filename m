Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id D5ECE3951C9A
 for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021 20:51:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D5ECE3951C9A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from Express5800-S70 (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 13JKp8b6008744
 for <cygwin-patches@cygwin.com>; Tue, 20 Apr 2021 05:51:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 13JKp8b6008744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1618865469;
 bh=IMsF+P+ASCG6k0zYNW4LGCpFjWWRL13XQ+TnCxBqfEI=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=ogpMVhSLP639tmrjpz0gjQnzOscWEqQdtOQiB04zNZGCnI6B82s7v4LmFmLnE9EPN
 KDtpY/P9WKBZb4JaC0O/6CbrDrSYTFrAD67YTs7/6uDd+QxrROUW2UbtqNr19sz/ua
 1B9UvWZMLhz/aVHQvKnCrDJPB8X8HfsCPge1bc+vCzzZzdoqRcHabp5UdwDBxflH6p
 tLl+Hbvla+Ex6AAKWG+3+2IDH3YavbM0FJpNFPco8C4eyuihExKbTOTgVcy4wN+OKx
 DUvVvJlAOPo0eHzn4cdH/eIZC3OBLpmT4Q2AVGMr4JcDt39zfDiO9uqmSr9yFjTlA0
 +aYmRqhuhyLfw==
X-Nifty-SrcIP: [124.155.50.190]
Date: Tue, 20 Apr 2021 05:51:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make rlwrap work with cmd.exe.
Message-Id: <20210420055113.b03868929391b157c69dc807@nifty.ne.jp>
In-Reply-To: <YH2RXQG9RT0V5WNG@calimero.vinschen.de>
References: <20210419115153.1983-1-takashi.yano@nifty.ne.jp>
 <YH2RXQG9RT0V5WNG@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 19 Apr 2021 20:51:40 -0000

On Mon, 19 Apr 2021 16:19:09 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Apr 19 20:51, Takashi Yano wrote:
> > - After the commit 919dea66, "rlwrap cmd" fails to start pseudo
> >   console. This patch fixes the issue.
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > index ba9f4117f..d44728795 100644
> > --- a/winsup/cygwin/fhandler_tty.cc
> > +++ b/winsup/cygwin/fhandler_tty.cc
> > @@ -1170,6 +1170,8 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
> >      }
> >    if (isHybrid)
> >      return;
> > +  if (get_ttyp ()->pcon_start)
> > +    return;
> >    WaitForSingleObject (pcon_mutex, INFINITE);
> >    if (!pcon_pid_self (get_ttyp ()->pcon_pid)
> >        && pcon_pid_alive (get_ttyp ()->pcon_pid))
> > -- 
> > 2.31.1
> 
> this patch doesn't apply.  Does it depend on the race issue fixes?

Yes. This depends on the race issue patches.
Please apply this patch after the race issue patches.

Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
