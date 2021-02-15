Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 9BB823945053
 for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021 13:08:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9BB823945053
Received: from Express5800-S70 (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 11FD84uv010917
 for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021 22:08:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 11FD84uv010917
X-Nifty-SrcIP: [118.243.85.178]
Date: Mon, 15 Feb 2021 22:08:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Abort read() on signal if
 SA_RESTART is not set.
Message-Id: <20210215220807.aa6509ee83ee971597511770@nifty.ne.jp>
In-Reply-To: <20210215120441.GL4251@calimero.vinschen.de>
References: <20210214094250.1245-1-takashi.yano@nifty.ne.jp>
 <20210215120441.GL4251@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 15 Feb 2021 13:08:24 -0000

On Mon, 15 Feb 2021 13:04:41 +0100
Corinna Vinschen wrote:
> On Feb 14 18:42, Takashi Yano via Cygwin-patches wrote:
> > - Currently, console read() keeps reading after SIGWINCH is sent
> >   even if SA_RESTART flag is not set. With this patch, read()
> >   returns EINTR on SIGWINCH if SA_RESTART flag is not set.
> >   The same problem for SIGQUIT and SIGTSTP has also been fixed.
> > ---
> >  winsup/cygwin/fhandler_console.cc | 7 +++----
> >  winsup/cygwin/fhandler_termios.cc | 1 +
> >  winsup/cygwin/tty.cc              | 1 +
> >  winsup/cygwin/tty.h               | 1 +
> >  4 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> > index 3c0783575..78af6cf2b 100644
> > --- a/winsup/cygwin/fhandler_console.cc
> > +++ b/winsup/cygwin/fhandler_console.cc
> > @@ -586,12 +586,11 @@ wait_retry:
> >  	case input_ok: /* input ready */
> >  	  break;
> >  	case input_signalled: /* signalled */
> > -	  release_input_mutex ();
> > -	  /* The signal will be handled by cygwait() above. */
> > -	  continue;
> >  	case input_winch:
> >  	  release_input_mutex ();
> > -	  continue;
> > +	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
> 
> Shouldn't this check for last_sig != 0 first?

This code is reached only after SIGINT, SIGTSTP, SIGQUIT (case
input_signalled) or SIGWINCH (case input_winch) has been sent.
Therefore, last_sig should be one of them here.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
