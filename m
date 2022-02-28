Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 2651F3858C20
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 09:44:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2651F3858C20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N0nzR-1oA6ti3hwr-00wk4H for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022
 10:44:51 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8AB85A80CE4; Mon, 28 Feb 2022 10:44:51 +0100 (CET)
Date: Mon, 28 Feb 2022 10:44:51 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pinfo: Fix exit code for non-cygwin apps
 which reads console.
Message-ID: <YhyZk1JonIErhPal@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220227004607.2051-1-takashi.yano@nifty.ne.jp>
 <YhyUHPKAQkHi3uQT@calimero.vinschen.de>
 <20220228183202.9236c4f2bbeacb65a816be64@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228183202.9236c4f2bbeacb65a816be64@nifty.ne.jp>
X-Provags-ID: V03:K1:l6tcyP4idHbyePzAzYmLpKzqCldEmmrXfERkXsPbs8EYfwOkUxE
 KYOChPSQncBPrl+FtF9aSGkt5mchmmK43vuefK/R71Oxn0rsSI4Q+LvFY6mNbGX2j1434cg
 LrR4M2KO8VH8ayLx9lckr5xIaFL6ffnscH7xhGAWY6IP7azcPDnuaVc2fHQpKb47Jz5NW7J
 w/Z6266d8EmaUuVSosxnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9CqXz4Mp3Ds=:ev+TV+LYCf2AZg7+j8WzMP
 dKNS5jEk9c2zSN4QVhjW0JGiou/Jz5LyMmN9dLDyevmOIP9rpsBoe/ou0kQcuLkvtK6kfMnk5
 OKKgYIKorQ6Ss8e2koFPX3an6eGEw/lN+JaY/ZWDvLhLZIdmSyvkTbznj+9ddXRojKC7bp+Ep
 uFlOSvmq7p4z9ZrGGw9WW5c6Rx43xyExMF+U94mSGm72/XvL6brKcTgQhV6ac5VILc2uGb0VJ
 eFHQhvP19FWNH0VyuQNBl/Ag+GL72ZQeEF6bau2IAPss+E0JKrqkm2CGNL1Tef7myK8w4Tc4o
 HsTyyaw/9mRQ6bpdD7Cf+xESnsZcb7Swg5r6iExUbp570V1zQPNrBLn/M3sAHSWtrBXOF8Wi/
 WFB0yopchjqgPuMnvilS8ENfIIeGNmnqYU8XLW54+7D1Qb1iMwFhJRg65qJ+MzgHj2oH7pf+l
 1n6klXW94lZUH1auGI9x3/Pw2kGUyXjlWQFSlRGl5FAflWwAresD1aLbF9Ar0cgNTc3itv5ji
 4l4wSNCVcDci6IC68AK12zS93g9JnUtK3WGMRiFS/WGV63lh8UqlOXZhHDf/1F61/Zzb2zrOD
 eUDZoXCEIRG4n+8RzWh4wueMqnG4Gp57dBwaD+P/yxFBZk2el5r/BRHNVXaSJViXVI/jvl8E8
 WCwYlgo/tlGk7fEHTKlbofxEIpUzgvn4+aCNiIJpILaxxTYzvUtbV+3X7C0BT2QjkUlEwi+3I
 UZMWAwxdx/m3m6Sv
X-Spam-Status: No, score=-96.5 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
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
X-List-Received-Date: Mon, 28 Feb 2022 09:44:54 -0000

On Feb 28 18:32, Takashi Yano wrote:
> On Mon, 28 Feb 2022 10:21:32 +0100
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Feb 27 09:46, Takashi Yano wrote:
> > > - The recent commit "Cygwin: pinfo: Fix exit code when non-cygwin app
> > >   exits by Ctrl-C." did not fix enough the issue. If a non-cygwin app
> > >   is reading the console, it will not return STATUS_CONTROL_C_EXIT
> > >   even if it is terminated by Ctrl-C. As a result, the previous patch
> > >   does not take effect.
> > >   This patch solves this issue by setting sigExeced to SIGINT in
> > >   ctrl_c_handler(). In addition, sigExeced will be cleared if the app
> > >   does not terminated within predetermined time period. The reason is
> > >   that the app does not seem to be terminated by the signal sigExeced.
> > > [...]
> > > --- a/winsup/cygwin/spawn.cc
> > > +++ b/winsup/cygwin/spawn.cc
> > > @@ -953,7 +953,15 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> > >  	  if (sem)
> > >  	    __posix_spawn_sem_release (sem, 0);
> > >  	  if (ptys_need_cleanup || cons_need_cleanup)
> > > -	    WaitForSingleObject (pi.hProcess, INFINITE);
> > > +	    {
> > > +	      LONG prev_sigExeced = sigExeced;
> > > +	      while (WaitForSingleObject (pi.hProcess, 100) == WAIT_TIMEOUT)
> > > +		/* If child process does not exit in predetermined time
> > > +		   period, the process does not seem to be terminated by
> > > +		   the signal sigExeced. Therefore, clear sigExeced here. */
> > > +		prev_sigExeced =
> > > +		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
> > > +	    }
> > >  	  if (ptys_need_cleanup)
> > >  	    {
> > >  	      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> > 
> > Is it really necessary to run the InterlockedCompareExchange in a loop?
> > What about
> > 
> >   if (WFMO(..., 100) == WAIT_TIMEOUT)
> >     {
> >       InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
> >       WFMO(..., INFINITE);
> >     }
> > 
> > ?
> 
> If non-cygwin app ignores Ctrl-C (like cmd.exe), and if
> you hit Ctrl-C twice or more, sigExeced should be cleared
> everytime on Ctrl-C. Your code clears sigExeced only once,
> doesn't it?

Oh, ok.  Then, please go ahead.


Thanks,
Corinna
