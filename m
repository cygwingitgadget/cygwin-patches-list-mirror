Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 3E3563858C3A
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 09:32:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3E3563858C3A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 21S9Vn9K010795
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 18:31:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21S9Vn9K010795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646040710;
 bh=H96wYGbzSJDfOA//oqegPF/GYkd+mLXucEABzgwBCqk=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=JSkxCY+lq3AXXQ8yoq1S0vK4hZAxJvUMFGmGCo+LN7lgztyorSCAO152+n/K06CK8
 w8/SWqk4btLrOQQNWM24X9npgTxEkSzGLEU7b4LBoeUMGaI77ylssnBTCnzr5Nu0jP
 AnKM4aJlruyrBRLUi5HTHvjsNEO12ZH1Fx5yWPm2x09xV3m0iW7XCOjPYHUvdVHZNQ
 RXxJGaTCgTWoIGK+C6DZ+tEwAv5mAM8PbCaGcCGu0l8V9a4w5o9Y1rqvugZJ0IE6aE
 b4jMHJkQJpytEV4ncWdToyL2j9f2sY/6ZrJy2hQRv75kabzQlFB81nBeDqPmskG3Nk
 tseHwkkAXxgLw==
X-Nifty-SrcIP: [119.150.36.16]
Date: Mon, 28 Feb 2022 18:32:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pinfo: Fix exit code for non-cygwin apps
 which reads console.
Message-Id: <20220228183202.9236c4f2bbeacb65a816be64@nifty.ne.jp>
In-Reply-To: <YhyUHPKAQkHi3uQT@calimero.vinschen.de>
References: <20220227004607.2051-1-takashi.yano@nifty.ne.jp>
 <YhyUHPKAQkHi3uQT@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Mon, 28 Feb 2022 09:32:14 -0000

On Mon, 28 Feb 2022 10:21:32 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Feb 27 09:46, Takashi Yano wrote:
> > - The recent commit "Cygwin: pinfo: Fix exit code when non-cygwin app
> >   exits by Ctrl-C." did not fix enough the issue. If a non-cygwin app
> >   is reading the console, it will not return STATUS_CONTROL_C_EXIT
> >   even if it is terminated by Ctrl-C. As a result, the previous patch
> >   does not take effect.
> >   This patch solves this issue by setting sigExeced to SIGINT in
> >   ctrl_c_handler(). In addition, sigExeced will be cleared if the app
> >   does not terminated within predetermined time period. The reason is
> >   that the app does not seem to be terminated by the signal sigExeced.
> > [...]
> > --- a/winsup/cygwin/spawn.cc
> > +++ b/winsup/cygwin/spawn.cc
> > @@ -953,7 +953,15 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  	  if (sem)
> >  	    __posix_spawn_sem_release (sem, 0);
> >  	  if (ptys_need_cleanup || cons_need_cleanup)
> > -	    WaitForSingleObject (pi.hProcess, INFINITE);
> > +	    {
> > +	      LONG prev_sigExeced = sigExeced;
> > +	      while (WaitForSingleObject (pi.hProcess, 100) == WAIT_TIMEOUT)
> > +		/* If child process does not exit in predetermined time
> > +		   period, the process does not seem to be terminated by
> > +		   the signal sigExeced. Therefore, clear sigExeced here. */
> > +		prev_sigExeced =
> > +		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
> > +	    }
> >  	  if (ptys_need_cleanup)
> >  	    {
> >  	      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> 
> Is it really necessary to run the InterlockedCompareExchange in a loop?
> What about
> 
>   if (WFMO(..., 100) == WAIT_TIMEOUT)
>     {
>       InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
>       WFMO(..., INFINITE);
>     }
> 
> ?

If non-cygwin app ignores Ctrl-C (like cmd.exe), and if
you hit Ctrl-C twice or more, sigExeced should be cleared
everytime on Ctrl-C. Your code clears sigExeced only once,
doesn't it?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
