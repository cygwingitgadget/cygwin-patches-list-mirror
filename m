Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id B3EF6385700B
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 08:26:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B3EF6385700B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGxYh-1kJrAY3wtH-00E7GY for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2020
 10:26:34 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7107DA83A8F; Mon,  7 Sep 2020 10:26:33 +0200 (CEST)
Date: Mon, 7 Sep 2020 10:26:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200907082633.GC4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
X-Provags-ID: V03:K1:kf3iA2U7nIxMUo9+ONZfRxdxfsG8T+4kkkT+NulirizFGv+pO7C
 2IykeFFvRUoydgO62srP+W7X916VC0tx0JH6y/U4Cc97yZeSj/W8Q0OxaabdDOE/AO3lJ/m
 GqyGRZIhhuRcS9jmvTTy2gzxwftuSAvT9yOvMOAZV1wn6/ZxHjgyJd2HGRU+l0fipFtpnwu
 0T9/dzfiWQPOc/zZpEF+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cwjjteK9e98=:5jYgU2cZXYzlcBTVnpHE6t
 3cnSNqj3FwNg8BggdfkzbhhI39SAU2kjW7o1UytOJ0YCaacXDrNXUzfCi3bnfOJ/itSmJRCts
 SVNGsSv6ufI2yk7vQLVXTKRsCX0APlwQgiLvST7hqFNgVsRRO2Fe549ne5VxT7bC3jHAMX5s2
 fguTHcTZrOC1WycFnwY4qMhOqXJqaWTWKCDtYk1K6zXCJVZKz5SO3xZM3MF5U+oJ35rWqb5Da
 OAKpi/jXxqbvLCwZL5ZUN1RVV7ag3zOYAVoEWJtrgmAaSzrjTlxRvXtAS9c/U22ht09gwFc3A
 1zR3OqJSsi5y9ht8DQ1SoQ2P9CfeuqwcI2+WCtdYN63hHkztTMkznzLLULN+1sgGISHxzwU4P
 08pQo7XPPFIMyISKwFUICs2TqVQ/M5iDvn7T8325C2214C7Vy6zKzU9l7qyKrczimzE8S6EiO
 BJUP9W1T9sTiJ0fvslSGjU5XLw2y9zR5lh+v0UUp5VhtSUZuwo2xlClkaKkWPx8QWmSrwNAJX
 XA0/Cn1YW+4irC3Baw86vePmoz+mUhxqJj7AEkCIIQSdvgIY8/d/DvbmblG2vt+yhMOIRgtaR
 6Xotdfz13EbujmV+hWuOSxSly51V2jOJTfts6oPMi2q3oc4mkXrfWa2UqSVLfzq1aUOje/Ktn
 CoKe8sWZGV6gZSA398J2LqCiKUUgs0et0s9pANMD6J+Vqn8ll8/8KSahPSNwG1b9+2nlSMfrm
 Kx43txGQIsC/TORBJfakq69Vv8ECAHOvd/9AgLW4x80Za1txlHDpyPZyZAbAj6ZG6BQ5zp8nn
 X4xk/Ih3MMn9PwEQmHnqDNkE+gZwTE8uD+JxERjIkdSOs2wHHJdbgBaY9zdMMw6SFJgwDdpn4
 MeYOl9wA1ajjWvs0w2Yw==
X-Spam-Status: No, score=-105.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 07 Sep 2020 08:26:38 -0000

Hi Takashi,

On Sep  5 17:43, Takashi Yano via Cygwin-patches wrote:
> On Fri, 4 Sep 2020 21:22:35 +0200
> Corinna Vinschen wrote:
> > So this boils down to the fact that term_code_page must be set
> > after the application is already running and as soo as it creates
> > the pty, me thinks.  What if __eval_codepage_from_internal_charset()
> > is called at pty creation?  Or even on reading from /writing to
> > the pty the first time?  That should always be late enough to fetch
> > the correct codepage.
> > 
> > Patch attached.  Does that work as expected?
> 
> Thank you very much for the patch.
> 
> Your new additional patch works well except the test case such as:
> 
>   int pm = getpt();
>   if (fork()) {
>     [do the master operations]
>   } else {
>     int ps = open(ptsname(pm), O_RDWR|O_NOCTTY);
>     close(pm);
>     setsid();
>     ioctl(ps, TIOCSCTTY, 1);
>     dup2(ps, 0);
>     dup2(ps, 1);
>     dup2(ps, 2);
>     close(ps);
>     [exec non-cygwin process]
>   }
> 
> If this test case is run in cygwin console (command prompt),
> it causes garbled output due to term_code_page == 0.

