Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id A73DB385042E
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 10:08:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A73DB385042E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCska-1lDtvG3K7s-008shP for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021
 11:08:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4E57AA80D85; Thu, 28 Jan 2021 11:08:02 +0100 (CET)
Date: Thu, 28 Jan 2021 11:08:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_serial.cc: MARK and SPACE parity for serial port
Message-ID: <20210128100802.GW4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
X-Provags-ID: V03:K1:TMqS38yUPDcdrAJqnwT/K0HkfCFqNHbaPFjopUkCjvMc920UnZm
 5PA50ZM/e8rWDiftCcxcnG6lkM1KoX1AR2Qdj3Vgm+qh8ZqmpMHYEur80bXgwN3EN1OwUta
 Gx2UlYqAzhJ7Za8jfZ0OOyO9g8v5GSihCdhJw7rPyq2wcSog2Ni5pzInmdzPQvaoBn38Rh+
 aD/td3CLr54fuodtGM+0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CeDmnHQwNTw=:5pDEzjP523SLzRklG/UDHc
 oR3XSpLNg8VD/BqzGR4NJP7VluIPe5OgoOsH716PMxojeEWVGBbRXiKxgZVp3u9bzkLhq9/aa
 R3s9j3kBEBZKIfdjpxQrO3vSC5tHfEVgxjDV+8EU//g/W0xZnS/g5ftqyzXnRjTAuXOE5hxZS
 0/SO01t8mvnLk31GpjMZg1baxEOco9niKNmyN4v1Wm3A+qf7M5TIRhsAAHerq1rAHY0lEIQzf
 S06KV2oKQtdTyrCAYdRSCN+yl+/wBBOYGHKMp9AsPY5MOUtnubr+gZLeiKRUnf08uhXRwNlED
 ISFmZeIVTNiv6CyU3/JgjWidN/yoSC34gw1T3BVN7CpGXeyJcDuWUo4xu9CpDVy4PIGLgmT5Y
 TDh68Hn+M4brMDsUwzWlxB73o71gDsX/mq+44Ctjrc0Q5nZYch0mMbh6VNzv37NCJOuAnut7Q
 116Z+jKqug==
X-Spam-Status: No, score=-107.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Thu, 28 Jan 2021 10:08:07 -0000

Hi Marek,

thanks for the patch.  This is a patch adding functionality so it's not
trivial.  Would you mind to express your willingness to put this patch
as well as further patches under 2-clause BSD license per the
"Before you get started" section of https://cygwin.com/contrib.html?

A few minor problems with this patch.

First of all, your MUA apparently broke the inline patch.  There are
line breaks in the patch, unexpected by git am, and the spacing in the
termios.h hunk is all wrong, see below.

If you can't change that in your MUA, please attach your patches as
plain text attachements, that usually helps.

On Jan 27 21:30, Marek Smetana via Cygwin-patches wrote:
> Hi,
> 
> This patch add MARK and SPACE parity support to serial port
> 
> ---
>  winsup/cygwin/fhandler_serial.cc    | 9 ++++++++-
>  winsup/cygwin/include/sys/termios.h | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_serial.cc
> b/winsup/cygwin/fhandler_serial.cc

Wrong line break

> index fd5b45899..23d69eca5 100644
> --- a/winsup/cygwin/fhandler_serial.cc
> +++ b/winsup/cygwin/fhandler_serial.cc
> @@ -727,7 +727,10 @@ fhandler_serial::tcsetattr (int action, const struct
> termios *t)

Wrong line break

>    /* -------------- Set parity ------------------ */
> 
>    if (t->c_cflag & PARENB)
> -    state.Parity = (t->c_cflag & PARODD) ? ODDPARITY : EVENPARITY;
> +    if(t->c_cflag & CMSPAR)
> +      state.Parity = (t->c_cflag & PARODD) ? MARKPARITY : SPACEPARITY;
> +    else
> +      state.Parity = (t->c_cflag & PARODD) ? ODDPARITY : EVENPARITY;

Please put the nested if/else into curly braces so the potential
for later changes breaking the if/else chain is reduced.

>    else
>      state.Parity = NOPARITY;
> 
> @@ -1068,6 +1071,10 @@ fhandler_serial::tcgetattr (struct termios *t)
>      t->c_cflag |= (PARENB | PARODD);
>    if (state.Parity == EVENPARITY)
>      t->c_cflag |= PARENB;
> +  if (state.Parity == MARKPARITY)
> +    t->c_cflag |= (PARENB | PARODD | CMSPAR);
> +  if (state.Parity == SPACEPARITY)
> +    t->c_cflag |= (PARENB | CMSPAR);
> 
>    /* -------------- Parity errors ------------------ */
> 
> diff --git a/winsup/cygwin/include/sys/termios.h
> b/winsup/cygwin/include/sys/termios.h

Wrong line break

> index 17e8d83a3..933851c21 100644
> --- a/winsup/cygwin/include/sys/termios.h
> +++ b/winsup/cygwin/include/sys/termios.h
> @@ -185,6 +185,7 @@ POSIX commands */
>  #define PARODD 0x00200
>  #define HUPCL 0x00400
>  #define CLOCAL 0x00800
> +#define CMSPAR  0x40000000 /* Mark or space (stick) parity.  */

Spacing here is completely off, probably due to your MUA.  Please note
that every definition is followed by a TAB and a SPACE for historical
reasons.  Ideally you do the same for the new CMSPAR definition.

> 
>  /* Extended baud rates above 37K. */
>  #define CBAUDEX 0x0100f
> 
> ---

Other than these minor formatting issues, your patch looks good,
so I'm looking forward to the fixed version.


Thanks,
Corinna
