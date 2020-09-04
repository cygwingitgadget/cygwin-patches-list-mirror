Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 33BC73987486
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 15:03:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 33BC73987486
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 084F2saC031815;
 Sat, 5 Sep 2020 00:02:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 084F2saC031815
X-Nifty-SrcIP: [124.155.38.192]
Date: Sat, 5 Sep 2020 00:03:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200905000302.9c777e3d2df4f49f3a641e42@nifty.ne.jp>
In-Reply-To: <nycvar.QRO.7.76.6.2009040822000.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009040822000.56@tvgsbejvaqbjf.bet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Fri, 04 Sep 2020 15:03:21 -0000

Hi Johannes,

On Fri, 4 Sep 2020 08:23:42 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 4 Sep 2020, Takashi Yano via Cygwin-patches wrote:
> 
> > Hi Johannes and Corinna,
> >
> > On Tue, 1 Sep 2020 18:19:16 +0200 (CEST)
> > Johannes Schindelin wrote:
> >
> > > When `LANG=en_US.UTF-8`, the detected `LCID` is 0x0409, which is
> > > correct, but after that (at least if Pseudo Console support is enabled),
> > > we try to find the default code page for that `LCID`, which is ASCII
> > > (437). Subsequently, we set the Console output code page to that value,
> > > completely ignoring that we wanted to use UTF-8.
> > >
> > > Let's not ignore the specifically asked-for UTF-8 character set.
> > >
> > > While at it, let's also set the Console output code page even if Pseudo
> > > Console support is disabled; contrary to the behavior of v3.0.7, the
> > > Console output code page is not ignored in that case.
> > >
> > > The most common symptom would be that console applications which do not
> > > specifically call `SetConsoleOutputCP()` but output UTF-8-encoded text
> > > seem to be broken with v3.1.x when they worked plenty fine with v3.0.x.
> > >
> > > This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> > > https://github.com/msys2/MSYS2-packages/issues/2012,
> > > https://github.com/rust-lang/cargo/issues/8369,
> > > https://github.com/git-for-windows/git/issues/2734,
> > > https://github.com/git-for-windows/git/issues/2793,
> > > https://github.com/git-for-windows/git/issues/2792, and possibly quite a
> > > few others.
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > > index 06789a500..414c26992 100644
> > > --- a/winsup/cygwin/fhandler_tty.cc
> > > +++ b/winsup/cygwin/fhandler_tty.cc
> > > @@ -2859,6 +2859,15 @@ fhandler_pty_slave::setup_locale (void)
> > >    char charset[ENCODING_LEN + 1] = "ASCII";
> > >    LCID lcid = get_langinfo (locale, charset);
> > >
> > > +  /* Special-case the UTF-8 character set */
> > > +  if (strcasecmp (charset, "UTF-8") == 0)
> > > +    {
> > > +      get_ttyp ()->term_code_page = CP_UTF8;
> > > +      SetConsoleCP (CP_UTF8);
> > > +      SetConsoleOutputCP (CP_UTF8);
> > > +      return;
> > > +    }
> > > +
> > >    /* Set console code page from locale */
> > >    if (get_pseudo_console ())
> > >      {
> > > --
> > > 2.27.0
> >
> > I would like to propose a counter patch attached.
> > What do you think of this patch?
> >
> > This patch does not treat UTF-8 as special.
> 
> Sure, but it only fixes the issue in `disable_pcon` mode in the current
> tip commit. That's because a new Pseudo Console is created for every
> spawned non-Cygwin console application, and that new Pseudo Console does
> _not_ have the code page set by your patch.

You are right. However, if pseudo console is enabled, the app
which works correclty in command prompt should work as well in
pseudo console. Therefore, there is nothing to be fixed.

> I verified that this patch works around the issue in `disable_pcon` mode,
> which is good.

Thanks for testing.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
