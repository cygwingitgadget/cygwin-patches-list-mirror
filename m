Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 8D9713850424
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 08:46:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8D9713850424
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MBll6-1kXBs01TFU-00C7ia for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020
 09:46:12 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DCA2CA80A56; Mon, 23 Nov 2020 09:46:11 +0100 (CET)
Date: Mon, 23 Nov 2020 09:46:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Further build cleanups
Message-ID: <20201123084611.GM303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201120140901.44474-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120140901.44474-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:vx9incxbouFwTSgoxHeDxNOgAcj5FAXPIx6o2+EBMBjDWyy2BUL
 fgNUR9PUjKhWc9nnWonf+ItxBDx/vJMSI4GZU2o5ighBhWcVJxxgjmKqwPOm0kuhjqySd3j
 XepUIVr/AyqHsbZjXf0X1Qjb/QqW9dhJdgrWfM9x3JZgoitzdLftcueR5tv3mPEaVe7kZ3K
 mHenl2rtuYWUVyipK+NjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:581wjd7wVjI=:teuuXYXpEfv1F+IC4Okc7s
 yRGS+AZHb2RPMq07Monn7/Psjuboo2Z3gGV4UX9KauZZKmjWYV4CSU+QXya+TCkc1j995xEXz
 8ztFlrdMowIQK/2oOuo2Mumzsuo9gcXe+LHemdAxuLezYU+lt/mRKMqrCZDkXYhcSeLbX9bGe
 294XpED0WtOVQehAPFDc/N187N1QB93IJyWMVFNNNHBflKClNE+v6i4huZQ+/iZeLsSeElg5Q
 I6ErjRi+EIgfyXMEczebm1raRTppCfwT/L9zuLrRKzsrLRaolSq1WpQ9RNdlgf9SBlpVUjiW+
 S/HWaPZY8Pt23dDbiZJ90Gvs0QWOlhGvegNXCoJJShO0LQ+tAIIlhjXczDgWZYiYQLGucyA+r
 vfQRMqVb/qD16a7g0zBs7s1LTNMXcBcPhiqZFO5NEKz0kY7sjpauV16pXPqBZ4d+tWzgnr4f8
 03siqRSkPQ==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 23 Nov 2020 08:46:14 -0000

On Nov 20 14:08, Jon Turney wrote:
> Jon Turney (3):
>   Drop libgmon.a build dependency on gcrt0.o
>   Use standard CXXFLAGS when compiling localtime_wrapper.c
>   Have cygmagic not create output if an error occurs
> 
>  winsup/cygwin/Makefile.in |  4 ++--
>  winsup/cygwin/cygmagic    | 17 ++++++++++++++---
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> -- 
> 2.29.2

GTG


Thanks,
Corinna
