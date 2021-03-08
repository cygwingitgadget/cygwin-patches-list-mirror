Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 08A013854801
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 09:35:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 08A013854801
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M890H-1lNszU0qPr-005Ez1 for <cygwin-patches@cygwin.com>; Mon, 08 Mar 2021
 10:35:03 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BE475A82677; Mon,  8 Mar 2021 10:35:02 +0100 (CET)
Date: Mon, 8 Mar 2021 10:35:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Discard input already accepted on interrupt.
Message-ID: <YEXvxgaGivK1aOKJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210305090150.1593-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305090150.1593-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:KuDF32oey8qTZ/wtzV8FGRlTIiOxCQtaNVPvxhzzDffXEat4PeL
 bqbCiBvwjjuUHxaNhciun81GbT2wwdVdPFRmA7rQn0/Ezo1q3Bp1Vp/TpMAIzdqhlv//m24
 lL8UZ+9Yg3uAkqTdRpGl8QBYJZARi7ewBG2BTSZxlSd5yNi0xKYmjhoL6tfT11hFY/7bCBb
 xXdQ12UdsIAWxrXKXnT7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DkaM2zilmrA=:XYk1Ik8NYtFoU6BWmnOBrV
 QXiN5gNU17wbfOHwlLWZy5AlsruGXjfWV2aQwwkjfVnPrYOGsFhnEiN0D4utUM2ZNAv+Z4TwH
 aMH1ubEa4oZVcMC+5clg9AyRUjkwPvfNwkSIyvRmZW4LYx3eqOESXMAOSbrrSz19mY/i0oDAR
 JfUduc4wCN4uRBDoVQpa1Gz6sVzByz+CAIueI6yFO6haCIUexX28eLLDaRX82azoztFcw2bEB
 csQ1KEjGIUvcdGj96hrRjNWerct6za6beEFySsgG2c8O/BRHtdFq4fFfuMqA/jndRx3uhJQa2
 1iE3LJkVRi2km9ytBqnqjizoPb2xYB+ccsvghpmXUhVRE8Yt8ATjXP09NLy2dqgZDTnuKqN02
 WabKvb6dVv5ARs8xNLHV9zOpiRICCn4gDq8tUF4bL+oR0fbxfCDFHVXhQeNPXkBfsnx79u32G
 X/BMW1doRQ==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 08 Mar 2021 09:35:12 -0000

On Mar  5 18:01, Takashi Yano via Cygwin-patches wrote:
> - Currently, input already accepted is not discarded on interrupt
>   by VINTR, VQUIT and VSUSP keys. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler.h          |  2 ++
>  winsup/cygwin/fhandler_termios.cc |  5 ++++-
>  winsup/cygwin/fhandler_tty.cc     | 23 +++++++++++++++++++++++
>  winsup/cygwin/tty.cc              |  1 +
>  winsup/cygwin/tty.h               |  1 +
>  5 files changed, 31 insertions(+), 1 deletion(-)

Pushed.


Thanks,
Corinna
