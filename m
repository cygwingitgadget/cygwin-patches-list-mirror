Return-Path: <cygwin-patches-return-10108-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97048 invoked by alias); 24 Feb 2020 16:10:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 97037 invoked by uid 89); 24 Feb 2020 16:10:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=033, cx, takashi.yano@nifty.ne.jp, sk:takashi
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Feb 2020 16:10:20 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id 01OGA8Wp020537	for <cygwin-patches@cygwin.com>; Tue, 25 Feb 2020 01:10:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01OGA8Wp020537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582560610;	bh=DVsJ9kksVsnjlx51H42uMVNr31/yIEGCFNCX4IJqSMk=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=hc+rOBGgQ5ixpRVH7wboTb0fDJdG67Z53S+13i5Hm6K3mNM+EW+1319GpymGIfNix	 oLAcD/BSJRhUQwuuIuijt8guRGAblNbHHe24nZ6NXKcyBIrywLhwZ8+CjG7ADkT6iO	 1vrxt9Fo390FoJzBzfLpHY9rAT+fQX5PAWx8MYP5QdpfrkKVS1xPtCp4QPqKxej9cO	 oGEsIZB/5L2tXDUIV4TUXSxUBUSNTDpHPJzsE1n6t0nxJ0QqASO5o1OV1/16h1qMyW	 jMwD2m3tn5PHofYlUI9MTOSf+/y5yoe+LNuBYvGj85kiYasZKxHhimoB6puy0sKF7q	 tzaDay0F2DaKg==
Date: Mon, 24 Feb 2020 16:10:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-Id: <20200225011011.7d2c6b5350c0738b705480ba@nifty.ne.jp>
In-Reply-To: <20200224100835.GD4045@calimero.vinschen.de>
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp>	<20200221194333.GZ4092@calimero.vinschen.de>	<20200222170123.23099cf86117791daa1722c5@nifty.ne.jp>	<20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp>	<20200224100835.GD4045@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00214.txt

On Mon, 24 Feb 2020 11:08:35 +0100
Corinna Vinschen wrote:
> I debugged this situation as well and what strikes me as weird is
> that in fhandler_console::close, there are two calls to
> request_xterm_mode_output(false).  The first one is only called if
> shared_console_info is != NULL, the other one is always called if
> wincap.has_con_24bit_colors().  This looks a bit fishy.  Not only
> the shared_console_info test is missing, but also the con_is_legacy
> test.
> 
> What about something like this:
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 42040a97162e..edb71fffe48f 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -1159,18 +1159,17 @@ fhandler_console::close ()
>  
>    acquire_output_mutex (INFINITE);
>  
> -  if (shared_console_info && myself->pid == con.owner &&
> -      wincap.has_con_24bit_colors () && !con_is_legacy)
> -    request_xterm_mode_output (false);
> -
> -  /* Restore console mode if this is the last closure. */
> -  OBJECT_BASIC_INFORMATION obi;
> -  NTSTATUS status;
> -  status = NtQueryObject (get_handle (), ObjectBasicInformation,
> -			  &obi, sizeof obi, NULL);
> -  if (NT_SUCCESS (status) && obi.HandleCount == 1)
> -    if (wincap.has_con_24bit_colors ())
> -      request_xterm_mode_output (false);
> +  if (shared_console_info && !con_is_legacy && wincap.has_con_24bit_colors ())
> +    {
> +      /* Restore console mode if this is the last closure. */
> +      OBJECT_BASIC_INFORMATION obi;
> +      NTSTATUS status;
> +      status = NtQueryObject (get_handle (), ObjectBasicInformation,
> +			      &obi, sizeof obi, NULL);
> +      if ((NT_SUCCESS (status) && obi.HandleCount == 1)
> +	  || myself->pid == con.owner)
> +	request_xterm_mode_output (false);
> +    }
>  
>    release_output_mutex ();

OK. I will submit a v2 patch according to your suggestion.
As for con_is_legacy check, it is included in
request_xterm_mode_output(), so is not necessary here.

> Btw., are you testing the console with black background?  I'm asking
> because I'm using the console with grey background and black characters,
> and I'm always seeing artifacts when using vim in xterm mode.
> 
> E.g., open vim on the fork-setsid.c source in the console in xterm
> mode.  Move the cursor to the beginning of the word `setsid'.  Now
> press the three chars
> 
>   c h <CR>
> 
> this moves the setsid call to the next line.  But it also adds
> black background after `setsid();'.  Simiar further actions always
> create black background artifacts.
> 
> Is there anything we can do against that?

This seems to be a bug of windows console. It also occurs in wsl.
/bin/echo -e '\033[H\033[5L'
causes the similar result.

The following code cause the problem as well.

#include <windows.h>
int main()
{
    CONSOLE_SCREEN_BUFFER_INFO sbi;
    SMALL_RECT r;
    COORD c = {0, 0};
    CHAR_INFO f = {' ', 0};
    HANDLE h = GetStdHandle(STD_OUTPUT_HANDLE);
    DWORD n;
    ReadConsoleOutputAttribute(h, &f.Attributes, 1, c, &n);
    GetConsoleScreenBufferInfo(h, &sbi);
    c.X = 0;
    c.Y = sbi.srWindow.Top + 5;
    ScrollConsoleScreenBuffer(h, &sbi.srWindow, NULL, c, &f);
    return 0;
}

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
