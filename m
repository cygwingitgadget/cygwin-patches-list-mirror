Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id D357B3846047
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 09:35:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D357B3846047
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9ZRc-1lMVgJ2FSW-005XMZ for <cygwin-patches@cygwin.com>; Mon, 08 Mar 2021
 10:35:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 090A2A8266C; Mon,  8 Mar 2021 10:35:11 +0100 (CET)
Date: Mon, 8 Mar 2021 10:35:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console, pty: Stop ignoring Ctrl-C by IGNBRK.
Message-ID: <YEXvzyCwLVWokfKs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210307014111.1065-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210307014111.1065-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:YAZVrOARQHcuvDSBdqEcWqx/BYt9Tqzwn+GUXHi7atn+NtIcIqK
 eWn5wQcCM3D3h/TYgdlJveLnVaDKB6Xj5JHGxAYY9Gk8ljP1BPYDaKN03Vrlg7IRMUkmpYl
 rR1v6Nepdu+Q2+l3uFR1w9eBF++0WkEORzbAZsrlVzBmKiw759y/XuNqVUsHptLQe9n2BOM
 RltD3LUtupLpnOl/mYgbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X8qUm/GSrR4=:8WW6nq9FfJ0eY5a7bShogh
 gKGj6EYTSipZGymsJUC7igmFEMl1e9XES5wsEl0oERVQmOKyf4fZLl5ApWuOHIByihgnW1Clx
 JS6l0WwIlo5elOxXrdGNhkxWhmiUnIzbkHHji3MeMFm6wnWYJjlytMj3cRBXD91qVJYXWN9PO
 dxaePcnvtXcx6y53BLTPSBH6rxaA8cBgQTlb1BjchJLMwKZ1jur2L2rhEPSEzFOUrapb5IBAk
 NEyMyyamuNlDc/m/5xbTepgQMGxGk3DgDi1iIyAunKUVfNlXH6kmuvpsdRNKzVxwb3gN5WWr6
 2FiEWi20l9wrI0gycay+PgQwcAfGPEojK9+MeR4v1BR5SWTDFzrqLgNfxHzw/hLhHwv4cR1vj
 ltS+6FEOKFc+IKW/D7VeTUyLhHlnEk7cc6d54FHxMT9ka0mxiewbW3+2VKdtptHGcInMe7zoz
 XI/hEmhKbdVceMF/m5ohcber5HYctj7EZ3MUZ0XHp3OZ/+YOmxFcnz62n8+f8JAgszp4uRv2F
 A==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 08 Mar 2021 09:35:26 -0000

On Mar  7 10:41, Takashi Yano via Cygwin-patches wrote:
> - Perhaps current code misunderstand meaning of the IGNBRK. As far
>   as I investigated, IGNBRK is concerned with break signal in serial
>   port but there is no evidence that it has effect to ignore Ctrl-C.
>   This patch stops ignoring Ctrl-C by IGNBRK for non-cygwin apps.
> ---
>  winsup/cygwin/fhandler_console.cc | 2 +-
>  winsup/cygwin/fhandler_tty.cc     | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Pushed.


Thanks,
Corinna
