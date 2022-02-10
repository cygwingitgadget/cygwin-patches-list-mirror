Return-Path: <mhentges@mozilla.com>
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by sourceware.org (Postfix) with ESMTPS id 40EB13858C20
 for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2022 15:40:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 40EB13858C20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=mozilla.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=mozilla.com
Received: by mail-yb1-xb35.google.com with SMTP id v186so16679249ybg.1
 for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2022 07:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mozilla.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=YWelIiAgLVuycibz/CT2lXbi46o72uKYidKIUXSv/c4=;
 b=Ig6Kpu4YV2EUR4kU1+HH9SBGjQX2BwP2dbK25jbPZhfXEAX4mICnHjJnWroXV2AoG7
 ZjZ9voMfQFeE2hMjHgLGkDnS/dT/Re58tVnAlSjqynTHH5bdDuAnijwKxpCTM2a1KveC
 0KRJ9vUOEPvPxXz4csYNzwwZ266H963QgvE7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=YWelIiAgLVuycibz/CT2lXbi46o72uKYidKIUXSv/c4=;
 b=MPrMk+0qBKrJFYR6De6pmbJnvzHJG5zilxF5knH/0hAdroLELIgbTMSSE8FPiIdQXC
 6Zb/RS6wP6lNEheMAQ+nAc4uW287iuEdJaLraDlXPN+qLun9p7WX61lquWfuAQ5A0gSY
 vM/o0W+QMAbp8JEJ+pxZqqkygi5SULl7Wh7EhopGKHJjNC3qXCc7A+G4k1Am9fvrdu9d
 8ONj5UhDwtIrMKQPIcBfYkZOEkEE2Dh33JusIw1CuWcfH8/oa6ymnWHX1NrQkvfpdl+l
 oIjviELB8YojbN0yTBW1OD3QgHyUIAtwm4jOalVaJunNCPYYanNWgtl5sVgGsgLCY+HV
 lZRQ==
X-Gm-Message-State: AOAM533/Z5Q25G9dUTS3aeXEid4Guv14qgv/DYRZmh1x0nXQuA7ik+hy
 hsMUdcvNaKZzYMiEaQ31FRlEkLxkCrcDgLBVyydAKGBGxM4=
X-Google-Smtp-Source: ABdhPJwSO3nsiNx+5n7X1QLeddOR2Z128edgANjgja1vuXqxmbEypEY+FyTaRrkEBbb3zpPd32XKA1iZiPAoZ9r5Fvo=
X-Received: by 2002:a81:4402:: with SMTP id r2mr7870687ywa.126.1644507647348; 
 Thu, 10 Feb 2022 07:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20220210170756.a2efb012fdc916e3873b1b55@nifty.ne.jp>
 <20220210153808.2655-1-mhentges@mozilla.com>
In-Reply-To: <20220210153808.2655-1-mhentges@mozilla.com>
From: Mitchell Hentges <mhentges@mozilla.com>
Date: Thu, 10 Feb 2022 10:40:36 -0500
Message-ID: <CAAvot8-BObo_X1d1E3x8o+qpZYFQO0qicYpz9G0dB3bkEtgvsA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Cygwin: console: Maintain EXTENDED_FLAGS state
To: cygwin-patches@cygwin.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, HTML_MESSAGE,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
X-List-Received-Date: Thu, 10 Feb 2022 15:40:50 -0000

Thanks, I appreciate it.
The initial send was via GMail, but I've wired up git-send-email to msmtp,
and I'm hoping that it's happy now - at least, it looks like tabs are being
preserved now, which is a good sign.

On Thu, Feb 10, 2022 at 10:38 AM Mitchell Hentges <mhentges@mozilla.com>
wrote:

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
> and friends in the only place where it had been ignoring it.
> Since the previous behaviour of leaving all three flags unset would
> essentially maintain their existing state (except for the footgun
> being worked around here), *adding* the carry-over of the flags now
> should not alter console behaviour.
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
>
>

-- 
Mitchell Hentges
Engineering Workflow
Mozilla
