Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 1689A3851C3B
 for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021 13:23:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1689A3851C3B
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6URd-1lE6gV29rl-006xSc for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021
 14:23:38 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 119DDA80D37; Mon, 15 Feb 2021 14:23:38 +0100 (CET)
Date: Mon, 15 Feb 2021 14:23:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Abort read() on signal if SA_RESTART
 is not set.
Message-ID: <20210215132338.GP4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210214094250.1245-1-takashi.yano@nifty.ne.jp>
 <20210215120441.GL4251@calimero.vinschen.de>
 <20210215220807.aa6509ee83ee971597511770@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215220807.aa6509ee83ee971597511770@nifty.ne.jp>
X-Provags-ID: V03:K1:o400ndjq+91IWlPJFDhWV0xpfzqhepr/20wpSjtKRiaKWpwAfEO
 TZp9/aCl/wJJKrEXkyCXif/GUS/Yukr11MTbFfm0GX6V8kR/cXaSktytrJFk7nNTohdTpZe
 RQ/HmmX1oceZQN0LZVDMQAFNQ7yKQB4FDy3iHtMNCnDKkFHvvU+aQtvtRwN4y1VAbHZoIQ1
 8SZTfflmP1vBDUJ8k0mBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X4tzdKn+ptQ=:FgqF2yl/Dsk1yQDczr9rRK
 JYagS+E/Nr7HKChNbVQrQxh1Lg/QScHwaCBOi9rPid+7vwHFsriTmQuCIzMPJcwqy4cqMtLHn
 zMxTPiQDhEQ2GBCzGWvYXkOX2FA+9g1i8ey/gCuA4cVX5qyiJt6sdQKayjBJXWp7/KAiX3XbN
 nhVRNlO0mQuFx98ITHcgNASW/Iu0UwOkUxZMeo+OTQZo5EVwww+1l2bUmC2iMsPDnsBt7fgrl
 BLv1SjrQY4oMm/cWI6/csBoB1TYEd7v1tmkvmkqDlkqwV4MtQ6lBhl2ST0Xz90x8R452dQRk3
 /G9PYtFzziOIInIkI1fp8vY6OpAeNztGEl2TGVBNGq0dtMhB71iQMswOM1gSjcbm+TDSrzHIH
 IwjFCb/uuAjVfO9CCMUtOFGlDJVf5rJM9AyyiiW4pgaBQYUW6F9lb+u8kVYV1FnSo2j4baD5Q
 YMeXlcYfxQ==
X-Spam-Status: No, score=-107.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 15 Feb 2021 13:23:42 -0000

On Feb 15 22:08, Takashi Yano via Cygwin-patches wrote:
> On Mon, 15 Feb 2021 13:04:41 +0100
> Corinna Vinschen wrote:
> > On Feb 14 18:42, Takashi Yano via Cygwin-patches wrote:
> > > - Currently, console read() keeps reading after SIGWINCH is sent
> > >   even if SA_RESTART flag is not set. With this patch, read()
> > >   returns EINTR on SIGWINCH if SA_RESTART flag is not set.
> > >   The same problem for SIGQUIT and SIGTSTP has also been fixed.
> > > ---
> > >  winsup/cygwin/fhandler_console.cc | 7 +++----
> > >  winsup/cygwin/fhandler_termios.cc | 1 +
> > >  winsup/cygwin/tty.cc              | 1 +
> > >  winsup/cygwin/tty.h               | 1 +
> > >  4 files changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> > > index 3c0783575..78af6cf2b 100644
> > > --- a/winsup/cygwin/fhandler_console.cc
> > > +++ b/winsup/cygwin/fhandler_console.cc
> > > @@ -586,12 +586,11 @@ wait_retry:
> > >  	case input_ok: /* input ready */
> > >  	  break;
> > >  	case input_signalled: /* signalled */
> > > -	  release_input_mutex ();
> > > -	  /* The signal will be handled by cygwait() above. */
> > > -	  continue;
> > >  	case input_winch:
> > >  	  release_input_mutex ();
> > > -	  continue;
> > > +	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
> > 
> > Shouldn't this check for last_sig != 0 first?
> 
> This code is reached only after SIGINT, SIGTSTP, SIGQUIT (case
> input_signalled) or SIGWINCH (case input_winch) has been sent.
> Therefore, last_sig should be one of them here.

Thanks, pushed.


Corinna
