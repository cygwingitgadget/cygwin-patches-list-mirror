Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 576F0385703A
 for <cygwin-patches@cygwin.com>; Fri, 21 May 2021 10:57:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 576F0385703A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MDQmW-1lZdG51sQA-00AVlv for <cygwin-patches@cygwin.com>; Fri, 21 May 2021
 12:57:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C4BE0A82BFF; Fri, 21 May 2021 12:57:34 +0200 (CEST)
Date: Fri, 21 May 2021 12:57:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH] Cygwin: utils: chattr: Allow to clear all attributes with
 '='.
Message-ID: <YKeSHsZyschd6qlr@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a8272535-f9a4-cbc0-d0ef-4d9040cc007f@t-online.de>
 <YKdoQb1YVefI2As2@calimero.vinschen.de>
 <0adadd04-acd2-8c0e-c744-690681a39a7f@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0adadd04-acd2-8c0e-c744-690681a39a7f@t-online.de>
X-Provags-ID: V03:K1:SzADUZ21deBzC+/dTABc4U403OaEtGF0hJSKzetWks6GNJBj9wb
 eJtB3pLw5OubvZ8hM7PosG+w42SGahDD29UWjyzt7+Rhwx0eq8dSPN1XuN7gmwDErptaqNc
 UuiKwJB8TBVehkraKg67FPCzHwXb+GyZHsukJD90hdHSzROrtKLCpnNQ+jGMwIZkCQ9Yqpy
 RFaGcYS0LAI/sc8MmRDRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qRCgyd76jGs=:H+kBvmayHx3NKO/icP8gMY
 754JgFPAB4f5WrZOg3sYkpiaHIFpXEvPryTHJ6NPVVkzz6+AdUVuvCkEGaa5tBQe1Pnvgyosy
 nZoGIMPvXnqhlo7VYWGc/B4ZwCrkuPEF9pQcDl2Rcg6T3xSLrnAPEAXSdR7UVB4IJzu1sfjTV
 C21ENn7MZ+zVBDs5+DQUqtPmgCRM3+aK5hMql4dfTX2fefNx0lg1wJvzzrZwoEfO25eeIAhTG
 XtTfjydR/zjhtGEPB2BuM9Cd83if4sKe9Thj/X1rv9O/Tt04UqWyv16saONEsxWhhowHFUt8S
 bx8v8D7MKObnfdBCNRRGsPjL+1AIpU/Pjn/ckZrFJpYhQEZxYUDOO41p/Od0GSb5HIKKwhlLJ
 H53EZnbXDMoJtiQJ1b0IALDodDqkRLUkAWEr2QkuQcFbnZdpDJp91TTKxW69ecn5XUEHFjjKZ
 IW7/eHsCNkISBIXSzoIB7biJCYwo+TvToVsqvCR79RvuX3m7+shs6V0YSIMJ54RyY/9I8zJGi
 hoOTnx/6PhfJmmlOhtnOx8=
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 21 May 2021 10:57:38 -0000

On May 21 12:07, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On May 20 23:04, Christian Franke wrote:
> > > 'chattr = FILE' is shorter that 'chattr -rhsat... FILE' :-)
> > That's ok, but it might be worth to add this to the docs, too :)
> 
> Next try attached...
> 
> 

> From 6ba0ab483f9417631a1592210141aefaff50ebc1 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Fri, 21 May 2021 11:44:32 +0200
> Subject: [PATCH] Cygwin: utils: chattr: Allow to clear all attributes with
>  '='.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/doc/utils.xml  |  5 +++--
>  winsup/utils/chattr.c | 13 ++++++++-----
>  2 files changed, 11 insertions(+), 7 deletions(-)

Pushed.


Thanks,
Corinna

