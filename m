Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 69365385481C
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 15:25:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 69365385481C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M26iv-1kekru0Sdd-002Vml for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020
 16:25:03 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 608F2A80BB6; Mon, 23 Nov 2020 16:25:02 +0100 (CET)
Date: Mon, 23 Nov 2020 16:25:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/3] Three pty fixes regarding pseudo console.
Message-ID: <20201123152502.GS303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201123110304.1368-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123110304.1368-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:1tl6vgbkOqQ8xDR6NNYdZqxSiI44VB+wYaaF5AgXrBLr67nlQz8
 AwZjrf7IhG+6sqQdatTQrI27P21neEO0+YSbAlTWgCbCm3dFFn7jAL3ZIJuJDJo2oCTCGbi
 fCBxB/pcHULfTacmE0IHeuWKXQS3im3vr1LV2eMXpg1Kx+J7Md17uojv8l6vetQ0we/tSbT
 pizWMUrSyLtK7bzJ68CWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vMZKutLAXZc=:saoVB3j6ibOOuo3xCv4j9M
 B9GcW7gXiWxoZswIJMm661VuU+KwZKzMPenDDHg70nTxaOniQcVrIPGePLm9jEGCSP1RCad9h
 sci4cKOtkiiFjCwnNZEr0ymvr/TWGT9Cj/DJpF1+mAJ7f3IG2guh7Id2uGxaBHPJgzdcKoMDi
 efRwcwsHDof1v7cUxrfyfRuoL3RgX5FVidd8yPomMu0qzWgYF6/CYqXPtdDQ9VpE3/LswZu+7
 PKiGXhqv5bJiF77GQ/YuqubtrRlQf/lvGGDBjPI5VBwr3SjT3jOV0Fbf/AZq2uAvs5hyie8to
 aPj+WrjR2Fp93grpxpz8dZ8I6yrqB9ZBWyOwU0FBv217L4ACukwU5WLFQtYPmmM7LUY+Kn7pk
 PiKF9eXyaHitXUXs/FcsFt1GQK2RWNsqBJUA68MPSqtRybK/FWn+D563A1x2VEL3szaLtSbAm
 GdCyKEsO3g==
X-Spam-Status: No, score=-100.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 23 Nov 2020 15:25:05 -0000

On Nov 23 20:03, Takashi Yano via Cygwin-patches wrote:
> Takashi Yano (3):
>   Cygwin: pty: Fix a bug in the code removing "CSI > Pm m".
>   Cygwin: pty: Discard "OSC Ps;? BEL/ST" in pseudo console output.
>   Cygwin: pty: Fix minor style issue.
> 
>  winsup/cygwin/fhandler_tty.cc | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> -- 
> 2.29.2

Pushed (with minor minor style issue reverted, i ++ --> i++.


Thanks,
Corinna
