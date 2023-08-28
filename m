Return-Path: <SRS0=JFVn=EN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1002.nifty.com (mta-snd01004.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id C14163857704
	for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 12:51:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C14163857704
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta1002.nifty.com with ESMTP
          id <20230828125134815.YLEP.19111.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 21:51:34 +0900
Date: Mon, 28 Aug 2023 21:51:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: spawn: Fix segfalt when too many command
 line args are specified.
Message-Id: <20230828215134.74cc810cd41daea1a3e21cf4@nifty.ne.jp>
In-Reply-To: <ZOx9j/YRr3UX88wV@calimero.vinschen.de>
References: <20230828094605.2405-1-takashi.yano@nifty.ne.jp>
	<ZOx9j/YRr3UX88wV@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 28 Aug 2023 12:57:19 +0200
Corinna Vinschen wrote:
> -      char *newargv[__argc + 1];
> -      char **nav = newargv;
> -      char **oav = __argv;
> -      while ((*nav++ = *oav++) != NULL)
> -	continue;
> +      char **newargv = (char **) malloc ((__argc + 1) * sizeof (char **));
> +      memcpy (newargv, __argv, (__argc + 1) * sizeof (char **));
>        /* Handle any signals which may have arrived */
>        sig_dispatch_pending (false);
>        _my_tls.call_signal_handler ();

Shouldn't this be sizeof (char *), not sizeof (char **)?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
