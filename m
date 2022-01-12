Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 53A913858406
 for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022 18:45:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 53A913858406
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MadGG-1mVv1N0D5W-00cBNY for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022
 19:44:59 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3BDA1A80B83; Wed, 12 Jan 2022 19:44:58 +0100 (CET)
Date: Wed, 12 Jan 2022 19:44:58 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux 5.16
 Gobble Gobble flags
Message-ID: <Yd8hqq0a6boX2Bn9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220112060431.7956-1-Brian.Inglis@SystematicSW.ab.ca>
 <Yd6q2CARZ3qNyo8H@calimero.vinschen.de>
 <23658f98-9edb-6119-a0d8-81cf58fe9d70@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23658f98-9edb-6119-a0d8-81cf58fe9d70@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:HPrZMxUQRHGYkaLPceUXsGU8beKERP7GrD2st9iHyu5hmUVz6+o
 epGnyI820BuCR/bugtyddbPbGNYE9zeU4sMXtHFh2uNstb7X6c+x9a1bTB1v2fUt1FKQZ8k
 Lgd/cBR5nUwBLk53YgGYeCybtHEYWRuY+t2We4J9/DSoX8o3mj+k4DuvMuRPUvPp/06pBXn
 RAPzSOiduBtJyFk4BDjrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sQQPFHIcWF0=:rsuRqIN4fmN13K63gwhdCo
 ajOBuhfA830fbgiDpgAO6zvc8in6CiYnUggAqC7kJ251k0L3Kfeg9HkStNuo2shl9xhyZ7O1h
 /9pr8uLA4PJ3eUYof6K65MxArs6OurZD6ImEJ8FmCq2tJHWXOzleiBDdFrfF4PgkFaxLSX3Ka
 Zh06EXqheYENR6iPolePUlmdvJfFrw6k7EfhVdAfs23QofrzT68nNjlOkj5ihgisszZ44L+8/
 TPZ732CxyLEUCJ0j7G2btBp/MsFZk39IYvEDPAF8Xs+sMEOztluIeXJq1yTujEc13Z3kJy0Dc
 p7e/rLG7u96W4CUrMpydX1AsCBmGxTrVSyrWqJk2Qx1m4lspJI0mU3L+qQg+e+6/5FsmyjQlM
 8C4bLvqn3Y2y8ctknLW7IVjUD3PUJ+J8dUFdEV/mf8Io0/L6BetQyFrFFBXoCMT+qtYvU0yuH
 u4Ap6DhB/y348y1Lmv1N24Svdisj7Fp1Fe13CWBz+b9Ub+/6Hfh4ispcK5EsqLODcZBNy/T4c
 hwnyC4rDbjyvcWkyf2zyGoNJwqbc1B2ac7lCTSZeexaOQiL1pGsnCAvYSzTlNeuMqke+AaMuR
 0iBMHFIvyMDHHLjOOoXPY9VPqzrV8HJQxBQHBrJvtH4HEfcfhO+TokNfzXWxKfEdeeF2btr/4
 Hgz6fkKmsK74WO98dxiATJuhLN372bKsuWzN5xqqaY2JD0iqdVOLtNtdSNB+vl6VOz4xWzPI2
 svkjIp/LGRy8QbVD
X-Spam-Status: No, score=-94.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Wed, 12 Jan 2022 18:45:02 -0000

On Jan 12 09:32, Brian Inglis wrote:
> On 2022-01-12 03:18, Corinna Vinschen wrote:
> > On Jan 11 23:04, Brian Inglis wrote:
> > > Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux 5.16 Gobble Gobble flags
> > 
> > Gobble Gobble?
> > 
> > Did I miss something or is that a preliminary subject line? :)
> 
> Linux 5.16 codename from rc3 which came out about US Thanksgiving; see
> bottom of thread:
> 
> https://lkml.kernel.org/lkml/163789349650.12632.8523698126811716771.pr-tracker-bot@kernel.org/t/#u
> 
> noticed:
> 
> https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.16-rc3
> 
> from scripts monitoring cpuid usage and cpuinfo changes across releases:
> 
> diff -pu linux-prev/Makefile linux-next/Makefile
> --- linux-prev/Makefile	2021-10-31 14:53:10.000000000 -0600
> +++ linux-next/Makefile	2022-01-11 07:45:05.000000000 -0700
> @@ -1,9 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  VERSION = 5
> -PATCHLEVEL = 15
> +PATCHLEVEL = 16
>  SUBLEVEL = 0
>  EXTRAVERSION =
> -NAME = Trick or Treat
> +NAME = Gobble Gobble

Heh, ok.  Thanks and pushed.


Corinna
