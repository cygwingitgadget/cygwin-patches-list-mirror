Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 4A82D3858292
 for <cygwin-patches@cygwin.com>; Mon, 11 Jul 2022 07:45:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4A82D3858292
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdeKd-1nbCFF0Yb3-00Zi0N for <cygwin-patches@cygwin.com>; Mon, 11 Jul 2022
 09:45:44 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C124BA80751; Mon, 11 Jul 2022 09:45:43 +0200 (CEST)
Date: Mon, 11 Jul 2022 09:45:43 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: clipboard: Add workaround for setting clipboard
 failure.
Message-ID: <YsvVJ82sIBrYXSj3@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220708034151.1780-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220708034151.1780-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:8oJrSBt3eg8bosYQRzBSZxkCx3bGIRx1qAsa6HU6Lx6b9LZATlE
 4G6Ey+UIUbHyJibziVXOwB/7xu6dEieHeL+AQU+8HaqpGu0/ip7hVzSv8PRyXuuhF6W9xQD
 Y9TidRdfetHDFiCeDlOAwiXBP3yf4WbjH2atLMfPlLtQYpliWZFajDfzzYJWDi64fxbBejv
 j9BESmOGt1aLGEc6+twkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4VKvme6TXY8=:pA06JRj1T5EgePFl6ApxS5
 sa3uGjp2dxQF+e8v5i6oycjrUijNiuzBOEm8xFGZlN+KF93/AE08waQVhGBmvAUMY6Rd+f9fl
 2Z07VIsX04YusbMXvEnpSXvJbclJRPfq+AH0DYhgHQXN6qqbWoOFoD9OBfTh7ZCzW9HBdrVvQ
 pl2+opulLkajBolfxM3Hbq46a+aF0FMR0T/92s2+p3ZZRFG0bzQDUlhCnWv1EW1A9yZSHHIRM
 qyqe/9ZgX+EOOGTCgGSfy3lq9tUtOf9ScO2O0d7J1ynNqvey6SQ2O/6Xote5r4barPtosbmjX
 O15mTKTm6R4Yshyer6BCwx07H9jcYRkMy2n2MwGQQaCS1eyjEJj948XIuIta5OvlYQEj364PE
 O2TrSId0/MJu6lTomVn8WDIAZXfefG6p0aSH3GMDSn1U0oR5WRubGj3cSojs4WluOEzwyp3z1
 fKKyDk++JQFvj0RAhOsQTG8MDks+RYArWEas0Fd5AJFR/2gLhphhM276kiMRiAt2NXqnthe4N
 6hx138VhjGs7UFkIDTFc7WNLei/hvQSKH1ZdVfAgyX9AbWquFiEmmUDXGCdAoDQNCke1VoQ9J
 EGkRh41GVBxypZgZP8QQiGb5behN+XOHJcySmnCKv6kVcoQ10y3ugC/1V4VQsDymcvBwa/2gJ
 st6ANWSRoP68LfaXS06/14KnPDW6jR2jstlBAv22EGk11N0KJidDaV/hKhlqgwX43xXUm55iq
 mPrl/iAaxGTggYR9OQkEBsCUBjJmwmeu3Q2NzXn+Bm6/45Q2FOkUF7qIiM4=
X-Spam-Status: No, score=-95.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Mon, 11 Jul 2022 07:45:46 -0000

On Jul  8 12:41, Takashi Yano wrote:
> - OpenClipboard() just after CloseClipboard() sometimes fails. Due
>   to this, /dev/clipboard sometimes fails to set CF_UNICODETEXT
>   data. This patch add a workaround for this issue.
> ---
>  winsup/cygwin/fhandler_clipboard.cc | 47 +++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 13 deletions(-)

Yup, Looks good.


Thx,
Corinna
