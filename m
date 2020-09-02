Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id A4BB2386EC47
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 09:41:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A4BB2386EC47
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 0829ewAm030348
 for <cygwin-patches@cygwin.com>; Wed, 2 Sep 2020 18:40:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0829ewAm030348
X-Nifty-SrcIP: [124.155.38.192]
Date: Wed, 2 Sep 2020 18:41:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200902184104.a4a754ab3827352eab126e5c@nifty.ne.jp>
In-Reply-To: <20200902083014.GH4127@calimero.vinschen.de>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 02 Sep 2020 09:41:33 -0000

On Wed, 2 Sep 2020 10:30:14 +0200
Corinna Vinschen wrote:
> On Sep  1 18:19, Johannes Schindelin wrote:
> > When `LANG=en_US.UTF-8`, the detected `LCID` is 0x0409, which is
> > correct, but after that (at least if Pseudo Console support is enabled),
> > we try to find the default code page for that `LCID`, which is ASCII
> > (437). Subsequently, we set the Console output code page to that value,
> > completely ignoring that we wanted to use UTF-8.
> > 
> > Let's not ignore the specifically asked-for UTF-8 character set.
> > 
> > While at it, let's also set the Console output code page even if Pseudo
> > Console support is disabled; contrary to the behavior of v3.0.7, the
> > Console output code page is not ignored in that case.
> > 
> > The most common symptom would be that console applications which do not
> > specifically call `SetConsoleOutputCP()` but output UTF-8-encoded text
> > seem to be broken with v3.1.x when they worked plenty fine with v3.0.x.
> > 
> > This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> > https://github.com/msys2/MSYS2-packages/issues/2012,
> > https://github.com/rust-lang/cargo/issues/8369,
> > https://github.com/git-for-windows/git/issues/2734,
> > https://github.com/git-for-windows/git/issues/2793,
> > https://github.com/git-for-windows/git/issues/2792, and possibly quite a
> > few others.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> Ok guys, I'm not opposed to this change in terms of its result,

I am sorry, but I cannot agree with Johannes's patch.

For example, code page in Japan is CP932 by default.
In this case, cmd.exe, netsh.exe and so on are generate
messages in Japanese.

If the code page is set to CP_UTF8, messages from such
commands changes to english. I guess similar things happen
for other locales.

I do not prefer this result.

Furthermore, I looked into the issue:
https://github.com/git-for-windows/git/issues/2734
and I found that git-for-windows always use utf-8
encoding even if the locale is ja_JP.CP932.
It does not change coding based on locale or code
page.

Even with Johannes's patch, if mintty is started with
locale ja_JP.CP932, the file name will be garbled
bacause SetConsoleOutputCP(CP_UTF8) will not be called.

IMHO, it is the problem of git-for-windows rather
than cygwin and msys2.

To make current version of git-for-windows work, it is
necessary to set code page to CP_UTF8 regardless locale.
This does not make sense at all.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
