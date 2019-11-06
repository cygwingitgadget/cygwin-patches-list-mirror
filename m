Return-Path: <cygwin-patches-return-9805-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108169 invoked by alias); 6 Nov 2019 15:07:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108160 invoked by uid 89); 6 Nov 2019 15:07:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=apps, dim, hts, initc
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Nov 2019 15:06:58 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id SMtbixk23RnrKSMtcil1Kx; Wed, 06 Nov 2019 08:06:56 -0700
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Cygwin: console, pty: Prevent error in legacy console mode.
To: cygwin-patches@cygwin.com
References: <20191106115909.429-1-takashi.yano@nifty.ne.jp>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <70126295-3dc8-7d1c-75ba-e5d60fe60b3e@SystematicSw.ab.ca>
Date: Wed, 06 Nov 2019 15:07:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106115909.429-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00076.txt.bz2

On 2019-11-06 04:59, Takashi Yano wrote:
> ---
>  winsup/cygwin/fhandler.h          |  1 +
>  winsup/cygwin/fhandler_console.cc | 45 ++++++++++++++++++++-----------
>  winsup/cygwin/fhandler_tty.cc     | 13 +++++++++
>  3 files changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index d5aa57300..313172ec5 100644

> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 241759203..79fa00bdb 100644

>        /* Enable xterm compatible mode in output */
>        GetConsoleMode (get_output_handle (), &dwMode);
>        dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
> -      SetConsoleMode (get_output_handle (), dwMode);

Nit:

> +      if (!SetConsoleMode (get_output_handle (), dwMode))
> +	con.is_legacy = true;
> +      else
> +	con.is_legacy = false;

prefer direct result:

> +      con.is_legacy = !SetConsoleMode (get_output_handle (), dwMode);

Beef:

> +      if (con.is_legacy)
> +	setenv ("TERM", "cygwin", 1);
>      }

handlers should not be changing user's env vars: that is the user's selection to
get their preferred operation in their apps.

If you need to set TERM, shouldn't you also set it appropriately for non-legacy
console?

Perhaps it may be set as a default, only if it is not already set by the user.

There are a lot of **un**settings in cygwin compared to my TERM:

$ infocmp -Id $TERM cygwin
comparing xterm-256color to cygwin.
    comparing booleans.
        bce: T:F.
        OTbs: T:F.
        ccc: T:F.
        xenl: T:F.
        km: T:F.
        hs: F:T.
        npc: T:F.
        mc5i: T:F.
        xon: F:T.
    comparing numbers.
        cols: 80, NULL.
        lines: 24, NULL.
        colors: 256, 8.
        pairs: 65536, 64.
    comparing strings.
        acsc: '``aaffggiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~',
'+\020\,\021-\030.^Y0\333`\004a\261f\370g\361h\260j\331k\277l\332m\300n\305o~p\304q\304r\304s_t\303u\264v\301w\302x\263y\363z\362{\343|\330}\234~\376'.
        cbt: '\E[Z', NULL.
        csr: '\E[%i%p1%d;%p2%dr', NULL.
        tbc: '\E[3g', NULL.
        mgc: '\E[?69l', NULL.
        clear: '\E[H\E[2J', '\E[H\E[J'.
        cud1: '\n', '\E[B'.
        civis: '\E[?25l', NULL.
        cnorm: '\E[?12l\E[?25h', NULL.
        cvvis: '\E[?12;25h', NULL.
        smacs: '\E(0', '\E[11m'.
        smam: '\E[?7h', NULL.
        blink: '\E[5m', NULL.
        smcup: '\E[?1049h\E[22;0;0t', '\E7\E[?47h'.
        dim: '\E[2m', NULL.
        sitm: '\E[3m', NULL.
        smpch: NULL, '\E[11m'.
        ech: '\E[%p1%dX', NULL.
        rmacs: '\E(B', '\E[10m'.
        rmam: '\E[?7l', NULL.
        sgr0: '\E(B\E[m', '\E[0;10m'.
        rmcup: '\E[?1049l\E[23;0;0t', '\E[2J\E[?47l\E8'.
        ritm: '\E[23m', NULL.
        rmpch: NULL, '\E[10m'.
        flash: '\E[?5h$<100/>\E[?5l', NULL.
        fsl: NULL, '^G'.
        is2: '\E[!p\E[?3;4l\E[4l\E>', NULL.
        initc:
