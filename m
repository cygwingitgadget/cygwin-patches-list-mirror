Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 74C50385781A
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 18:58:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 74C50385781A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N63NW-1m68kX0btI-016Sbj for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021
 19:58:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C7B08A80D4E; Mon, 25 Jan 2021 19:58:52 +0100 (CET)
Date: Mon, 25 Jan 2021 19:58:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/8] syscalls.cc: Deduplicate remove
Message-ID: <20210125185852.GG4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210122122215.GF810271@calimero.vinschen.de>
 <20210122154712.3207-2-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210122154712.3207-2-ben@wijen.net>
X-Provags-ID: V03:K1:Us1/5a76OcrQC/7Hrie1GbgRemLcBxDiZKGpLKrhApZx2fmhaQL
 W0rRMAsnKAWTciev0aAFMcUAG0aHukFVTLNxJ6RKDaiLz67IdAeC7bizRDbBJYb1DaRLCCR
 0HQTCMz5hRqiZ69eB3zzppjDCP3qZL4d0zsc5h58FpJiTh/SYasv+/QhLygJlaVft2+kbs9
 Qu4kDbl7349cb8CTrXL/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3dLT8NZ748Q=:wCTN9oJsh9hR4CeJg18dwN
 Zd5pcnW5lnxzF6caYDKL5iIg7jBqv+7MHMXzi/L+aGOxQOSQHjM+QA6FvwS81ixVsRdlpVtjm
 QGvBcsuIYuHSQNBqos31N7SoyGKno4jd5RZl0XOZQILyHUoyhTLR24bxKT59j/ZfjVwhfSl0+
 oXxVY29WL/vM3z4Oj0TIW8kZVlnl9Xp+qOjzCNywhubZWETq5FXu+pqtE8/jCjyj2XzIOee72
 /WU7ppCO43ofhVFudXB9iKifw9eHSsV8eXOlcKnXNmpThmWlBn2AqRskeGuIJKeNNp9h+j/Sl
 gLQ9yaEZc5NNaMgfTRl0uJtFjRJLJbNYMbgAKrdtVUbQhzvPSqT6oYP11H85q0eXid2euK57V
 vbx5sAdbnsj7Rf8iFFqoZTPyD9XjbKlnGKu0/gWh6qm3jXQtchIzjqOwtZAm52cFi/MGO2akA
 dAiM2YnZvg==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Mon, 25 Jan 2021 18:58:55 -0000

On Jan 22 16:47, Ben Wijen wrote:
> The remove code is already in the _remove_r function.
> So, just call the _remove_r function.
> ---
>  winsup/cygwin/syscalls.cc | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Pushed.


Thanks,
Corinna
