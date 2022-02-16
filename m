Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id BDD603858D3C
 for <cygwin-patches@cygwin.com>; Wed, 16 Feb 2022 10:43:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BDD603858D3C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNL2Y-1neYjL1o2U-00OqIV for <cygwin-patches@cygwin.com>; Wed, 16 Feb 2022
 11:43:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0BDC0A807A1; Wed, 16 Feb 2022 11:43:53 +0100 (CET)
Date: Wed, 16 Feb 2022 11:43:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: wincap: Add capabilities for Windows 11.
Message-ID: <YgzVaeCEKItAei3n@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220216094008.2087-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220216094008.2087-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:6AUfLMLUw17RyulqNzUoQdAuh8GnBTmogsiuQ1ALGAgM16Nr/TG
 Ue+gh/cYVUt226sBmMuGHe8LWrYlnuqGjDsy7CpD40rBhq228HrToGO2WCC3jj6mZovZeyI
 7C866+aEez9hdmMfEzukz4Y0GqVlOAjJOdsb4ar6EYVZXY+q302dNsWFdMwVopxb+S5ZPiV
 4+BWY9yP/fHhDbapN8BXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/NeC89jusgc=:nnTr7oepvCeS2nLLIbEbwM
 Ph5nk3BptjdK7I3DZZvFHU8ivR2Yr8jmoBMpuA/Bm1UEQHVu2+ujDCFWFXZes0zqXE5ZJKvZg
 3B4xZIC9Itnsjh6DUJnrRp6BlPkzETLWzFq44Z0e82FXjxbpiJhyTeo+mHdzk7gMtpwrddkek
 A+fXNahNUByX3l4c73iOGG1o8PTyEWJb+8KWbyZBd1Mb/OnPIeEcJQA0MaG76ri9TeZ4xqZ0T
 sjB71xBG7Q5RtheOG+KVDjTEyEbAdGK2y9IHJ+NwAnRNRSAEOUbbfYdNeQz2uKbDoNf+2Cf3y
 NQzXJb7udy0i2wZkAnmnuuqKn2JZOg2uV57JikAFC7eaQCqR7U7e35xZKOX/ksfVpKIEgzwzi
 TsqQi7bPWBrrBrgHxG0yrRoLZ9GL0L47LhjUtjPJb6C2shv4py1osm/b87N4DMWXxjNux2s/x
 QXgtCs91wY9G8KlI5Rtq88cJc5rUsN13otw/wUasEZAAZWYRrQZNT5zM13Bn0voguQgARHtXf
 a9CQCubQQoHEAeql3AhDTUrWt8a4frmFms+awGRAhOT5H4C2OkGBESxPgKw321Ii508YFTVyF
 3hqbY+Df6/dhaJw2m+KOXsh5nNAG47MwuPwXbrmXFDk6rd3wmfVqbsFDDixLYjZhh6CLhL8v8
 0L+wr4sG+eqZGNEVVORUawnOGWRuHQJu6HQzaZrYtIwtMNVP3tj63BQh+c8z4pr97TBRpqnMV
 Hp5sim4z35Pu/B3s
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 16 Feb 2022 10:43:56 -0000

On Feb 16 18:40, Takashi Yano wrote:
> - The capability changes since Windows 11 have been reflected in
>   wincap.cc. The capability has_con_broken_tabs is added, which is
>   false since Windows 11.
> ---
>  winsup/cygwin/wincap.cc | 47 ++++++++++++++++++++++++++++++++++++++++-
>  winsup/cygwin/wincap.h  |  2 ++
>  2 files changed, 48 insertions(+), 1 deletion(-)

Looks good!


Thx,
Corinna
