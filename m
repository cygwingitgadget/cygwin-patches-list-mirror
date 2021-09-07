Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 323813858039
 for <cygwin-patches@cygwin.com>; Tue,  7 Sep 2021 18:22:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 323813858039
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N2Dks-1n66YW3tLK-013fQr for <cygwin-patches@cygwin.com>; Tue, 07 Sep 2021
 20:22:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5F10BA80D89; Tue,  7 Sep 2021 20:22:18 +0200 (CEST)
Date: Tue, 7 Sep 2021 20:22:18 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix error handling of master write().
Message-ID: <YTet2suQC5341byD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210907102745.1149-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210907102745.1149-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:rOg1eL3d3QY8/vpQaig07NKorWUp50t3rmhg/KjYWVANDzoy6Km
 E7S7LQEB4bMz4ydAmB1iZwLb54I/XKHrbv0MQkcPXZSLm+6eVHI6lhWQx9CNugJRTBQ1VfQ
 7FR1IH5hM45Hz5pfS3bblrhUuu0KF1mggkqfbAMDer8PXEDDdz7LOUbaQzcicCXt6PPXvac
 L0IeqOqYhga/xzVx7VOjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DatKZpW9BkE=:CVWizX6s2B9vTsA0xhSSyD
 eEBEKerrZDp5LJG/mbYep6MotORS6cRMiEwvMpX0RCTqJztpqf/L6UXGGJT8FocPXcodhuwdq
 k6ePVKa3nEs7gQJx2x5fcZRLS6sMxRb4OKx+rj0MHHLcFl3qZM8fWpEHg5MyIEBKePkqR4MWG
 8AwnZNwd1YCi9TAxJe8A1tArZubzggB70DSTqohZSkJ1UVtTtQrBFAMk4i/8dcDPcStSNWkZ+
 4aAsVi0okey/zLfkjK5gc3NGJ/KsLQ61778lA/uJRIjJfUDnhDheSCf165yDrJ9RGY9nMa2r5
 2Vnnbg8gwA9DizR+Mbwp2NV7/+pJlCqxXPQaVHx2xEq8csgoQYhNDcVwDiLWSOCQxy8lR+ZU7
 LoIJL4xJBM+6ixT5mdfRumezVgC8g0e+YSTaJOXuzuwP4aeVoq7+XFRGfxErSTBltUvm4Ecu1
 QIv38Hv7bTpHBwQSxF8FU9yQboCp1gHyophahqnolxHcmtXrkipVHz0W0Um0HNMRtC/yw9YH0
 OluC1eIwGnfJsL0ra/iOAwKV6MQ1xdtSoFujPdBYQmzar/SI2K6FDBckz8yI3/pwrlG2R4pz/
 S4CX3GSTHWb636e841vYLoXrmATcYsFrdAr8A5zLCmBa/vnGoN35itwDT33E1v2wrwy7GMXL0
 bjdXxyU269wUDVxUvNp5AoHTs/B/iuUTdE7tVmRGdxF9f7Ssiiqxt0tid4j/s2SJ+Bh+h2cag
 LYDlTB1SUwP8cI+oYlISxxd8MK0PYC2DxrKj9rSBcYqxCz2Phoqn4KfapH0=
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 07 Sep 2021 18:22:21 -0000

On Sep  7 19:27, Takashi Yano wrote:
> - Currently, error handling of write() in pty master side is broken.
>   This patch fixes that.
> ---
>  winsup/cygwin/fhandler_termios.cc | 24 +++++++++++-------------
>  winsup/cygwin/fhandler_tty.cc     | 11 +++++++----
>  2 files changed, 18 insertions(+), 17 deletions(-)

Pushed.


Thanks,
Corinna
