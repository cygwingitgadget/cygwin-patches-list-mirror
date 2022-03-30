Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 9DCAE3858C50
 for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2022 00:17:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9DCAE3858C50
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 22U0H9sG014680;
 Wed, 30 Mar 2022 09:17:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 22U0H9sG014680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1648599430;
 bh=qN1HH19pA1u1+rJk9zGRDLx3SF+xb/Ciqwm32LOekWU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Vrtfy3PTUsoPvqUWl8OPoqdhlLNtfwT/toYMhcY6+BECL2FyJv3/LUhUSUwvFTeRj
 xvV0OWZ7HUSTA8w0hrAufdT9Zze6AmHx0vUchkW4DDB2TGfpEoQhDCnKF53UHec5mI
 0VRtSYr9uFIat4MYxipQPOzWfS/vbqxFwQ44suuYu+YeIR8Q/yfSR+oWdSdkGpRn66
 QXhPUlwCf4qIaTQU8F4GJ9VWZCxdn2nbUL8NAwCyCzX0koQdXIp7rYmbyfBuf1fLyr
 igGSSmMJzFRsUid682t1T3FsflKlrcGASHG0EP0WNtHahuObVTd84Vz33dXvSCME3X
 MMmyQ5Y7WOylA==
X-Nifty-SrcIP: [119.150.44.95]
Date: Wed, 30 Mar 2022 09:17:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pipe: Avoid deadlock for non-cygwin writer.
Message-Id: <20220330091716.f4541fdff98f2b0aa0c1ec2f@nifty.ne.jp>
In-Reply-To: <alpine.BSO.2.21.2203290816270.56460@resin.csoft.net>
References: <20220329090753.47207-1-takashi.yano@nifty.ne.jp>
 <alpine.BSO.2.21.2203290816270.56460@resin.csoft.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Wed, 30 Mar 2022 00:17:37 -0000

On Tue, 29 Mar 2022 08:21:11 -0700 (PDT)
Jeremy Drake wrote:

> On Tue, 29 Mar 2022, Takashi Yano wrote:
> 
> > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > index fb3d09d84..cd2d3a7ef 100644
> > --- a/winsup/cygwin/spawn.cc
> > +++ b/winsup/cygwin/spawn.cc
> > @@ -645,8 +646,18 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  		     && (fd == fileno_stdout || fd == fileno_stderr))
> >  	      {
> >  		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> > -		pipe->close_query_handle ();
> >  		pipe->set_pipe_non_blocking (false);
> > +		pipe->request_close_query_hdl ();
> > +
> > +		tty_min dummy_tty;
> > +		dummy_tty.ntty = (fh_devices) myself->ctty;
> > +		dummy_tty.pgid = myself->pgid;
> > +		tty_min *t = cygwin_shared->tty.get_cttyp ();
> > +		if (!t) /* If tty is not allocated, use dummy_tty instead. */
> > +		  t = &dummy_tty;
> > +		/* Emit __SIGNONCYGCHLD to let all processes in the
> > +		   process group close query_hdl. */
> > +		t->kill_pgrp (__SIGNONCYGCHLD);
> >  	      }
> >  	    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
> >  	      {
> >
> 
> This block seems to be inside a loop over handles.  Would it make sense to
> move the `tty_min dummy_tty` through `t->kill_pgrp` lines outside the
> loop, and set a flag in the loop instead, so the pgrp only needs to be
> signaled (killed) once rather than for each handle that needs closing?

Thanks for the advice. I will submit v5 patch reflecting your advice.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
