Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 2EE14398B88D
 for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2021 08:23:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2EE14398B88D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdeX1-1mhiTx2oiX-00ZdvJ for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2021
 10:23:20 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 31657A80DD9; Wed, 28 Jul 2021 10:23:20 +0200 (CEST)
Date: Wed, 28 Jul 2021 10:23:20 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fix getifaddrs problems
Message-ID: <YQET+MEG4oFWfvAv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ac22273-23b7-5be4-7f4a-48f4766bfff8@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ac22273-23b7-5be4-7f4a-48f4766bfff8@cornell.edu>
X-Provags-ID: V03:K1:x1CLPPQ2+0JpP0AD+BmbgwgoO/ubX0bWgh4Pa2jzQDa4+l6BfGi
 27fzptESN462vg60R5lxHvD8XbboMGb8mv7YlgKi5DBpeKezUR35UpZJAM4fuDRCNhgm0Uq
 5v3kY5kvPzcFuBUNm7XAAc/+d0wxAoNXRrdjpiZ3PlmBiihzvWs8Cnv58r957VavwfKWj0s
 z6KaQ4FsbzqcG+nkAcYGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J48GEd8IIwI=:WkcfC6gwvx9Eohklr/uNtM
 aWN9MvuiJnMsXQT3iexvj7WE1M2c4hNs6SYecbFYmg4SGbLDtz+YXfT/VMhy/hwpEOVawMDCG
 iOE9jvtQ/viMg2AtYW/UyipNTHQGnD0cZYxrGmZvHGAhBajWSpNPIUsEcm6/ekiv1W7I+y9B9
 FCuDwRX4fZcv3MRHPHBbRR3mWjew3WIIej/dLwmIzKS6ciWLjVKIIPbdU7QVmtsD/rh/fNmg/
 xPVvrjPd/weIXL4WqZ5WR0j5hy7g4U6ntu4S3UyBXd6BT3GcYAEXWXfCQmYwAbV3q2ycyH6OF
 5+LAuMRk01NaEAN1h2t2q2CTfuoom1Lxj0rnD5MFpbcvpeGawi1Ugq2XrpJlzUHogBxfLdzGY
 ab3cG9wqr7hi5uSpWkjQrG8PaIn9TBRxcTc/MhxR3HM5ftLfK/iNJ8ZemQw0vt+z6k3VvYAi1
 lxjLYaig1MsjIRZoalLbJuu+U4iW8EHMwXTmFh02+yRXCJe5tNZhax+RmSjeWb2v7Xq+AHvPO
 MwParkGi28yOmsEX3Q9LtZWwuzSY9iit/+SCEc/TjluVPFXkAV8BX7+aGidaOA4gbXMWQdXOU
 Y6CHznnrXWC9d95lp0JQi2decrkJh4rKMYglS2zcivC0eZflCgKkkgj3BB6xb2tPXTRR2C4Ex
 OFSGWr47r+KcXiBFm3TRCpsX0F0Jvdp2mHoQXZx8iBHo59LAkolXaj9KQxfOxkCgmI3Yh/pm1
 IvTofA1L6rQPl16nQ56gEvS6ZW9yLA4KPtUvdWiQAfTbYDM/4++ACK0DBIrIbKLWAdj9gxCcV
 9I4aGDWMLPhrQxGllmFepAAWeDoWE31g1vp5oO5mhjfMKyrFY3dTKNUVfEi0jrsNUjDPtqKz5
 mxVhboeFiNO9koBcNxFw==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 28 Jul 2021 08:23:23 -0000

On Jul 26 17:02, Ken Brown wrote:
> The two patches in this series fix the two problems reported in
> 
>   https://cygwin.com/pipermail/cygwin/2021-July/248970.html
> 
> As I indicated in that message, I'm not 100% sure of the second patch.

Just checked on Linux and it looks like the right thing to do.
Please push.


Thx,
Corinna
