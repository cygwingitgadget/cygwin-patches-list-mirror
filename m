Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id C6E3D3857436
 for <cygwin-patches@cygwin.com>; Wed,  7 Jul 2021 08:47:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C6E3D3857436
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCKO2-1lslTr2UmQ-009Rs0 for <cygwin-patches@cygwin.com>; Wed, 07 Jul 2021
 10:47:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id ACA9BA80D3E; Wed,  7 Jul 2021 10:47:48 +0200 (CEST)
Date: Wed, 7 Jul 2021 10:47:48 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
Message-ID: <YOVqNEsazee7/U5V@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
 <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
 <alpine.BSO.2.21.2106031321380.30039@resin.csoft.net>
 <alpine.BSO.2.21.2106031355540.30039@resin.csoft.net>
 <YORvS4cn1fQX3O70@calimero.vinschen.de>
 <alpine.BSO.2.21.2107061038250.56404@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2107061038250.56404@resin.csoft.net>
X-Provags-ID: V03:K1:rqRW2Yp6YeL3It3DsPhMArjUCbfNaZUgHx4xXDfR983VR5q321a
 CYgR1byOCIJBdaDonPq2iCC9uLIZmZrHkDCOlavHfvnpUCrfvyVNEhaGEIRc9MPPQhJehYN
 /tI88FFVyc9O2Ci0UWt9HAEXiMQNdPX4yu+r88EhG90SZp1+oeAwfD/GJun9KPQMyIO5haK
 2GJ1XunVVOhau1st1OpdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zDsYF0Y64IY=:fP2fXrNl16rbIos0YUZUvA
 rpV0iRFZUWF7/pOjKA2CX/smgJMlbizfvPwcxwDdgx9vZeKoicLIhddY1fuE2DTC/IKLSwGpR
 PgmkCfYmpd+NQP48PjGsYii1MQwJD1Ss6nSzqsBRqMifXSruMICcMp/EHqElZ6LLDds5WY8+W
 FD95QsQG7+sNadyLo31M6m67zYCI8RoqAP9dZYzV0/YsRTfB/1PK48/xXY0M85HVklVZE/6+t
 x/Ekx+JXrmKIzO1JAA5WPuE5AJb4TU4fLE0o1ZHt26tnx2Up5e+7mDJ9V76vEY0pmD3CtuC2n
 gFcqCeENNu9LqC+WJ81i/H+afJLpFKk+e6Od5HuOSV66Iz36F92t+EdCg8fBSFWiMnpSyK2I8
 6zDvdRBhe2YgLTplmYHUNfUwiMnP27iugATrV8jwbO+Hn0P5YqivRhuF5E9fg/wzvxZTTZJZ5
 +ccn6TDWsdqe8z135sK6taIvZF1Fz8cU3IjHIN8fgcASXxrDe2lHFBaIXtq3qvtWnNbw7QldA
 18sCbozrk8EQvqKTFp/Wh6KuSE591183/iwD5r6BBQxjFaQe5WvCO13X7+Tad60GGLe3CkZYL
 93CFqkZv7XhlPi6KKBqkkZn9i/ETJBbpl3d0AgYBunmdzsFcucbEzlToYUxn7myjsMphImNNx
 X5L19tldktp08J1UMMRiDZBIkrg2FZnx4XheET6LLutHt4xrT0Zlcd2tAz0Zljxbm8eJGg1dO
 +ZIeNpZK7+v2yg96ogl4OgUjxDkeSTHvrpNuxHVJMU67CCASWZvx9O7VDgIXdj9WBpg0Vk5Tb
 R1a5SYkiNkU3wDZ5XzKCdIcaK3X9wk6HKMYjyTPoPZneZFd5yyMvi1xQiVG/ahXwtdH12KjnZ
 qK+2l2/RIYLVRkhpikBg==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 07 Jul 2021 08:47:55 -0000

On Jul  6 10:40, Jeremy Drake via Cygwin-patches wrote:
> The new GetFinalPathNameW handling for native symlinks in inner path
> components is disabled if caller doesn't want to follow symlinks, or
> doesn't want to follow reparse points.
> ---
>  winsup/cygwin/path.cc | 88 ++++++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 43 deletions(-)

Pushed.


Thanks,
Corinna
