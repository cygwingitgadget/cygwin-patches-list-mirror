Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 5F949385702F
 for <cygwin-patches@cygwin.com>; Wed,  7 Jul 2021 11:41:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5F949385702F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MuUvS-1lAmBk0a4w-00rYHQ for <cygwin-patches@cygwin.com>; Wed, 07 Jul 2021
 13:41:14 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 223C7A8052E; Wed,  7 Jul 2021 13:41:13 +0200 (CEST)
Date: Wed, 7 Jul 2021 13:41:13 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: propagate font zoom via SIGWINCH
Message-ID: <YOWS2QU6HB7D7ZX2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9191991e-4c52-43f1-cd9e-6eaac9013f24@towo.net>
 <YORkHm5mUk1jfMtm@calimero.vinschen.de>
 <b0dba327-4e00-f681-fcbf-db0da3890b89@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0dba327-4e00-f681-fcbf-db0da3890b89@towo.net>
X-Provags-ID: V03:K1:5FfXwe3Wh35uF2SrVO5xb4xO/FR2GoZl9CdRvD5QTEQZk/gZsyq
 KRtKMQ283DN5GLLl06LUWQfxvN9s29yjJSAOtXW+dNCBhrkgMjuZNbLpmX3TggtxbBBcign
 0ciP6tGsiX/dZ+5nXveG9abaJDqLpNcO3uk52OSiOzARiDFz7Nvdm8eMqHShJn1u+znTLrH
 uNsbTqrCHHsQJVJsJHl0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4T9gM9t62F8=:MSCqD/rn0sMWevlrhv6Vg6
 XG+wn+qKxy8VrGAMR6JUfcQRP01CoA52bsvisFj9vYgET2LzJQqmGiDwm1MoMcLfGm3yibyix
 IAV2lhaIwWBjX1hGhntNnaOSodvKQsHb3PFEhOBy3triGFBX0XJsNjYqYwFswkYFovrecFCrp
 YEECmZywCT3uJN1Dbnnth7RDL+IE9WtQZ6Vtvk1JGvl9bNJ9Xs8kVcpMYneDPX7IbCuzvA8QY
 GPGzUfAVyhDtu5+Hze98QzPeQpKDTVp/+WpPlUlgMwmEvTGy3ZBj8BpTgDIICSK8+ejqZKSSV
 6xuFsJsfPwXiBOcOb8caFUcwiwOLB6waqDDa/kjximiY6XGSdlrEuonbPVpqnbzxteef5v4zb
 f6UMwJqUVcRW+fl1sT8ilwDDDHjvo3ujJCSWCxh2PVuQycUU/U0oR9AGGa7NLvynGqxSHfgtc
 lZ6vWV3P5LTEZX0TW6224ULOW/DXekY+dIq+o9+3Lb7/vQ7stWfjCosBaydVxkBITCRSIs8rf
 oLCU6arDZkBskXVin4GTWpWjCNSsW7peBMeairLlfiGE1tpDgbTfAGof3o5jM5zS1pGrOD7bj
 LbOq4XUKEFHL/Ny5yhnYJAOXtUp99feMKWLlGrgfTQVtzgGelok03VCTFba+r7PhPXAzB55HL
 SSn9qPRAapFamtgL5zPAWC7gf0ONbVahm6Zoa4fuPxlFiyAe3ZEPyjljHDA58t5BP/pTSm2I2
 V6cxkgO9IvulFN4Fu+CPO7H/1W7+VMvO+VMP0Fn7vgNRltzkCk5kg2ypzcqidrIyWoJbU2Xas
 le/XhiQv1n32Sx8GUgK4y+0ie5duF9ejrDqhmYJ1tQl94gG3gA8K+PhZBIH9SAxSHt+rziQCK
 mI9tySEXFQ6wZ7TWgCgw==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 07 Jul 2021 11:41:16 -0000

On Jul  7 11:43, Thomas Wolff wrote:
> Update with more elaborate commit comment, hopefully formatted properly.
> 
> Am 06.07.2021 um 16:09 schrieb Corinna Vinschen:
> > Hi Thomas,
> > 
> > On Jul  3 18:19, Thomas Wolff wrote:
> > > xterm 368 and mintty 3.5.1 implement a new feature to support notification
> > > of terminal scaling via font zooming also if the terminal text dimensions
> > > (rows/columns) stay unchanged, using ioctl(TIOCSWINSZ), raising SIGWINCH.
> > > This does not work in cygwin currently. The attached patch fixes that.
> > > Thomas
> > Can you please put the describing text into the commit message?
> > 
> > 
> > Thanks,
> > Corinna
> 

> Subject: [PATCH] tty/pty: support TIOCSWINSZ pixel-size-only change
>  notification
> 
> xterm 368 and mintty 3.5.1 implement a new feature to support 
> notification of terminal scaling via font zooming also if the terminal 
> text dimensions (rows/columns) stay unchanged, using 
> ioctl(TIOCSWINSZ), raising SIGWINCH;
> this patches cygwin to support that scenario
> 
> ---
>  winsup/cygwin/fhandler_tty.cc | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Pushed.

Thanks,
Corinna
