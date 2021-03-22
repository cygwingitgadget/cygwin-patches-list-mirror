Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id BFB653858004
 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 11:49:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BFB653858004
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mysa4-1lc0Sh1qni-00vwO5 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021
 12:49:21 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C1E20A80D44; Mon, 22 Mar 2021 12:49:20 +0100 (CET)
Date: Mon, 22 Mar 2021 12:49:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Rename input named pipes.
Message-ID: <YFiEQJf6ZDivGbPH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210321035953.1671-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210321035953.1671-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:cBKiL4VqIwJtk4HdHKtX4KafJ5sMgxkREzfTiK4YOhgBQfrxw3f
 kiQ1Bp4pz+aEX8WDQhV6qgmG7xYR74xscftlVXM4YPAFNyEWTARpU9e4xrqce7CJ5VsgfZV
 J4wqbFj8/ywdlcalxZlOuj3Ha4S8Mek1O1mP6i4LOHqZ1jymN+vd+opRiwaZ/14DWMMEe5q
 Py1y2BLQsCAW95Bk7d9ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:15s1lUT5iyo=:QKIQDrIH3fapixfCMpU6b8
 KEBbceLKffS+cRGGyfPaG1PuZofD9fkjxZ1BTXOO33HMS6aV+XUELYrFYij3jDfKbrYHrhIUv
 4BT0v6tVbYvn8zLoGboWg+WNcqNWirwqiVncVn6BqP/QoZqjZMJAUY7Q+vO2i3A0A/hZISoHQ
 Xhhpwt6mGBsd+9Qrp1Ic2Jg1CFuqnEkCTES5608Fc80Y3s7X+M0rpHNDyMWs9v6Dh9X24ZKPo
 +3DUSrk3JE51yllRigqKuz+2xKlWkdj9JazL9Z3i23Q0Cz711+3a6grVlKuICd/js/XZv6WtV
 c6AANtrqZL1na5dZL386vz+uJC9ctxcJxLkZh7qpNsKVxkd4+JMB3a06tsUsHAGjHTtUo1N2g
 BXaroCxjjBauDRrEz5C1LSh9qKcLYf5BA5VRBFgdLALTdy6mH5fuGpMHNBaJj2AFEsN3XdZtx
 Zx+P4m9h2w==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 22 Mar 2021 11:49:24 -0000

Hi Takashi,

On Mar 21 12:59, Takashi Yano via Cygwin-patches wrote:
> - Currently, the name of input pipe is "ptyNNNN-from-master" for
>   cygwin process, and "ptyNNNN-to-slave" for non-cygwin process.
>   These are not only inconsistent with output pipes but also very
>   confusing.
>   With this patch, these are renamed to "ptyNNNN-from-master-cyg"
>   and "ptyNNNN-from-master" respectively.
> ---
>  winsup/cygwin/fhandler_tty.cc | 2 +-
>  winsup/cygwin/tty.cc          | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Actually... wouldn't it make more sense to call the Cygwin pipe

  pty%d-from-master / pty%d-to-slave

and the non-Cygwin one something like

  pty%d-from-master-nat / pty%d-to-slave-nat

?

After all, Cygwin is the norm, and non-Cygwin is the exception.

On second thought, this would also make sense for thr fhandler methods,
i. e.

  get_output_handle / get_output_handle_cyg

vs.

  get_output_handle_nat / get_output_handle

Probably the fhandler stuff is too much renaming for this release,
but we should do this for the next one, I think.


Thanks,
Corinna
