Return-Path: <SRS0=dMBQ=EG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1020.nifty.com (mta-snd01009.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id E0F503857C45
	for <cygwin-patches@cygwin.com>; Mon, 21 Aug 2023 08:53:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E0F503857C45
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta1020.nifty.com with ESMTP
          id <20230821085325658.CYZA.131070.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 21 Aug 2023 17:53:25 +0900
Date: Mon, 21 Aug 2023 17:53:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix failure to clear switch_to_nat_pipe
 flag.
Message-Id: <20230821175325.30ceb6a94f0ecc4157e3f1ba@nifty.ne.jp>
In-Reply-To: <ZOMeTorrvdScqcZ2@calimero.vinschen.de>
References: <20230819060739.898-1-takashi.yano@nifty.ne.jp>
	<ZOMeTorrvdScqcZ2@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 21 Aug 2023 10:20:30 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Aug 19 15:07, Takashi Yano wrote:
> > After the commit fbfea31dd9b9, switch_to_nat_pipe is not cleared
> > properly when non-cygwin app is terminated in the case where the
> > pseudo console is disabled. This is because get_winpid_to_hand_over()
> > sometimes returns PID of cygwin process even though it should return
> > only PID of non-cygwin process. This patch fixes the issue by adding
> > a new argument which requests only PID of non-cygwin process to
> > get_console_process_id().
> 
> How critical is that? Do we need a 3.4.9 asap, or can we wait and
> collect a few more bugfixes first?

This problem is affected only when pseudo console is not
activated. So, most of Win10 users do not have this issue.
However, Win7/8 users may notice some small gritch after
non-cygwin app is executed.

BTW, are you noticed that dumper.exe is missing in 3.4.8?
When you release new cygwin to fix that, I would be happy
if above patch will applied as well.

Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
