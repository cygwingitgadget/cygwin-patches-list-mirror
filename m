Return-Path: <SRS0=gf06=ET=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 2E24A4BA2E04
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 07:50:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2E24A4BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2E24A4BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782201039; cv=none;
	b=WDIY6eEsKELjRvAkh7vokEBKTCKIofEy7DtvtZ6CzRkw1jTUATv1pPkD14YfJsX0CVjrEI4uQMk/nf3b9NL7w7jUXvqpmHdJRO1ARIl65ih57HlbS/eewO+ITmGoEX6YDVjHujfMqksCFa/EGeUxk+00tDFZk9g8hv0u+iIv6QY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782201039; c=relaxed/simple;
	bh=+WSw+dZ1FIzNDFpM37ASlQzJrix2jbypwn2R5xTf5XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=CqccJGoYXAxosigmnJ1m1Xq9Jtk44slvAl/AXVzIzxpoJ1anJ4r/Z65Nz2wOZ9AOIcJPz5QIfJaTRCPq8gcaPnY1zrDZibzSX2BJhi6PrK0uCWSGe5TumVUekz/MwhdxWFHBFeb+tukcsyAHaCy/P1AUes1R0apcqj1/tfkjldU=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2E24A4BA2E04
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65N85eWt018149
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 01:05:40 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdJJO2lO; Tue Jun 23 01:05:37 2026
Message-ID: <ee4f59ef-f0e9-48ea-ada5-6eaa7f19bfb8@maxrnd.com>
Date: Tue, 23 Jun 2026 00:50:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Cygwin: pty: Discard pcon input buffer when
 discard_input is called.
To: cygwin-patches@cygwin.com
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
 <20260613140917.27155-3-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260613140917.27155-3-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/13/2026 7:09 AM, Takashi Yano wrote:
> Previously, the process on pty could not be a child of non-cygwin
> process. So, it is not necessary to flush pcon input buffer even
            ^^^^ replace "So" with "In that case"

> when discard_input() is called. However, now, the child process
> of non-cygwin app on pseudo console is running on pty. So,
> discard_input() should affect to the pcon input buffer as well.
> 
> This prevents the probelm:
                     ^^^^^^^
>    1) Run 'sleep 10' in cmd.exe
>    2) Enter 'ps\n' while sleeping
>    3) Press Ctrl-C
>    4) 'ps' will be executed after terminating 'sleep' by Ctrl-C.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviwed-by:
> ---
>   winsup/cygwin/fhandler/pty.cc | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index d625ff9df..b3a8d57cc 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -583,6 +583,14 @@ fhandler_pty_master::discard_input ()
>     if (!get_ttyp ()->pcon_activated)
>       while (::bytes_available (bytes_in_pipe, from_master_nat) && bytes_in_pipe)
>         ReadFile (from_master_nat, buf, sizeof(buf), &n, NULL);
> +  else
> +    {
> +      DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
> +      DWORD resume_pid =
> +	fhandler_pty_common::attach_console_temporarily (target_pid);
> +      FlushConsoleInputBuffer (h_pcon_in_dupped);
> +      fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
> +    }
>     get_ttyp ()->discard_input = true;
>     ReleaseMutex (input_mutex);
>   }
> @@ -2585,7 +2593,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>         for (size_t i = 0, j = 0; i < len; i++)
>   	{
>   	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
> -	  if (r != done_with_debugger)
> +	  if (r != done_with_debugger &&
> +	      (r != signalled || (ti.c_lflag & NOFLSH) || buf[i] == '\003'))
>   	    {
>   	      char c = buf[i];
>   	      /* Workaround for pseudo console in Windows 11 */

Other than the minor commentary changes, this LGTM.

..mark

