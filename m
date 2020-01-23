Return-Path: <cygwin-patches-return-9991-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30261 invoked by alias); 23 Jan 2020 15:02:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30252 invoked by uid 89); 23 Jan 2020 15:02:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 15:02:50 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id 00NF2lBC006692	for <cygwin-patches@cygwin.com>; Fri, 24 Jan 2020 00:02:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 00NF2lBC006692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579791767;	bh=+pK2LjO3eY4+TDp0l/rGTwVTN9PHjYQnO3sW1z6x+6c=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=ZSSTGTTV/IB1Ksgd3EZrGOt/n3PtIbdgYfe3D0rRoh/7hvj4yANUifnCYQ2Lwc7AW	 F0V/izil12dj/XlgUCpfOfYn2Ce4JbiyJ6SDDtFF5S3LEO8XFIL1vz0V2T/FP1DYVu	 2URAtxKd79xvNcZLQ1fqZ9uNBTUV1WfhElxUkP/oAa47tDkOzgqwT91Tj6wfMifQCl	 bFkw83gIDaOIs+5u9FoEcDCQQ3ymEFz6DUgif1WHTyLWMv4wxl2aGe3ObowRXVf1NL	 XvWZJw5GfRXD6qHJOkkp0WbPuHwE1xqC+QuuHj0fuTEKYA1qjq8cX4RB5efsvg6dMs	 tL/b26iNB4GuQ==
Date: Thu, 23 Jan 2020 15:02:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
Message-Id: <20200124000302.0d451876467be07b2709a34a@nifty.ne.jp>
In-Reply-To: <20200123125154.GD263143@calimero.vinschen.de>
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp>	<20200123043007.1364-1-takashi.yano@nifty.ne.jp>	<20200123125154.GD263143@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00097.txt

On Thu, 23 Jan 2020 13:51:54 +0100
Corinna Vinschen wrote:
> On Jan 23 13:30, Takashi Yano wrote:
> > - After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
> >   cygwin programs which call both printf() and WriteConsole() are
> >   frequently distorted. This patch reverts waiting function to dumb
> >   Sleep().
> I understand the need for this change, but isn't there any other
> way to detect if the pseudo console being ready?  E. g., something
> in the HPCON_INTERNAL struct or so?

In any case, this patch has a problem that windows native program takes
a very long time to start/stop after the window size is changed.

Please do not apply this patch.

If you want to try this patch, please use following patch along with
v2 patch.

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 2b7c667a6..06ac0c5e0 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2413,6 +2413,7 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
 	  COORD size;
 	  size.X = ((struct winsize *) arg)->ws_col;
 	  size.Y = ((struct winsize *) arg)->ws_row;
+	  get_ttyp ()->last_push_time = GetTickCount ();
 	  ResizePseudoConsole (get_pseudo_console (), size);
 	}
       if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
