Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 237013851C04
 for <cygwin-patches@cygwin.com>; Sun, 31 May 2020 08:40:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 237013851C04
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mt6wz-1iqV9F2szx-00tRpF for <cygwin-patches@cygwin.com>; Sun, 31 May 2020
 10:40:16 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 10B5CA80FFD; Sun, 31 May 2020 10:40:16 +0200 (CEST)
Date: Sun, 31 May 2020 10:40:16 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Some fixes for pty.
Message-ID: <20200531084016.GY6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200531055320.1419-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200531055320.1419-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:CYOyxzlkHSwy0Cd9vxbABl2SQjHSx85mzCk/4EkGMsnGNzUOohY
 rT4YStlYwJ8ZYCXsdI65bz6Jna2YiymppMv94kjL0r4Wr7SLAn0lx3PsNkrEws0BiUMTGHG
 +fB3S2v3KhK2N2pvhFDWJfwxnNwTTHklXRwWQDwngtaW4ZkxyFKjPMU7PACcSgRUewQhMrD
 c+4RVeTHLCnlJiytb11BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7kEeyBw0jJQ=:wglnIeHyfD6xDMDLtgCtWz
 uIPkbcYlo483TGVU2+Rvreg0GKHtISfRQL5LohRKZMoavi8AJPl33Hi6K0waUfqwCe98nMnZ9
 HyyUBJd7yLPXjEnEuWj+xihx9fsASJ8A0LR9+wGz+BlVCqJnjrgurD7DKjRjb4AOzA9gWfV4o
 7JEbflYZOy1zBbl3FM9QweVnEvXncDeF2T1GQrhlIkfr2Sxsro3HcvV/Ju/gg63ODHOSPkjwj
 EgKzB1+PJk1/wXedRe5SAMgeiioySoxkvFtxs8MuUuyGPk3bBI2FhzMOJL1O2GU12FXawfliP
 qq5Ow5xlINWN7qBuYOvozu5lPZtJvsJV+mU0PlHhBjOTDaX0U5lO2zAaU9q0fuYE+m6koA4Ha
 J/dNZFfYcJIGiqr1MKK0d1gFGcAVrU/DLhO/jliHuZhHMh5l2jdGmqtXTS1z3JG1uixd5MPYs
 paF+SKeu3UUsFQefYnZgjocO/8lqH5nOZKfcANGJAEzKeCJTy0jL8XKb+i3DLbHFhz6G8tDbt
 TagoRSIDY48UiByfwYL2JvQknw3padv5klrN7glF+svkzPuGKVC3/wwuC5ccsEYja+DOjpnTu
 8+QaPJoGYmyqBxO+LOumdhocOpAp0aX4wD1nHwKlf2mmPEWrenPrfHAu4xQKODUC14g1A+ec1
 9HZ/1Nza4FmaKT40eqWSlYzjq6BXkFakNn2XgMv8h0YS+ilbzjIknKC9HnIUjJdn9cy22FODc
 1q5vG7h3LDKIQDLcxShSAAF4Nm9K0Iv4BhLqdiJSPYK4d7tzXs8T7comh3sfZ1hPrwfFXe0xj
 rhhea36lhwCTyQ/DAJxvGjMhVvpbrZhgqTJfZM9v11TXhSHsLAfkUSyucekbT9sY1cXUjmw
X-Spam-Status: No, score=-99.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Sun, 31 May 2020 08:40:20 -0000

On May 31 14:53, Takashi Yano via Cygwin-patches wrote:
> Patches for https://cygwin.com/pipermail/cygwin/2020-May/245057.html
> and three other issues that were noticed during this fix.
> 
> Takashi Yano (4):
>   Cygwin: pty: Prevent garbage remained in read ahead buffer.
>   Cygwin: console: Discard some unsupported escape sequences.
>   Cygwin: pty: Clean up fhandler_pty_master::pty_master_fwd_thread().
>   Cygwin: pty: Revise the code which prevents undesired window title.
> 
>  winsup/cygwin/fhandler.h          |  3 +-
>  winsup/cygwin/fhandler_console.cc | 54 ++++++++++++++++++++++---------
>  winsup/cygwin/fhandler_tty.cc     | 41 +++++++++++------------
>  3 files changed, 59 insertions(+), 39 deletions(-)
> 
> -- 
> 2.26.2

Pushed.

I'm going to create a developer snapshot for testing right now, should
take just a few minutes.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
