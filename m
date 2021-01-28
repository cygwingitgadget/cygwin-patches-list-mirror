Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id BFDA1398E438
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 10:25:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BFDA1398E438
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAwPf-1lGO6J2I3t-00BJbe for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021
 11:25:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 179F8A80D85; Thu, 28 Jan 2021 11:25:34 +0100 (CET)
Date: Thu, 28 Jan 2021 11:25:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 0/4] Improve pseudo console support.
Message-ID: <20210128102534.GZ4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210128032614.1678-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128032614.1678-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:LeOXJ57dSbTIDWeMG5t/k9zpZfxSFsZtb/QDGir9auUC5zMzEgn
 irLvF83duoCH2vEZsIeZOZT+80wIEmgBaKCYxg5RzkcDX8LIighfM/0yrW3zMvWRtzd6MF1
 KMXlu/ThSdQiFmYDSSIR80pZBDJVhq5O6gVcUwMQk/TcOx1e1qyURVKHeyE5eKW2naF5Iz0
 GiOcsHYow9q4kgcVqpjCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BtWcAz0I2WE=:KRzHhnJaHjYxl6j4puqV7n
 rWkQi1rtlQq1sqryNYquC720MRudQQ0fbMAa8jUxQYuxocFPUgXAXVEXIwnDgFX09l+ETUPLt
 RrCDlJZyAoG1rYKHm30+P55QN8HjhKL7+poLvPpnsCJaDAgSeT5gWl9fufAqN4cp+cHO8VtyX
 ngDq+GvEfvMFOTRog/JPlJcWG0EoeC2aMJ087S6UXcCX+ig/rjJlbRMHNM6OfB2qwGHYcVoxL
 C7Qq3L0GeXiyEKPQeK0o4m1RtU+c7WC2aRm1SwKcS1p1JserDJe5/d6cZKp/5+CbhfVDbTaSo
 +PYb9JgQfhDW+f2xAvGHhXYVoLpZLbrzhTH2Q2bgMP75Bab9LiPxy+fmTJuHfjJHozmmFEP7f
 s9tCZ1fm3MsYuP6ZO3uMhiDwh4jjae5se+oTMDveUG7mHu+oF5fGf5HZeucvM5QIwMPF4gQfc
 Ycr81jJBnA==
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
X-List-Received-Date: Thu, 28 Jan 2021 10:25:37 -0000

On Jan 28 12:26, Takashi Yano via Cygwin-patches wrote:
> The new implementation of pseudo console support by commit bb428520
> provides the important advantages, while there also has been several
> disadvantages compared to the previous implementation.
> 
> These patches overturn some of them.
> 
> The disadvantage:
>  1) The cygwin program which calls console API directly does not work.
> is supposed to be able to be overcome as well, however, I am not sure
> it is worth enough. This will need a lot of hooks for console APIs.
>  --> Respecting Corinna's opinion, we decided not to implement this.
> 
> v3: Fix typeahead input issue in GDB. Several other bugs have also
>     been fixed.
> v4: Change the conditions for calling transfer_input() slightly in
>     reset_switch_to_pcon() to avoid calling it if uncecessary or
>     with no effect.
> v5: Small bug fix in v4.
> v6: Yet another bug fix.
>     Add missing CloseHandle().
>     Take into account when the master is running as a service (such
>     as ssh session).
> v7: Specify FILE_FLAG_OVERLAPPED for to_slave pipe to prevent
>     PeekNamedPipe() from blocking in transfer_input().
>     Simplify the code determining if the slave is reading.
> 
> Takashi Yano (4):
>   Cygwin: pty: Inherit typeahead data between two input pipes.
>   Cygwin: pty: Keep code page between non-cygwin apps.
>   Cygwin: pty: Make apps using console APIs be able to debug with gdb.
>   Cygwin: pty: Allow multiple apps to enable pseudo console
>     simultaneously.
> 
>  winsup/cygwin/fhandler.h      |   22 +-
>  winsup/cygwin/fhandler_tty.cc | 1123 +++++++++++++++++++++++++++------
>  winsup/cygwin/select.cc       |    7 +-
>  winsup/cygwin/spawn.cc        |  106 +++-
>  winsup/cygwin/tty.cc          |   13 +-
>  winsup/cygwin/tty.h           |   21 +-
>  6 files changed, 1059 insertions(+), 233 deletions(-)
> 
> -- 
> 2.30.0

Pushed.


Thanks,
Corinna
