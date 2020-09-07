Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 934E33851C2A
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 08:27:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 934E33851C2A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfL0-1kxZaj0uJe-00ilq9 for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2020
 10:27:39 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D044CA83A8F; Mon,  7 Sep 2020 10:27:38 +0200 (CEST)
Date: Mon, 7 Sep 2020 10:27:38 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200907082738.GD4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200905201506.8bbca09f51a2b2b06135affa@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905201506.8bbca09f51a2b2b06135affa@nifty.ne.jp>
X-Provags-ID: V03:K1:4o0y4m4LEGxrS5FA/7YvaoaYWH70muswdj4NVWIkQvRJnP4Dqsn
 vTqM9w7E6VoiKGizmhON58gF27NnuiPuWkLpQqkxoiPdButL+aVn7onpMdzuGpXuPpQCnsJ
 UnfaOEhUApktNEs2BJR7FB14h01/mQedqOeqehP7Ge9edPzSVAcbQ5jmLKGjs5uwZuu1+u/
 cjbxMk3KHLKRfRZ4n5bUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n3UXTlgm7mY=:GOLFHHSvlLA7M1KqgHveuC
 cCJ6oqJ/srITZD6qYDKhUi1NRW3nYXbtppSiKrbEICeF/s0IWyRIvAxzngIgF02CUrEpGDc3/
 72C12edChIrQiYVPceq47+miw14sl8NCc4rvkX/qarnFUJqsyxd9aym5F8mJ/KJHMkmVBLgJJ
 XB5iQF8Pjd3hRzjz5i+80KgUEv+Tt3S20B1WNKvbRTFByJzpkyKYH5TmPsjRuEK/Y/vpA78+/
 nSjxajvtG746cxdLMMA1f/CThmDXVe2RMF4Pyn/9UxIIVw3s/f9aFSaeYwCgJjrcAiQYFAHVc
 aWgLxrGIQL4pif8FyDLG8S+j4cwD1zE+oW0v8V5Z+3fuwi46p2uRtKQq4AAjZ8lNFN9n76k63
 LMo+xKHQtAfiP7CpRVz2ppJ1coM6Dzyz9wVnPOp/dLdjTgMM5MQdKXoPeorpCeb2TSATXQr/7
 LViSiHRbXbFpWLZ8DnB0k0UnjegY/0KDX/SmitowfeBTQtSvaABXU7JSR5Mhq8jfU6Qe6bfPV
 4HFFtzVWvLfbHnTOooZqElNFfZZZE1GX2ETo7zkABrXoBtJxsg5I481EjkhnMLO74dl0eX6Vj
 McB8Ul4YYEHaeC4yHgTsplO7ZIWzld7WvtTOrTXfFik0Xo860VqaDziaGZYJ/xsyxlZBCx3Qa
 AZERN+zO3QAy8R970Gyy/5VOXUbIhe2uAWPqsYJIALSbaeQCpv/dvS2dVUPasdLBKBv9iw7J1
 U5pX+qmQlAraO29kHUoUZuWCoda+v3E63406qn6PwjvaNWmUMCgkVMxjRd+s6IIdnGA/dby1P
 MiAK7guX+Jvjx0YuRaEG6xt/YHpysBBYmASb7zCFUbZCCRT/G8uDg2BWkEY1zRMvt3HzgvBBN
 PDOCeu2HulpUCJtIz/nQ==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 07 Sep 2020 08:27:41 -0000

On Sep  5 20:15, Takashi Yano via Cygwin-patches wrote:
> On Sat, 5 Sep 2020 17:43:01 +0900
> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> No. This does not fix enough.
> 
> In the test case above, if it does not call setlocale(),
> __eval_codepage_from_internal_charset() always returns "ASCII"

??? __eval_codepage_from_internal_charset() never returns ASCII.
It returns UTF-8 by default.


Corinna
