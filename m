Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id 5DBFD3858D28
 for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2022 08:08:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5DBFD3858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 21A87up0013475
 for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2022 17:07:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 21A87up0013475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644480477;
 bh=u55BsA69P1J17CSfNmrp7qS83yxEJm48qy6gC08NXLk=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=s01j0uqD0Xo2yn+xH4bOsGqbrFR8kcu9LtSZBThVPUpgh9unr9xCGOOj+ylR1fMj1
 SwpQ7QC85MKhk1JER/wHlBduwkJrrEZ9xR2DnWjqKAwVIMTxLYbjcbi1wMkowlKGXe
 xpxY3a8eEi2VhF0mIvDUePDxcnmfx+UTl4A3EaZHknMsjNgg2qTiKsAYmOOCpm59S2
 FdJb0S2Lu93JGYVu/xKsFentYtw0KR71hKAzIaFdaKYy/uDvRmDZ63AzGQ1qEsBfgI
 RZjPIclQASEUd9sTE8m8WyGiRNVM92vZQQxTTE3nYcLbAjRgxHxIx6kLi0xSxUwVM7
 jFbN74XJ+CwWA==
X-Nifty-SrcIP: [119.150.36.16]
Date: Thu, 10 Feb 2022 17:07:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: console: Maintain EXTENDED_FLAGS state
Message-Id: <20220210170756.a2efb012fdc916e3873b1b55@nifty.ne.jp>
In-Reply-To: <CAAvot89oYw7QF8YNMGp9fGTRsB18u2of1TFw-g_B4GWctLtFDw@mail.gmail.com>
References: <CAAvot89oYw7QF8YNMGp9fGTRsB18u2of1TFw-g_B4GWctLtFDw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 10 Feb 2022 08:08:25 -0000

On Wed, 9 Feb 2022 19:09:02 -0500
Mitchell Hentges wrote:
> As well-described over in this post [1], it's possible for
> the active console mode to be impossible to correctly determine.
> Specifically, if ENABLE_EXTENDED_FLAGS is at any point unset,
> then the flags it's associated with (ENABLE_INSERT_MODE,
> ENABLE_QUICK_EDIT_MODE) will no longer be discoverable - they'll
> always show up as unset, regardless of real console state.
> 
> It's not possible to work around this by setting
> ENABLE_EXTENDED_FLAGS once then re-querying, because setting
> ENABLE_EXTENDED_FLAGS on it's own will *disable* its related
> flags.
> 
> Anyways, to avoid this case, all programs doing SetConsoleMode()
> must be good community citizens and carefully maintain its state.
> Unfortunately, we're accidentally stepping on this in
> fhandler_console::set_input_mode().
> 
> This patch solves this by carrying forward ENABLED_EXTENDED_FLAGS
> (and friends) in the only place where it had been ignored: set_input_mode()
> Since the previous behaviour of leaving all three flags unset would
> essentially maintain their existing state (except for the footgun
> being worked around here), *adding* the carry-over of the flags now
> should not alter console behaviour.
> 
> [1] https://www.os2museum.com/wp/disabling-quick-edit-mode/
> ---
>  winsup/cygwin/fhandler_console.cc | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_console.cc
> b/winsup/cygwin/fhandler_console.cc
> index 7a1a45bc1..b2554c3ba 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -458,16 +458,18 @@ void
>  fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
>                                   const handle_set_t *p)
>  {
> -  DWORD flags = 0, oflags;
> +  DWORD oflags;
>    WaitForSingleObject (p->input_mutex, mutex_timeout);
>    GetConsoleMode (p->input_handle, &oflags);
> +  DWORD flags = oflags
> +      & (ENABLE_EXTENDED_FLAGS | ENABLE_INSERT_MODE |
> ENABLE_QUICK_EDIT_MODE);
>    switch (m)
>      {
>      case tty::restore:
> -      flags = ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT |
> ENABLE_PROCESSED_INPUT;
> +      flags |= ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT |
> ENABLE_PROCESSED_INPUT;
>        break;
>      case tty::cygwin:
> -      flags = ENABLE_WINDOW_INPUT;
> +      flags |= ENABLE_WINDOW_INPUT;
>        if (wincap.has_con_24bit_colors () && !con_is_legacy)
>         flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
>        else
> --
> 2.35.1

Thanks for the patch. The patch looks good, however, it is
malformed, probably due to your mailer. (e.g. Sprious new
line inserted, and tab not preserved.)

Could you please resend it?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
