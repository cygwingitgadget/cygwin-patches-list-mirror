Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 96A89386F447
 for <cygwin-patches@cygwin.com>; Mon, 18 May 2020 00:50:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 96A89386F447
Received: from Express5800-S70 (v040007.dynamic.ppp.asahi-net.or.jp
 [124.155.40.7]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 04I0oPH5027040;
 Mon, 18 May 2020 09:50:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 04I0oPH5027040
X-Nifty-SrcIP: [124.155.40.7]
Date: Mon, 18 May 2020 09:50:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: termios: Set ECHOE, ECHOK, ECHOCTL and ECHOKE
 by default.
Message-Id: <20200518095027.5965dbaadf685666e126fa13@nifty.ne.jp>
In-Reply-To: <CABPLASQozh_iBkLA-hGpQ88dQ6BHB0m=U_VBSotuM4zFXS3Piw@mail.gmail.com>
References: <20200517023444.286-1-takashi.yano@nifty.ne.jp>
 <CABPLASQozh_iBkLA-hGpQ88dQ6BHB0m=U_VBSotuM4zFXS3Piw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 18 May 2020 00:50:59 -0000

On Mon, 18 May 2020 01:21:07 +0200
Kacper Michajlow via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> On Sun, 17 May 2020 at 04:53, Takashi Yano via Cygwin-patches <
> cygwin-patches@cygwin.com> wrote:
> 
> > - Backspace key does not work correctly in linux session opend by
> >   ssh from cygwin console if the shell is bash. This is due to lack
> >   of these flags.
> >
> >   Addresses: https://cygwin.com/pipermail/cygwin/2020-May/244837.html.
> > ---
> >  winsup/cygwin/fhandler_termios.cc | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/winsup/cygwin/fhandler_termios.cc
> > b/winsup/cygwin/fhandler_termios.cc
> > index b6759b0a7..b03478b87 100644
> > --- a/winsup/cygwin/fhandler_termios.cc
> > +++ b/winsup/cygwin/fhandler_termios.cc
> > @@ -33,7 +33,8 @@ fhandler_termios::tcinit (bool is_pty_master)
> >        tc ()->ti.c_iflag = BRKINT | ICRNL | IXON | IUTF8;
> >        tc ()->ti.c_oflag = OPOST | ONLCR;
> >        tc ()->ti.c_cflag = B38400 | CS8 | CREAD;
> > -      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN;
> > +      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN
> > +       | ECHOE | ECHOK | ECHOCTL | ECHOKE;
> >
> >        tc ()->ti.c_cc[VDISCARD] = CFLUSH;
> >        tc ()->ti.c_cc[VEOL]     = CEOL;
> > --
> > 2.21.0
> >
> >
> Maybe also set  IXANY | IMAXBEL? For reasonable set of default values.

I don't think so, because they are not set also in xterm in linux.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
