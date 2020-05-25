Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id C7DEE388E825
 for <cygwin-patches@cygwin.com>; Mon, 25 May 2020 09:03:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C7DEE388E825
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MV2Sk-1jV0Jm2b7m-00S4gw for <cygwin-patches@cygwin.com>; Mon, 25 May 2020
 11:03:32 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EB3F9A80FF5; Mon, 25 May 2020 11:03:29 +0200 (CEST)
Date: Mon, 25 May 2020 11:03:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Stop counting number of slaves attached to
 pseudo console.
Message-ID: <20200525090329.GC6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200525084908.980-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525084908.980-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:vkGMOrM44En2rFVlpKMZ++WhFCDGaHyOoeYwCO5bTh0MN7zeNLQ
 M+BgwC2S9J9KUBk8LXqpJswEN7z1F+ItrNM91mkNGNbNa/5mAAJgx3utS4i5kZNUAxxF4A7
 73RSJw8I9xKHtQy9DUSmhDS8K6KGRwEfU+zoIWmfUYHZ7XWfzRm/slow3qBYqd0QvZWPLpM
 eMykJ9qGa9vAPJHfik9ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uLDt8pQ1VuE=:TjS7RXHJiOVQTXYJdcGidh
 TE8GdkFqOxyaaEguNsi/J3HJvIOVCIhXeGNmt3nzPpme7eP1cfKXYU5e89mK371z+edohD/A/
 ygI0Y4evlErc62hLpkPijPiGKUeI1w8tSf00/ad9JU++xz9BFsqtEnHx4mP2GumnaL2MJA/1H
 y5t57+4TEY5TTA5v+QajDiiVMmFx+as+4WluWXM+x4bwaClXcQwO+KUVkmevoKCzK7rPBodXG
 BevirhzLT0PZSQK2OdJD+lKJx4y8EpkRW7T8euCEpbxSz6hqJtweFnAHSyIVaj2tseszxhaeW
 tBfNnPRBySHF9lX2K7oGMO+FMNB2xUvzCf7LlTwFrp07M/CXYM3SiacB96bXWqW5d80N3dQjq
 mh/SKa7giyJswdyeuqxtMC387Nu0RhGtNoNgionrnaxqRvXAhukma4iYWkkaoPNsmUXcTF1Rs
 ln2VFM/tTpMAi5L/RzpIN7IeJAlad6kMhiFqsXx0fHlS1w/0j04M2l4qmxnWb1mIkATl6MRNN
 M3/p/HEWzx6q3D6xFAYGZCscTDAybOmVagXQL5Fd6a2O0uf87ffPzC0VrBjDFFytpI5rSn+N8
 lhdPFx84/Wte0SfeVM2PrfIBhky6vB8/S1+qgMpq6qRW6xDoQ/GVsP0UIZew59QvqkKiE6W0D
 404ReGX2vi57dh9fheEvgG7KzGsWvnlc1zLwtLItE66JX27/DEl1zf9VAV9iDiumGCh7nzEWA
 3nRnktgTb+3j1/iv7d/Mf9Rmr+FmymR3Yc7NgVaGkoSE1ExRNXhIHfQMebsIhX0zXb8hFK7C2
 WM44UWAqakSArj5wA3Ek3GcAoqKR0SUKEP11DyPXXdQGbyKXdcjp63cEX+Haq/bxiJzewUt
X-Spam-Status: No, score=-98.7 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 25 May 2020 09:03:35 -0000

On May 25 17:49, Takashi Yano via Cygwin-patches wrote:
> - The number of slaves attached to pseudo console is used only for
>   triggering redraw screen. Counting was not only needless, but also
>   did not work as expected. This patch removes the code for counting.
> ---
>  winsup/cygwin/fhandler_tty.cc | 22 +++++-----------------
>  winsup/cygwin/tty.cc          |  3 +--
>  winsup/cygwin/tty.h           |  1 -
>  3 files changed, 6 insertions(+), 20 deletions(-)

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
