Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 2B4CE3858022
 for <cygwin-patches@cygwin.com>; Mon, 23 Aug 2021 15:02:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2B4CE3858022
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9MlI-1n5Z4d2Ru8-015IGX; Mon, 23 Aug 2021 17:02:31 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D9EBAA80D62; Mon, 23 Aug 2021 17:02:30 +0200 (CEST)
Date: Mon, 23 Aug 2021 17:02:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Aleksandr Malikov <schn27@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix race condition in List_insert
Message-ID: <YSO4hmZcdL/5w44q@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Aleksandr Malikov <schn27@gmail.com>,
 cygwin-patches@cygwin.com
References: <20210823142748.1012-1-schn27@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823142748.1012-1-schn27@gmail.com>
X-Provags-ID: V03:K1:kQl5/O/gNYLkJv8WzTIgIpMYqNzyaZ3MpiPebwkYH9I2zaMoEhk
 +QY4KF0JedtFyzlSyi/gr1lWRdC8mwiOKpfe7Y4V2Z3Atj8fxieeekF1u8ipCLjDqAsSII+
 1UNI084GeoY2afyNqEU6zs9mnEWf8i2f6sYlevR/Q1mEyrlfeRIptKW69MPowCEPnXdxhlB
 7ALODO5zuQ4mZKc+GqPhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TIK+5iPLloU=:O6WWz2+55XDxJ3QqluNtvF
 +58ploONzQbug8FN76UczKYnE4H/ioITFUOF7dmzGp3IXn0Z1i4EpxBevBdVj0Q+ZBoiZkxgZ
 ZL9OkKLYVN6nPnAKUTmdND/G40D7CsUryPXzWZpYkQyUhdglsO3Y8fymxaLItW1pgqkTbPGon
 QpDk5wTXjf9ZeTFQFJPOBioloTrnNnXj4+vBvldOCJLtDKDHSSaSJb7sZGCCXQZlC/DVwPrCd
 bVbtEoaapLRVyKTspOI9cICo61Th1XsLK8QhJyN9ZDN2hki6+XOJxI0u2OTxjnBpiKWXp1/SD
 MuI3dWbo5jpSCCTBf0yvMMSgvlhakztrcnBtLz2aiakEXPZ3zQo1pLRllUAFCH9YPBPeXBR31
 7R5wF52PwM86MnUdIG4ZilhAYFtE2GZa+vSc8gnHj/xjG6+JEjFyb9M2aX1AS2oYP7uyk0Zf3
 KuHkeIVRi09kfNa9UlmAv6PgCNUyy2e780V6oQonqIaJXxpO+Lh7jE9FR1SqYKqPVpwSLwzJ5
 ufukB2zW/3ls4APl29BiUiEePYbKU/fCgZ3/X9TauRNOMeOhmqv1is4/tsJ9+NzhYSvJSoIKV
 Q897Iv6HPTfJKr4cg/k0I8MbTWH2d4NkujhPZ8H447RvGGcPb+aSBFg8Q4NQJHEm9oEQBHhM5
 RHNQtu0/yco7DIeEqBF8vUh1IXwt8P8fx7dfBTZVtOyW+IGI0PMiPLeBmGSmVKHX9DXyIlTOR
 MiMU7yE2T1hGR3ST97XtFEkbDxn+28kMLG6PRzgg7MBsBa/k3s2iWvQXJ/2pely0kcHu+0M2a
 kB2FHFAlLjiDh5/tR3pvFrUcsRdkHfVSw60umOgFuL8rrhtag1DD+7mDnbOdMXqFATkL/k0AC
 4HWO6NT/yCdSo37I9iYA==
X-Spam-Status: No, score=-99.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 23 Aug 2021 15:02:44 -0000

Hi Aleksandr,


thanks for the patch.

On Aug 23 17:27, Aleksandr Malikov wrote:
> From: Aleksand Malikov <schn27@gmail.com>
> 
> Revert mx parameter and mutex lock while operating the list.
> Mutex was removed with 94d24160 informing that:
> 'Use InterlockedCompareExchangePointer to ensure race safeness
> without using a mutex.'
> 
> But it does not.
> 
> Calling pthread_mutex_init and pthread_mutex_destroy from two or
> more threads occasionally leads to hang in pthread_mutex_destroy.

Do you have a simple testcase in plain C, by any chance?

> To not change the behaviour of other cases where List_insert was called,
> List_insert_nolock is added.

LGTM.  Can you please provide a copyright waiver per
https://cygwin.com/contrib.html.  See the winsup/CONTRIBUTORS file.


Thanks,
Corinna
