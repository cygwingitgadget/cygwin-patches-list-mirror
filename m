Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 32383394BE3A
 for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021 12:06:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 32383394BE3A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M3DaN-1lAoE73B89-003guX for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021
 13:06:22 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B9C1BA805E2; Mon, 15 Feb 2021 13:06:21 +0100 (CET)
Date: Mon, 15 Feb 2021 13:06:21 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix a bug in input transfer for GDB.
Message-ID: <20210215120621.GM4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210214184752.716-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210214184752.716-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:RY9HAkqxJTnqhqepG6pjOdNrZJywBObm/0H7YtLrHDFQSg5TKUm
 HcfTiwZ4zilRz57rRq9Aqul3baRgAUT5Jz8QqtqJnjh5G4/9Yl60ql7CVVZXAeu3dyAXcwk
 JZRoXv4UnBipAdyPHTnTQOTPPFbVXJyMAUmwYK95/c0DtLrqauC5kZJjchGdxAXvMl+7FHY
 yUJ9hBxdN9j4GulzHWODA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e3X89TGRNVg=:UsJ//hV2qgwtx2EuncwoV+
 dXTH5SSBo0d99oNYBs58sh+qwO9fpvZXotduns4QzuEMrZQtdL3G2BZqNxVlP9db3lgkBw1ni
 TK/LuREjzvJYaD55nXCedK6ly5ERXLUek7ffz8naPR0f7otMW3UnqqPBJjG4C7EV2bENXYAFE
 kVKAyLip8sYAwVp+UcskZ6hkjuWGpSPstfl+kFbHFIII/O/pAXidg4wXOFmjYx4DaowLI4mCW
 QxAAkO4Yk/NVG00MROuhGYdK3FiT9OEFzlxCpXNCNjuVsSjrTyZw3Z1R0U+FI5yyy96P2idUa
 +0joHsWjqu2veT2JqejKoD8Pm6XGZs2HS2hIr3+lbrQgQ9AJT1AxbLN0bFZmJfzC9GbJBEzpQ
 6P91ZtKOBbB3nlJ+IwM4k27Tbqe4PfM9BVtViguxF3F7hMjD0rBL3wOC1RXcGiNl8NEzRZL9C
 YMON89HbHw==
X-Spam-Status: No, score=-107.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 15 Feb 2021 12:06:25 -0000

On Feb 15 03:47, Takashi Yano via Cygwin-patches wrote:
> - With this patch, not only NL but also CR is treated as a line end
>   in the code checking if input transfer is necessary.
> ---
>  winsup/cygwin/fhandler_tty.cc | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index f6eb3ae4d..5afede859 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1181,7 +1181,7 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
>    /* In GDB, transfer input based on setpgid() does not work because
>       GDB may not set terminal process group properly. Therefore,
>       transfer input here if isHybrid is set. */
> -  if (get_ttyp ()->switch_to_pcon_in && !!masked != mask && xfer && isHybrid)
> +  if (isHybrid && !!masked != mask && xfer)
>      {
>        if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
>  	{
> @@ -1471,7 +1471,8 @@ wait_retry:
>  out:
>    termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
>    len = (size_t) totalread;
> -  mask_switch_to_pcon_in (false, totalread > 0 && ptr0[totalread - 1] == '\n');
> +  bool saw_eol = totalread > 0 && strchr ("\r\n", ptr0[totalread -1]);
> +  mask_switch_to_pcon_in (false, saw_eol);
>  }
>  
>  int
> -- 
> 2.30.0

Pushed.


Thanks,
Corinna
