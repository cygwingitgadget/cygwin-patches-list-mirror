Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 4089C386F46B
 for <cygwin-patches@cygwin.com>; Thu, 28 May 2020 07:27:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4089C386F46B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDyc8-1jlrvM1I3g-009z2Q for <cygwin-patches@cygwin.com>; Thu, 28 May 2020
 09:27:16 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9FD7FA80529; Thu, 28 May 2020 09:27:13 +0200 (CEST)
Date: Thu, 28 May 2020 09:27:13 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix a bug in free_attached_console().
Message-ID: <20200528072713.GN6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200528034305.243-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528034305.243-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:ZTILnsCnwgBnprsNF+UopB9kxIo3nV8bZQ7AME3+Jns9c3ASyta
 zMHAzRcWkoG57LaEAheF9e5yhevBq8uiWU6XhHL8D8mL3cAkLG2h0ed6VDHy957Aa7GSjYI
 jtiDy6O/Pn6Z5UqQCebYOHZl+E5+2NgGWjEkJH1S1QZzHffnPaoj8x8eiVbcAfbcVU1RjXO
 Pdytj4LqpESguiSxwA/8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JZn7AT+i6sc=:bN9C0NEF7PrF9cX+6uyODw
 yPTCorUqigtAiijL93MPXDaYt+A4L30r2vSrardQlRV/qU1avBNuISGSV1lgTSA7MTsNbqAbv
 mNR0ANeph0T8QpF5e4mKFNTkcMp72fh/37xXvXK6YeOvW64d/X0LgXF2GQ0bjJJSo3Kffgevh
 7afMwq1vGKheakyhJbKZT5RQb2bsBOKYExxdDe91rf1DK27KYrOrsNiYyGLp1PwFOWRPRYiI5
 /dQq+QVJ/jgp0YZZ2fyKzq3pnauvZGbuJTqhZ4WfvCt17HBs02umTZpykaf25UL587hdcyjv+
 J/CdlLrF5kxdrvdv2tCKSKLGZxinsGNsvCGyLJpEvQeZo3ZCkvicL2syV08jyayIoqFb5LoHV
 /V5PGOJWAcIzqaypamBFmWcTU4sEsiee/Q2HxvBaj65UGOuD4rfJSo7+LYBg8vzFHZhc2fOzG
 +D1W9tSHZDtDfzflXGa9TlFhg7+joX7ONehRm2aXshPaUyjceV79gHvNl7bvfYOrzLqEdZ1hy
 n9Gau/99ehbWQWNDVx1pFYy0cjboEadTH+MgW2EQKdamiJ7TRt1TgMbovIaT3O27TVx8qf1oB
 XWjtIHcqwDh5HmmAlrv7vFUfKp+fNjicHZgOG/QaEKMwNChUrWukV23Rgzz3j2pv2lToHbQRm
 uCmR2tcXlJK4bFdBthTZS2H3mMPeCI7GZHeThLl+VlLEQiGV9GBgrkrU24BcIg6r9/zb2zEay
 wOMJkuwdx7wo5tulAnsTo3NCAnAFi1qlze7A2gj+UcFUzkwlQ2RJDz3NmwEHEQvlrnOgzUZAB
 6eE8uMwxASaHw44vatVRp+9OQpHOy62E8X29CdORZCV5aSmii+x9yqci275zF4X+fSYLB/z
X-Spam-Status: No, score=-104.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 28 May 2020 07:27:19 -0000

On May 28 12:43, Takashi Yano via Cygwin-patches wrote:
> - After commit 7659ff0f5afd751f42485f2684c799c5f37b0fb9, nohup does
>   not work as expected. This patch fixes the issue.
> 
>   Addresses:
>   https://cygwin.com/pipermail/cygwin-developers/2020-May/011885.html
> ---
>  winsup/cygwin/fhandler_tty.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index df08dd20a..f29a2c214 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -188,7 +188,10 @@ set_ishybrid_and_switch_to_pcon (HANDLE h)
>  inline void
>  fhandler_pty_slave::free_attached_console ()
>  {
> -  if (freeconsole_on_close && get_minor () == pcon_attached_to)
> +  bool attached = get_ttyp () ?
> +    fhandler_console::get_console_process_id (get_helper_process_id (), true)
> +    : (get_minor () == pcon_attached_to);
> +  if (freeconsole_on_close && attached)
>      {
>        FreeConsole ();
>        pcon_attached_to = -1;
> -- 
> 2.26.2

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
