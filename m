Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by server2.sourceware.org (Postfix) with ESMTPS id 19A1D394844E
 for <cygwin-patches@cygwin.com>; Mon,  9 Mar 2020 01:38:00 +0000 (GMT)
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp
 [125.0.207.171]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 0291bmWk020894
 for <cygwin-patches@cygwin.com>; Mon, 9 Mar 2020 10:37:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0291bmWk020894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1583717868;
 bh=kk5hmzPXrQXUGYPrQar6YyTO44BD7dRGKbnlyBCXYZY=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=C5m+cfLtieu1sdRthuG0FbywHAj9HtkV+lHSliP41b8ljVgcpdoUt8JQIvrFVWOa0
 h7RfS90naCIoCbIw3r/V4Y2J1jDKyr2FIbVEKR1oGWE83STqm5ZgzARZgpRjYE2kgx
 2/k9XrX6QPhBWT/uUClCIJkhvRZ1pN59aVYF3yw/nslHlbI8wG3zqzoHGSTLYnk+bv
 JD3FGE/Ni66ZC98cbaGiZD2z/te74UDo3ROJ1gjfms2F5Uv2lWLnQNdnOddPWDmqRI
 1hh+P+3ww60eVXjmzaot/yhIK/mbi02dfUQiChcvOBv/WHdse4hZJ6W71tR6i+cSFf
 ZJcPYSy51GqdA==
X-Nifty-SrcIP: [125.0.207.171]
Date: Mon, 9 Mar 2020 10:37:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix behaviour of "ESC 8" after reset.
Message-Id: <20200309103758.a585927730f39f5149bb94e6@nifty.ne.jp>
In-Reply-To: <20200306015528.671-1-takashi.yano@nifty.ne.jp>
References: <20200306015528.671-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_2, GIT_PATCH_3,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 09 Mar 2020 01:38:03 -0000

On Fri,  6 Mar 2020 10:55:28 +0900
Takashi Yano wrote:
> - This patch matches the behaviour of "ESC 8" (DECRC) to the real
>   xterm after full reset (RIS), soft reset (DECSTR) and "CSI 3 J".
> ---
>  winsup/cygwin/fhandler_console.cc | 7 +++++++
>  1 file changed, 7 insertions(+)

If this patch is applied first, Hans's patch cannot be
applied cleanly. So, I will submit v2 patch which can
be applied after Hans's patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