term_code_page is set on fhandler_pty_slave::open, which is what
you call above.  How can term_code_page be 0 after that?  Are you
talking about the forking parent process being master?  If so, either
switching `#if 1/#if 0' blocks in the patch might fix this (by setting
term_code_page on first read/write), or alternatively adding an
__eval_codepage_from_internal_charset() call to the master creation
as well.  Did you try enabling the #if 0'd blocks?

Either way, the call to __eval_codepage_from_internal_charset() should
take place as soon as the first pty gets created or on first pty
read/write.

__eval_codepage_from_internal_charset() could also simply be called
on *every* invocation of pty read/write, given how low profile it is.

Apart from that, I don't see anything wrong with the above scenario.
If the application creating the pty does *not* switch locale, we're
in "C" locale territory, and we should default to UTF-8.  That's
what a call to __eval_codepage_from_internal_charset() would do,
because it defaults to UTF-8 and never returns the ASCII codepage.

> > Btw., the main loop in fhandler_pty_master::pty_master_fwd_thread()
> > calls 
> > 
> >   char *buf = convert_mb_str (cygheap->locale.term_code_page,
> >                               &nlen, CP_UTF8, ptr, wlen);
> >                                      ^^^^^^^
> >   [...]
> >   WriteFile (to_master_cyg, ...
> > 
> > But then, after the code breaks from that loop, it calls
> > 
> >   char *buf = convert_mb_str (cygheap->locale.term_code_page, &nlen,
> >                               GetConsoleOutputCP (), ptr, wlen);
> >                               ^^^^^^^^^^^^^^^^^^^^^
> >   [...]
> >   process_opost_output (to_master_cyg, ...
> > 
> > process_opost_output then calls WriteFile on that to_master_cyg handle,
> > just like the WriteFile call above.
> > 
> > Is that really correct?  Shouldn't the second invocation use CP_UTF8 as
> > well?
> 
> That is correct. The first conversion is for the case that pseudo
> console is enabled, and the second one is for the case that pseudo
> console is disabled.
> 
> Pseudo console converts charset from console code page to UTF-8.
> Therefore, data read from from_slave is always UTF-8 when pseudo
> console is enabled. Moreover, OPOST processing is done in pseudo
> console, so write data simply by WriteFile() is enough.
> 
> If pseudo console is disabled, cmd.exe and so on uses console
> code page, so the code page of data read from from_slave is
> GetConsoleOutputCP(). In this case, OPOST processing is necessary.

This is really confusing me.  We never set the console codepage in the
old pty code before, it was just pipes transmitting bytes.  Why do we
suddenly have to handle native apps running in a console in this case?!?

> diff --git a/winsup/cygwin/cygheap.h b/winsup/cygwin/cygheap.h
> index 2b84f4252..8877cc358 100644
> --- a/winsup/cygwin/cygheap.h
> +++ b/winsup/cygwin/cygheap.h
> @@ -341,7 +341,6 @@ struct cygheap_debug
>  struct cygheap_locale
>  {
>    mbtowc_p mbtowc;
> -  UINT term_code_page;

No, wait.  Just reverting this change without checking the alternatives
doesn't make sense.

Why would we want to store the codepage in every single tty, given
term_code_page is set to the same value in every one of them?  AFAICS
it's sufficient to have a single term_code_page shared with the child
processes via cygheap.  The idea is to get rid of the complex
setup_locale code in every execve call and just set it once in a process
tree starting at the process creating the ptys.


Corinna
