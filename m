Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 477DB394D8AB
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 09:50:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 477DB394D8AB
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mdvyo-1lZZPW3tRu-00b4S4 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021
 10:50:44 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 874D7A80D4C; Wed, 20 Jan 2021 10:50:43 +0100 (CET)
Date: Wed, 20 Jan 2021 10:50:43 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix "Bad file descriptor" error in
 script command.
Message-ID: <20210120095043.GS59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210120091620.814-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120091620.814-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:31CHMCif1+jlGUACMIJ0LG0BLKuAPa+b70ligrah1XF2hLz6Ng0
 CqjVBhP+EDJ6OAVFNiZUF33pxYzLkTlCWZlL/VGZzTzObs21K6aUZDFfCFWf0fVLIPeGD7B
 CuraYkj/WaLW3mi0ndEhuN1m8j9AFu9aocMlKbHNcighLw9a5qKVtasrIPOpQk0leQAlHdX
 dO1B/1YdMSNzqvYYwGiOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MgCU6nlRq8c=:UrUsvTlA71NPlzTzN5daL2
 RK5wpSCrITJuoUVo7XYHt1kc3scxfg2WAXTY0VtoNB3Vo4AdQAMmYBGxo90RUblbPH9tNSE5v
 SpX7jm49BCqmt1Eo/o9BNF0rgR3az++jfimxrzydNHF9K9m1n8+fUgY0jstzLAmszytGqH0Hr
 Fr0QVIqy1p0XYWnACEuJ1Wk3UDwJSCn4sW1xc8d99VjBXvYxTRnrUWx0n8R7JCHvDuonl8rQQ
 nij7nHjznOTpOVDq6VEFZwkLMkPugUeHZl5HK12VbVkBWeHIMBjRosCkA/A5xfRymgfyKrw42
 kllHhwkJkvrblPo6fri83q2YP+mGIABn5r68GyDb/MuNo9HhrTxP6GPorkiO/d+MhlNp95SVI
 WvFPRfnv6rfyIfuYkPwRhQiuv1OiXM9vHqBSYiAdYjpECV1F2NJiXJXzsNp/SP2zs2fRl2nq2
 bp/Vrs8duA==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 20 Jan 2021 09:50:47 -0000

On Jan 20 18:16, Takashi Yano via Cygwin-patches wrote:
> - After the commit 72770148, script command exits occasionally with
>   the error "Bad file descriptor" if it is started in console on Win7
>   and non-cygwin process is executed. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 10 ++--
>  winsup/cygwin/select.cc           | 95 ++++++++++++++++++++++++++++++-
>  winsup/cygwin/select.h            |  7 +++
>  3 files changed, 105 insertions(+), 7 deletions(-)

Pushed.


Thanks,
Corinna
