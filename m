Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id CD8E33947C24
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 09:50:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CD8E33947C24
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRCFu-1lMyF232pA-00NCBU for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021
 10:50:24 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1C6ADA80D4C; Wed, 20 Jan 2021 10:50:24 +0100 (CET)
Date: Wed, 20 Jan 2021 10:50:24 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Reduce buffer size in
 get_console_process_id().
Message-ID: <20210120095024.GR59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210120005700.531-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120005700.531-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:ieM6avsuxVDKxh3TY2szO5i5nlq7bl249Au/2PK1FesGg5q1jp0
 dEqdn/MDH2VJZZ8VV2XCIlA/Fimz7J+Vdh6gBMMK2mRu03t0i9Km8s3o6LwD3NHtT2C9WOH
 dh+ADWJbAg7hCPWZ4+aJkqwj23/jz0WpEcEJzyQ0yliXx1v7atCYLhffX0ekl8B38oQb9aF
 UYbR77LY6VpKqPG5KcwMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vzG69Qpbr6Y=:tTz0bBsAZm9x+D8z4GHKpQ
 jlObCVPimYQGr1SueOXpWyvhFwt3SDU4OYYUZ1MBbNk//JmNBW8c9c3r9lziV9aaG5LBCiZsV
 OLXr30FP9dq7B7ir8aMQvEoxZK3fXG/0itW05jPa2lNT2E50oc0px1ySOtIercA3lW6jb4qJW
 SKwUuie4wE88OsN7UN7xSQoB9ajthtFn4YHafjKi2eYJ7UgIsToWXbqXqbct24TNgIenaOU0E
 +E/jgWl81lVNQQj3Hn/gQtffNOgcpM+AtI/VZAbXbM8jOZgGHJ1BhsBkknaO076oQK3JUqV8E
 XVaj0+PbHwcovCit2gdR942P/RCA4EHXh6F8oqoatURdPVEOMTIGsorvrxHxYSdFkr4uPqKTq
 RydvBxq+l0fBmhgRFhlANsRMZzqjeckoR9F3OJsAVl1oKqBt2OOm1f9a4PzIkkB08i257TxDk
 C18m4llrFw==
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
X-List-Received-Date: Wed, 20 Jan 2021 09:50:28 -0000

On Jan 20 09:57, Takashi Yano via Cygwin-patches wrote:
> - The buffer used in get_console_process_id(), introduced by commit
>   72770148, is too large and ERROR_NOT_ENOUGH_MEMORY occurs in Win7.

Huh, funny!  Will we ever be happy with just 8192 processes per
console? :)

>   Therefore, the buffer size has been reduced.
> ---
>  winsup/cygwin/fhandler_tty.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Pushed.


THanks,
Corinna
