Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 81A053840C0D
 for <cygwin-patches@cygwin.com>; Sat, 30 May 2020 17:42:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 81A053840C0D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjBNV-1j2iP93xFV-00f8LO for <cygwin-patches@cygwin.com>; Sat, 30 May 2020
 19:42:10 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 86F3EA80FF6; Sat, 30 May 2020 19:42:10 +0200 (CEST)
Date: Sat, 30 May 2020 19:42:10 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Make cursor keys work in vim under
 ConEmu.
Message-ID: <20200530174210.GV6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200530092503.1142-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200530092503.1142-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:S+BwzxJpUqUxzFZXGnpu9FNuwrrAUUjGk7YhFbPM/ousrCPCh9W
 ziJlsJ6eleS3mSe+CYp6NHReXuk0pns9D1dG5hCIX7DUpucAgA2D68BDsUbFSslY2QJgLN5
 CwtY8iDBOTA2tpuY2ipSgMuoehFdYbQaEM3g58rzoSuy62NkSfniZzdOJKnsoOsTYwj7j1a
 YlEo9IpoJR0hZsMvwwjEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xMGRYFGScfg=:OhBMtj4mjeCFBMHPTSG861
 jQv8vj+GShmsMDLAgj+uX/i7uwdFLuHDzLv0NCSFURiF3wldphMO3ihnAT5mykhc0Ohu/fYjR
 ORwCrA5ph0WX+7hQaXKVuFfaUw2TO6Zog4Jw5FktakQis5ZNRY5sBGF5CHCcOJrQtSptq9PqJ
 4WcS9hipQeUn4XjReYt8Q2ZbIIzEV938w6IaNmI2i0fWOOeE4Wcm8n9qpitT1fqc9tclbVVaf
 Pa0UX5meyUWV2XVUTdfprgFWiCsY+uTRvUIDN3Iu+o1TuYHQMvUevNQtjEeFA1MQXYDl8WrHP
 SuNBGxPMOnOYVL7WJagArw1varEEZnt+MWUCcQ1Be47sfCRkZBTpCzH/tbkQR+CYaJc7aovRk
 Wfw7/rWBl7/Q4bcdC3Ox9opHOj+zIiCVzJutJjQH4Z89xbbqN4ZtKPt9sT9bvD9y7FPHca+Bl
 gvhaV+loSrTlC4LhqnETW7ncoHIcNjFSMq6OsZiN5/2y0RA3ZpPLRZRLENAUvA8uhHtIJmCrU
 /VfaJgTT1Bg5oa21qt+uE630qUDUwOPaZzVfkA6RSVScPadXmKdMGvqEAwVKtdNbTqJO/H1Yz
 dmhteiBqxfSDJj8DBThnQwmkLPU/bEQ1AOFCODzED26CCz7IoxNs4OW2LLxecXha5p1FdkusJ
 JsPJIaNPeBbUSO77SvtWfypUhNapg/Zcc23/ILHi+ZN1fxZ+g72FerfNLA5f+sxCT5ZmKotvb
 HFZDs4ctVx6KxRbnpYjFOJK1+ho/gIR1woQ79aKMztQiMs78ohzeO8SRmCK6/U257g+knqIFQ
 TIh01OvED1cv6eb44fkAWb5U0PxzK65NAk2EjaeyjM+uKNkNZIK+O1XgQ79uzowhvECt5q7
X-Spam-Status: No, score=-99.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 30 May 2020 17:42:14 -0000

On May 30 18:25, Takashi Yano via Cygwin-patches wrote:
> - After commit 774b8996d1f3e535e8267be4eb8e751d756c2cec, cursor
>   keys do not work in vim under ConEmu without cygwin-connector.
>   This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler.h          |  1 +
>  winsup/cygwin/fhandler_console.cc | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
