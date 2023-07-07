Return-Path: <SRS0=MpmZ=CZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1020.nifty.com (mta-snd01011.nifty.com [106.153.227.43])
	by sourceware.org (Postfix) with ESMTPS id 4BFFD385842A
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 23:01:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4BFFD385842A
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta1020.nifty.com with ESMTP
          id <20230707230126440.GCYW.25677.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 8 Jul 2023 08:01:26 +0900
Date: Sat, 8 Jul 2023 08:01:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: fstat(): Fix st_rdev returned by fstat()
 for /dev/tty.
Message-Id: <20230708080127.1b8a0be63e3c1a2acc472c24@nifty.ne.jp>
In-Reply-To: <ZKfkrrnMdbVv0N11@calimero.vinschen.de>
References: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
	<20230707033458.1034-3-takashi.yano@nifty.ne.jp>
	<ZKfkrrnMdbVv0N11@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 7 Jul 2023 12:10:54 +0200
Corinna Vinschen wrote:
> On Jul  7 12:34, Takashi Yano wrote:
> > While st_rdev returned by fstat() for /dev/tty should be FH_TTY,
> > the current cygwin1.dll returns FH_PTYS+minor or FH_CONS+minor.
> > Similarly, fstat() does not return correct value for /dev/console,
> > /dev/conout, /dev/conin or /dev/ptmx.
> > 
> > This patch fixes the issue by:
> > 1) Introduce dev_refered_via in fhandler_termios.
>                        ^
>                dev_referred_via, please

Thansk!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
