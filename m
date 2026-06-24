Return-Path: <SRS0=WipY=EU=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 828304BA543C
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 08:02:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 828304BA543C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 828304BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782288158; cv=none;
	b=HER7rV1CWao2EmHfmwJh2oPEt25xk/mWhhJEPLcHKxUGnlaNVh4gqn0Mnao5gKoes9HqCuTaR9Ci1uBxgVUAWT1POhO/EU9v2zerGSjg2IChBoJWL8Dw2aTQuR7JMXzrr2bZNJX1xf9FNMuQalrgk850txaAV94Rr6T/7KPuQB8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782288158; c=relaxed/simple;
	bh=Dwl8iEfNTdQCZKqkxPmNiecjgEcKhv9o3oHatxffJF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=El3H9c/eWb7eY9DosT/vyVmbCGtQvgNQLenSSHDtkEnssW+c7UZOC5ElC/fmtVqZ2sq++xOv24PKMBmxy6xdbqo5osMv8nM0vR1K69k5UmBE8tWfz1epHdYi9w/Mj10haisKbZ1RYrWW+kQlDkwd6upXN7/bTnrYgBZMlX1IB+A=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 828304BA543C
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65O8HdVO042445
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 01:17:39 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdE1VQm4; Wed Jun 24 01:17:33 2026
Message-ID: <88edad1a-5ae6-4ba4-989d-1e26491353bb@maxrnd.com>
Date: Wed, 24 Jun 2026 01:02:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Cygwin: console: Ensure the master thread runs only
 when it is supposed to
To: cygwin-patches@cygwin.com
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
 <20260610163533.10187-2-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260610163533.10187-2-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/10/2026 9:35 AM, Takashi Yano wrote:
> Currently, disabling cons_master_thread is done by just setting the
> flag disable_master_thread. In fact, actual suspension of master
> thread is delayed a bit. Therefore, non-cygwin program where the
> master thread should be disabled may run even though the master
> thread is running in a short time. This patch ensure that the master
> thread is suspended when non-cygwin app is running. In addition,
> while master thread is running, console mode should not be changed.
> Therefore, the order of set_input_mode() call and disabling/enabling
> master thread is swapped.
> 
> Fixes: d2b14c303c04 ("Cygwin: console: Redesign handling of special keys.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/console.cc | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 45eff6efe..a5e6cd89d 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -439,6 +439,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
>   
>         if (con.disable_master_thread)
>   	{
> +	  con.master_thread_suspended = true;
>   	  cygwait (40);
>   	  continue;
>   	}
[...]

The only question I have for this patch is whether you need to set
     con.master_thread_suspended = false
right after the cygwait(40) call.  Can't tell if that's an omission or 
it's intentional to 'continue' into the main body of the function with 
that flag still true.

Other than that, LGTM.  OK to push.

..mark
