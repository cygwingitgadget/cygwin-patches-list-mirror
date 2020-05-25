Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id E51B5388E825
 for <cygwin-patches@cygwin.com>; Mon, 25 May 2020 09:00:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E51B5388E825
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMWcT-1jLtTM3H8h-00Jb6U for <cygwin-patches@cygwin.com>; Mon, 25 May 2020
 11:00:55 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 18083A80FF6; Mon, 25 May 2020 11:00:55 +0200 (CEST)
Date: Mon, 25 May 2020 11:00:55 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Revise code to make system_printf() work
 after close.
Message-ID: <20200525090055.GB6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200521082501.1324-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200521082501.1324-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:CR7zZasSmmqqMoAalttGG8F9ii0KR4WV+6OVzXWsTSuM6hTNWaY
 kKDXQuFCVJYlC6V1nuGSjdYJn5VifrGhmp+wbm35Nwqo/G8/4eJHCzxiOqZzx9vq54wA75f
 TwDGP9jzAagb/PbAb9+7DzGwo5uQdZ23rIX9As6eGmRC6zceZGigIMCSNDOQ3/Pw+hQywFL
 ZforypPXa5RmaHwrNI4lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JHv2YgP/kgw=:fFp/Jt1QVAP4psT3VypMlO
 19O1Jn7HDvyqbK3+JgXD/HHlZpcb0JBqHzOLXVjNdRfQUyJnnCA0Tu1VRfPEUf8SbcuQFCCxp
 AG96mOxDdbBIlHzfxdptDqtXV7dn6nig8VKKzXYcTC6otTiN657NLEY1ERYDPhJ+aQcSDWD2y
 nnRHLRFZ5MeHPcZtnvyiXB3l0Vj2NpS/B2J04H1tScfbFR+Pbehe0cNTLv78tBsW7SybLnUdS
 qCP+BQp3zlO3Wwx6xlVcxZ002erGc8cFLHA/vwvDPl2xwalMyTCNhBl5p8HVh1W2fEyIdisPO
 JsOlAEiiEiKFnB/lrIjManjffj1DtKcR27v8ka7Hbtzya3zpHFj5Gj15RZvD9om9026If38dv
 50+pt0KE+d5l7q0e5wHS/guA/IpMYec4EbpPOwyUSXCg/ign5hy6dP6Kzra/WoMC04Wo3oOTW
 lz8Yh86BUGkI3cDmx/gHgRaC1rf/P7f1GRUlCn9m4A3SqX0ZHG04vvQ81tPoDVAQwmYgOX2zy
 xeEBmvYoDOh3Uzqy87AdeCN1RFsfZ7eFX0NkDs6gwqkkFZ7Y9VJ3dZFOaTXt/3WLBpLvlCj9l
 38xXuVT2AmXX3Mi8VICIc9dt1bq6aBqDwO2jCWa+2sXde2KYTD+J1wori7VUr6aSjFSagkxMx
 ZY3CaZBGNRn0m30fYFJOPdNUHhu2DZDqqoRUKuXZfCVt/t7WzTJf4a38iLhFNhPQwYKDB2PYv
 lo4UnjR0a3Ic354pUrkrEnG57MD8QO7AEnCFdR96hOTRzm5ywdjJ4pFymaip57aYUkVsPnCDb
 sLV3tPmDKAEKW7xz+xv4GfuA4TmP304JsNshjhcMqLgP9LT5Usnq10UuaEUkLGe3IoMW7ss
X-Spam-Status: No, score=-98.4 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 25 May 2020 09:00:58 -0000

On May 21 17:25, Takashi Yano via Cygwin-patches wrote:
> - After commit 0365031ce1347600d854a23f30f1355745a1765c, the issue
>   https://cygwin.com/pipermail/cygwin-patches/2020q2/010259.html
>   occurs. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 15 ++++++++++++---
>  winsup/cygwin/tty.cc          | 23 +++++++++++++++++++++++
>  winsup/cygwin/tty.h           |  2 ++
>  3 files changed, 37 insertions(+), 3 deletions(-)

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
