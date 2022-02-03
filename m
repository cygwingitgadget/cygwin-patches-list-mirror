Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 5553C3858C2C
 for <cygwin-patches@cygwin.com>; Thu,  3 Feb 2022 11:36:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5553C3858C2C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5G1T-1mGi2S1rfh-011DcV for <cygwin-patches@cygwin.com>; Thu, 03 Feb 2022
 12:36:45 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E1AB7A808FF; Thu,  3 Feb 2022 12:36:44 +0100 (CET)
Date: Thu, 3 Feb 2022 12:36:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: path: Fix UNC path handling for SMB3 mounted to
 a drive.
Message-ID: <Yfu+TPEQgeC7OJdR@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220203084026.1934-1-takashi.yano@nifty.ne.jp>
 <YfuZK5lTopYPSwwZ@calimero.vinschen.de>
 <20220203182832.3f0613375ce8eadd2cd27b05@nifty.ne.jp>
 <20220203195949.5842fb4ab2ab901fe4a6f789@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220203195949.5842fb4ab2ab901fe4a6f789@nifty.ne.jp>
X-Provags-ID: V03:K1:HSSyr7zV332h3fbGL+GXsBCRjQI/PnrwhTIzjYsFCZKGY+gad95
 icXHgDyKhMK7dCua6aFyIO7BqGi082ZaA5Lvau3Cogf0jDOLvz39VWXK3V/wR6jYbYGXLbM
 gBl9QeDN6/WVfZwj4XYoAuLle5XqvQzhJRj0Sl0dv414edHcq20sZUK1Wq0pjX9xEXVdffr
 3LCJBwnyAEmxiUrpWFXyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zNYBIbW4vEI=:EIqPlEpqZNLO9Up5KniL/J
 bsBWRv4XSrmFGJcRUGlCS1brKNQyHr9ctHx6o2WaDsI8BnyRR4gBAoP8KArvLohV6AcxE/Pbm
 W3cKUpBm7vr9ChnUVY/cIjhclzQqS93vktpXF5sMjUJb9egl7Rt56vzI+OwJCXzfhFSWP6Zja
 1D6ZWG9juKTdayK6ItHPcfMKlwcT23iEg1PtNN4Av2m+8HNoZhjIGb6d/GHSVsOgLse0Jgkmz
 1VGis3e2dlFWSjO/rttk+FGHhFNU9IKuvZhPUE2Qfy1WBYoPNkJawjn0YmDJZrI+wnXMxat1M
 Mu6u/f7maMeUZ+qAdmgdk+09hd0ifrp4i192L09p3kLj+Vt/q+ZoTehg6nm/WEPE3boPxnmCC
 NsRkU+Ziz7TB6uJEBxPOlPkBAbVft6SbCZoVuyGOnMgmL9RAARhkR3p9bHaiecDgq75P+KWrW
 tIoyFzTwizsP8eXoDQ6bM05C9vHmCxgdlv1p12mcmEB4CPfPbfLaVsLwTqCgDZq+3NtxCyGCb
 mvpyS0uThe5vUlMCyEl3qxM4+YtP/5o3emUmVe7ErsTzdeUXDLfIX+EczlPGZyGZSbtgB3ehm
 6BbDO4e2QvdzHcGZAoe/WEJCqxgdHtCavWx0iAuUBaAKvnQJwDZSWtokN6BvK3FsknXAMW3kf
 1/YlmM1/Id5iR5zAMm45O34LDySUtcEZJpZIX6mT+JnzaJXszBzBJkW5fGt5qbvpXvTlvT/zF
 TtfDaent3dLfYYZF
X-Spam-Status: No, score=-97.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H5,
 RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
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
X-List-Received-Date: Thu, 03 Feb 2022 11:36:52 -0000

On Feb  3 19:59, Takashi Yano wrote:
> On Thu, 3 Feb 2022 18:28:32 +0900
> Takashi Yano wrote:
> > On Thu, 3 Feb 2022 09:58:19 +0100
> > Corinna Vinschen wrote:
> > > On Feb  3 17:40, Takashi Yano wrote:
> > > > - If an UNC path is mounted to a drive using SMB3.11, accessing to
> > > >   the drive fails with error "Too many levels of symbolic links."
> > > >   This patch fixes the issue.
> > > I'm curious.  I'm using Samba as well and never saw this problem.
> > > Can you describe how to reproduce?
> > 
> > I used samba under debian stretch last December, and
> > confirmed current code worked without the problem.
> > 
> > Recently, I have upgraded the server OS from stretch
> > to bullseye, and noticed this problem.
> > 
> > Perhaps, samba version and its protocol version may be
> > related.
> > 
> > My samba version is: Version 4.13.13-Debian
> 
> I have just reconfirmed that this problem does not occur
> if samba under debian stretch is used even with SMB3.11.
> 
> Samba version of stretch is: Version 4.5.16-Debian.

Indeed, I can reproduce it.  I'm using Fedora 35 with Samba 4.15.3,
so there's probably a behavioural change.  The reason I didn't
notice it is that I never use drive letters but always UNC paths.

Thanks!


Corinna
