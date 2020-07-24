Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 8623E3857C42
 for <cygwin-patches@cygwin.com>; Fri, 24 Jul 2020 08:42:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8623E3857C42
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2VGj-1kx3wP1n4x-013tmX for <cygwin-patches@cygwin.com>; Fri, 24 Jul 2020
 10:42:30 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D363BA81012; Fri, 24 Jul 2020 10:42:29 +0200 (CEST)
Date: Fri, 24 Jul 2020 10:42:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add flags and TLB
 size
Message-ID: <20200724084229.GA4206@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200722192254.13188-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200722192254.13188-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:vsyd1agIljpdjxoTVJFjZRQcW/iD/PSAU2SSnzCmj/l9/kMzh12
 5JeVw/X5MVYYq+K+JLBZN9Jo+kEc/Hs8KEeH6dvBZ6yApclj05UnlVNFqGIN/gp9kSxR6zi
 o54vmIbJaoRSgr40+cP3sNyLLzYx5cWEW0CorILw011KHBbeePRfrMQmmZlEiG3i7/7CDdP
 zmeK+2Q2G4K7IV1vN6sxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yJzkpjzN1ds=:IKRJnUZUDwFspF27zaNt4W
 9eHSKpHj1fF1hqZ5/GrfHlPuEwIhIrnaNyEBUqb/sJI1Bt1AK8EtEQWQTJtxQRFuHsGVBnvxF
 btAUlkh8McXLgRsSoujxi4WoK6y4uaHgEaKXHvYvLCswtfvUj9KcEkneJMN1ko4dwcq8+2rPo
 oayGAcIHkO2POfqsg+71QZLnEF45ldqxLTvG+qap/7hrqFJHYLFAKEeg6UGAq9wLZj7SQZmN7
 w6kBnebNifXdpK4toeenKQYAFDc9NVntpfpAyXZrbcEF23bQAz1BQHUHN+qagalWIjPNtevTi
 31ML1oCVO+MRLbCmB9KIb6Cvhu3G55s16oHu6o93TYUyQmePRx+kO1uXeZOl/0ymASGki+2vw
 89ntBVmSTgxTBgGVg3aMOQzuxWRlCxBWWGq3zWlPT2lSTtRN2OuxW45Neyr3OO6fBwAf3cZ/1
 WX5uivHjFkFuLXOgWU8J1xMcWjI7IUnccdn5jOhsyYiNuwzBxelXDk3acABi/qt6Wq76od/5x
 thq9lncscMAzVkobHBMyE5H4G/TWl9YuNPePB4l3mteMzwdJDKKf47AtTJK9l7hGUSTmdLp4C
 IGnYpJ1EIyJByrWZio/p6oDJ9i9DUMiCLDQB1sJFCv7HOtRWccVuL/z13fqYsByc2Zo2tWFMf
 Ut8AQv70XTWhGY2Pk+o9G72G+42S0vRK6nIsSfA0cWiaM62O5UsZA8Q/Biq6YlkYqgp38ZY37
 fXglDC3sl3p66tvZ0IIsIwAyU8tko1ZCm2QXy9evkVGCseCufgcdLdJ7fycfXYzuXASd3ao/c
 D7954mBb8kCKoyJ2KtQbuIS55t8v034nND5QPf/Jn4nbpH9ncjYW9eW+JQpBof7YFBbmwNGVs
 ntHQKCxGj433y1VWUBgg==
X-Spam-Status: No, score=-99.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 24 Jul 2020 08:42:34 -0000

On Jul 22 13:22, Brian Inglis wrote:
> update to Linux-next 5.8 order fields and flags:
> add amd_dcm, arch_lbr, arch_perfmon, art, cpuid, extd_apicid, ibpb,
> ibrs, ibrs_enhanced, nonstop_tsc_s3, nopl, rep_good, ring3mwait, ssbd,
> stibp, tsc_known_freq, tsc_reliable, xtopology flags;
> add TLB size line;
> add ftuprint macro for feature test unconditional flag print;
> add commented out flags requiring CR or MSR access in print order with
> comment explaining issue;
> make cpuid leaf numbers consistent 8 hex digits for searching
> ---
>  winsup/cygwin/fhandler_proc.cc | 297 ++++++++++++++++++++++++++++-----
>  1 file changed, 255 insertions(+), 42 deletions(-)

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
