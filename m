Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id C1B393857C58
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 19:57:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C1B393857C58
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M3D3N-1jzkMz10fd-003hnZ for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020
 21:57:16 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CD3D3A80456; Thu, 16 Jul 2020 21:57:15 +0200 (CEST)
Date: Thu, 16 Jul 2020 21:57:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/12] FIFO: fix multiple reader support
Message-ID: <20200716195715.GD3784@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200716161915.16994-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716161915.16994-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:6SD5I5Dh/F8uOQkihGbt5LeDLvEpOC9/hsUNLri5EEVr0ksgvR8
 4jF+P49tjwe1eFdBQ1H1h14ipMqBjkIwbd9tAt9LwTxna0jx9qGUdOqht9+GWlRBC64QvhE
 fqBFeOGpe8knKMjenB1s175K0HN/T5u588xrN76gaUWVZ6OpNa2pz/0hNEUHLZcMyzQiuV8
 bqpIq/B+K04NKGj6lrBVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jj5Nl3vDaXo=:bpGBqNXCKFosf4duCComHu
 O/i/0m7FacZqaMoE9ZWe3aF8uO0RHLeSzPWeAgC9I2YeMCxiKsqlQ287CMDjvqKcgdwTuoUa8
 PBaOr4+TgHBkZ6hGHqViqWNXApydy+9g2TLUh9lsQBfEr6d+iZMUzSpBjsKeVIfKDJjTYiFd7
 HJVCguzyLlUCGXGcvHQ0KcOMIIfam/DnVV8XBkXOsUC+Tf7oVpvrckSO9LLhsSMN23Blt93Xk
 lgvJp6v4kpzqDZJ/sjvzSAvRWa7leTloG5wD7PNb0oqw31Qn57XeIeKpX1mvucj0x4TRQsfpk
 XUtU//gY7pKZTyV7Oa3Q7Sr2m/rlGv58GubcqXFx2EFRPhW50S/eHygkTxmRAwaN9qRQTBfSi
 Z6uhtZbX7U8cAxsSfnmzIYmb5vsp/58Cc0IuS401DjHJksSL3z9GycXmAkt4LvBFVwlbkKP8E
 ZcRFic3NElCcjGAmpMo1UUX5wwsNE1mtk5vLt8uUmKzdAgZh+k+e4HVjSzxh5NSaMN7D63Uov
 EF4wc3f1AXeQLLbrU3NII7MBDJjdx4zm7bfJ1ndidPtDfbRsCJhUh+5UE28eWMlh4ggv6i422
 F4QQD8o14FTIrPgbqkZzV3AsG/cZ/SCZLkeJgOE/jHlqD2cIdgEoKeOHD7jWWDH3GXyZC1ASz
 0StrVyXri9m8SjJVNrFqUAmlQ3cFiAbIzGUvgfrHEfNx8dCWxedRD5nLlPWEtOB3/viFph310
 I/x+L3zikJcevka1X238iHxgJc3Fjbxb5++Zi6PFFvuO7ZGHVy5vbmmPD9F07w1yNQeoI3uFi
 1amTitbt07fo8A3V8Mwvp3V44jCDBfdD0JTd51OO2gyX6Nwou04GnMXZFUDs4q6aktDGqGJTy
 9gKJa5cwvwBdD2ttn1GA==
X-Spam-Status: No, score=-98.9 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Thu, 16 Jul 2020 19:57:19 -0000

Hi Ken,

On Jul 16 12:19, Ken Brown via Cygwin-patches wrote:
> There were several flaws in my previous attempt to add support for
> explicitly opening a FIFO multiple times for reading.  (By
> "explicitly" I mean by calling open rather than by calling
> fork/exec/dup.)  See
> 
>   https://sourceware.org/pipermail/cygwin/2020-July/245456.html
> 
> for one indication of problems
> 
> The most important flaw was that I tried to use an indirect,
> unreliable method for determining whether there are writers open.
> This is fixed in the second patch of this series by adding a member
> '_nwriters' to struct fifo_shmem_t, which counts the number of open
> writers.
> 
> We now have to give writers access to the shared memory as well as
> readers, so that they can increment _nwriters in open/fork/exec/dup
> and decrement it in close.
> 
> The other patches contain miscellaneous fixes/improvements.
> 
> Ken Brown (12):
>   Cygwin: FIFO: fix problems finding new owner
>   Cygwin: FIFO: keep a writer count in shared memory
>   Cygwin: fhandler_fifo::hit_eof: improve reliability
>   Cygwin: FIFO: reduce I/O interleaving
>   Cygwin: FIFO: improve taking ownership in fifo_reader_thread
>   Cygwin: FIFO: fix indentation
>   Cygwin: FIFO: make certain errors non-fatal
>   Cygwin: FIFO: add missing lock
>   Cygwin: fhandler_fifo::take_ownership: don't set event unnecessarily
>   Cygwin: FIFO: allow take_ownership to be interrupted
>   Cygwin: FIFO: clean up
>   Cygwin: FIFO: update commentary
> 
>  winsup/cygwin/fhandler.h       |  55 +--
>  winsup/cygwin/fhandler_fifo.cc | 725 ++++++++++++++++++---------------
>  winsup/cygwin/select.cc        |  14 +-
>  3 files changed, 433 insertions(+), 361 deletions(-)

LGTM, please push.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
