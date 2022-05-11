Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 24E633857402
 for <cygwin-patches@cygwin.com>; Wed, 11 May 2022 08:03:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 24E633857402
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8GIa-1nt9GD0fke-014CKo for <cygwin-patches@cygwin.com>; Wed, 11 May 2022
 10:03:05 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 33CB8A8076B; Wed, 11 May 2022 10:03:04 +0200 (CEST)
Date: Wed, 11 May 2022 10:03:04 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] fhandler_process.cc(format_process_stat): fix
 /proc/pid/stat issues
Message-ID: <YnttuBkTc0HN3KQh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220510144443.5555-1-Brian.Inglis@SystematicSW.ab.ca>
 <20220510144443.5555-2-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220510144443.5555-2-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:Ca+gcoBrqBzUJMOLMHscQh4rRAce5qMx8VkeScBodpwTZ3xL5xX
 2/B68d6A9hjTgKmr8fwc2vStET6oOMybzHGaR8CKWQi1vw0h82jzHIQaNziZ2G0mlcp+va1
 OwLHaubra0eBWD1B12DeI1rGfMmL5124yz7pIMeTgLBAZKJMYLzi9RW2gjX8EXMajL2wJNS
 lP5870LbnP3BvVTj4BTfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWEcJSPaGN8=:PCgHb3zb/DYruTREc2UHM7
 mkAYrJYav9UqKtD/lS7sGyEinJpktDTp77atoEiyXdpMOzm4SfiRyRdI7Q+yv/U+Vn6YhKsV3
 LnFuiRYvbnNP/PXJIg7o3vb0gOnbkY6xKPURNT4ogPqwA4uhElyoPDrhi/BiRUXIOJEUTsd33
 NidMQEJEsq7Krh+Thl9KXu59q3iGuedHvyaQvvBp1xtFs8wisSkvyR99Ow2nAWmKyK77ZaG0S
 RLKdZ+hVgI3cqw4CTSpf7SYjwO8ufRysP4ayorwZcOfUeqN1YhwIms0rXZ5szuPbXLbbJVmB1
 peFgWFLUAKTXvKVAqGWnWUtPNUS1f02vfNTuk8bQXSYEUmsxqkzeEPp3mUtIbGuBjTk54oMvo
 WqWaoklEJk0lhBuYNRmMxinJj1+R5dwTaAHLna0bzt2snTUPQ/FXdhwPu5h+CjzqQQiby3QLI
 bJMG8tHKVHcuN4sv8QjLZBul6SdaYdl/Qk5gExIbQD947S/G3YBqEabtTbHPojgq+jb2lQQRO
 gEWCThUOBOFoM1QIv+JbIDciFSDUn2dR4Mz4ImO+rcCdeHT5NRhO/o1rd56AdFgSTYZtw87J5
 E9UQ+mbSj/beeyNJkva8/hdGAVVdw9Ec8YsXh6/81TPF+sOczHTTABHhwscOI0dxQLJxgtyDn
 6jmk3XARvPKHRXlFycQMCZlc0bPqbpk21TC8zsDpbODvUC5pI0S+ZQ7nDDEIDKPv90OeWV9Bp
 N+67MTzE+p68xTHw5LO1GITAsekxNHiKPXH2RDTmwUCWx1zat8xD5RQf1Sw=
X-Spam-Status: No, score=-95.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_BL, RCVD_IN_MSPIKE_ZBI, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 11 May 2022 08:03:17 -0000

On May 10 08:44, Brian Inglis wrote:
> 
> fix tty_nr maj/min bits, vmmaxrss units, and x86 format mismatch:
> ctty maj is 31:16, min is 15:0; tty_nr s/b maj 15:8, min 31:20, 7:0;
> vmmaxrss s/b bytes not pages;
> times all 64 bit - change formats of first two instances from %lu to %U;
> realign sprintf formats and variables/values in more logical groups
> ---
>  winsup/cygwin/fhandler_process.cc | 33 +++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 

Pushed.


Thanks,
Corinna
