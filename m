Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 0E2113851C0A
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 13:28:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0E2113851C0A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfqCF-1j804N3ZTV-00gF3s for <cygwin-patches@cygwin.com>; Tue, 19 May 2020
 15:28:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4209AA80F7E; Tue, 19 May 2020 15:28:06 +0200 (CEST)
Date: Tue, 19 May 2020 15:28:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Call FreeConsole() only if attached to
 current pty.
Message-ID: <20200519132806.GX3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200519105523.1620-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200519105523.1620-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:xUPHQ6W67m8ES0V1gDu4W/rknAj98/kCaMeW5/jUSWtdFNn6WFL
 a59GJeEU+v5qkVQ5CcUs3zDndmDNK3byMDBsVHU33jI4JZ4/ySFq2s2YhkTy/kRe5XTHyAp
 7zL3daPU63ucPhnzusfB8V8H8+e2GoodUMb6JH8cAE212dqg311tQixo+EIGrBHeAvepDQL
 PvEYTY8TI3yiqEPtNQIUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+LTLbL/dvJ8=:KbDCZFCPOYYMUJvd4zEcZN
 r+SudFdiFuCXfu3gPzpgCFSP/rqykwv9j54lqSRETAson1DTGASlOAbqlt4vNZiSSQxdrdCgr
 XhYnsQpAdpjfcyI8CktBsgijP3/Kf8JhCWRXONoTOCrBmx8Zejml49PasdmfH22F9bqmnaFw1
 DIokk1lP0SOO3l8V8nZbvsCR7+7gRdtt/sUQrASTXgdFgxoYh78csIw6an8vN0ApHXktxRI8M
 jRGmn4JQHQCvTna8hjOK/fnspW/q4t0fPQ5EVteWKbQ5m0xy8AK/dTS342KyKgigoSAVSad27
 81TzV984DEM4dpIpiPmQWzs0iljgsAriK17Ag3K2sJmFDHCT35MjQxFbKUf6Er6d51ghWku5M
 jXqrwzZGhQirbvnfU4EgRMeresRYYjFfg+rZ4QTBPhsuZ9W+LAmcsiyHaqSUiRS1iG4wUhhS7
 wU6KTLrdThrdSaELqJTIlMtjQujbBvktFruaTrRFpAwSYHCsMdfTwPAPfuWtU1tUwgCkMwy4B
 GzkypT+XaeItfTs+BtbCClhpKj4/4W9fDHq5ESY2Hy51yPTRoIKZ9YHY7NQc+8/PJjzOjyp7W
 3XU3SUXBQj34C6ap8bQIwY8m8Bzm3WQ9jiSpjqzolD+KwaVhymjlxxofKUGe8syIozhm2Z5xU
 DfuJLc7Q1yh5prqegFDLhNIWyXx/lifChTmjiPvKJBZ91lOwduG5OdA1jIXC0QuHFY+O+JoMx
 MDweqIKj6WdI4NZY9OBLovSAH/OYZnrdo/s0O1GTUeAqOqPcusy0t2uqpk6FQMVYb4fA7E7Dp
 vJVF438n78YUe3NP9YJLiuyizpTjw6f+BtVnoUJjCESqEJMgmz7p5K0HBwZ/TcVkCVQn4nm
X-Spam-Status: No, score=-98.5 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 19 May 2020 13:28:09 -0000

On May 19 19:55, Takashi Yano via Cygwin-patches wrote:
> - After commit 071b8e0cbd4be33449c12bb0d58f514ed8ef893c, the problem
>   reported in https://cygwin.com/pipermail/cygwin/2020-May/244873.html
>   occurs. This is due to freeing console device accidentally rather
>   than pseudo console. This patch makes sure to call FreeConsole()
>   only if the process is attached to the pseudo console of the current
>   pty.
> ---
>  winsup/cygwin/fhandler.h      |  1 +
>  winsup/cygwin/fhandler_tty.cc | 28 +++++++++++++---------------
>  2 files changed, 14 insertions(+), 15 deletions(-)

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
