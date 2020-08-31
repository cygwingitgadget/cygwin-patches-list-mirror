Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id C0DFD3857C4D
 for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020 10:12:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C0DFD3857C4D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mgvn9-1kn81614ZR-00hQju for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020
 12:12:17 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2ABDAA83A7D; Mon, 31 Aug 2020 12:12:15 +0200 (CEST)
Date: Mon, 31 Aug 2020 12:12:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v10] Cygwin: pty: Disable pseudo console if TERM does not
 have CSI6n.
Message-ID: <20200831101215.GX3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200831094854.725-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200831094854.725-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:ljYVngCIRysR8490XlxBrUmyVOZ1plirbHA0f7tX3vfHEVekbbx
 htKXp+XrbjyevrhGHOFlb8E3dP4zNTvMQt8A+dehwNWERVpHoBZD5GivheWw3uBFsxNiHvi
 ZxS/9v+WX23ZZVH0nNnrcA8/2YeIwd6fjd37gJt/L9hFP/zxqhgygG5mmsDJe6YUNBDiKxv
 CCwoFULaCLahHwxU5s5pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3d7h+ShpSJE=:xbwpd7r4YaG2fVUVc+GfKW
 1Ud0qn0UIakZAW3NRqVeoGKdNJaqBpGPgAo09h2ObfUzF8PvF0Yu/XF+/JeVGh856wVhr1zYD
 LI9S/n9HKkCsjGbxt9bmU/XqA565pxpQ+L3gjBK2mDP0i89f4Y6dfj2OwJ46pk92QUIHsfekZ
 70vOfB3IiFjnPA+rUjy/gPCajR9+P01L9Ln+wPMpWwMc+CJbK19mGcu6TgefLvGXxbvYS1MDo
 d3F/yOYO5c5oi2e+Lm+LE/aacKVt/3idpyJCe69IwwREexkBLeRzWmbACAwf1dQqXK5TrooSi
 2CTsvX24IiN/zxNmgHvuWDjyCh4rnUqINHn4+Emfrw1aM/pjG9Skw/pmYWhxmeytTC6P6WG+0
 idBn2dJ00A26cZ19TkdfM1QLWHcW2CWCqdXlb2fEDf5+H26OxvqIgF39GnURHRUJC9FN8EgSD
 ETyNQaXI5E1VTBP8YxrUi4TCzAlKECmjaw06YvSRZoGYcHtW7iSDtQI+A8KRg7ygdiu5xMTkm
 +CG4XBlxCzhiZIDUwTeheuVpZRuVjRr9WU9Plos9AM3LSNsN0ERzDqoSj8PD0NaKto6JPZG23
 AQ8Bsspe6nd8TAHOHXcyevGnEk9mHVT614rDlmxBh7/96kX3PuNIDli4gArOiH+edc3ip8aLo
 i2GYsf8tXwWX+qUW5bPO97yT2s4xUwXRMVeT0qjLRCYCtzQkMXk3yyZ6/dwB8PYU16pq/Atix
 /cORPM+8pKrHGS8r9bJ9MtTthr+X+HS+CYkqMcYyauoKkGZqydLnLCQXrs6GJWdrzDxuQqWfG
 yZdBHCTqEIFJeaxM4ENNkFDvR50Y61E1/VJ5pfa8N4tb3T0128h/JjthWSaJpJx1G2tnSMvf9
 G1Q1U0S8dPDK25NmzLFg==
X-Spam-Status: No, score=-100.5 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 31 Aug 2020 10:12:21 -0000

On Aug 31 18:48, Takashi Yano via Cygwin-patches wrote:
> - Pseudo console internally sends escape sequence CSI6n (query cursor
>   position) on startup of non-cygwin apps. If the terminal does not
>   support CSI6n, CreateProcess() hangs waiting for response. To prevent
>   hang, this patch disables pseudo console if the terminal does not
>   have CSI6n. This is checked on the first execution of non-cygwin
>   app using the following steps.
>     1) Check if the terminal support ANSI escape sequences by looking
>        into terminfo database. If terminfo has cursor_home (ESC [H),
>        the terminal is supposed to support ANSI escape sequences.
>     2) If the terminal supports ANSI escape sequneces, send CSI6n for
>        a test and wait for a responce for 40ms.
>     3) If there is a responce within 40ms, CSI6n is supposed to be
>        supported.
>   Also set-title capability is checked, and removes escape sequence
>   for setting window title if the terminal does not have the set-
>   title capability.
> ---
>  winsup/cygwin/fhandler.h      |   1 +
>  winsup/cygwin/fhandler_tty.cc | 235 ++++++++++++++++++++++++++++++----
>  winsup/cygwin/spawn.cc        |  18 ++-
>  winsup/cygwin/tty.cc          |   3 +
>  winsup/cygwin/tty.h           |   3 +
>  5 files changed, 230 insertions(+), 30 deletions(-)

Pushed with minor typo fixes (responce -> response, responced ->
responded).  A native english speaker will probably use different
expressions, like (not responded -> not acknowledged) or something,
but I think it's ok as is.

Thanks for your explanations in your other mail!


Corinna
