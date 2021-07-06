Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 473C6385E83D
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 14:09:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 473C6385E83D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MelWf-1lQsiQ2yRR-00apKC; Tue, 06 Jul 2021 16:09:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BA5FDA80D68; Tue,  6 Jul 2021 16:09:34 +0200 (CEST)
Date: Tue, 6 Jul 2021 16:09:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thomas Wolff <towo@towo.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: propagate font zoom via SIGWINCH
Message-ID: <YORkHm5mUk1jfMtm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thomas Wolff <towo@towo.net>, cygwin-patches@cygwin.com
References: <9191991e-4c52-43f1-cd9e-6eaac9013f24@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9191991e-4c52-43f1-cd9e-6eaac9013f24@towo.net>
X-Provags-ID: V03:K1:7ScHvTDeTKRCaPV1pfDjgOw3sEituaYnD152T7/I1iA1Cyh3Ewz
 WlQzutyPOl8pENXbSaodG4sIqT/Su5TktdF11SL36EmIgX5bYzDTUaJ2f9rm62BYYDU/Bci
 l7WIOUzg0KuHbvTuyEnsqSWOXIgEgqj3YlAAfSgfMXrW2OP5CCJsxAr9iN2MzKOx11a/muD
 3fBGYnLV8WRZ3Vjnr5xgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nigPSGYnnFw=:g9VaR+2wi5TzubwYoQsE21
 z3r0k0yzzdTkO/dXCUiKzX701odMQNY3w2UqLj0L7NzGmR9MWCFa32CPlqkCc/gsWJBHuxYrf
 PszoeX0qEmO/NEqQxXA0180VNEEtixAdp5ygFNBOVmJyXVb+v0hZxT0m77cQvfjcksNY9DBL1
 mwkztQ89h6DKRThh01yZZc1JE1kUM04PQTgmrHqvEKzf6bcD271HI7l+DFCduNXx7UEvgpCLl
 Q/ntoCfpFrF16QxZKXb6RvcwkS5lLJzCBBGPDpKpJ2cL8RrurPbHjUahywd4iH0XzNWakxnRB
 AV5+1yt/af6V7P7gNu+uqU9mm1clUqVWiHvikBR0Tw+jlEnMuJPfsQfVVGckPEQgm0DLd2MZY
 mrUYczdB7Lf+ODZk2BrjILKU8A6CURtHDwX12ric5AVBJOx02RxcqVlZGopc1YOLNI7bs5yT7
 fb2thseAS38tLfldZCLWrmRHrKX66346nEDKk0iphbs/ISBAglDI5zp2wBBd2Vmdjs9EBwVpE
 TnGF10KYSKGMrz2y3uT4+NhygRkL0vUtIugZl+NMP4vOU/TEFzHF8IBVs2aJpU+Q0oocdb+TE
 2ynhmnKvcnU3Vig/DoT3kvIEiLnQ1BuHi/r19wqonqqJ330Ug30hnqweRytOIxqr+XG2Xqz5x
 SRDuLg2Ns+zIm1mVw+IEUNZGUJoe9oJiWUWfV22IDFsHZZnxErI9Ehwh2hiRST3XoN/5bFP9Z
 3C9nd/cB+PIm1TWdATaenH3v0qprRkNKXW253pLYHNQlGurxxKD+inXP9uIUDgvDHRKJ22+kC
 4RGJ5G0TUGHHEogWCj0B9/wIkEWI1EmwV80hBtuiZsVPsdT7pHbMJmc77xqbPs4JvEsw8tW/9
 LR1a0gzIQfvxMbJXxTWw==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 06 Jul 2021 14:09:38 -0000

Hi Thomas,

On Jul  3 18:19, Thomas Wolff wrote:
> xterm 368 and mintty 3.5.1 implement a new feature to support notification
> of terminal scaling via font zooming also if the terminal text dimensions
> (rows/columns) stay unchanged, using ioctl(TIOCSWINSZ), raising SIGWINCH.
> This does not work in cygwin currently. The attached patch fixes that.
> Thomas

Can you please put the describing text into the commit message?


Thanks,
Corinna
