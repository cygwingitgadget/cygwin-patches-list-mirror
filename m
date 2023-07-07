Return-Path: <SRS0=MpmZ=CZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0020.nifty.com (mta-snd00010.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id D87373858D38
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 03:30:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D87373858D38
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta0020.nifty.com with ESMTP
          id <20230707033005636.TYZM.104723.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 7 Jul 2023 12:30:05 +0900
Date: Fri, 7 Jul 2023 12:30:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: dtable: Delete old kludge code for /dev/tty.
Message-Id: <20230707123005.493ee21ae5ad31500af6415c@nifty.ne.jp>
In-Reply-To: <ZKQualiRASkQFC8N@calimero.vinschen.de>
References: <20230704100338.255-1-takashi.yano@nifty.ne.jp>
	<ZKQualiRASkQFC8N@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Tue, 4 Jul 2023 16:36:26 +0200
Corinna Vinschen wrote:
> On Jul  4 19:03, Takashi Yano wrote:
> > This old kludge code assigns fhandler_console for /dev/tty even
> > if the CTTY is not a console when stat() has been called. Due to
> > this, the problem reported in
> > https://cygwin.com/pipermail/cygwin/2023-June/253888.html
> > occurs after the commit 3721a756b0d8 ("Cygwin: console: Make the
> > console accessible from other terminals.").
> > 
> > This patch fixes the issue by dropping the old kludge code.
> > 
> > Though the exact reason why the kludge code was necessary is not
> > clear enough, this kluge code has no longer seemed to be necessary
>                                 ^^^^^^^^^^^^^^^^^^^^
> I'm not a native speaker myself, but
> 
> 				no longer seems
> 
> might be better here.
> 
> Anyway, this is GTG.

I think I understand correctly the concept of cnew_no_ctor macro in
dtable.cc now. cnew_no_ctor calls fhandler_console(void *) instead of
fhandler_console(fh_devices) to omits initialization of instance for
stat() call. This might make stat() slightly faster.

Based on this understanding, I would like to withdraw the previous
patch, and propose new patch series.

Could you please review the patch seriese?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