'\E]4;%p1%d;rgb\:%p2%{255}%*%{1000}%/%2.2X/%p3%{255}%*%{1000}%/%2.2X/%p4%{255}%*%{1000}%/%2.2X\E\\',
NULL.
        ich1: NULL, '\E[@'.
        ka1: '\EOw', NULL.
        ka3: '\EOy', NULL.
        kb2: '\EOu', '\E[G'.
        kcbt: '\E[Z', NULL.
        kc1: '\EOq', NULL.
        kc3: '\EOs', NULL.
        kcud1: '\EOB', '\E[B'.
        kend: '\EOF', '\E[4~'.
        kent: '\EOM', NULL.
        kf1: '\EOP', '\E[[A'.
        kf13: '\E[1;2P', '\E[25~'.
        kf14: '\E[1;2Q', '\E[26~'.
        kf15: '\E[1;2R', '\E[28~'.
        kf16: '\E[1;2S', '\E[29~'.
        kf17: '\E[15;2~', '\E[31~'.
        kf18: '\E[17;2~', '\E[32~'.
        kf19: '\E[18;2~', '\E[33~'.
        kf2: '\EOQ', '\E[[B'.
        kf20: '\E[19;2~', '\E[34~'.
        kf21: '\E[20;2~', NULL.
        kf22: '\E[21;2~', NULL.
        kf23: '\E[23;2~', NULL.
        kf24: '\E[24;2~', NULL.
        kf25: '\E[1;5P', NULL.
        kf26: '\E[1;5Q', NULL.
        kf27: '\E[1;5R', NULL.
        kf28: '\E[1;5S', NULL.
        kf29: '\E[15;5~', NULL.
        kf3: '\EOR', '\E[[C'.
        kf30: '\E[17;5~', NULL.
        kf31: '\E[18;5~', NULL.
        kf32: '\E[19;5~', NULL.
        kf33: '\E[20;5~', NULL.
        kf34: '\E[21;5~', NULL.
        kf35: '\E[23;5~', NULL.
        kf36: '\E[24;5~', NULL.
        kf37: '\E[1;6P', NULL.
        kf38: '\E[1;6Q', NULL.
        kf39: '\E[1;6R', NULL.
        kf4: '\EOS', '\E[[D'.
        kf40: '\E[1;6S', NULL.
        kf41: '\E[15;6~', NULL.
        kf42: '\E[17;6~', NULL.
        kf43: '\E[18;6~', NULL.
        kf44: '\E[19;6~', NULL.
        kf45: '\E[20;6~', NULL.
        kf46: '\E[21;6~', NULL.
        kf47: '\E[23;6~', NULL.
        kf48: '\E[24;6~', NULL.
        kf49: '\E[1;3P', NULL.
        kf5: '\E[15~', '\E[[E'.
        kf50: '\E[1;3Q', NULL.
        kf51: '\E[1;3R', NULL.
        kf52: '\E[1;3S', NULL.
        kf53: '\E[15;3~', NULL.
        kf54: '\E[17;3~', NULL.
        kf55: '\E[18;3~', NULL.
        kf56: '\E[19;3~', NULL.
        kf57: '\E[20;3~', NULL.
        kf58: '\E[21;3~', NULL.
        kf59: '\E[23;3~', NULL.
        kf60: '\E[24;3~', NULL.
        kf61: '\E[1;4P', NULL.
        kf62: '\E[1;4Q', NULL.
        kf63: '\E[1;4R', NULL.
        khome: '\EOH', '\E[1~'.
        kcub1: '\EOD', '\E[D'.
        kmous: '\E[<', NULL.
        kcuf1: '\EOC', '\E[C'.
        kDC: '\E[3;2~', NULL.
        kEND: '\E[1;2F', NULL.
        kind: '\E[1;2B', NULL.
        kHOM: '\E[1;2H', NULL.
        kIC: '\E[2;2~', NULL.
        kLFT: '\E[1;2D', NULL.
        kNXT: '\E[6;2~', NULL.
        kPRV: '\E[5;2~', NULL.
        kri: '\E[1;2A', NULL.
        kRIT: '\E[1;2C', NULL.
        kspd: NULL, '^Z'.
        kcuu1: '\EOA', '\E[A'.
        rmkx: '\E[?1l\E>', NULL.
        smkx: '\E[?1h\E=', NULL.
        rmm: '\E[?1034l', NULL.
        smm: '\E[?1034h', NULL.
        nel: NULL, '\r\n'.
        oc: '\E]104\007', NULL.
        indn: '\E[%p1%dS', NULL.
        rin: '\E[%p1%dT', NULL.
        mc0: '\E[i', NULL.
        mc4: '\E[4i', NULL.
        mc5: '\E[5i', NULL.
        rep: '%p1%c\E[%p2%{1}%-%db', NULL.
        rs1: '\Ec\E]104\007', '\Ec\E]R'.
        rs2: '\E[!p\E[?3;4l\E[4l\E>', NULL.
        setab:
'\E[%?%p1%{8}%<%t4%p1%d%e%p1%{16}%<%t10%p1%{8}%-%d%e48;5;%p1%d%;m', '\E[4%p1%dm'.
        setaf:
'\E[%?%p1%{8}%<%t3%p1%d%e%p1%{16}%<%t9%p1%{8}%-%d%e38;5;%p1%d%;m', '\E[3%p1%dm'.
        sgr:
'%?%p9%t\E(0%e\E(B%;\E[0%?%p6%t;1%;%?%p5%t;2%;%?%p2%t;4%;%?%p1%p3%|%t;7%;%?%p4%t;5%;%?%p7%t;8%;m',
'\E[0;10%?%p1%t;7%;%?%p2%t;4%;%?%p3%t;7%;%?%p6%t;1%;%?%p7%t;8%;%?%p9%t;11%;m'.
        smglr: '\E[?69h\E[%i%p1%d;%p2%ds', NULL.
        hts: '\EH', NULL.
        tsl: NULL, '\E];'.
        u8: '\E[?%[;0123456789]c', '\E[?6c'.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
